Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7964BBED3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbiBRR5p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 12:57:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbiBRR5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:57:42 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2437D45
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:57:25 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-LyuZhOUAM8KAwzhdnLs7oA-1; Fri, 18 Feb 2022 12:57:19 -0500
X-MC-Unique: LyuZhOUAM8KAwzhdnLs7oA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A476D1091DA0;
        Fri, 18 Feb 2022 17:57:17 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 713A82BCC1;
        Fri, 18 Feb 2022 17:57:15 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 1/3] rtla/hist: Make -E the short version of --entries
Date:   Fri, 18 Feb 2022 18:57:07 +0100
Message-Id: <5dbf0cbe7364d3a05e708926b41a097c59a02b1e.1645206561.git.bristot@kernel.org>
In-Reply-To: <cover.1645206561.git.bristot@kernel.org>
References: <cover.1645206561.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, --entries uses -e as the short version in the hist mode of
timerlat and osnoise tools. But as -e is already used to enable events
on trace sessions by other tools, thus let's keep it available for the
same usage for all rtla tools.

Make -E the short version of --entries for hist mode on all tools.

Note: rtla was merged in this merge window, so rtla was not released yet.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/tools/rtla/common_hist_options.rst |  2 +-
 Documentation/tools/rtla/rtla-osnoise-hist.rst   |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c            | 10 +++++-----
 tools/tracing/rtla/src/timerlat_hist.c           | 10 +++++-----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/tools/rtla/common_hist_options.rst b/Documentation/tools/rtla/common_hist_options.rst
index 0266cd08a6c9..df53ff835bfb 100644
--- a/Documentation/tools/rtla/common_hist_options.rst
+++ b/Documentation/tools/rtla/common_hist_options.rst
@@ -2,7 +2,7 @@
 
         Set the histogram bucket size (default *1*).
 
-**-e**, **--entries** *N*
+**-E**, **--entries** *N*
 
         Set the number of entries of the histogram (default 256).
 
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index 52298ddd8701..f2e79d22c4c4 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -36,7 +36,7 @@ default). The reason for reducing the runtime is to avoid starving the
 **rtla** tool. The tool is also set to run for *one minute*. The output
 histogram is set to group outputs in buckets of *10us* and *25* entries::
 
-  [root@f34 ~/]# rtla osnoise hist -P F:1 -c 0-11 -r 900000 -d 1M -b 10 -e 25
+  [root@f34 ~/]# rtla osnoise hist -P F:1 -c 0-11 -r 900000 -d 1M -b 10 -E 25
   # RTLA osnoise histogram
   # Time unit is microseconds (us)
   # Duration:   0 00:01:00
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 1f0b7fce55cf..52c053cc1789 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -426,7 +426,7 @@ static void osnoise_hist_usage(char *usage)
 	static const char * const msg[] = {
 		"",
 		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-p us] [-r us] [-s us] [-S us] [-t[=file]] \\",
-		"	  [-c cpu-list] [-P priority] [-b N] [-e N] [--no-header] [--no-summary] \\",
+		"	  [-c cpu-list] [-P priority] [-b N] [-E N] [--no-header] [--no-summary] \\",
 		"	  [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
@@ -439,7 +439,7 @@ static void osnoise_hist_usage(char *usage)
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|osnoise_trace.txt]",
 		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
-		"	  -e/--entries N: set the number of entries of the histogram (default 256)",
+		"	  -E/--entries N: set the number of entries of the histogram (default 256)",
 		"	     --no-header: do not print header",
 		"	     --no-summary: do not print summary",
 		"	     --no-index: do not print index",
@@ -486,7 +486,7 @@ static struct osnoise_hist_params
 	while (1) {
 		static struct option long_options[] = {
 			{"bucket-size",		required_argument,	0, 'b'},
-			{"entries",		required_argument,	0, 'e'},
+			{"entries",		required_argument,	0, 'E'},
 			{"cpus",		required_argument,	0, 'c'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
@@ -507,7 +507,7 @@ static struct osnoise_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "c:b:d:e:Dhp:P:r:s:S:t::0123",
+		c = getopt_long(argc, argv, "c:b:d:E:Dhp:P:r:s:S:t::0123",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -534,7 +534,7 @@ static struct osnoise_hist_params
 			if (!params->duration)
 				osnoise_hist_usage("Invalid -D duration\n");
 			break;
-		case 'e':
+		case 'E':
 			params->entries = get_llong_from_str(optarg);
 			if ((params->entries < 10) || (params->entries > 9999999))
 				osnoise_hist_usage("Entries must be > 10 and < 9999999\n");
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 436a799f9adf..237e1735afa7 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -429,7 +429,7 @@ static void timerlat_hist_usage(char *usage)
 	char *msg[] = {
 		"",
 		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] [-t[=file]] \\",
-		"         [-c cpu-list] [-P priority] [-e N] [-b N]  [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
+		"         [-c cpu-list] [-P priority] [-E N] [-b N]  [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
 		"         [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
@@ -443,7 +443,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -T/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
 		"	  -n/--nano: display data in nanoseconds",
 		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
-		"	  -e/--entries N: set the number of entries of the histogram (default 256)",
+		"	  -E/--entries N: set the number of entries of the histogram (default 256)",
 		"	     --no-irq: ignore IRQ latencies",
 		"	     --no-thread: ignore thread latencies",
 		"	     --no-header: do not print header",
@@ -494,7 +494,7 @@ static struct timerlat_hist_params
 			{"cpus",		required_argument,	0, 'c'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"debug",		no_argument,		0, 'D'},
-			{"entries",		required_argument,	0, 'e'},
+			{"entries",		required_argument,	0, 'E'},
 			{"duration",		required_argument,	0, 'd'},
 			{"help",		no_argument,		0, 'h'},
 			{"irq",			required_argument,	0, 'i'},
@@ -516,7 +516,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "c:b:d:e:Dhi:np:P:s:t::T:012345",
+		c = getopt_long(argc, argv, "c:b:d:E:Dhi:np:P:s:t::T:012345",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -543,7 +543,7 @@ static struct timerlat_hist_params
 			if (!params->duration)
 				timerlat_hist_usage("Invalid -D duration\n");
 			break;
-		case 'e':
+		case 'E':
 			params->entries = get_llong_from_str(optarg);
 			if ((params->entries < 10) || (params->entries > 9999999))
 					timerlat_hist_usage("Entries must be > 10 and < 9999999\n");
-- 
2.34.1

