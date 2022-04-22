Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B45D50BC7E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378303AbiDVQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358809AbiDVQE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:04:56 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4BD56777
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:02:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d15so11772819pll.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=GrML/tBTGNY7cLGJx8CIKpBVBkMLPsIgHNXEWz+KIqE=;
        b=1a6APHrULGYP1dJsN53TaDp7jPPW+CvobVkYof/ar3uvqU0QP32czYFG+RBQOq4dlQ
         O0+6zuixtrKn96NNzM3PZLT5lij7UR7C9RYTM8s2TiEBSEDfxXp1j09V0S4+abUZmFtr
         7wZbAs5kYLrSbkYpf3uua/gMd09Hj14WyRCsOXzvrGe7iEZ8hfTNQafxfnDkHYd8kTZU
         QAGGCt8Cj9Z9kj2JW8SNf5b0a21klhiyklivDgh+0t+2Y1+9dcEikpsdTKshrAUO3/N2
         E+F0XYWVsdn54IAtrXKStea6tqUewniEH2JZ4Bj/A1tDuI7d6CzlAKDCEQc+yxvUH7Ar
         FJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=GrML/tBTGNY7cLGJx8CIKpBVBkMLPsIgHNXEWz+KIqE=;
        b=hxdi1FqlVLEWShTkFcVwMcPiGhv/sOKD/IPVVSTa85wWLy4xS4aA4bBFe+2UpQGrvY
         Ba40xvpxfKdii4RCddb9tkXdKEc8vYSIa9/9iW6LU1GqpSrnVb/0N3l1z6XBIextyjYX
         V396vFlVlvz9SduRcJ+zWYvBf51RVbtDWxZr+Pm5HHMKj0qy5T9557tA53z2bIWTw9Tx
         O14IjedruwzG6EnUTp+C/E8phDQe69ulHVo2RxaS8RFo2tZNycxpcsJf5n5DaORg2GKT
         XuBRviAEDwsyI1/RCAG/yomOVJFZw8RsBOAih6o2aPMi4lgDPyIuegUk7/5yUkqn5a1i
         VK5A==
X-Gm-Message-State: AOAM532LUf7GLEf9txLrHqwmTDU4ENHb7xtt9IMxJNYI0DNvnDexfIrA
        qZBYuvTYdvM/OyF/emVd/ntfQw==
X-Google-Smtp-Source: ABdhPJxkiEuskTJie+8vnx3wqlos6BbFtB2ZyVeeKujutXEW9fftctoqJTMU84FgXXrH0NC3z1gypA==
X-Received: by 2002:a17:902:8f94:b0:151:64c5:7759 with SMTP id z20-20020a1709028f9400b0015164c57759mr5312483plo.4.1650643322202;
        Fri, 22 Apr 2022 09:02:02 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id z27-20020aa7991b000000b0050a4e43d3ffsm3122813pff.65.2022.04.22.09.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:02:01 -0700 (PDT)
Date:   Fri, 22 Apr 2022 09:02:01 -0700 (PDT)
X-Google-Original-Date: Fri, 22 Apr 2022 08:59:01 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.18-rc4
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-650d0eb6-fc62-4859-b713-2a4e6ccd7465@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-rc4

for you to fetch changes up to bf9bac40b7635e2ce43ba0051a64c3fd44312405:

  RISC-V: cpuidle: fix Kconfig select for RISCV_SBI_CPUIDLE (2022-04-21 15:10:47 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.18-rc4

* A pair of build fixes for the recent cpuidle driver.
* A fix for systems without sv57 that manifests as a crash early in
  boot.

----------------------------------------------------------------
I'm not sure if that boot bug was just so bad nobody's found anything else, I'm
farther behind than usual, or the stricter merge window resulted in less
fallout.  Maybe just a bit of everything, but I always get worried when things
aren't broken...

----------------------------------------------------------------
Anup Patel (1):
      RISC-V: mm: Fix set_satp_mode() for platform not having Sv57

Randy Dunlap (2):
      cpuidle: riscv: support non-SMP config
      RISC-V: cpuidle: fix Kconfig select for RISCV_SBI_CPUIDLE

 arch/riscv/Kconfig.socs             | 2 +-
 arch/riscv/mm/init.c                | 1 +
 drivers/cpuidle/cpuidle-riscv-sbi.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)
