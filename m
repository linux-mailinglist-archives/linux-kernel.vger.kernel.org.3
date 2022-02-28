Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DDE4C7AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 21:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiB1Upy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiB1Upv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:45:51 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2328B1AD8C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:45:09 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id s1-20020a056830148100b005acfdcb1f4bso10483713otq.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=37rZJQ74Nddiz7Fa72xJmyUnMXPSg63y6oFhaM6t5b4=;
        b=NM50C5gv0OC8WiIyWnd3vm589lRC8/8/tjDlXlWNTPonzkEzk2eUiEUAygw8fTIGCf
         MJh3fWCEx+aow7yTfpeqlsLA/RytPSHUSwfouXntBWQU6CBbj/efolAtxHj++h2V9e4t
         nux3HDfrksMFt/IL35qyiF1VNwyVIEIl/pDN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=37rZJQ74Nddiz7Fa72xJmyUnMXPSg63y6oFhaM6t5b4=;
        b=1y/lQ/hXNUenb6L4Jfnp9L5Z6tVWKo9wjVgocWFkBE5Di3RkFDJKc19hxkD9gMKY5C
         yDvql9tLshCFxWIKU3EjUZ7tHQCjd3zUmFfjkcfHIuy8BvC45mptD7nFfr5tIqO3s+cy
         Jex7T6mDSXw7QADfaLT9NAc2KgrnI6I6J5oZxyb29Fv3X4AXj+1rfdUKGuUPjID9oWgp
         J/gO/gMVgf1Rzzy15PGa1Mh7rbmExfAW2PZ+wLT6HnjPGoH+YYXOulRNxj1FuzEoyfRT
         +E+xKLWsLyYnD0c87itLuL3hqi3WZ6V2ROFOabQpBksUONLamzXjiCuvEsaX8qUvQ2u9
         GWfw==
X-Gm-Message-State: AOAM5334p3EcpP+dm1tb6MIzabdQh6O3B4lQGrkJbUPx3SAuap6AkkJh
        B6gvTWqlpjA0tNsFza/lZ8u7ORSFYptDig==
X-Google-Smtp-Source: ABdhPJzBaJe76D/goF6oG4OHizr7qnqqsB0ldxOa9aG0bohctIlOMXrXo1Ngy+Hm4Q47AU6/p9/45w==
X-Received: by 2002:a05:6830:43:b0:5ad:1b56:efeb with SMTP id d3-20020a056830004300b005ad1b56efebmr10133075otp.304.1646081108257;
        Mon, 28 Feb 2022 12:45:08 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id a12-20020a056870d60c00b000d6d215bf88sm4942917oaq.37.2022.02.28.12.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:45:07 -0800 (PST)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 5.18-rc1
Message-ID: <ae1801b4-9c1f-b0eb-f3c6-dd888b689efe@linuxfoundation.org>
Date:   Mon, 28 Feb 2022 13:45:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A69A2C635D1C6FA99A1D04FC"
Content-Language: en-US
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A69A2C635D1C6FA99A1D04FC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 5.18-rc1

This cpupower update for Linux 5.18-rc1 adds AMD P-State Support to
cpupower tool. AMD P-State kernel support went into 5.17-rc1.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 101025ff8e47d3c938ad2ae646a1794b9a8aa730:

   tools/power/cpupower/{ToDo => TODO}: Rename the todo file (2022-01-24 09:07:11 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-5.18-rc1

for you to fetch changes up to 8382dce5e4835c045f33b8958a5f559d212cdd11:

   cpupower: Add "perf" option to print AMD P-State information (2022-02-23 17:46:21 -0700)

----------------------------------------------------------------
linux-cpupower-5.18-rc1

This cpupower update for Linux 5.18-rc1 adds AMD P-State Support to
cpupower tool. AMD P-State kernel support went into 5.17-rc1.

----------------------------------------------------------------
Huang Rui (10):
       cpupower: Add AMD P-State capability flag
       cpupower: Add the function to check AMD P-State enabled
       cpupower: Initial AMD P-State capability
       cpupower: Add the function to get the sysfs value from specific table
       cpupower: Introduce ACPI CPPC library
       cpupower: Add AMD P-State sysfs definition and access helper
       cpupower: Enable boost state support for AMD P-State module
       cpupower: Move print_speed function into misc helper
       cpupower: Add function to print AMD P-State performance capabilities
       cpupower: Add "perf" option to print AMD P-State information

  tools/power/cpupower/Makefile                      |  6 +-
  tools/power/cpupower/lib/acpi_cppc.c               | 59 +++++++++++++++
  tools/power/cpupower/lib/acpi_cppc.h               | 21 ++++++
  tools/power/cpupower/lib/cpufreq.c                 | 23 ++++--
  tools/power/cpupower/lib/cpufreq.h                 | 12 +++
  tools/power/cpupower/man/cpupower-frequency-info.1 |  3 +
  tools/power/cpupower/utils/cpufreq-info.c          | 87 +++++++++-------------
  tools/power/cpupower/utils/helpers/amd.c           | 77 +++++++++++++++++++
  tools/power/cpupower/utils/helpers/cpuid.c         | 13 ++++
  tools/power/cpupower/utils/helpers/helpers.h       | 22 ++++++
  tools/power/cpupower/utils/helpers/misc.c          | 60 +++++++++++++++
  11 files changed, 321 insertions(+), 62 deletions(-)
  create mode 100644 tools/power/cpupower/lib/acpi_cppc.c
  create mode 100644 tools/power/cpupower/lib/acpi_cppc.h
----------------------------------------------------------------

--------------A69A2C635D1C6FA99A1D04FC
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-cpupower-5.18-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-cpupower-5.18-rc1.diff"

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 3b1594447f29..e9b6de314654 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -143,9 +143,9 @@ UTIL_HEADERS = utils/helpers/helpers.h utils/idle_monitor/cpupower-monitor.h \
 	utils/helpers/bitmask.h \
 	utils/idle_monitor/idle_monitors.h utils/idle_monitor/idle_monitors.def
 
-LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h
-LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c
-LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o
+LIB_HEADERS = 	lib/cpufreq.h lib/cpupower.h lib/cpuidle.h lib/acpi_cppc.h
+LIB_SRC = 	lib/cpufreq.c lib/cpupower.c lib/cpuidle.c lib/acpi_cppc.c
+LIB_OBJS = 	lib/cpufreq.o lib/cpupower.o lib/cpuidle.o lib/acpi_cppc.o
 LIB_OBJS :=	$(addprefix $(OUTPUT),$(LIB_OBJS))
 
 override CFLAGS +=	-pipe
diff --git a/tools/power/cpupower/lib/acpi_cppc.c b/tools/power/cpupower/lib/acpi_cppc.c
new file mode 100644
index 000000000000..c401ac331e9f
--- /dev/null
+++ b/tools/power/cpupower/lib/acpi_cppc.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include "cpupower_intern.h"
+#include "acpi_cppc.h"
+
+/* ACPI CPPC sysfs access ***********************************************/
+
+static int acpi_cppc_read_file(unsigned int cpu, const char *fname,
+			       char *buf, size_t buflen)
+{
+	char path[SYSFS_PATH_MAX];
+
+	snprintf(path, sizeof(path), PATH_TO_CPU "cpu%u/acpi_cppc/%s",
+		 cpu, fname);
+	return cpupower_read_sysfs(path, buf, buflen);
+}
+
+static const char * const acpi_cppc_value_files[] = {
+	[HIGHEST_PERF] = "highest_perf",
+	[LOWEST_PERF] = "lowest_perf",
+	[NOMINAL_PERF] = "nominal_perf",
+	[LOWEST_NONLINEAR_PERF] = "lowest_nonlinear_perf",
+	[LOWEST_FREQ] = "lowest_freq",
+	[NOMINAL_FREQ] = "nominal_freq",
+	[REFERENCE_PERF] = "reference_perf",
+	[WRAPAROUND_TIME] = "wraparound_time"
+};
+
+unsigned long acpi_cppc_get_data(unsigned int cpu, enum acpi_cppc_value which)
+{
+	unsigned long long value;
+	unsigned int len;
+	char linebuf[MAX_LINE_LEN];
+	char *endp;
+
+	if (which >= MAX_CPPC_VALUE_FILES)
+		return 0;
+
+	len = acpi_cppc_read_file(cpu, acpi_cppc_value_files[which],
+				  linebuf, sizeof(linebuf));
+	if (len == 0)
+		return 0;
+
+	value = strtoull(linebuf, &endp, 0);
+
+	if (endp == linebuf || errno == ERANGE)
+		return 0;
+
+	return value;
+}
diff --git a/tools/power/cpupower/lib/acpi_cppc.h b/tools/power/cpupower/lib/acpi_cppc.h
new file mode 100644
index 000000000000..85ca83080316
--- /dev/null
+++ b/tools/power/cpupower/lib/acpi_cppc.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ACPI_CPPC_H__
+#define __ACPI_CPPC_H__
+
+enum acpi_cppc_value {
+	HIGHEST_PERF,
+	LOWEST_PERF,
+	NOMINAL_PERF,
+	LOWEST_NONLINEAR_PERF,
+	LOWEST_FREQ,
+	NOMINAL_FREQ,
+	REFERENCE_PERF,
+	WRAPAROUND_TIME,
+	MAX_CPPC_VALUE_FILES
+};
+
+unsigned long acpi_cppc_get_data(unsigned int cpu,
+				 enum acpi_cppc_value which);
+
+#endif /* _ACPI_CPPC_H */
diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index c3b56db8b921..1516d23c17c9 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -83,20 +83,21 @@ static const char *cpufreq_value_files[MAX_CPUFREQ_VALUE_READ_FILES] = {
 	[STATS_NUM_TRANSITIONS] = "stats/total_trans"
 };
 
-
-static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
-						 enum cpufreq_value which)
+unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
+						 const char **table,
+						 unsigned int index,
+						 unsigned int size)
 {
 	unsigned long value;
 	unsigned int len;
 	char linebuf[MAX_LINE_LEN];
 	char *endp;
 
-	if (which >= MAX_CPUFREQ_VALUE_READ_FILES)
+	if (!table || index >= size || !table[index])
 		return 0;
 
-	len = sysfs_cpufreq_read_file(cpu, cpufreq_value_files[which],
-				linebuf, sizeof(linebuf));
+	len = sysfs_cpufreq_read_file(cpu, table[index], linebuf,
+				      sizeof(linebuf));
 
 	if (len == 0)
 		return 0;
@@ -109,6 +110,14 @@ static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
 	return value;
 }
 
+static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
+						 enum cpufreq_value which)
+{
+	return cpufreq_get_sysfs_value_from_table(cpu, cpufreq_value_files,
+						  which,
+						  MAX_CPUFREQ_VALUE_READ_FILES);
+}
+
 /* read access to files which contain one string */
 
 enum cpufreq_string {
@@ -124,7 +133,7 @@ static const char *cpufreq_string_files[MAX_CPUFREQ_STRING_FILES] = {
 
 
 static char *sysfs_cpufreq_get_one_string(unsigned int cpu,
-					   enum cpufreq_string which)
+					  enum cpufreq_string which)
 {
 	char linebuf[MAX_LINE_LEN];
 	char *result;
diff --git a/tools/power/cpupower/lib/cpufreq.h b/tools/power/cpupower/lib/cpufreq.h
index 95f4fd9e2656..2f3c84035806 100644
--- a/tools/power/cpupower/lib/cpufreq.h
+++ b/tools/power/cpupower/lib/cpufreq.h
@@ -203,6 +203,18 @@ int cpufreq_modify_policy_governor(unsigned int cpu, char *governor);
 int cpufreq_set_frequency(unsigned int cpu,
 				unsigned long target_frequency);
 
+/*
+ * get the sysfs value from specific table
+ *
+ * Read the value with the sysfs file name from specific table. Does
+ * only work if the cpufreq driver has the specific sysfs interfaces.
+ */
+
+unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
+						 const char **table,
+						 unsigned int index,
+						 unsigned int size);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index 6aa8d239dff9..dd545b499480 100644
--- a/tools/power/cpupower/man/cpupower-frequency-info.1
+++ b/tools/power/cpupower/man/cpupower-frequency-info.1
@@ -53,6 +53,9 @@ human\-readable output for the \-f, \-w, \-s and \-y parameters.
 \fB\-n\fR \fB\-\-no-rounding\fR
 Output frequencies and latencies without rounding off values.
 .TP  
+\fB\-c\fR \fB\-\-perf\fR
+Get performances and frequencies capabilities of CPPC, by reading it from hardware (only available on the hardware with CPPC).
+.TP
 .SH "REMARKS"
 .LP 
 By default only values of core zero are displayed. How to display settings of
diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index f9895e31ff5a..0646f615fe2d 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -84,43 +84,6 @@ static void proc_cpufreq_output(void)
 }
 
 static int no_rounding;
-static void print_speed(unsigned long speed)
-{
-	unsigned long tmp;
-
-	if (no_rounding) {
-		if (speed > 1000000)
-			printf("%u.%06u GHz", ((unsigned int) speed/1000000),
-				((unsigned int) speed%1000000));
-		else if (speed > 1000)
-			printf("%u.%03u MHz", ((unsigned int) speed/1000),
-				(unsigned int) (speed%1000));
-		else
-			printf("%lu kHz", speed);
-	} else {
-		if (speed > 1000000) {
-			tmp = speed%10000;
-			if (tmp >= 5000)
-				speed += 10000;
-			printf("%u.%02u GHz", ((unsigned int) speed/1000000),
-				((unsigned int) (speed%1000000)/10000));
-		} else if (speed > 100000) {
-			tmp = speed%1000;
-			if (tmp >= 500)
-				speed += 1000;
-			printf("%u MHz", ((unsigned int) speed/1000));
-		} else if (speed > 1000) {
-			tmp = speed%100;
-			if (tmp >= 50)
-				speed += 100;
-			printf("%u.%01u MHz", ((unsigned int) speed/1000),
-				((unsigned int) (speed%1000)/100));
-		}
-	}
-
-	return;
-}
-
 static void print_duration(unsigned long duration)
 {
 	unsigned long tmp;
@@ -183,9 +146,12 @@ static int get_boost_mode_x86(unsigned int cpu)
 	printf(_("    Supported: %s\n"), support ? _("yes") : _("no"));
 	printf(_("    Active: %s\n"), active ? _("yes") : _("no"));
 
-	if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
-	     cpupower_cpu_info.family >= 0x10) ||
-	     cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
+	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
+	    cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) {
+		return 0;
+	} else if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
+		    cpupower_cpu_info.family >= 0x10) ||
+		   cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
 		ret = decode_pstates(cpu, b_states, pstates, &pstate_no);
 		if (ret)
 			return ret;
@@ -254,11 +220,11 @@ static int get_boost_mode(unsigned int cpu)
 	if (freqs) {
 		printf(_("  boost frequency steps: "));
 		while (freqs->next) {
-			print_speed(freqs->frequency);
+			print_speed(freqs->frequency, no_rounding);
 			printf(", ");
 			freqs = freqs->next;
 		}
-		print_speed(freqs->frequency);
+		print_speed(freqs->frequency, no_rounding);
 		printf("\n");
 		cpufreq_put_available_frequencies(freqs);
 	}
@@ -277,7 +243,7 @@ static int get_freq_kernel(unsigned int cpu, unsigned int human)
 		return -EINVAL;
 	}
 	if (human) {
-		print_speed(freq);
+		print_speed(freq, no_rounding);
 	} else
 		printf("%lu", freq);
 	printf(_(" (asserted by call to kernel)\n"));
@@ -296,7 +262,7 @@ static int get_freq_hardware(unsigned int cpu, unsigned int human)
 		return -EINVAL;
 	}
 	if (human) {
-		print_speed(freq);
+		print_speed(freq, no_rounding);
 	} else
 		printf("%lu", freq);
 	printf(_(" (asserted by call to hardware)\n"));
@@ -316,9 +282,9 @@ static int get_hardware_limits(unsigned int cpu, unsigned int human)
 
 	if (human) {
 		printf(_("  hardware limits: "));
-		print_speed(min);
+		print_speed(min, no_rounding);
 		printf(" - ");
-		print_speed(max);
+		print_speed(max, no_rounding);
 		printf("\n");
 	} else {
 		printf("%lu %lu\n", min, max);
@@ -350,9 +316,9 @@ static int get_policy(unsigned int cpu)
 		return -EINVAL;
 	}
 	printf(_("  current policy: frequency should be within "));
-	print_speed(policy->min);
+	print_speed(policy->min, no_rounding);
 	printf(_(" and "));
-	print_speed(policy->max);
+	print_speed(policy->max, no_rounding);
 
 	printf(".\n                  ");
 	printf(_("The governor \"%s\" may decide which speed to use\n"
@@ -436,7 +402,7 @@ static int get_freq_stats(unsigned int cpu, unsigned int human)
 	struct cpufreq_stats *stats = cpufreq_get_stats(cpu, &total_time);
 	while (stats) {
 		if (human) {
-			print_speed(stats->frequency);
+			print_speed(stats->frequency, no_rounding);
 			printf(":%.2f%%",
 				(100.0 * stats->time_in_state) / total_time);
 		} else
@@ -472,6 +438,17 @@ static int get_latency(unsigned int cpu, unsigned int human)
 	return 0;
 }
 
+/* --performance / -c */
+
+static int get_perf_cap(unsigned int cpu)
+{
+	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
+	    cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE)
+		amd_pstate_show_perf_and_freq(cpu, no_rounding);
+
+	return 0;
+}
+
 static void debug_output_one(unsigned int cpu)
 {
 	struct cpufreq_available_frequencies *freqs;
@@ -486,11 +463,11 @@ static void debug_output_one(unsigned int cpu)
 	if (freqs) {
 		printf(_("  available frequency steps:  "));
 		while (freqs->next) {
-			print_speed(freqs->frequency);
+			print_speed(freqs->frequency, no_rounding);
 			printf(", ");
 			freqs = freqs->next;
 		}
-		print_speed(freqs->frequency);
+		print_speed(freqs->frequency, no_rounding);
 		printf("\n");
 		cpufreq_put_available_frequencies(freqs);
 	}
@@ -500,6 +477,7 @@ static void debug_output_one(unsigned int cpu)
 	if (get_freq_hardware(cpu, 1) < 0)
 		get_freq_kernel(cpu, 1);
 	get_boost_mode(cpu);
+	get_perf_cap(cpu);
 }
 
 static struct option info_opts[] = {
@@ -518,6 +496,7 @@ static struct option info_opts[] = {
 	{"proc",	 no_argument,		 NULL,	 'o'},
 	{"human",	 no_argument,		 NULL,	 'm'},
 	{"no-rounding", no_argument,	 NULL,	 'n'},
+	{"performance", no_argument,	 NULL,	 'c'},
 	{ },
 };
 
@@ -531,7 +510,7 @@ int cmd_freq_info(int argc, char **argv)
 	int output_param = 0;
 
 	do {
-		ret = getopt_long(argc, argv, "oefwldpgrasmybn", info_opts,
+		ret = getopt_long(argc, argv, "oefwldpgrasmybnc", info_opts,
 				  NULL);
 		switch (ret) {
 		case '?':
@@ -554,6 +533,7 @@ int cmd_freq_info(int argc, char **argv)
 		case 'e':
 		case 's':
 		case 'y':
+		case 'c':
 			if (output_param) {
 				output_param = -1;
 				cont = 0;
@@ -660,6 +640,9 @@ int cmd_freq_info(int argc, char **argv)
 		case 'y':
 			ret = get_latency(cpu, human);
 			break;
+		case 'c':
+			ret = get_perf_cap(cpu);
+			break;
 		}
 		if (ret)
 			return ret;
diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index 97f2c857048e..c519cc89c97f 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -8,7 +8,10 @@
 #include <pci/pci.h>
 
 #include "helpers/helpers.h"
+#include "cpufreq.h"
+#include "acpi_cppc.h"
 
+/* ACPI P-States Helper Functions for AMD Processors ***************/
 #define MSR_AMD_PSTATE_STATUS	0xc0010063
 #define MSR_AMD_PSTATE		0xc0010064
 #define MSR_AMD_PSTATE_LIMIT	0xc0010061
@@ -146,4 +149,78 @@ int amd_pci_get_num_boost_states(int *active, int *states)
 	pci_cleanup(pci_acc);
 	return 0;
 }
+
+/* ACPI P-States Helper Functions for AMD Processors ***************/
+
+/* AMD P-State Helper Functions ************************************/
+enum amd_pstate_value {
+	AMD_PSTATE_HIGHEST_PERF,
+	AMD_PSTATE_MAX_FREQ,
+	AMD_PSTATE_LOWEST_NONLINEAR_FREQ,
+	MAX_AMD_PSTATE_VALUE_READ_FILES,
+};
+
+static const char *amd_pstate_value_files[MAX_AMD_PSTATE_VALUE_READ_FILES] = {
+	[AMD_PSTATE_HIGHEST_PERF] = "amd_pstate_highest_perf",
+	[AMD_PSTATE_MAX_FREQ] = "amd_pstate_max_freq",
+	[AMD_PSTATE_LOWEST_NONLINEAR_FREQ] = "amd_pstate_lowest_nonlinear_freq",
+};
+
+static unsigned long amd_pstate_get_data(unsigned int cpu,
+					 enum amd_pstate_value value)
+{
+	return cpufreq_get_sysfs_value_from_table(cpu,
+						  amd_pstate_value_files,
+						  value,
+						  MAX_AMD_PSTATE_VALUE_READ_FILES);
+}
+
+void amd_pstate_boost_init(unsigned int cpu, int *support, int *active)
+{
+	unsigned long highest_perf, nominal_perf, cpuinfo_min,
+		      cpuinfo_max, amd_pstate_max;
+
+	highest_perf = amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF);
+	nominal_perf = acpi_cppc_get_data(cpu, NOMINAL_PERF);
+
+	*support = highest_perf > nominal_perf ? 1 : 0;
+	if (!(*support))
+		return;
+
+	cpufreq_get_hardware_limits(cpu, &cpuinfo_min, &cpuinfo_max);
+	amd_pstate_max = amd_pstate_get_data(cpu, AMD_PSTATE_MAX_FREQ);
+
+	*active = cpuinfo_max == amd_pstate_max ? 1 : 0;
+}
+
+void amd_pstate_show_perf_and_freq(unsigned int cpu, int no_rounding)
+{
+	printf(_("    AMD PSTATE Highest Performance: %lu. Maximum Frequency: "),
+	       amd_pstate_get_data(cpu, AMD_PSTATE_HIGHEST_PERF));
+	/*
+	 * If boost isn't active, the cpuinfo_max doesn't indicate real max
+	 * frequency. So we read it back from amd-pstate sysfs entry.
+	 */
+	print_speed(amd_pstate_get_data(cpu, AMD_PSTATE_MAX_FREQ), no_rounding);
+	printf(".\n");
+
+	printf(_("    AMD PSTATE Nominal Performance: %lu. Nominal Frequency: "),
+	       acpi_cppc_get_data(cpu, NOMINAL_PERF));
+	print_speed(acpi_cppc_get_data(cpu, NOMINAL_FREQ) * 1000,
+		    no_rounding);
+	printf(".\n");
+
+	printf(_("    AMD PSTATE Lowest Non-linear Performance: %lu. Lowest Non-linear Frequency: "),
+	       acpi_cppc_get_data(cpu, LOWEST_NONLINEAR_PERF));
+	print_speed(amd_pstate_get_data(cpu, AMD_PSTATE_LOWEST_NONLINEAR_FREQ),
+		    no_rounding);
+	printf(".\n");
+
+	printf(_("    AMD PSTATE Lowest Performance: %lu. Lowest Frequency: "),
+	       acpi_cppc_get_data(cpu, LOWEST_PERF));
+	print_speed(acpi_cppc_get_data(cpu, LOWEST_FREQ) * 1000, no_rounding);
+	printf(".\n");
+}
+
+/* AMD P-State Helper Functions ************************************/
 #endif /* defined(__i386__) || defined(__x86_64__) */
diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 72eb43593180..eae91f11d187 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -149,6 +149,19 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 		if (ext_cpuid_level >= 0x80000008 &&
 		    cpuid_ebx(0x80000008) & (1 << 4))
 			cpu_info->caps |= CPUPOWER_CAP_AMD_RDPRU;
+
+		if (cpupower_amd_pstate_enabled()) {
+			cpu_info->caps |= CPUPOWER_CAP_AMD_PSTATE;
+
+			/*
+			 * If AMD P-State is enabled, the firmware will treat
+			 * AMD P-State function as high priority.
+			 */
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_CPB;
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_CPB_MSR;
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_HW_PSTATE;
+			cpu_info->caps &= ~CPUPOWER_CAP_AMD_PSTATEDEF;
+		}
 	}
 
 	if (cpu_info->vendor == X86_VENDOR_INTEL) {
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 33ffacee7fcb..96e4bede078b 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -11,6 +11,7 @@
 
 #include <libintl.h>
 #include <locale.h>
+#include <stdbool.h>
 
 #include "helpers/bitmask.h"
 #include <cpupower.h>
@@ -73,6 +74,7 @@ enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
 #define CPUPOWER_CAP_AMD_HW_PSTATE	0x00000100
 #define CPUPOWER_CAP_AMD_PSTATEDEF	0x00000200
 #define CPUPOWER_CAP_AMD_CPB_MSR	0x00000400
+#define CPUPOWER_CAP_AMD_PSTATE		0x00000800
 
 #define CPUPOWER_AMD_CPBDIS		0x02000000
 
@@ -135,6 +137,16 @@ extern int decode_pstates(unsigned int cpu, int boost_states,
 
 extern int cpufreq_has_boost_support(unsigned int cpu, int *support,
 				     int *active, int * states);
+
+/* AMD P-State stuff **************************/
+bool cpupower_amd_pstate_enabled(void);
+void amd_pstate_boost_init(unsigned int cpu,
+			   int *support, int *active);
+void amd_pstate_show_perf_and_freq(unsigned int cpu,
+				   int no_rounding);
+
+/* AMD P-State stuff **************************/
+
 /*
  * CPUID functions returning a single datum
  */
@@ -167,6 +179,15 @@ static inline int cpufreq_has_boost_support(unsigned int cpu, int *support,
 					    int *active, int * states)
 { return -1; }
 
+static inline bool cpupower_amd_pstate_enabled(void)
+{ return false; }
+static inline void amd_pstate_boost_init(unsigned int cpu, int *support,
+					 int *active)
+{}
+static inline void amd_pstate_show_perf_and_freq(unsigned int cpu,
+						 int no_rounding)
+{}
+
 /* cpuid and cpuinfo helpers  **************************/
 
 static inline unsigned int cpuid_eax(unsigned int op) { return 0; };
@@ -184,5 +205,6 @@ extern struct bitmask *offline_cpus;
 void get_cpustate(void);
 void print_online_cpus(void);
 void print_offline_cpus(void);
+void print_speed(unsigned long speed, int no_rounding);
 
 #endif /* __CPUPOWERUTILS_HELPERS__ */
diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
index fc6e34511721..9547b29254a7 100644
--- a/tools/power/cpupower/utils/helpers/misc.c
+++ b/tools/power/cpupower/utils/helpers/misc.c
@@ -3,9 +3,11 @@
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
+#include <string.h>
 
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
+#include "cpufreq.h"
 
 #if defined(__i386__) || defined(__x86_64__)
 
@@ -39,6 +41,8 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
 			if (ret)
 				return ret;
 		}
+	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATE) {
+		amd_pstate_boost_init(cpu, support, active);
 	} else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
 		*support = *active = 1;
 	return 0;
@@ -83,6 +87,22 @@ int cpupower_intel_set_perf_bias(unsigned int cpu, unsigned int val)
 	return 0;
 }
 
+bool cpupower_amd_pstate_enabled(void)
+{
+	char *driver = cpufreq_get_driver(0);
+	bool ret = false;
+
+	if (!driver)
+		return ret;
+
+	if (!strcmp(driver, "amd-pstate"))
+		ret = true;
+
+	cpufreq_put_driver(driver);
+
+	return ret;
+}
+
 #endif /* #if defined(__i386__) || defined(__x86_64__) */
 
 /* get_cpustate
@@ -144,3 +164,43 @@ void print_offline_cpus(void)
 		printf(_("cpupower set operation was not performed on them\n"));
 	}
 }
+
+/*
+ * print_speed
+ *
+ * Print the exact CPU frequency with appropriate unit
+ */
+void print_speed(unsigned long speed, int no_rounding)
+{
+	unsigned long tmp;
+
+	if (no_rounding) {
+		if (speed > 1000000)
+			printf("%u.%06u GHz", ((unsigned int)speed / 1000000),
+			       ((unsigned int)speed % 1000000));
+		else if (speed > 1000)
+			printf("%u.%03u MHz", ((unsigned int)speed / 1000),
+			       (unsigned int)(speed % 1000));
+		else
+			printf("%lu kHz", speed);
+	} else {
+		if (speed > 1000000) {
+			tmp = speed % 10000;
+			if (tmp >= 5000)
+				speed += 10000;
+			printf("%u.%02u GHz", ((unsigned int)speed / 1000000),
+			       ((unsigned int)(speed % 1000000) / 10000));
+		} else if (speed > 100000) {
+			tmp = speed % 1000;
+			if (tmp >= 500)
+				speed += 1000;
+			printf("%u MHz", ((unsigned int)speed / 1000));
+		} else if (speed > 1000) {
+			tmp = speed % 100;
+			if (tmp >= 50)
+				speed += 100;
+			printf("%u.%01u MHz", ((unsigned int)speed / 1000),
+			       ((unsigned int)(speed % 1000) / 100));
+		}
+	}
+}

--------------A69A2C635D1C6FA99A1D04FC--
