Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8954D267D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiCIBZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiCIBZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:25:47 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286E73B00F;
        Tue,  8 Mar 2022 17:24:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlNmeGJ3gx3b0hyPimXPEoABlQ6CjhKbcL2w4cCvYk5TmkWhyUrxH3Km/GeEjdTjLhsp1vAlEfZj6Arl5hLtDDs+3i2nlB464wH0UK8eETTEeHp3jOUyVNyY2dbuT0KYlGJfttdFrqzDVCednfYS4PZgY8DuCO7xd8EH4sdVjC/tZ+SZ9IfR3/XJ5l5r7WBjUadxnhCbZiuX7PUKUB4QkuJnld0KamLx9kxx/Fb5PZJRM4PgGHhTmthN1r37A2y9Yu9+SKLGYR0NoD8GdFDaZlMKq1AY3G7nkYw6V0hUh0obfipq5Xhlcv2pfzQPloAu3gw1/0WYjgqexq/A/Koraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a9NT+7g2SvJJ2LrITSmpa7sKSaQybXjwJIVx5Qi+QA=;
 b=ad1X5toasTvfHNasO1XHfBvyDDTLBsnnHXZQ5DqmG6VpdRbQHS1LqU2wR9b7+TxHZ+T06U1kCj9+cgBDr0H0F6mTe/Z9WJREi1oX49mhTa0Zj4zGg/wz1bWyh5s+StvwdwgVoBBORSLOrTv2RAyuCWKWcJddWaNEvFVkvPdkwrchzbzgoYOPycoyytAEFdlBQ35gwezpDWaJFV4o69QOihxqNwzzRacaBAbTyeM5+6fTkp8ciarWmGC1rI1wNNsCpixG4+oHG7nLg7NWLDF1kigKZ2m0Oxidjlr/cRyQuc2gaTi7dKONTwx+aPJsb1Q3WaGLM+PvWP0Xhc1w9zNBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7a9NT+7g2SvJJ2LrITSmpa7sKSaQybXjwJIVx5Qi+QA=;
 b=eQ4UMy/rL7Qkmmvsyy9MPB6iwcw9Gz9cdp+y0r9G8LgGXXTRCzmfRuOApkLEj31J8T2Bju4Lvil2+QI7PHvhdHTESP5uPUZZPyCcjrveHv/jA5DO4keZM/d0akSkLX90BlUX+pUlKphCNK7uJrQq6eUI+0X8f0yw4Q0Fq5zLUlI=
Received: from MW4PR03CA0081.namprd03.prod.outlook.com (2603:10b6:303:b6::26)
 by DM6PR12MB3196.namprd12.prod.outlook.com (2603:10b6:5:187::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Wed, 9 Mar
 2022 01:24:33 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::f6) by MW4PR03CA0081.outlook.office365.com
 (2603:10b6:303:b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 01:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 01:24:32 +0000
Received: from jinzhosu-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 19:24:27 -0600
From:   Jinzhou Su <Jinzhou.Su@amd.com>
To:     <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <srinivas.pandruvada@linux.intel.com>, <dsmythies@telus.net>
CC:     <ray.huang@amd.com>, <viresh.kumar@linaro.org>,
        <todd.e.brandt@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <deepak.sharma@amd.com>, <alexander.deucher@amd.com>,
        <xiaojian.du@amd.com>, <perry.yuan@amd.com>, <li.meng@amd.com>,
        <jinzhou.su@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>
Subject: [PATCH v3 2/4] tools/power/x86/intel_pstate_tracer: make tracer as a module
Date:   Wed, 9 Mar 2022 09:23:49 +0800
Message-ID: <20220309012351.616826-3-Jinzhou.Su@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220309012351.616826-1-Jinzhou.Su@amd.com>
References: <20220309012351.616826-1-Jinzhou.Su@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fdbbf84-b073-42ed-73e1-08da016b90fb
X-MS-TrafficTypeDiagnostic: DM6PR12MB3196:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3196483F29A806C45636ABAC900A9@DM6PR12MB3196.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 076oc/O3ZRdMzsDdYMJN9kPUNWw4Jf+rrMAGI1WuS/hweRvf9ltFTrDcr0BSxPYW/mOCewpPJexNM0bjU/L5ylP9kmUS1/ivnEOSSCHChC7fb/cOyw9rIglIuRso7AbBqYd5qI0wWm0lyVtVxC9zDi2aA+8IXyPMfZbX8QGTJ0gE3voMYGLkgm60YzRlaQdIoKnkzNKLMUBv6Z4kLu1MuWyrDbee4MUBfby64EiegOgU/mW70pVQiknSn5DKCY+MFAm0gQszA5J97HXfK4C10M/19xs9ZmiUj0FlSBaGB3/bJhU6D0Um9IszxPFIQ2rxQYHW5kiYRrKak6VHCdiihfduPIfdvBkPthq2+5/I1zG3RG4KLS6MHQNtYGv6gr80ZDSWqsUf6oIMr68KwAPryAYmk4nixb0AfQ0m6fYC5gQaUC1k7o/P0LBx6LnP88RScXL7rXCMIWHzM3Z+oJL+c7T0OX4TDOWsulX23qis1TTq4VBlaX6BDkf+F8R5NE5/YJgBEM65xmMw+tvmztyS3XJTRAEhmXtpTjZz4J5052Y5iX8+Jjvtnch9hA9AgjV5cVO0tyXg6iV+l+1o60eFaVrzQiPVAOJyL5D4LFFhkSWJ7KM+u9iqZ7zjYccGq/pqVX6caxnK0P9jsIrm0Aaq7FclPo3YaU9nlbejhIlsBtaAtH7l+OFCw78rj5ee4cG4Airgr8iYFYhR6+Yrex/nqKOiLFf+I8o8G+P756U3gH9G0wzDymdC5Plf3pv2QC+kmHPbQgKIgNaoT20Uib1P/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(1076003)(54906003)(2906002)(110136005)(36756003)(8936002)(83380400001)(316002)(186003)(30864003)(2616005)(16526019)(86362001)(26005)(81166007)(356005)(70586007)(70206006)(8676002)(36860700001)(7696005)(4326008)(47076005)(5660300002)(508600001)(336012)(6666004)(426003)(40460700003)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 01:24:32.9998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdbbf84-b073-42ed-73e1-08da016b90fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make intel_pstate_tracer as a module. Other trace event can import
this module to analyze their trace data.

Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
Acked-by: Doug Smythies <dsmythies@telus.net>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 .../intel_pstate_tracer.py                    | 260 +++++++++---------
 1 file changed, 129 insertions(+), 131 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index e15e20696d17..b46e9eb8f5aa 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -63,7 +63,7 @@ C_USEC = 3
 C_SEC = 2
 C_CPU = 1
 
-global sample_num, last_sec_cpu, last_usec_cpu, start_time, testname
+global sample_num, last_sec_cpu, last_usec_cpu, start_time, testname, trace_file
 
 # 11 digits covers uptime to 115 days
 getcontext().prec = 11
@@ -72,17 +72,17 @@ sample_num =0
 last_sec_cpu = [0] * MAX_CPUS
 last_usec_cpu = [0] * MAX_CPUS
 
-def print_help():
-    print('intel_pstate_tracer.py:')
+def print_help(driver_name):
+    print('%s_tracer.py:'%driver_name)
     print('  Usage:')
     print('    If the trace file is available, then to simply parse and plot, use (sudo not required):')
-    print('      ./intel_pstate_tracer.py [-c cpus] -t <trace_file> -n <test_name>')
+    print('      ./%s_tracer.py [-c cpus] -t <trace_file> -n <test_name>'%driver_name)
     print('    Or')
-    print('      ./intel_pstate_tracer.py [--cpu cpus] ---trace_file <trace_file> --name <test_name>')
+    print('      ./%s_tracer.py [--cpu cpus] ---trace_file <trace_file> --name <test_name>'%driver_name)
     print('    To generate trace file, parse and plot, use (sudo required):')
-    print('      sudo ./intel_pstate_tracer.py [-c cpus] -i <interval> -n <test_name> -m <kbytes>')
+    print('      sudo ./%s_tracer.py [-c cpus] -i <interval> -n <test_name> -m <kbytes>'%driver_name)
     print('    Or')
-    print('      sudo ./intel_pstate_tracer.py [--cpu cpus] --interval <interval> --name <test_name> --memory <kbytes>')
+    print('      sudo ./%s_tracer.py [--cpu cpus] --interval <interval> --name <test_name> --memory <kbytes>'%driver_name)
     print('    Optional argument:')
     print('      cpus:   comma separated list of CPUs')
     print('      kbytes: Kilo bytes of memory per CPU to allocate to the trace buffer. Default: 10240')
@@ -323,7 +323,7 @@ def set_4_plot_linestyles(g_plot):
     g_plot('set style line 3 linetype 1 linecolor rgb "purple" pointtype -1')
     g_plot('set style line 4 linetype 1 linecolor rgb "blue" pointtype -1')
 
-def store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _to, mperf, aperf, tsc, freq_ghz, io_boost, common_comm, load, duration_ms, sample_num, elapsed_time, tsc_ghz):
+def store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _to, mperf, aperf, tsc, freq_ghz, io_boost, common_comm, load, duration_ms, sample_num, elapsed_time, tsc_ghz, cpu_mask):
     """ Store master csv file information """
 
     global graph_data_present
@@ -342,11 +342,9 @@ def store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _t
 
     graph_data_present = True;
 
-def split_csv():
+def split_csv(current_max_cpu, cpu_mask):
     """ seperate the all csv file into per CPU csv files. """
 
-    global current_max_cpu
-
     if os.path.exists('cpu.csv'):
         for index in range(0, current_max_cpu + 1):
             if cpu_mask[int(index)] != 0:
@@ -381,27 +379,25 @@ def clear_trace_file():
         print('IO error clearing trace file ')
         sys.exit(2)
 
-def enable_trace():
+def enable_trace(trace_file):
     """ Enable trace """
 
     try:
-       open('/sys/kernel/debug/tracing/events/power/pstate_sample/enable'
-                 , 'w').write("1")
+        open(trace_file,'w').write("1")
     except:
         print('IO error enabling trace ')
         sys.exit(2)
 
-def disable_trace():
+def disable_trace(trace_file):
     """ Disable trace """
 
     try:
-       open('/sys/kernel/debug/tracing/events/power/pstate_sample/enable'
-                 , 'w').write("0")
+       open(trace_file, 'w').write("0")
     except:
         print('IO error disabling trace ')
         sys.exit(2)
 
-def set_trace_buffer_size():
+def set_trace_buffer_size(memory):
     """ Set trace buffer size """
 
     try:
@@ -421,7 +417,7 @@ def free_trace_buffer():
         print('IO error freeing trace buffer ')
         sys.exit(2)
 
-def read_trace_data(filename):
+def read_trace_data(filename, cpu_mask):
     """ Read and parse trace data """
 
     global current_max_cpu
@@ -481,135 +477,137 @@ def read_trace_data(filename):
                 tsc_ghz = Decimal(0)
                 if duration_ms != Decimal(0) :
                     tsc_ghz = Decimal(tsc)/duration_ms/Decimal(1000000)
-                store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _to, mperf, aperf, tsc, freq_ghz, io_boost, common_comm, load, duration_ms, sample_num, elapsed_time, tsc_ghz)
+                store_csv(cpu_int, time_pre_dec, time_post_dec, core_busy, scaled, _from, _to, mperf, aperf, tsc, freq_ghz, io_boost, common_comm, load, duration_ms, sample_num, elapsed_time, tsc_ghz, cpu_mask)
 
             if cpu_int > current_max_cpu:
                 current_max_cpu = cpu_int
 # End of for each trace line loop
 # Now seperate the main overall csv file into per CPU csv files.
-    split_csv()
+    split_csv(current_max_cpu, cpu_mask)
 
 def signal_handler(signal, frame):
     print(' SIGINT: Forcing cleanup before exit.')
     if interval:
-        disable_trace()
+        disable_trace(trace_file)
         clear_trace_file()
         # Free the memory
         free_trace_buffer()
         sys.exit(0)
 
-signal.signal(signal.SIGINT, signal_handler)
+if __name__ == "__main__":
+    trace_file = "/sys/kernel/debug/tracing/events/power/pstate_sample/enable"
+    signal.signal(signal.SIGINT, signal_handler)
 
-interval = ""
-filename = ""
-cpu_list = ""
-testname = ""
-memory = "10240"
-graph_data_present = False;
+    interval = ""
+    filename = ""
+    cpu_list = ""
+    testname = ""
+    memory = "10240"
+    graph_data_present = False;
 
-valid1 = False
-valid2 = False
+    valid1 = False
+    valid2 = False
 
-cpu_mask = zeros((MAX_CPUS,), dtype=int)
+    cpu_mask = zeros((MAX_CPUS,), dtype=int)
 
-try:
-    opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=","interval=","cpu=","name=","memory="])
-except getopt.GetoptError:
-    print_help()
-    sys.exit(2)
-for opt, arg in opts:
-    if opt == '-h':
-        print()
+    try:
+        opts, args = getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trace_file=","interval=","cpu=","name=","memory="])
+    except getopt.GetoptError:
+        print_help('intel_pstate')
+        sys.exit(2)
+    for opt, arg in opts:
+        if opt == '-h':
+            print_help('intel_pstate')
+            sys.exit()
+        elif opt in ("-t", "--trace_file"):
+            valid1 = True
+            location = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
+            filename = os.path.join(location, arg)
+        elif opt in ("-i", "--interval"):
+            valid1 = True
+            interval = arg
+        elif opt in ("-c", "--cpu"):
+            cpu_list = arg
+        elif opt in ("-n", "--name"):
+            valid2 = True
+            testname = arg
+        elif opt in ("-m", "--memory"):
+            memory = arg
+
+    if not (valid1 and valid2):
+        print_help('intel_pstate')
         sys.exit()
-    elif opt in ("-t", "--trace_file"):
-        valid1 = True
-        location = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))
-        filename = os.path.join(location, arg)
-    elif opt in ("-i", "--interval"):
-        valid1 = True
-        interval = arg
-    elif opt in ("-c", "--cpu"):
-        cpu_list = arg
-    elif opt in ("-n", "--name"):
-        valid2 = True
-        testname = arg
-    elif opt in ("-m", "--memory"):
-        memory = arg
-
-if not (valid1 and valid2):
-    print_help()
-    sys.exit()
-
-if cpu_list:
-    for p in re.split("[,]", cpu_list):
-        if int(p) < MAX_CPUS :
-            cpu_mask[int(p)] = 1
-else:
-    for i in range (0, MAX_CPUS):
-        cpu_mask[i] = 1
-
-if not os.path.exists('results'):
-    os.mkdir('results')
+
+    if cpu_list:
+        for p in re.split("[,]", cpu_list):
+            if int(p) < MAX_CPUS :
+                cpu_mask[int(p)] = 1
+    else:
+        for i in range (0, MAX_CPUS):
+            cpu_mask[i] = 1
+
+    if not os.path.exists('results'):
+        os.mkdir('results')
+        # The regular user needs to own the directory, not root.
+        fix_ownership('results')
+
+    os.chdir('results')
+    if os.path.exists(testname):
+        print('The test name directory already exists. Please provide a unique test name. Test re-run not supported, yet.')
+        sys.exit()
+    os.mkdir(testname)
     # The regular user needs to own the directory, not root.
-    fix_ownership('results')
-
-os.chdir('results')
-if os.path.exists(testname):
-    print('The test name directory already exists. Please provide a unique test name. Test re-run not supported, yet.')
-    sys.exit()
-os.mkdir(testname)
-# The regular user needs to own the directory, not root.
-fix_ownership(testname)
-os.chdir(testname)
-
-# Temporary (or perhaps not)
-cur_version = sys.version_info
-print('python version (should be >= 2.7):')
-print(cur_version)
-
-# Left as "cleanup" for potential future re-run ability.
-cleanup_data_files()
-
-if interval:
-    filename = "/sys/kernel/debug/tracing/trace"
-    clear_trace_file()
-    set_trace_buffer_size()
-    enable_trace()
-    print('Sleeping for ', interval, 'seconds')
-    time.sleep(int(interval))
-    disable_trace()
-
-current_max_cpu = 0
-
-read_trace_data(filename)
-
-if interval:
-    clear_trace_file()
-    # Free the memory
-    free_trace_buffer()
-
-if graph_data_present == False:
-    print('No valid data to plot')
-    sys.exit(2)
-
-for cpu_no in range(0, current_max_cpu + 1):
-    plot_perf_busy_with_sample(cpu_no)
-    plot_perf_busy(cpu_no)
-    plot_durations(cpu_no)
-    plot_loads(cpu_no)
-
-plot_pstate_cpu_with_sample()
-plot_pstate_cpu()
-plot_load_cpu()
-plot_frequency_cpu()
-plot_duration_cpu()
-plot_scaled_cpu()
-plot_boost_cpu()
-plot_ghz_cpu()
-
-# It is preferrable, but not necessary, that the regular user owns the files, not root.
-for root, dirs, files in os.walk('.'):
-    for f in files:
-        fix_ownership(f)
-
-os.chdir('../../')
+    fix_ownership(testname)
+    os.chdir(testname)
+
+    # Temporary (or perhaps not)
+    cur_version = sys.version_info
+    print('python version (should be >= 2.7):')
+    print(cur_version)
+
+    # Left as "cleanup" for potential future re-run ability.
+    cleanup_data_files()
+
+    if interval:
+        filename = "/sys/kernel/debug/tracing/trace"
+        clear_trace_file()
+        set_trace_buffer_size(memory)
+        enable_trace(trace_file)
+        print('Sleeping for ', interval, 'seconds')
+        time.sleep(int(interval))
+        disable_trace(trace_file)
+
+    current_max_cpu = 0
+
+    read_trace_data(filename, cpu_mask)
+
+    if interval:
+        clear_trace_file()
+        # Free the memory
+        free_trace_buffer()
+
+    if graph_data_present == False:
+        print('No valid data to plot')
+        sys.exit(2)
+
+    for cpu_no in range(0, current_max_cpu + 1):
+        plot_perf_busy_with_sample(cpu_no)
+        plot_perf_busy(cpu_no)
+        plot_durations(cpu_no)
+        plot_loads(cpu_no)
+
+    plot_pstate_cpu_with_sample()
+    plot_pstate_cpu()
+    plot_load_cpu()
+    plot_frequency_cpu()
+    plot_duration_cpu()
+    plot_scaled_cpu()
+    plot_boost_cpu()
+    plot_ghz_cpu()
+
+    # It is preferrable, but not necessary, that the regular user owns the files, not root.
+    for root, dirs, files in os.walk('.'):
+        for f in files:
+            fix_ownership(f)
+
+    os.chdir('../../')
-- 
2.27.0

