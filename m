Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F995150FF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379183AbiD2QmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379176AbiD2QmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:42:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962ABDA6F7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:38:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so10993214pju.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=YTMYWglJvPxKf/1GGyXAmCCcwylWdWEiN/xnc6H4bII=;
        b=o1jWtkGx+gsZKQRsxZdhrXhfVUTRcyKnmoTvYkBIldeUZvn0qlLyyiVV7XnlaIjF4A
         LVypMwXn5fAnh+ghQ987B+getFJU1yz3LEgzlDEqYIusXqz5ZnnQcLl9jD40RmhcpQ0j
         IYRaDmeLyUX4oKvNrvbkxymyYvVTq20uFbRZ2ZFEUNPpsun5Azkk2L6UfnhgTWAeRxBu
         SDjaGt1M97ZRQpMZsKFEpOdjXIjIMZOJdMMAfkOeBBrNb3GfN5jBb4I91Y9iPV0NNJvW
         62ZUNV3tHzBu5aGBBuzznxrw9OwalHawyVIwSOGrWt5g5fYnhPLXv58RJVpqxNXRHpxj
         zXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=YTMYWglJvPxKf/1GGyXAmCCcwylWdWEiN/xnc6H4bII=;
        b=i7PzsFFbaMdYV6N4b9o2XyMOM7plCx+fdD8KLtQ+p73rB8+BqptUwO3HGNKjm71ZTj
         Vf4jmyndYAwpTMbW2rXvskXhlGNbfUIMLg4LFQDXrnFcnFsWLsSNoQYahzn1eh5ks3sE
         F3V1APqHScuo2fGNINtk+A4CHKRPfk+LO/cvD0nYKnZLJtOTpMc8AmM86Q/2NsT6BLre
         xcSfVDlCG4H8slGbFOJ5sn6dmWR2XmHY2k958vld1l+8ppSUP0y99g3RaWnrGqrMUpAx
         XNvRBd2C1aAfg0ErJZRv4l/dT2ANRqvoCs1eSv76O5UDTYvILQa62d6yhcpux1X4eCkc
         nlZA==
X-Gm-Message-State: AOAM530JKRGz38AgAd3g/Li/d/tRwnkWODZMpu1SyeUP7StzWiZa0P3U
        6/DddAS1+ZBlWXuT5SsHSy5y4rXLTn9XEQ==
X-Google-Smtp-Source: ABdhPJwQWxUqLl5/Zu2o/iphx2H7waYswkLfcS81pxZLHOe9vRl6qKy4w3qTXb8VQ5AeIc7hAn165A==
X-Received: by 2002:a17:90b:4b41:b0:1d9:b562:5bbe with SMTP id mi1-20020a17090b4b4100b001d9b5625bbemr68533pjb.61.1651250336123;
        Fri, 29 Apr 2022 09:38:56 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id h7-20020aa786c7000000b00505bf336385sm3622057pfo.124.2022.04.29.09.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:38:55 -0700 (PDT)
Date:   Fri, 29 Apr 2022 09:38:55 -0700 (PDT)
X-Google-Original-Date: Fri, 29 Apr 2022 09:38:49 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.18-rc6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-23ee08e3-f500-4297-bd05-a1902598d9b3@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bf9bac40b7635e2ce43ba0051a64c3fd44312405:

  RISC-V: cpuidle: fix Kconfig select for RISCV_SBI_CPUIDLE (2022-04-21 15:10:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-rc5

for you to fetch changes up to ac0280a9ca106c5501257e79d165f968712b5899:

  RISC-V: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL (2022-04-26 08:19:53 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.18-rc6

* A fix to properly ensure a single CPU is running during patch_text().
* A defconfig update to include RPMSG_CTRL when RPMSG_CHAR was set,
  necessary after a recent refactoring.

----------------------------------------------------------------
Arnaud Pouliquen (1):
      RISC-V: configs: Configs that had RPMSG_CHAR now get RPMSG_CTRL

Guo Ren (1):
      riscv: patch_text: Fixup last cpu should be master

 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 arch/riscv/kernel/patch.c         | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)
