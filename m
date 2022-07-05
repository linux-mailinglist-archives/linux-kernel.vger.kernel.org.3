Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DC75664C3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiGEIJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGEIJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:09:20 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8070962D1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:09:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so5709184pjn.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:content-language
         :to:from:subject:organization:content-transfer-encoding;
        bh=lH4IraMjDQIc3xg7hdCPG5Ni3hmmo4y/xTgGaamoYPA=;
        b=YkSSF+WtLhCLd6jIjY2Lg3IBYFxSs4HVW0SRZfPl7/k8jCQ+MDZfUebgfsAuGSb7tO
         l0lgOss0G6f5pph7A3L3MiDnkFA9Tcc9OB1c854frVAk00tRLW5tk1dCo8zcI+iE42So
         jkKW6dsaWLKeOpS4nOZ8hywzXqUc4nhgzu5j1Y6d+jSnVn+h22A/8FvpVLfbXOsPActo
         iQL9whiWMwnQv7DFGNVaFHOhnsH+fjvYTPbP0jiWgsmF8dh96B6Kqql6O/zDSzeYgaBT
         rjtTtOzjQr2yGksCxnumeJ/msx/leGE0UXoTDdw27uUOvalsWb9RvhIEvgUo9+y4a1xx
         brvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :content-language:to:from:subject:organization
         :content-transfer-encoding;
        bh=lH4IraMjDQIc3xg7hdCPG5Ni3hmmo4y/xTgGaamoYPA=;
        b=n7KYEP1FyukOvRS4hSXn42u3G4nF1edUbHNEShBg1nZhIpsR1ZTfQHYgJdRhrF3rgr
         kMwYUhNC7LFmpmzjG4DnfrxYJB/vVq9RGhuzpBmB2D/WrNjBvK7pLxpJRMpS/Ra4xlVI
         OV96XWJridl/T9PLE4/15HWbYNxtgcBSER+MvCqE9JYoDhJE8CBhtBldE5cUXkVwu6j6
         L+bLgnHlCKIKXQou5kDDpHX7dGv65j1OLF9dm1GASWMz/5N6DWKCn7WyCKnfji2DjxPB
         TPsgRrVkj/o0nrQuIxHfKlrIiAGZyrx5CSDgDCHVfA2OKoc+71YnJe7OLI8FkE/VJ3Q5
         m5IQ==
X-Gm-Message-State: AJIora/64Kr+nyyuIzMqMq0mhpJC7iBUqTMf1Yw8/D5QTugMZPF4IzFr
        6zNAnndCmIzV8SO4LJD7xrc=
X-Google-Smtp-Source: AGRyM1vX3TT9zjik8dc8qqqLcHGCHObZTQ087xLkuPSzBW4Eh54iccRTrYgfyZDcSmD6Ix4RjtTL3w==
X-Received: by 2002:a17:90a:a605:b0:1ea:6b4f:915e with SMTP id c5-20020a17090aa60500b001ea6b4f915emr41990567pjq.60.1657008558880;
        Tue, 05 Jul 2022 01:09:18 -0700 (PDT)
Received: from [192.168.10.101] (p0594749-vcngn.tkyo.nt.ngn.ppp.ocn.ne.jp. [211.125.9.60])
        by smtp.gmail.com with ESMTPSA id x9-20020a1709027c0900b0016b8a72740dsm15601339pll.222.2022.07.05.01.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 01:09:18 -0700 (PDT)
Message-ID: <d1ff3c27-e248-56ff-89b8-7b75c0f817ba@gmail.com>
Date:   Tue, 5 Jul 2022 17:09:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Reply-To: hayashizaki.masayuki@gmail.com
Content-Language: en-US
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        irogers@google.com
From:   Hayashizaki Masayuki <hayashizaki.masayuki@gmail.com>
Subject: [GIT PULL] tools/perf/pmu-events: Fix some typo (2022-07-05 05:10:43
 +0900)
Organization: AkariSpetification
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I sent a pull request. Please review and merge.

Reason:
Fix some typo.

Git repository URL:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Branch name:
pmu-events-fixes-5.19-5

Pull request log:
git request-pull origin/master pmu-events-fixes-5.19-5
fatal: 'pmu-events-fixes-5.19-5' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
warn: No match for commit 2a3f9ec126ba4bb036b638ede6794c3ce313c6c4 found 
at pmu-events-fixes-5.19-5
warn: Are you sure you pushed 'HEAD' there?
The following changes since commit c1084b6c5620a743f86947caca66d90f24060f56:

   Merge tag 'soc-fixes-5.19-2' of 
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2022-07-04 
10:41:59 -0700)

are available in the Git repository at:

   pmu-events-fixes-5.19-5

for you to fetch changes up to 2a3f9ec126ba4bb036b638ede6794c3ce313c6c4:

   tools/perf/pmu-events: Fix some typo (2022-07-05 05:10:43 +0900)

----------------------------------------------------------------
Hayashizaki Masayuki (1):
       tools/perf/pmu-events: Fix some typo

  tools/perf/pmu-events/arch/x86/broadwell/pipeline.json   | 10 +++++-----
  tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json | 10 +++++-----
  tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json  | 10 +++++-----
  tools/perf/pmu-events/arch/x86/haswell/pipeline.json     | 10 +++++-----
  tools/perf/pmu-events/arch/x86/haswellx/pipeline.json    | 10 +++++-----
  5 files changed, 25 insertions(+), 25 deletions(-)

Diff:
diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json 
b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
index 18d21b94a4b9..23e0c3fadc53 100644
--- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
@@ -1133,7 +1133,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 0.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 0.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
@@ -1153,7 +1153,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 1.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 1.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
@@ -1213,7 +1213,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 4.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 4.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
@@ -1233,7 +1233,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 5.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 5.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
@@ -1253,7 +1253,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 6.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 6.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json 
b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
index 7580b8af0d13..b67eba679844 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
@@ -1133,7 +1133,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 0.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 0.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
@@ -1153,7 +1153,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 1.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 1.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
@@ -1213,7 +1213,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 4.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 4.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
@@ -1233,7 +1233,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 5.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 5.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
@@ -1253,7 +1253,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 6.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 6.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json 
b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
index 18d21b94a4b9..23e0c3fadc53 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
@@ -1133,7 +1133,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 0.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 0.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
@@ -1153,7 +1153,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 1.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 1.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
@@ -1213,7 +1213,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 4.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 4.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
@@ -1233,7 +1233,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 5.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 5.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
@@ -1253,7 +1253,7 @@
      },
      {
          "AnyThread": "1",
-        "BriefDescription": "Cycles per core when uops are exectuted in 
port 6.",
+        "BriefDescription": "Cycles per core when uops are executed in 
port 6.",
          "Counter": "0,1,2,3",
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
diff --git a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json 
b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
index a53f28ec9270..06fbe7d34a8c 100644
--- a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
@@ -1035,7 +1035,7 @@
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
          "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted 
in port 0.",
+        "PublicDescription": "Cycles per core when uops are executed in 
port 0.",
          "SampleAfterValue": "2000003",
          "UMask": "0x1"
      },
@@ -1056,7 +1056,7 @@
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
          "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted 
in port 1.",
+        "PublicDescription": "Cycles per core when uops are executed in 
port 1.",
          "SampleAfterValue": "2000003",
          "UMask": "0x2"
      },
@@ -1117,7 +1117,7 @@
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
          "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted 
in port 4.",
+        "PublicDescription": "Cycles per core when uops are executed in 
port 4.",
          "SampleAfterValue": "2000003",
          "UMask": "0x10"
      },
@@ -1138,7 +1138,7 @@
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
          "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted 
in port 5.",
+        "PublicDescription": "Cycles per core when uops are executed in 
port 5.",
          "SampleAfterValue": "2000003",
          "UMask": "0x20"
      },
@@ -1159,7 +1159,7 @@
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
          "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted 
in port 6.",
+        "PublicDescription": "Cycles per core when uops are executed in 
port 6.",
          "SampleAfterValue": "2000003",
          "UMask": "0x40"
      },
diff --git a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json 
b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
index a53f28ec9270..06fbe7d34a8c 100644
--- a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
@@ -1035,7 +1035,7 @@
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
          "EventName": "UOPS_EXECUTED_PORT.PORT_0_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted 
in port 0.",
+        "PublicDescription": "Cycles per core when uops are executed in 
port 0.",
          "SampleAfterValue": "2000003",
          "UMask": "0x1"
      },
@@ -1056,7 +1056,7 @@
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
          "EventName": "UOPS_EXECUTED_PORT.PORT_1_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted 
in port 1.",
+        "PublicDescription": "Cycles per core when uops are executed in 
port 1.",
          "SampleAfterValue": "2000003",
          "UMask": "0x2"
      },
@@ -1117,7 +1117,7 @@
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
          "EventName": "UOPS_EXECUTED_PORT.PORT_4_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted 
in port 4.",
+        "PublicDescription": "Cycles per core when uops are executed in 
port 4.",
          "SampleAfterValue": "2000003",
          "UMask": "0x10"
      },
@@ -1138,7 +1138,7 @@
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
          "EventName": "UOPS_EXECUTED_PORT.PORT_5_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted 
in port 5.",
+        "PublicDescription": "Cycles per core when uops are executed in 
port 5.",
          "SampleAfterValue": "2000003",
          "UMask": "0x20"
      },
@@ -1159,7 +1159,7 @@
          "CounterHTOff": "0,1,2,3,4,5,6,7",
          "EventCode": "0xA1",
          "EventName": "UOPS_EXECUTED_PORT.PORT_6_CORE",
-        "PublicDescription": "Cycles per core when uops are exectuted 
in port 6.",
+        "PublicDescription": "Cycles per core when uops are executed in 
port 6.",
          "SampleAfterValue": "2000003",
          "UMask": "0x40"
      },
-- 
Hayashizaki Masayuki
hayashizaki.masayuki@gmail.com
AkariSpetification / Developer
https://akari.mn
