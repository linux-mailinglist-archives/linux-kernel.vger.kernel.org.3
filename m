Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC564C4903
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbiBYPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbiBYPco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:32:44 -0500
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBC921BC56;
        Fri, 25 Feb 2022 07:32:11 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id y189so6599505ybe.4;
        Fri, 25 Feb 2022 07:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XIo95I5CSuDu07kV8bCF7A7OdJcPDQG/mfn+QtIzwws=;
        b=A9M5wD951NfXbYNzb49x3RGiheguUGPUIzm9bUhvmUSRmZsMJEWfX4FhgBcyo2OzXi
         Ed+24uYaZTwwMEZTjpZ9W6wL7t+bL0ZF7gzYF+JCopzuGF37iN8qNlhzj5RwJ4x9VLKL
         gHPdXWph0BRFGmFJgRnUqHdcgJI77UPGGhNiiL6+1OOY5HL3G9xpL2ooAoZKMETX3FOd
         OxfonnTA4PQzUydWafG2qdfZBmaa9V/BPpp/bIJX/Twb7qUmrmYVpdk6nOeFXbN+fGgO
         ALTuottRT4EAtrKsFPnPCMOnFVDp0Aez5lmPE5YIGXEKPdREMtL1SBIa72cUcmRnL2xA
         pkvg==
X-Gm-Message-State: AOAM533BvUvhZoecHZCxWyAdgfiN9ULmLloPUyWHrqjKt+aQivMyIRU+
        Ji5TC6mUI6u0CtJDX9O2smPjN1MRtj3/feArsV0Un5KS27E=
X-Google-Smtp-Source: ABdhPJz06MkArKMDiWXp9ew08baAlYqqGdxwREv8k4v/aL1+G7trQrEVut30eFI/sMoXOezJNX7TkPmMY6CEkoUASdI=
X-Received: by 2002:a25:378f:0:b0:61d:8e8b:6cf5 with SMTP id
 e137-20020a25378f000000b0061d8e8b6cf5mr7385521yba.622.1645803131002; Fri, 25
 Feb 2022 07:32:11 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Feb 2022 16:32:00 +0100
Message-ID: <CAJZ5v0jOz82pc7KvQrmBojyOAdL6tGnNtfqspROFf3j0+5enGA@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.17-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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
 pm-5.17-rc6

with top-most commit c5eb92f57de2446e0071c3af70ea54f237eb05d5

 Merge branch 'cpufreq/arm/fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

on top of commit cfb92440ee71adcc2105b0890bb01ac3cddb8507

 Linux 5.17-rc5

to receive power management fixes for 5.17-rc6.

These fix the throttle IRQ handling during cpufreq initialization on
Qualcomm platforms (Bjorn Andersson).

Thanks!


---------------

Bjorn Andersson (2):
      cpufreq: Reintroduce ready() callback
      cpufreq: qcom-hw: Delay enabling throttle_irq

---------------

 Documentation/cpu-freq/cpu-drivers.rst                    |  3 +++
 Documentation/translations/zh_CN/cpu-freq/cpu-drivers.rst |  2 ++
 drivers/cpufreq/cpufreq.c                                 |  4 ++++
 drivers/cpufreq/qcom-cpufreq-hw.c                         | 11 ++++++++++-
 include/linux/cpufreq.h                                   |  3 +++
 5 files changed, 22 insertions(+), 1 deletion(-)
