Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5983D56C386
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239366AbiGHTUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGHTUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:20:05 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BBA167EA;
        Fri,  8 Jul 2022 12:20:04 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id r3so39353274ybr.6;
        Fri, 08 Jul 2022 12:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M7CMxMpAwaG1MqNPytiWNPh0UB9uZ/2w81H3Zj9t5RA=;
        b=Kb3gjypPpLB/zsZMH4XXkNLFBYlZFcmUxl9CfNYymvGGX3McB9LWf7xrvB6OPTO3hF
         3Lhh9L2hJtY77n0Fb6JrHzXhnkk5jNzSHF/Bk6hrQHdhKQ+gUxdzXsTamApWOMpw3qcu
         armPr6ZhaDZ6Tpz2/XNpw0S1IAzfvkoXEyfTDEaOXo2F8jhh/gJhbQFKygJSXAjiM4y8
         QQ35/I7KcMTE2HjvYCB/rwu2fX/L+51PqSVOXeglSDaiUt1fjhmPPEkmrMPpOf5blvG2
         vaBFZq0rnxlhMkVMq0OaWo4bO4YuscKeckvl0nDxH+JFgXkCm1+DYMuySfwJMUQs5A97
         e2yA==
X-Gm-Message-State: AJIora8iX0oRbIuexSXMlgdk1M4ysQ+oUHUJEfI/IXxFTg0L78MdRPxU
        OtDtcZXSTA9IwIDPzxbTI9cghOM8zCj7GoKu5QWQ1Uo1RNE=
X-Google-Smtp-Source: AGRyM1uUHMQdTqbeGGG/jL/jWci1lO985PbtRSbTT50EcJ9vwWBxrmX4EGboe5lr7UI5GWGZBc7XFdpX77laKRWXY3w=
X-Received: by 2002:a25:a2ca:0:b0:66e:719e:279 with SMTP id
 c10-20020a25a2ca000000b0066e719e0279mr4938693ybn.622.1657308003304; Fri, 08
 Jul 2022 12:20:03 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Jul 2022 21:19:50 +0200
Message-ID: <CAJZ5v0hASBaOm4m9b7S5Y1ATfL8ppL07g_dpgVcceXmtnOMRcw@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.19-rc6
To:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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
 acpi-5.19-rc6

with top-most commit 8b356e536e69f3a4d6778ae9f0858a1beadabb1f

 ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is supported

on top of commit 88084a3df1672e131ddc1b4e39eeacfd39864acf

 Linux 5.19-rc5

to receive ACPI fixes for 5.19-rc6.

These fix two recent regressions related to CPPC support.

Specifics:

 - Prevent _CPC from being used if the platform firmware does not
   confirm CPPC v2 support via _OSC (Mario Limonciello).

 - Allow systems with X86_FEATURE_CPPC set to use _CPC even if CPPC
   support cannot be agreed on via _OSC (Mario Limonciello).

Thanks!


---------------

Mario Limonciello (2):
      ACPI: CPPC: Only probe for _CPC if CPPC v2 is acked
      ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is supported

---------------

 arch/x86/kernel/acpi/cppc.c | 10 ++++++++++
 drivers/acpi/bus.c          | 11 +++++------
 drivers/acpi/cppc_acpi.c    | 20 ++++++++++++++++++--
 include/acpi/cppc_acpi.h    |  1 +
 include/linux/acpi.h        |  2 +-
 5 files changed, 35 insertions(+), 9 deletions(-)
