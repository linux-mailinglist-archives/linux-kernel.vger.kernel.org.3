Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5EB5766D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiGOSjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiGOSjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:39:43 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B724730542;
        Fri, 15 Jul 2022 11:39:42 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31c86fe1dddso55341907b3.1;
        Fri, 15 Jul 2022 11:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tZSAmkhI57/m5p5+yBVvC0sIcY5dskuse/7Nb3HZPtw=;
        b=Om8aMkpLRaE4NIQrQBAiOZzpihcR/5duwqOByVUpOvdZDSRl/oLWX4f/gnZlT0D/LJ
         kdGTkgODXoEbuLH5RpgFhkn8g3uNDRL63wv4HQnzoSN1o5lWrs6dxaQxufCP/SLm1kl/
         nDpOXbqDp5s+nMQHmEa607iGSuzMkNnonMSEBY/LGc+KdPYrXMmCPGGrnSMHboHeolGb
         aer4YNWhODngkZ4JLj//34+RwxWwu2UpwX/YKnVS5Pdn/akDsSGbnwmBzlz0rY5twEuZ
         avaO182r1ORNOxx5U4mXusfgxQnCD8h1VBooFPlXY3zS5qggZ91vUQ2eExzzrOkoSpGP
         nWgQ==
X-Gm-Message-State: AJIora/4DaXykl26gFiO+SK1jnzgdhTEQWnUIXe073YzW5wYAn9p+bKu
        nqHwA96WOx5R32x1pP3toV0UtXfLp+T5D+uX6bwNF9AiOhg=
X-Google-Smtp-Source: AGRyM1vurSdoTVuN/RnJ8mniQ8GmkHS7VnOkQOqLbNTQBB5/DOQZHY3PYObZWlJ3HyMUjpZcEoamm2Dh5kxTiDrfVjk=
X-Received: by 2002:a81:cd6:0:b0:31d:72e3:8b81 with SMTP id
 205-20020a810cd6000000b0031d72e38b81mr17281862ywm.301.1657910382016; Fri, 15
 Jul 2022 11:39:42 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 20:39:30 +0200
Message-ID: <CAJZ5v0gDqO1fu=i9MOWuryMG7XNp+qMTTSRzNGyxY-+Jrx3wFQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.19-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.19-rc7

with top-most commit fbd74d16890b9f5d08ea69b5282b123c894f8860

 ACPI: CPPC: Fix enabling CPPC on AMD systems with shared memory

on top of commit 32346491ddf24599decca06190ebca03ff9de7f8

 Linux 5.19-rc6

to receive an ACPI fix for 5.19-rc7.

This fixes more fallout from recent changes of the ACPI CPPC handling
on AMD platforms (Mario Limonciello).

Thanks!


---------------

Mario Limonciello (1):
      ACPI: CPPC: Fix enabling CPPC on AMD systems with shared memory

---------------

 arch/x86/kernel/acpi/cppc.c | 6 ++++++
 1 file changed, 6 insertions(+)
