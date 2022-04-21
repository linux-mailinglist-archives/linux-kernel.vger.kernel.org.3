Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DDA509E07
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388552AbiDUKwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240995AbiDUKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:52:06 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9853B29836
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:49:16 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w133so5331739ybe.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BQ0CLsTXT42vFbYOeRl03igvGnE16091WeuDyL+jVf4=;
        b=LTvf19NnKXJimjRK01dVNnocqskdXFhHxxWcuUhM+Pm4NKHJj4m49ZCfwZGqk6RxnD
         Rj9ZtBzTzaj6mKrxS0UGtbSJJ4YPT/AlQZcOlOdP4gIXhh9kqHNWNkKVTkOnkvJmxmGa
         BUTCfaDtQXfwOFBTN7Kb1hkJidhkZIbF7gSDIeNZjVZ8LdIysJCS69c5giEmws4XD1Ak
         F0SnlJJtIb5WnXG6a7fYOG6mNOyBDMSf/VaUPYTy2owrQwI7QzMoFXoVHues9TIuEcFu
         V9GdVCiUDUGu4sBQdH5P4PoU0WYNxqih5SmzNwGyBX6k8BK8Fgul6OQvh/7a8JJ2b4aa
         Y7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BQ0CLsTXT42vFbYOeRl03igvGnE16091WeuDyL+jVf4=;
        b=nSwZ/16NRvVlwLRWptyXgpRg+XXNL2bWt94oMOomQIyh2kku3f5bhStvyQgCpxxi/8
         C2+uRu93SVK+alLpBcmJZgbWSIarnNxbcSnuiPly/aU+vK6jYOgIycXAfrFao/i6XRaG
         YUsJcQ/Dxy956CdpXkC3SoqejkRDBack99Bxq66grU7t90BhnzKyEMr3axk1mYEOaZpM
         QjHZQB0wt1SW7WUCzlFP72hpnX0fQaub1q2W728DxHqdR18d5OO2cFxZsFNhdtFca/4U
         Ek3H9AaH67VFet/UYl3sswZ3mAnNX+nATH+PivZgCPJpPOLeIVrgal59pJt99S1mlTqQ
         BXPg==
X-Gm-Message-State: AOAM5329AT2cg+0jZLmUgKBk8B02srzVNiTrabW+7zfCmqT/uhJyvzFk
        uzm5yJnVDIq/e/Aq+kaZoHP0JseWJhfOMJqhDew1BrzPIa6IMZ+M
X-Google-Smtp-Source: ABdhPJzJtPgo/lx5O03SPinhaB+c3NAb+x84sJgadXvgRzJK9w5kOO3zpF7r9W2DbkCbFipkU3OPlEs4awZRZsxCAbs=
X-Received: by 2002:a25:dd02:0:b0:645:76bb:e38d with SMTP id
 u2-20020a25dd02000000b0064576bbe38dmr1529379ybg.88.1650538155724; Thu, 21 Apr
 2022 03:49:15 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 21 Apr 2022 16:19:04 +0530
Message-ID: <CA+G9fYvnf3Ys+ptCJf1fNOc1rjTiSEEY9Gxbc49eOrx227xOoQ@mail.gmail.com>
Subject: [next] riscv: sifive/fu540-c000.dtsi:171.4-42: ERROR
 (duplicate_property_names): /soc/dma@3000000:compatible: Duplicate property name
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        lkft-triage@lists.linaro.org
Cc:     Zong Li <zong.li@sifive.com>, Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next-20220421 riscv defconfig builds failed [1].

Regressions found on riscv:

   - riscv-clang-13-defconfig
   - riscv-clang-12-defconfig
   - riscv-gcc-10-defconfig
   - riscv-clang-nightly-defconfig
   - riscv-clang-11-defconfig
   - riscv-gcc-8-defconfig
   - riscv-clang-14-defconfig
   - riscv-gcc-9-defconfig
   - riscv-gcc-11-defconfig

arch/riscv/boot/dts/sifive/fu540-c000.dtsi:171.4-42: ERROR
(duplicate_property_names): /soc/dma@3000000:compatible: Duplicate
property name
ERROR: Input tree has errors, aborting (use -f to force output)
make[3]: *** [scripts/Makefile.lib:376:
arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dtb] Error 2

drivers/pci/pci-driver.c:533:12: warning:
'pci_restore_standard_config' defined but not used [-Wunused-function]
  533 | static int pci_restore_standard_config(struct pci_dev *pci_dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:226: __sub-make] Error 2


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The recent patch on this file.
I will run my bisect script and get back to you.
---
riscv: dts: Add dma-channels property and modify compatible


Add dma-channels property, then we can determine how many channels there
by device tree, in addition, we add the pdma versioning scheme for
compatible.

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Steps to reproduce:
------------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.

tuxmake --runtime podman --target-arch riscv --toolchain gcc-11
--kconfig defconfig


--
Linaro LKFT
https://lkft.linaro.org

[1] https://builds.tuxbuild.com/2868anlKwTP8aavo19LT6KRIq1T/
