import re
import collections
import numpy
import math

############################## INPUT #######################################

filename = 'id3-18.txt'
##########################################################################

with open(filename, 'r') as file:
    contents_of_file = file.read()

lines = re.findall(r'\d\s(.*)\n', contents_of_file)[:-1]
lines = [line.split() for line in lines]
class_line = numpy.transpose(lines)[0]
lines = [[[line[att], line[0]]for att in range(len(line))] for line in lines]
lines = [[row[i] for row in lines] for i in range(len(lines[0]))][1:]
lines = [[[line[ele][0], line[ele][1], ele+1] for ele in range(len(line))] for line in lines]

all_lines = lines
all_attributes = ['myarmy', 'enemyarmy', 'betrayal', 'enemybetrayal', 'expected']

def what_the_hell(chosen_lines,popinson):

    global all_attributes
    global class_line
    global lines

    curr_att = all_attributes.copy()
    back_up_lines = lines

    chosen_lines = [x - 1 for x in chosen_lines]
    back_up_lines = [[line[x] for x in range(len(line)) if x in chosen_lines] for line in back_up_lines]
    class_line_f = [class_line[x] for x in range(len(class_line)) if x in chosen_lines]

    attribute_groups = {
        'myarmy' :
        {
            'small': {'att_share':0},
            'medium': {'att_share':0},
            'large': {'att_share':0},
        },
        'enemyarmy':
        {
            'small': {'att_share':0},
            'medium': {'att_share':0},
            'large': {'att_share':0},
        },
        'betrayal':
        {
            'possible': {'att_share':0},
            'impossible': {'att_share':0},
        },
        'enemybetrayal':
        {
            'possible': {'att_share':0},
            'impossible': {'att_share':0},
        },
        'expected':
        {
            'true': {'att_share':0},
            'false': {'att_share':0},
        }
    }

    if popinson:
        for poperino in popinson:
            attribute_groups.pop(poperino)
            back_up_lines.pop(curr_att.index(poperino))
            curr_att.remove(poperino)


    classes = ['Y', 'M', 'N']
    number_of_lines = len(back_up_lines[0])
    line_counter = 0

    for att, val in attribute_groups.items():
        for option in val:
            for cls in classes:
                occur_count = len([x for x in back_up_lines[line_counter] if x[1] == cls and x[0] == option])
                if occur_count:
                    attribute_groups[att][option][cls] = occur_count
                attribute_groups[att][option]['att_share'] += occur_count
        line_counter += 1


    class_occurrences = collections.Counter(class_line_f)

    classes_entropy = 0
    for option in classes:
        val = class_occurrences[option]
        if val:
            classes_entropy -= val/number_of_lines*math.log2(val/number_of_lines)

    print('\nCLASS entropy = ', classes_entropy)

    results = []

    for att, val1 in attribute_groups.items():

        att_entropy = 0

        for option, val2 in val1.items():

            att_share = attribute_groups[att][option]['att_share']
            if att_share:
                attribute_occ = att_share / number_of_lines
                option_acc = 0
                for val in list(val2.values())[1:]:
                    cls_share = val / att_share
                    option_acc -= cls_share * math.log2(cls_share)

                att_entropy += attribute_occ * option_acc

        results.append([att, classes_entropy - att_entropy])

        print(f'{att.upper()} entropy = {att_entropy} --> zisk = {classes_entropy - att_entropy}')

    print()
    results.sort(key=lambda x : x[1], reverse=True)
    print(f"The best option is '{results[0][0]}' with value {results[0][1]}\n")

    idx = curr_att.index(results[0][0])
    used_att = results[0][0]

    for key in attribute_groups[results[0][0]]:
        resulterino = [x for x in back_up_lines[idx] if x[0] == key]
        check = [cls[1] for cls in resulterino]
        if not check:
            continue
        new_table = [cls[2] for cls in resulterino]
        if len(set(check)) != 1:
            print('================================\n')
            print(f"Option '{key}' gotta keep going!")
            print(new_table, end='')
            if not popinson:
                popinson = []

            popinson.append(used_att)

            what_the_hell(new_table,popinson)

            popinson.remove(used_att)
        else:
            print("================================")
            print(f"\nBranch for attribute '{used_att}' with option '{key}' ends with answer'{resulterino[0][1]}' for {new_table}'\n")
            print("================================")

what_the_hell([x for x in range(1,13)], None)
