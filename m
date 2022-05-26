Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F09B535612
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbiEZWXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiEZWXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:23:42 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEDC663DB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:23:38 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r71so2491421pgr.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 15:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qTkavwHRG1kUc7MxLLp8QNhHsYtlyypXgt7Cjx7vDVs=;
        b=PshBz5VS9QipcURmfBmNiQgFaxxRYldCwPz4iHpsbw2DXAjjVYY1vsfMQRE4cR4xBc
         ESydKV5rkBbalNPk55GbhtDwJN8xJ34M25U8DtFK3qyQSUdqZhSYhLjhDozi16BhQA6U
         /i2RD7b24+7cNBayA7W5Cm6goqg6xW/j+5u9dM26wwKqgF49CX2x6f99EGw8ev3Cbtrg
         7IVYG9V6UUwx7TbL99gLN+fGS/NwRk9ml+iQGf7a2fa1duxo3GGlQYUo3jazcwHsFdHU
         BCp996pwt872vvF53nA/d2RbQh2sKTImfaIRUrwbaizdTVfSrrJPh6pYsK5bECD+pOsD
         lgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qTkavwHRG1kUc7MxLLp8QNhHsYtlyypXgt7Cjx7vDVs=;
        b=ad2NIm+uLEnrx1C+AtbYGRd9TZa6bkIlhvQmTWLNAQTfl3ML3xAYYFu63IvIxtdvyq
         PZII1jIhXblgQVg+eIyR7z2GyBVxuM7mWHQ3Lpm2LeSB4Xl32hKAiNWXJSYU73nuszV3
         0J6Wzeo6KhaUwJy8XockeIwhJ6Qvai60J2YWRX4nh14FE+ak49G8KI9Ug0LAQT4VRnTi
         sGzWNS8oj9CLxJ6etz2s4VFFxLp+kKRXRwKvukzBGZ3HAhAYnL332xq9d4DshWZw075J
         dPOvUcekWjgzBnzs9hrVkz0FR21Yb8ghOl6n/ALkRP6fAcY9u9091Nn0FNHoZlv2GJqZ
         MTzg==
X-Gm-Message-State: AOAM533E80WJi/hxS9VowfGadIL9/dTXRCdan3fSVZgApUOpIMTx/3w7
        ES12aeEtCN15QRbj1q662Ywb2jx6Gkc27A==
X-Google-Smtp-Source: ABdhPJwbfOaJPqis6FimF5jgp55B1scv/z1hwwGkaOmrhZks5bXXO1AAmJiliGEIG583B56XDFGuNA==
X-Received: by 2002:a05:6a00:7d6:b0:518:9fa0:7dc with SMTP id n22-20020a056a0007d600b005189fa007dcmr22226173pfu.36.1653603818173;
        Thu, 26 May 2022 15:23:38 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090a2e0400b001df2b09ce9dsm165500pjd.4.2022.05.26.15.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 15:23:37 -0700 (PDT)
Date:   Fri, 27 May 2022 07:23:35 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [GIT PULL] OpenRISC updates for 5.19
Message-ID: <Yo/955uRNSaSMBqn@antec>
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

Hi Linus,

Please consider for pull

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git@github.com:openrisc/linux.git tags/for-linus

for you to fetch changes up to 83da38d82b2f7ac207646e55be94e8bd642e2c39:

  openrisc: Allow power off handler overriding (2022-05-23 17:15:50 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.19

Fixups and enhancements for OpenRISC:
 - A few sparse warning fixups and other cleanups I noticed when working
   on a recent TLB bug found on a new OpenRISC core bring up.
 - A few fixup's from me and Jason A Donenfeld to help shutdown OpenRISC
   platforms when running CI tests

----------------------------------------------------------------
Jason A. Donenfeld (2):
      openrisc: remove bogus nops and shutdowns
      openrisc: define nop command for simulator reboot

Julia Lawall (1):
      openrisc: fix typos in comments

Stafford Horne (14):
      openrisc: Add gcc machine instruction flag configuration
      openrisc: Cleanup emergency print handling
      openrisc: Add support for liteuart emergency printing
      openrisc: Add syscall details to emergency syscall debugging
      openrisc: Pretty print show_registers memory dumps
      openrisc: Update litex defconfig to support glibc userland
      openrisc/traps: Declare file scope symbols as static
      openrisc/traps: Remove die_if_kernel function
      openrisc/traps: Declare unhandled_exception for asmlinkage
      openrisc/time: Fix symbol scope warnings
      openrisc/delay: Add include to fix symbol not declared warning
      openrisc/fault: Fix symbol scope warnings
      openrisc: Remove unused IMMU tlb workardound
      openrisc: Allow power off handler overriding

 arch/openrisc/Kconfig                     |  53 +++++
 arch/openrisc/Makefile                    |  17 ++
 arch/openrisc/configs/or1klitex_defconfig |  32 +++
 arch/openrisc/kernel/entry.S              |  20 +-
 arch/openrisc/kernel/head.S               | 368 ++++++++----------------------
 arch/openrisc/kernel/process.c            |  19 +-
 arch/openrisc/kernel/time.c               |   3 +-
 arch/openrisc/kernel/traps.c              |  63 ++---
 arch/openrisc/lib/delay.c                 |   1 +
 arch/openrisc/mm/fault.c                  |   9 +-
 arch/openrisc/mm/tlb.c                    |   2 +-
 11 files changed, 272 insertions(+), 315 deletions(-)
