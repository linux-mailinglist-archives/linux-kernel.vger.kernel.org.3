Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35DD57E3F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiGVPwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiGVPwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:52:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A127C175A2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:52:12 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so4570538pjf.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc;
        bh=xxCjmpN4Td1O1TLl9RPWhjj4pmV0G2VbYEtqRP5n4WU=;
        b=RT+f+K/2V1LHD4Z/VOLMCmId4hLO6umi4FFYwOybHCOifv8e5/eRrXZiUqKVqjKzMS
         KuuE5PIYICkz428gzsdKYfmHn/0vPNxwhmigBh6C4lJgoqlPRLdjSzRjBHoA89JfceGq
         +1qfTspOAidXZUBBPeEfkwLDRijDt+Wj2mz/8QSeH7Ym+tzbUTfL/aRkFMJtg5OWD3Uw
         Wy89HSIKDDL3IA8VD7E0begRcSA+v6rDADaYcMqKRCBLjYos+5GjoPKxp9cL3iC4Oz+J
         by0lZ5hUZXD3HXzGEr+5XjUZEPc3MJGEYaQjE3hiotqTPRE+ywjBZg36JU0PNkZfOpym
         sq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc;
        bh=xxCjmpN4Td1O1TLl9RPWhjj4pmV0G2VbYEtqRP5n4WU=;
        b=5Fc8SWywilXVJ9vK7EMFnwJXASwGoRkWBrB1VgzkYMUWHWZK4Us+2Ou2Zmwqhmkoue
         wNoZuDPqRn7TKOOkjMj//Dq5e/m3AYRc8WTiFLiDtCl/ymkvbyjJMwPxjuKmZIafXSXR
         KipyDCdvArOGw29CkpwfPPOujfHRthyMO6Q2m+MFuj+B3owQqcVe6b3piV6D01iiPLxW
         Ik5afnt9cchKXJjlEB/4/MOFrfNRufqyFi98lw3SDqJNyMqhAwmBgUqrxx2e89N9ACXW
         grvRJZCeqrXw9GmzKiy0VvFoz6R+/BaKvfvTCr2Im0/NW3E4gox8LvpUHSbIrb7y1fAA
         6cZA==
X-Gm-Message-State: AJIora8JJGSSHlUKbMHpigNvJL8KEnBryri6x8cW4LW3NlynzzqFqwl6
        gNipO0szHI8MsHVax2RhxMZfFXkWJucgFw==
X-Google-Smtp-Source: AGRyM1vEZLAZF9DCuWsNoUFGP21Kyefpbe3NfQBqP64ehoiXTyy2/lOEI165BJMePyRi4UzpoCXLfw==
X-Received: by 2002:a17:902:ccc9:b0:16b:af81:37c6 with SMTP id z9-20020a170902ccc900b0016baf8137c6mr499347ple.107.1658505131786;
        Fri, 22 Jul 2022 08:52:11 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902f60300b0016bdea07b9esm3885040plg.190.2022.07.22.08.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 08:52:11 -0700 (PDT)
Date:   Fri, 22 Jul 2022 08:52:11 -0700 (PDT)
X-Google-Original-Date: Fri, 22 Jul 2022 08:52:08 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.19-rc8
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-84a83727-f880-4d8a-b9df-0c45accff355@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'dt-fixes-for-palmer-5.19-rc6'
The following changes since commit 7fccd723912702acfc2d75e8f0596982534f7f24:

  Merge tag 'dt-fixes-for-palmer-5.19-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git into fixes (2022-07-13 10:44:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.19-rc8

for you to fetch changes up to c1f6eff304e4dfa4558b6a8c6b2d26a91db6c998:

  riscv: add as-options for modules with assembly compontents (2022-07-21 12:09:29 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.19-rc8

* Two kexec-related build fixes.
* A DTS update to make the GPIO nodes match the upcoming dtschema.
* A fix that passes -mno-relax directly to the assembler when building
  modules, to work around compilers that fail to do so.

----------------------------------------------------------------
Ben Dooks (1):
      riscv: add as-options for modules with assembly compontents

Krzysztof Kozlowski (1):
      riscv: dts: align gpio-key node names with dtschema

Li Zhengyu (2):
      RISCV: kexec: Fix build error without CONFIG_MODULES
      RISC-V: kexec: Fix build error without CONFIG_KEXEC

 arch/riscv/Makefile                             | 1 +
 arch/riscv/boot/dts/canaan/canaan_kd233.dts     | 2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_bit.dts  | 2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_dock.dts | 2 +-
 arch/riscv/boot/dts/canaan/sipeed_maix_go.dts   | 6 +++---
 arch/riscv/boot/dts/canaan/sipeed_maixduino.dts | 2 +-
 arch/riscv/kernel/Makefile                      | 2 +-
 arch/riscv/kernel/elf_kexec.c                   | 2 +-
 8 files changed, 10 insertions(+), 9 deletions(-)
