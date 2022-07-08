Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3860656C245
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbiGHTVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiGHTVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:21:34 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFD91EAE0;
        Fri,  8 Jul 2022 12:21:34 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id n74so9707666yba.3;
        Fri, 08 Jul 2022 12:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=M7CMxMpAwaG1MqNPytiWNPh0UB9uZ/2w81H3Zj9t5RA=;
        b=4IPOAVcqVe0wF5sKrH6p5IoPU+e1XxE2lJy76HRA35PBYRGm1XMUOV5TlYt6RdvdBL
         XR45i1qa2+0Bfre6bGUzDd9bhAMlYja636Lgitwwu1ZtVw5Z3YWAHYKkbz4QNhu7JZzu
         AWFn+YNpF6v8pjFxX81FxqUz9NdlM+6POLu0CF2LGgpGhKswH4ubXd97JM70z/goTJtE
         4ZdmYJ1tMTCCeoJbNFhEtz3MQW6sN1cWXGsXDUyLuLn8e2LRmeLyE1FrlPKBFsUaciD8
         i9EsyhGQeuznlAjE+n3YfcGsLva5V5hcQTv/f8plSYPQvhApn83G49zhn+uPWkDz4Dzg
         PVjQ==
X-Gm-Message-State: AJIora/unHuUf8G+eVaBVpXwzfFV5R3yO2NkO9Hl7RfdPurfhjQt5olk
        n0qoBOLAk6PBoclPTVx8K7++O+fU0Gw08iLA8uTFD11ZBjM=
X-Google-Smtp-Source: AGRyM1vyHLicsEKC3SRbE+ACpCdHzjNBQukOQyHJ8cx53Q1WYFNz6npbuVizO0YNrjiITkXgT1T5Bh03ZEMzGYtJA5A=
X-Received: by 2002:a25:664f:0:b0:66c:d0f4:36cc with SMTP id
 z15-20020a25664f000000b0066cd0f436ccmr5205979ybm.482.1657308093364; Fri, 08
 Jul 2022 12:21:33 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Jul 2022 21:21:20 +0200
Message-ID: <CAJZ5v0gJcS9bQ07tRaN2KjOF_8+VvyRRrXNN6aQ=cujog1xXDg@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.19-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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
