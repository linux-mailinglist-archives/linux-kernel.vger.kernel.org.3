Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B4A58B0D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 22:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbiHEUaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 16:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiHEUaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 16:30:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940281EAD7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:30:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pm17so3748575pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 13:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8shiq3ExegNMJKwy0qXw4HrKImMBLrJX5WjP8qCxZoQ=;
        b=A+AjsT5HxnNkB8Q7xyJ2l9prw3L3QSOYq+ERHA46rfe63EW6v6Nyw6FjLX0fj/pHzm
         rGWQ/SuyFLdO6vFeIEFOGgkJxp4vEG1qzy8oWWSQ8wTl4UFoVhaQc+84Ns3tv2oc8bTD
         ijU67z6Xy5UFIGcQiobSngm1F3820DIERB3f9Pgsd5f35+Mljilm8Og5svMNQtR8Wcgq
         5WFgq8j0OPrZXEqjpSERhM1bsCbtjv11vCLgFc/6DrhfPOtfghZAtCL180gqaR/hsCE3
         8It+1ZG2TCZRalYvf94QH0a14Cru95peGmACUIqAY3srIyyjzoRyWOOovs2h6C+xeoTY
         WEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8shiq3ExegNMJKwy0qXw4HrKImMBLrJX5WjP8qCxZoQ=;
        b=5cm/EAu4XD4RKJNPHsKnYEgJ1BEr+CdawjNuuW12ph2i38o52yWM/4PNYtaOcg55As
         fcZPb1K/qi10IWFe8qd7U4cImtuNTtVD2I+IxU7FyLUW5EV9+4IxopAy7zGp5B/zhUu9
         RRI55OLrNZGEFHm7pe3K2piYnpKwM7ohzxUuFXcJypyC1VCcwIGJPb+lhS7enrOa0vWI
         hnE+Mu1ryL2nrO36ZNZroYQstaepHuKko6Fo0SS6CuAOKpv/YPQw84bl+7vpyiC1DzGz
         LqMbHRidrnBmK5uTfFf2hglDYjw6SaUS+i+w2c12hL9rR0SZbGKWUenAm85VGSAFsPQP
         OmEg==
X-Gm-Message-State: ACgBeo3YSui6jKeeQX+cTojZOWTfPa3B8X02y483LuhOXKB0SU7VSlKC
        P6o1E8713efne4ocltLp0PM/wUbMl7s=
X-Google-Smtp-Source: AA6agR7fLbI82TXjaKf5dCIm3W3ikIcL9njw1IikMRoYURZ5NitU7R45eTsoXDwOtcVDAc45LtAUrg==
X-Received: by 2002:a17:902:f54b:b0:16e:f07b:46d0 with SMTP id h11-20020a170902f54b00b0016ef07b46d0mr8426975plf.77.1659731406810;
        Fri, 05 Aug 2022 13:30:06 -0700 (PDT)
Received: from localhost ([182.171.77.115])
        by smtp.gmail.com with ESMTPSA id x10-20020aa79aca000000b0052e6d5ee183sm3380241pfp.129.2022.08.05.13.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 13:30:06 -0700 (PDT)
Date:   Sat, 6 Aug 2022 05:30:04 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC fixes/updates for v6.0-rc1
Message-ID: <Yu19zEVnjSkH8nO2@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please consider for pull,

The following changes since commit 0757060a438835df82bd8aec40d4abc7dc4c9584:

  Merge branch 'pci/header-cleanup-immutable' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git (2022-07-30 05:47:13 +0900)

are available in the Git repository at:

  git@github.com:openrisc/linux.git tags/for-linus

for you to fetch changes up to 52e0ea900202d23843daee8f7089817e81dd3dd7:

  openrisc: io: Define iounmap argument as volatile (2022-07-30 05:50:15 +0900)

----------------------------------------------------------------
OpenRISC fixes for 5.20-rc1/6.0

In this cycle we add PCI support to OpenRISC used in our new QEMU virt
platform.  The base of this series is a merge of Bjorn's PCI headers
cleanup branch and 5.16-rc6.  The patches from the PCI branch are needed
for the series to work.

The main updates from me include:
 - Kconfig updates to support OpenRISC PCI (just config now after the
   PCI cleanups I did on Bjorn's branch)
 - A new defconfig for the qemu virt platform.
 - Also there is one MAINTAINERS update.  As I was working on the PCI
   series we kept getting bounces from Richard's old email address. I
   added this here; I am not sure how these are usually handled when
   the maintainer doesn't queue it themselves.

----------------------------------------------------------------
Stafford Horne (4):
      openrisc: Add pci bus support
      openrisc: Add virt defconfig
      MAINTAINERS: Update Richard Henderson's address
      openrisc: io: Define iounmap argument as volatile

 MAINTAINERS                          |   2 +-
 arch/openrisc/Kconfig                |   5 +-
 arch/openrisc/configs/virt_defconfig | 108 +++++++++++++++++++++++++++++++++++
 arch/openrisc/include/asm/Kbuild     |   1 +
 arch/openrisc/include/asm/io.h       |   4 +-
 arch/openrisc/mm/ioremap.c           |   2 +-
 6 files changed, 117 insertions(+), 5 deletions(-)
 create mode 100644 arch/openrisc/configs/virt_defconfig
