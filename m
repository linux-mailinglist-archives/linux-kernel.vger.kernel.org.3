Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242C647941F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbhLQSfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbhLQSfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:35:53 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02791C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:35:52 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id t123so1607438pfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=YaNxns1s+TGyCVBsFW30ZbL2hW+Yb5XnvuO0hRitp/o=;
        b=DyPBpxf4wGnF7oC2LDeND0KeUEx99zwWf2C204q18+fYZZpsAwENdGXuwz0c1Yo4cV
         pQFUp1Ld7r7lqO0ggydhW5a8jQ1lQXnu/HKD9fVGnS7a83PT7pFTELipkxN0misTegGC
         eKzY2GtxnGOaXfABt3OgLrcGnDljdyl6ygr78lUExq+MjXWuCYroOiu7kUHjJt3hGNTq
         Oz2Q7Cesptbxfe4sTVqP6ZpHrjc/By95VJhoRYuvARM2DU7N0f7Pzm3Ks9OPc+7jyrG+
         2c8ksBOwsBPCnXAo1ShNfFxyIygHCWayj+DgudzOpcmXrPrKyEs5v0CzlHiKcgMt8D6d
         FQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=YaNxns1s+TGyCVBsFW30ZbL2hW+Yb5XnvuO0hRitp/o=;
        b=O+KfDC16n4t+6caNBRdb6N7j3EN8a/IPpXsFLE6Q62BNXmd57a0g85ESoWsnBFkg9b
         XJc9BU9OQQqJcEGfENGq7KZhGLloyFV0QJDi7ed5/02HPGCJ8k4sdkXSwgRaefuqNj0R
         dx99P/IX+5DzV1pn1ZE2e6LVYI78T0OXew/U2CML3lBZTTknfK5EYwaTTZkN37z3RHAw
         wVBYWQuZPIP2C7UM70+tb1KuhztNrW9oS9zQ4b17Qhy5khfWgJBxLDzkWmMVaXG+iJAj
         XjbuoVTcdADmUwN3/ii+4C2Q5Zi/BWJ3oImeZBZ2qsWvkIDkPmKTCb66ijrnZgfWu8n1
         R1Rw==
X-Gm-Message-State: AOAM5311X9Zl3e1kXHQpHqQLcxROpaDh8kyWGVk18q9j0RyMN+fRJ6Xl
        ixBpRJFBGCbK2QVe4yRv7agtROlKTIfpLw==
X-Google-Smtp-Source: ABdhPJyjYm/Bau5+PTPtAe1IyAqGABNPgFtGfulvfHKU2dMaHXAmglvAUAPrF+XB5onIgHMvNLPTBw==
X-Received: by 2002:aa7:8545:0:b0:4ba:7163:7dfd with SMTP id y5-20020aa78545000000b004ba71637dfdmr4204093pfn.61.1639766152335;
        Fri, 17 Dec 2021 10:35:52 -0800 (PST)
Received: from localhost ([12.163.77.120])
        by smtp.gmail.com with ESMTPSA id gf4sm8877475pjb.56.2021.12.17.10.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:35:51 -0800 (PST)
Date:   Fri, 17 Dec 2021 10:35:51 -0800 (PST)
X-Google-Original-Date: Fri, 17 Dec 2021 10:18:21 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.16-rc6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-e635e7d2-fa3c-4c47-8a6b-989873263b30@palmer-ri-x1c9>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5a19c7e06236a9c55dfc001bb4d1a8f1950d23e7:

  riscv: fix building external modules (2021-11-18 23:06:23 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.16-rc6

for you to fetch changes up to f6f7fbb89bf8dc9132fde55cfe67483138eea880:

  riscv: dts: sifive unmatched: Link the tmp451 with its power supply (2021-12-16 21:27:45 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.16-rc6

* A handful of DT updates for the SiFive HiFive Unmatched, that fix the
  regulator handling.  These should stop some warning spew.
* A pair of fixes for both the SiFive Hifive Unleashed and Unmatched,
  that correctly hook up the MMC card detect signal.

----------------------------------------------------------------
Bin Meng (2):
      riscv: dts: unleashed: Add gpio card detect to mmc-spi-slot
      riscv: dts: unmatched: Add gpio card detect to mmc-spi-slot

Vincent Pelletier (5):
      riscv: dts: sifive unmatched: Name gpio lines
      riscv: dts: sifive unmatched: Expose the board ID eeprom
      riscv: dts: sifive unmatched: Expose the PMIC sub-functions
      riscv: dts: sifive unmatched: Fix regulator for board rev3
      riscv: dts: sifive unmatched: Link the tmp451 with its power supply

 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts |   1 +
 .../riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 113 ++++++++++-----------
 2 files changed, 54 insertions(+), 60 deletions(-)
