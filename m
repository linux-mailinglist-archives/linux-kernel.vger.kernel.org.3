Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4C057E65D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiGVSRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiGVSRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:17:30 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9866D9D0;
        Fri, 22 Jul 2022 11:17:27 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-31e64ca5161so56218037b3.1;
        Fri, 22 Jul 2022 11:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=BBAfLf3hHvughLpu0fA5WUlnYgIgIhkxMFQweD2OfqY=;
        b=K1A97yfWyAchtMAI4wiyLIKJ0s4RqwPtVX+3rLms68iiiJC4qQ3S8hUNYVmwq0of9p
         n7Ciw4Bv5nE2McYJDKYsqtj9nJG7BGrDXegOhWuo618FysGDYZrDmLlbI1ihcvcIjSIN
         RCr126/QMIPPKkES7y8hfR6xr74BwKRtsrZg+juh0+s4bSPObaW4tlbzxUnvfaCCuZWM
         ecqkW3KA3jrCrjaMc66LwuFrN4gAV2hbPgKViirjeJ3V1x2lsWjdxsTkhxhe6c0aK+Ds
         Ycbo4BnH+zagIHaMjR5jJGQAIjra7qoBncHaKvabugxwZ9qurpwTCyQVFPXThnAfE0LR
         Ebdg==
X-Gm-Message-State: AJIora+YlQC6AZpyz7UPmJlg6yEw7tJlvbfMaXKRgOaz1mg44OuZvuHJ
        YxzQey/w7kPwY395pjN2w9oKlIQyGaeObQ3r6JcuHzWiJfs=
X-Google-Smtp-Source: AGRyM1tSbglIK0/BX+gOyaNnSNy4n3Yv6MIsE/y/W5x2KOhUZbtSIdHUMzZXt466yke3Vi9IfEe9b+UJFQHtFp3m5v0=
X-Received: by 2002:a81:78c6:0:b0:31e:848b:6e2 with SMTP id
 t189-20020a8178c6000000b0031e848b06e2mr941222ywc.301.1658513847064; Fri, 22
 Jul 2022 11:17:27 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jul 2022 20:17:13 +0200
Message-ID: <CAJZ5v0guJm8F0myVa2DG3mxkStPQ-+vzuY6Gob2hk3Jk=guWCQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.19-rc8
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
 acpi-5.19-rc8

with top-most commit 09073396ea62d0a10b03f5661dcabfd8eca3f098

 ACPI: CPPC: Don't require flexible address space if X86_FEATURE_CPPC
is supported

on top of commit ff6992735ade75aae3e35d16b17da1008d753d28

 Linux 5.19-rc7

to receive an ACPI fix for 5.19-rc8.

This fixes yet another piece of ACPI CPPC changes fallout on AMD
platforms (Mario Limonciello).

Thanks!


---------------

Mario Limonciello (1):
      ACPI: CPPC: Don't require flexible address space if
X86_FEATURE_CPPC is supported

---------------

 drivers/acpi/cppc_acpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
