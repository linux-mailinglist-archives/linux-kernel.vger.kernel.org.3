Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E66563A33
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiGATyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiGATyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:54:24 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3683A393D6;
        Fri,  1 Jul 2022 12:54:23 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31780ad7535so33403607b3.8;
        Fri, 01 Jul 2022 12:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0jZbzvSJLsbSCPeKykkBVX68fkas6FX34DPyZvRNxH0=;
        b=B4ewZ7KVzyo1nehiyA0Zm0d8twYlmVkkPRclMEr2x8WDK+EOYUGfAyn1ue4Bxb9PiD
         vSIc7vPJCyFolgHxvip2Axzj0GtJhpR51kMn2DhMwscsfbuti6MjbkAcCRGKjpCx4XFN
         6RN7ckMjL9HRmsrxw9lvzitjEmwBsI1GNfSub3ITGX6WYpnjRV7GRstzUH3NNTXQre4R
         z/yy+kQBZsKtEOB/Uyuc34gM9rLPI1+ffTat0DKrGfghYDwpopjy6+K45XeYK3V2bwN1
         0DvVmQKcMRQqR9M1OyfOTy3OzX1jY8qgL3O/76pAIWGJ16EsAYPOJjFZRVCg+5bVfi84
         iFOg==
X-Gm-Message-State: AJIora/965aZezGeYBZnVNYmG4WjfCubS9S4glOqXtsjZK2pXqW7vLdC
        YCsW0det7kAO+ckrb6pqxXH2oVJTd1BUxsg1Jfv5CYZOvY4=
X-Google-Smtp-Source: AGRyM1t7uMohhytuJ9yuKsXY2gM3A9md7ex8xqm/F7o6cxx65Y5yoyGkG/67hw8uqRmzH4RieLNyF5y7Qm91IAHBVf8=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr18541343ywb.326.1656705262395; Fri, 01
 Jul 2022 12:54:22 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Jul 2022 21:54:11 +0200
Message-ID: <CAJZ5v0i25SEq5cNqC3hxkSJwcpstdJ36_xBVs=wPZ1Dz=TiC5Q@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.19-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.19-rc5

with top-most commit bc621588ff591564ea01ad107e7bae869c1c0285

 Merge branch 'pm-cpufreq'

on top of commit 03c765b0e3b4cb5063276b086c76f7a612856a9a

 Linux 5.19-rc4

to receive power management fixes for 5.19-rc5.

These fix some issues in cpufreq drivers and some issues in devfreq:

 - Fix error code path issues related to PROBE_DEFER handling in
   devfreq (Christian Marangi).

 - Revert an editing accident in SPDX-License line in the devfreq
   passive governor (Lukas Bulwahn).

 - Fix refcount leak in of_get_devfreq_events() in the exynos-ppmu
   devfreq driver (Miaoqian Lin).

 - Use HZ_PER_KHZ macro in the passive devfreq governor (Yicong Yang).

 - Fix missing of_node_put for qoriq and pmac32 driver (Liang He).

 - Fix issues around throttle interrupt for qcom driver (Stephen Boyd).

 - Add MT8186 to cpufreq-dt-platdev blocklist (AngeloGioacchino Del
   Regno).

 - Make amd-pstate enable CPPC on resume from S3 (Jinzhou Su).

Thanks!


---------------

AngeloGioacchino Del Regno (1):
      cpufreq: Add MT8186 to cpufreq-dt-platdev blocklist

Christian Marangi (5):
      PM / devfreq: Fix kernel panic with cpu based scaling to passive gov
      PM / devfreq: Mute warning on governor PROBE_DEFER
      PM / devfreq: Fix cpufreq passive unregister erroring on PROBE_DEFER
      PM / devfreq: Rework freq_table to be local to devfreq struct
      PM / devfreq: Fix kernel warning with cpufreq passive register fail

Jinzhou Su (1):
      cpufreq: amd-pstate: Add resume and suspend callbacks

Liang He (2):
      drivers: cpufreq: Add missing of_node_put() in qoriq-cpufreq.c
      cpufreq: pmac32-cpufreq: Fix refcount leak bug

Lukas Bulwahn (1):
      PM / devfreq: passive: revert an editing accident in SPDX-License line

Miaoqian Lin (1):
      PM / devfreq: exynos-ppmu: Fix refcount leak in of_get_devfreq_events

Stephen Boyd (1):
      cpufreq: qcom-hw: Don't do lmh things without a throttle interrupt

Yicong Yang (1):
      PM / devfreq: passive: Use HZ_PER_KHZ macro in units.h

---------------

 drivers/cpufreq/amd-pstate.c         | 24 ++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 drivers/cpufreq/pmac32-cpufreq.c     |  4 ++
 drivers/cpufreq/qcom-cpufreq-hw.c    |  6 +++
 drivers/cpufreq/qoriq-cpufreq.c      |  1 +
 drivers/devfreq/devfreq.c            | 76 ++++++++++++++++++------------------
 drivers/devfreq/event/exynos-ppmu.c  |  8 +++-
 drivers/devfreq/governor_passive.c   | 62 +++++++++++++----------------
 include/linux/devfreq.h              |  5 +++
 9 files changed, 111 insertions(+), 76 deletions(-)
