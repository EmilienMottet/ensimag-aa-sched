## Problem description

Some jobs must be executed on a parallel system composed of identical processors.  
The objective is to finish as soon as possible.

### Inputs
- the total number of processors
- a set jobs to execute, with for each job:
  - a processing time (assumed integral)
  - a number of required processors

### Output
A feasible schedule. For each job:
- a starting time (positive integer)
- a set of processors to execute the job

Such that:
- **processors are not shared**: at each time, processors are either idle or computing 1 job
- **makespan is minimal**: the completion time of the last job must be minimal
- (all jobs are executed)

## Input and output formats

Input jobs are described in a CSV file with the following fields:
- ``job_id`` for the unique job number
- ``execution_time`` for the processing time (strictly positive integer)
- ``requested_number_of_processors`` for the number of required processors (strictly positive integer)

Output allocations should also be formatted in CSV with the following fields for each allocation:
- ``job_id`` states which job the allocation is about
- ``starting_time`` for the starting time (positive integer)
- ``allocated_processors`` for the selected processors (string). Examples:
  - "0" stands for only using the first processor
  - "0 1 2" stands for using the first three processors
  - "0 17 37" stands for using processors 0, 17 and 37
- ``execution_time`` (should be identical to input data for the corresponding ``job_id``)
- ``requested_number_of_processors`` (should be identical to input data for the corresponding ``job_id``)

## Visualisation
Schedules can be visualized thanks to Evalys.

### Install Evalys
``` bash
pip3 install evalys
```

### Visualize a result file
Assuming that evalys is installed and that the allocation file is named
``schedule.csv``, the following script should visualize the schedule:

``` python
from evalys.jobset import JobSet
from evalys.visu import plot_gantt
import matplotlib.pyplot as plt

# Interactive mode
plt.ion()

# Read the allocations
js = JobSet.from_csv('schedule.csv')

# Generate needed data to visualize the jobs execution
js.df['submission_time'] = 0
js.df['waiting_time'] = js.df['starting_time']

# Plot!
plot_gantt(js)
```
