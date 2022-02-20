Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6164BCFE0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 17:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243243AbiBTQbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 11:31:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiBTQbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 11:31:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FAD4AE05
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 08:30:52 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vz16so27221938ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 08:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2G6HGRIzCEmE89H5wDpfU+oum09SC6vpI/xczji82A=;
        b=AkbjzHgV9zAu+zUIS1gUtT7UUoz24Rd+RulaxnOYTnhuVhMv8ciKvmOXKJ9MNH5Ufo
         cMl5bT4W2+I41xgKLzdLdrzVgCz+Kd5CqxrWIRrBaolVDmmtB8SygNkmKQzz1TngbIr3
         IhZibbm91cW81DxNmoVgm6U/IF3pe9cyH8UDL0TWqZgZUGJZceDvfcIvSKfbi2CSobRP
         U2M8Jh2NbaYxT82AkpiybWMHoKp1HKFHaCWrYnPkr0C56kG8/oTfnzq/bkm4F6pqe/hj
         pOtK6rFoGu3FcEvmLjDJhkQHymdgVVW04snF79Uoqzydd3/JBqwP9O3FFnrt+JCwmeBE
         NL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p2G6HGRIzCEmE89H5wDpfU+oum09SC6vpI/xczji82A=;
        b=AnGtNT2V/Wq+bZzXpmGxv8x8NMT4r7oR3ht31JIbkUpMlzUvE3bxRUM1KVSXl+TBj3
         fzt9rMf7qc857BZWEPywCZfRJqg4oDspqcvHvw2rJQJjWdg44F+g5SNBBeVRtrlEA/Vj
         MmwotqCRo4e0MGVgJKKso+izet4XfITYUbpibEEWyN0Unk5OFiY3tljLAetlevrBlFAJ
         9E2yYQZgENVezMSHriyTPIMBIUUOCt6Z9TFglaLLQm4ZkXUogJv2PH0VeZG/lSVtbBLP
         X/gJIV61J+xqpOdOCPDRtZaZ6dRcj0xw+xi1W2SN2Sw2GuuowkBGK0luPIdD5s5miB3/
         PnpQ==
X-Gm-Message-State: AOAM531U40Jg+uvSPrnfVeFrGE7kGx7I+6UX+g0SfmsA7o17oha1iNr3
        eS8UWBKanpMd7GcI93sWmQT+69SJGHQkLzoioIhgNw==
X-Google-Smtp-Source: ABdhPJyWuK3ZtXL+Ui7a8rINYgV8rUuNpF0LH8+fcBRpHY21q6RQ8yfGkcO163Rza0GTKh6g9JyLlg==
X-Received: by 2002:a17:906:d9c4:b0:6cc:ecbd:3667 with SMTP id qk4-20020a170906d9c400b006ccecbd3667mr12915863ejb.645.1645374650685;
        Sun, 20 Feb 2022 08:30:50 -0800 (PST)
Received: from localhost.localdomain ([217.61.0.106])
        by smtp.gmail.com with ESMTPSA id j19sm4277072ejm.111.2022.02.20.08.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 08:30:50 -0800 (PST)
From:   Hans Weber <hwe.kernel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Hans Weber <hwe.kernel@gmail.com>
Subject: [PATCH 3/3] patch : first example not showing umask field from Table 1-2
Date:   Sun, 20 Feb 2022 17:30:47 +0100
Message-Id: <20220220163047.117864-1-hwe.kernel@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signe-off-by: Hans Weber <hwe.kernel@gmail.com>
---
 Documentation/filesystems/proc.rst | 105 ++++++++++++++++-------------
 1 file changed, 58 insertions(+), 47 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index b9d1c6764266..40ca0f9087db 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -138,7 +138,7 @@ usually fail with ESRCH.
            /proc (as of 5.10.0) 
 
  ======================================================================================
- Name   	      T  Content
+ Name		      T  Content
  ======================================================================================
  arch_status          f Task architecture specific information
  attr                 d API for security modules
@@ -213,52 +213,63 @@ usually fail with ESRCH.
 For example, to get the status information of a process, all you have to do is
 read the file /proc/PID/status::
 
-  >cat /proc/self/status
-  Name:   cat
-  State:  R (running)
-  Tgid:   5452
-  Pid:    5452
-  PPid:   743
-  TracerPid:      0						(2.4)
-  Uid:    501     501     501     501
-  Gid:    100     100     100     100
-  FDSize: 256
-  Groups: 100 14 16
-  VmPeak:     5004 kB
-  VmSize:     5004 kB
-  VmLck:         0 kB
-  VmHWM:       476 kB
-  VmRSS:       476 kB
-  RssAnon:             352 kB
-  RssFile:             120 kB
-  RssShmem:              4 kB
-  VmData:      156 kB
-  VmStk:        88 kB
-  VmExe:        68 kB
-  VmLib:      1412 kB
-  VmPTE:        20 kb
-  VmSwap:        0 kB
-  HugetlbPages:          0 kB
-  CoreDumping:    0
-  THP_enabled:	  1
-  Threads:        1
-  SigQ:   0/28578
-  SigPnd: 0000000000000000
-  ShdPnd: 0000000000000000
-  SigBlk: 0000000000000000
-  SigIgn: 0000000000000000
-  SigCgt: 0000000000000000
-  CapInh: 00000000fffffeff
-  CapPrm: 0000000000000000
-  CapEff: 0000000000000000
-  CapBnd: ffffffffffffffff
-  CapAmb: 0000000000000000
-  NoNewPrivs:     0
-  Seccomp:        0
-  Speculation_Store_Bypass:       thread vulnerable
-  SpeculationIndirectBranch:      conditional enabled
-  voluntary_ctxt_switches:        0
-  nonvoluntary_ctxt_switches:     1
+>cat /proc/self/status
+Name:	cat
+Umask:	0022
+State:	R (running)
+Tgid:	19633
+Ngid:	0
+Pid:	19633
+PPid:	13898
+TracerPid:	0
+Uid:	1000	1000	1000	1000
+Gid:	1000	1000	1000	1000
+FDSize:	256
+Groups:	24 25 27 29 30 44 46 108 113 114 119 1000 
+NStgid:	19633
+NSpid:	19633
+NSpgid:	19633
+NSsid:	13898
+VmPeak:	    5440 kB
+VmSize:	    5440 kB
+VmLck:	       0 kB
+VmPin:	       0 kB
+VmHWM:	     520 kB
+VmRSS:	     520 kB
+RssAnon:	      68 kB
+RssFile:	     452 kB
+RssShmem:	       0 kB
+VmData:	     316 kB
+VmStk:	     132 kB
+VmExe:	      20 kB
+VmLib:	    1460 kB
+VmPTE:	      44 kB
+VmSwap:	       0 kB
+HugetlbPages:	       0 kB
+CoreDumping:	0
+THP_enabled:	1
+Threads:	1
+SigQ:	0/47433
+SigPnd:	0000000000000000
+ShdPnd:	0000000000000000
+SigBlk:	0000000000000000
+SigIgn:	0000000000000000
+SigCgt:	0000000000000000
+CapInh:	0000000000000000
+CapPrm:	0000000000000000
+CapEff:	0000000000000000
+CapBnd:	000001ffffffffff
+CapAmb:	0000000000000000
+NoNewPrivs:	0
+Seccomp:	0
+Seccomp_filters:	0
+Speculation_Store_Bypass:	vulnerable
+Cpus_allowed:	ff
+Cpus_allowed_list:	0-7
+Mems_allowed:	00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000001
+Mems_allowed_list:	0
+voluntary_ctxt_switches:	0
+nonvoluntary_ctxt_switches:	0
 
 This shows you nearly the same information you would get if you viewed it with
 the ps  command.  In  fact,  ps  uses  the  proc  file  system  to  obtain its
-- 
2.30.2

