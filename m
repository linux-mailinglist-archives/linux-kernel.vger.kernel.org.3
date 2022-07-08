Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3EC56BC44
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbiGHPAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 11:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiGHPAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 11:00:43 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63A6252B7;
        Fri,  8 Jul 2022 08:00:42 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r2so27707743qta.0;
        Fri, 08 Jul 2022 08:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PSI4KLEuzkabIqqadLT6+X8M6jfSSpKpVHtyF/imonU=;
        b=C6am7rebaM0Tifi+XLxyOed4RDqyyUpGEqHhJv6tlPppXmzeC6Fillwk2V58Dm/AAE
         t/vcsaxZvH4O2H7SReRcrxqK3/G1j1n3qmXC3pN7mQ14IVHk+1CyX38YlZwcUkQe8F/+
         8F4Y0xqHWQtBRP+D9CiPasDGCW7fxytOMIYZS5qlZY5VcEjDJIpoZox/Z3geLo7l2WYv
         ZZt3tdF6VRebIoLzUGm8yllF735stIhXHd66SQWORhPhY0wBO5qycY7VX3ynNPXIBWh3
         zb5Jvl2ttJIfZ7HAueYgP2+zmv5/HkTCXOrWqdMqyAW+j2dS62L3d0pTuCd0oIdwaCIt
         eDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PSI4KLEuzkabIqqadLT6+X8M6jfSSpKpVHtyF/imonU=;
        b=0u/Hs0tvn9iK/iqrYtQl46degCO/bMEsKIfYXW6VGiao32K7Ks+AZti90FFhFHIGcj
         DLLyhlfT+Qbu/bdLSDPKJd9TDBfj/NN86D/0Rt8k2HOuoO6nsurw+T2Xvu6yFPSmD8UJ
         6K6DOqU/rbwXKH4a6IlwJYv3rkzW65a+altZzKBoe2k5yjDjkqPaafdK6UILdX/Hd4jt
         ZQ+Kcel34soDdTJrKXRn6J/ph1QwlhM9eN4Xnyv4SVD4bzLvwIFfDSkUTMCOKYMrNhHd
         na4S9e2N8F0+LweNQqzr8BEZEjzXCVVDUD9cq9C/5qcWiSAmhwRoCNIYUQAo1EaH2GSv
         ZvVQ==
X-Gm-Message-State: AJIora/dtfY/bCU80pb1u7lwrh/6GDO1gKBIE9BrrbXyiXdP2Nb7ViNq
        u2OVMGuZ45Xr9v/Dtn3tZOE7k6FZsuo=
X-Google-Smtp-Source: AGRyM1tfZAHLe/EFx4sZ0b2lTA9QuQx+Ojm07ZEfBw+nta/I97l4QIA1Y9vugt4RgHd9paBi12VEUA==
X-Received: by 2002:ad4:5d6f:0:b0:470:6dd0:c407 with SMTP id fn15-20020ad45d6f000000b004706dd0c407mr3140797qvb.121.1657292441725;
        Fri, 08 Jul 2022 08:00:41 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-180.dsl.bell.ca. [184.147.143.180])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a410d00b006a716fed4d6sm5091100qko.50.2022.07.08.08.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 08:00:41 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia Poulin <kcarcia@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rt-tests-2.4
Date:   Fri,  8 Jul 2022 11:00:17 -0400
Message-Id: <20220708150017.13462-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm pleased to announce version 2.4 of the rt-tests suite.

Thanks to everyone who contributed!

John Kacur

To fetch:

Clone
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git

Branch: main

Tag: v2.4

Tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rt-tests/older

John Kacur (5):
  rt-tests: Fix parsing of affinity when there is a space.
  rt-tests: Remove classic_pi
  rt-tests: Makefile: ctags: Change obsolete extra to extras
  rt-tests: cyclictest: Fix seg fault for verbose with no affinity maxk
  rt-tests: Change to version v2.4

Liwei Song (1):
  rt-migrate-test: increase the buf size to 2048 when parse cpuinfo

Marcelo Tosatti (1):
  rt-numa: ignore runtime cpumask if -a CPULIST is specified

Nicolas Saenz Julienne (1):
  oslat: Print offending cpu number when above threshold

Oscar Shiang (3):
  rt-numa: Correct the comment of numa_initialize()
  rt-tests: oslat.8: Remove the argument of --bias
  rt-tests: hwlatdetect: Add option to specify cpumask

Sebastian Andrzej Siewior (1):
  cyclictest: Delay setting of main_affinity_mask after creating
    threads.

Song Chen (1):
  sched_deadline/cyclicdeadline: add tracelimit

Yihao Wu (1):
  hackbench: Add af_inet mode besides af_unix and pipe

bartwensley (1):
  rt-tests: resync has_smi_counter with turbostat code

 Makefile                              |   6 +-
 src/cyclictest/cyclictest.c           | 119 +++--
 src/hackbench/hackbench.c             |  57 ++-
 src/hwlatdetect/hwlatdetect.8         |   3 +
 src/hwlatdetect/hwlatdetect.py        |  19 +
 src/lib/rt-numa.c                     |   5 +-
 src/oslat/oslat.8                     |   2 +-
 src/oslat/oslat.c                     |   8 +-
 src/pi_tests/classic_pi.c             | 599 --------------------------
 src/pi_tests/classic_pi.odg           | Bin 12470 -> 0 bytes
 src/rt-migrate-test/rt-migrate-test.c |   4 +-
 src/sched_deadline/cyclicdeadline.8   |   6 +
 src/sched_deadline/cyclicdeadline.c   |  49 ++-
 src/signaltest/signaltest.c           |   4 +-
 14 files changed, 227 insertions(+), 654 deletions(-)
 delete mode 100644 src/pi_tests/classic_pi.c
 delete mode 100644 src/pi_tests/classic_pi.odg

-- 
2.36.1

