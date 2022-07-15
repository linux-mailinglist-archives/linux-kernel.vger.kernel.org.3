Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE5957660B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiGORbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiGORbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:31:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CF418341
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:31:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g126so5219533pfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=Zz8Y77yoAGNRfrRZsS32slqkoRu0n2tXilRPTny1hNk=;
        b=U+HKY/vtJgiL6UI2Gho2wjd2mWjcGrbj6+j9CQ1oTRQk7ptpDKp2u9+Ki0ZW+sBIbf
         NxJRSvvPdkdiN0sT2Ccz44VD0NxFZL1r2gSvczreME+0oiZezv8MU4Qjwj2Qn4w1xAWy
         U42bC7no0E91NFnaMDU8Qpu5WV27GOFrrjemuxwmAaLnNBPRUY6gvsJG9B/yzwGSpgR2
         uUYKCLXaiBgOGrZVk2ODbC4d9foXbk/I2L++BxvaesgQjVTOUTQLiJLSntB1nSZz1SM1
         7Hi7MyoXiIjS5wzsrti3LKGJaYeG80gqMS9gJ4Ay27kdYMgYGlIm8R5Xi6LpRqcZUIz0
         YNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=Zz8Y77yoAGNRfrRZsS32slqkoRu0n2tXilRPTny1hNk=;
        b=PLp1mL4hwYKLHeRx7gLClu+z7K8dVsheV6RvYXIF5DrGalsSZAp+koDfCe6tjnIt5S
         Uh6wamzk1JB5Qmt3urwJIFzjq7R93ItmNqDoSpfRerI3beX0R8wOlMC9UuCxMqt0zDsc
         VS+qXQNMirLxVFoyAc4qK6RqB4a4T/YPN0cvzRmiqQ8xmlIFJzAWaetCGM8SfPWxmtTs
         o0NSLxtUCS+BM5LYilDVpgXlMT5qpk3/lq2OWV8ivORSvg1iNAEWfphQ33HrLV2p/epV
         SGSCx/5jwscUloH05pjIf0Pm7g0yzgqm7hUGpQpAwjelG3dXx+EKH6TrsUre0y0+Tbi7
         gH6A==
X-Gm-Message-State: AJIora+1mboRpn899cmo2+495nqbloLFW5QwgqQCt4RkXksIW4MWEwml
        oks5+sBlW5QkxHJ8tmcRts0uIuXt6FRCoQ==
X-Google-Smtp-Source: AGRyM1uK6H62+1FI7CSjQPix+i5ysBrKbtH/rgd1suwn/D7CP71+5XnCnfYwW5dIr5nQ5w5uqvJE+A==
X-Received: by 2002:a05:6a00:1908:b0:525:5dad:cb1c with SMTP id y8-20020a056a00190800b005255dadcb1cmr15080303pfi.47.1657906270704;
        Fri, 15 Jul 2022 10:31:10 -0700 (PDT)
Received: from localhost ([50.221.140.186])
        by smtp.gmail.com with ESMTPSA id 125-20020a620483000000b00528c4c770c5sm4134320pfe.77.2022.07.15.10.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 10:31:09 -0700 (PDT)
Date:   Fri, 15 Jul 2022 10:31:09 -0700 (PDT)
X-Google-Original-Date: Fri, 15 Jul 2022 10:31:01 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.19-rc7
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-077c44de-b969-4894-9547-066c73040835@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e83031564137cf37e07c2d10ad468046ff48a0cf:

  riscv: Fix ALT_THEAD_PMA's asm parameters (2022-06-17 06:16:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc7

for you to fetch changes up to 7fccd723912702acfc2d75e8f0596982534f7f24:

  Merge tag 'dt-fixes-for-palmer-5.19-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git into fixes (2022-07-13 10:44:22 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.19-rc7

* A fix to avoid printing a warning when modules do not exercise any
  errata-dependent behavior and the SiFive errata are enabled.
* A fix to the Microchip PFSOC to attach the L2 cache to the CPU nodes.

----------------------------------------------------------------
Conor Dooley (1):
      riscv: dts: microchip: hook up the mpfs' l2cache

Heiko Stuebner (1):
      riscv: don't warn for sifive erratas in modules

Palmer Dabbelt (1):
      Merge tag 'dt-fixes-for-palmer-5.19-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git into fixes

 arch/riscv/boot/dts/microchip/mpfs.dtsi | 4 ++++
 arch/riscv/errata/sifive/errata.c       | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)
