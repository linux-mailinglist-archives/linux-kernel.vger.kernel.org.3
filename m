Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5E24D6767
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350687AbiCKRTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350669AbiCKRTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:19:16 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E776ED31F9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:18:12 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id p8so8374025pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=/vAMVQ4S4rG50aDrpEZgzM1DrWkgQMPidGWj+MF7bA4=;
        b=ldXEpgleUADdcyKGiAURlNlkwwL/8MDZLJ8RxYVwdoB3ipWBEYxgGC+oDApYJe1giz
         WhptnF633qvGSRwsPogNwQcfvNiLz77Ba7ImzxEb9Qz/t6e5+3aPfMrcWOpxXKD0pzp5
         jwPMY0qWYb8e4M/+AkQCGU6/CG8XBAHZ1OtqDGm8Mg8MryqAyTyaWtBa+FYzJED+J9q5
         1pzY8SC/NGSfNY1GhXhubWfqUi3fpqVj1rx80FT2xOPglEZdjeVeLzEmkhAzYYK938Qv
         acuy8/WuUB4NV2v10hZG1EpW+p6Ss1dsc24xvlbimnDq8lr7BSYtrwpU0xxdDJWuS33q
         nhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=/vAMVQ4S4rG50aDrpEZgzM1DrWkgQMPidGWj+MF7bA4=;
        b=sdcbvXCmlUhp20ULq7kWeZFWLbMex/BrENEV05osnww8oy831K+qmZGoPv7RAy86vH
         rZG/mjDl/NaURsrpYCLFjjvKHcymTh7QFnIVU6DrtSbYTdnlDMZ+rDUgNGSeEPoDhARs
         O15uEj+0nwTQF/HVWz0ksrnqSmA4qs7G9KT0pbAzxt6SMfjtvPwh3JnVQ2HxrzEsN0Fs
         L8MaFieKtPIKqZ1ciBDui8tzCk07kTXs/Jk6X/rlSFmN2gfTQUZZsDwx5I9HQonCZBt9
         HdhyNPjG4cbOVSo9EeThl7cbo2B9qfMaCgd1TtLKoKCXrjCRcG0CwUN6mgZnnoWttjLL
         2DRQ==
X-Gm-Message-State: AOAM532kGFV9g3QTgSiORYNaUedsfthcU8JwWcOuRsn2O+CR5KISL6ZS
        vgIyW02EjKq4UtjglARJamBaIb+rsg3Htw==
X-Google-Smtp-Source: ABdhPJyU9YbKB8/oleGqNbhXYfvTE58OeXWtoh7DpJIPNpXHhCOBSo5+IZAgxcuSScJzJw0Yy+o+eA==
X-Received: by 2002:aa7:88d5:0:b0:4f7:1b6a:8673 with SMTP id k21-20020aa788d5000000b004f71b6a8673mr11236281pff.5.1647019092209;
        Fri, 11 Mar 2022 09:18:12 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id l13-20020a056a00140d00b004e13da93eaasm11202260pfu.62.2022.03.11.09.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:18:12 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:18:12 -0800 (PST)
X-Google-Original-Date: Fri, 11 Mar 2022 08:59:17 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.17-rc8
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-1484f557-fd58-4fe3-afce-a630fac5c8b3@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 74583f1b92cb3bbba1a3741cea237545c56f506c:

  riscv: dts: k210: fix broken IRQs on hart1 (2022-03-03 20:04:21 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc8

for you to fetch changes up to 0966d385830de3470b7131db8e86c0c5bc9c52dc:

  riscv: Fix auipc+jalr relocation range checks (2022-03-10 20:37:44 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.17-rc8

* A fix to prevent users from enabling the alternatives framework (and
  thus errata handling) on XIP kernels, where runtime code patching does
  not function correctly.
* A fix to properly detect offset overflow for AUIPC-based relocations
  in modules.  This may manifest as modules calling arbitrary invalid
  addresses, depending on the address allocated when a module is loaded.

----------------------------------------------------------------
I know it's pretty late, so no big deal if these don't make it for 5.17.

The module issue is particularly ugly: itcould manifest for the majority of
users, and depends on a bunch of long-term runtime behavior so won't get caught
by simple tests.  The bug has been around forever, though, and it'll likely get
backported either way -- figured there's no reason to wait, though.

----------------------------------------------------------------
Emil Renner Berthing (1):
      riscv: Fix auipc+jalr relocation range checks

Jisheng Zhang (1):
      riscv: alternative only works on !XIP_KERNEL

 arch/riscv/Kconfig.erratas |  1 +
 arch/riscv/Kconfig.socs    |  4 ++--
 arch/riscv/kernel/module.c | 21 ++++++++++++++++-----
 3 files changed, 19 insertions(+), 7 deletions(-)
