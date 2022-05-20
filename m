Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C0E52EF77
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350968AbiETPm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245043AbiETPmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:42:25 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EF69D067
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:42:23 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v10so8027266pgl.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=9O1f2uby0zF1P32LSN2FMpx0hIAco3n5Bs6/xy9ApFI=;
        b=jKO0iq7lQ1xQ4bnZ+ws+dIULKtsFxtFOS7MbiT5CcNTxlhn5rCPFM6DpZnbCBYqBop
         0gcX/R4ObVLroFeWjSaIiAJudD/7GdQgmQvt5ctxsSzCH8u50HtWelKgXmahZu9jcdL8
         KZ6Azppfly05DJqDiV0gLOjSjUs95LqvQqm0LAmi/cWjOsgUm5zvPWHyqz8DktAhk/o9
         f45ijqH4gKcSCqEzDvo0OJJYLzmcHCIsd9ig/iKCpb8pkPA6G56IuVwGM2c3JC1kIOPe
         94nqvxovyNL/a9P8dtwCsApeDZFp6tzOEvgBukqmAiBoAJ3Vh7SRJkBYn1xhl7EnzG5J
         kUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=9O1f2uby0zF1P32LSN2FMpx0hIAco3n5Bs6/xy9ApFI=;
        b=12KoFS63F0QlUi3zzcSlvwPT/JHw0DytxYOsASn9XPXAPxnsH3+mSXmrl35nQ4DKTx
         ywgXa+0OfyzwuZ7I5qCHJwmuDJqOeOtoubdjnW2eDUA4fsEJyy/ILx4aVf+vv/rcPyjt
         vwzY8Og4MSjxw7sUpMPEzciZE0kW2B1JRCt0aUM++IpgBaCFlhWanEHhlXZfT87Imy4x
         zRYfIQOZCL60O/UTmEaj7sAUUifCV1ZzmM+IKgik9R5oZfvD70VT7IDWyI3510+O8ka3
         hIf6LBtf8z8/4wUfo1xhYPkW9r4g7SGWqdOqK0qHR65AMUH3dZg6+2TJqPcHe0/50imc
         gI7g==
X-Gm-Message-State: AOAM530jg89AwRMD6qpgl305J6u1XJQdau7l2LrzUpULVo1gk3RSNnBq
        h9cah9h4Sq6Y2uEY0VUlrilBWtqTIBRbgA==
X-Google-Smtp-Source: ABdhPJzZLYUzziEx6OFJM4uFhj7Wleke9vzg8Yp/95RWj6BQKn25v6NMxMQ2T2rnmfilk9IuJ6tsOQ==
X-Received: by 2002:a63:d301:0:b0:3c1:7361:b260 with SMTP id b1-20020a63d301000000b003c17361b260mr9173962pgg.367.1653061343219;
        Fri, 20 May 2022 08:42:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 144-20020a621696000000b0050dc76281acsm1975781pfw.134.2022.05.20.08.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:42:22 -0700 (PDT)
Date:   Fri, 20 May 2022 08:42:22 -0700 (PDT)
X-Google-Original-Date: Fri, 20 May 2022 08:41:49 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 5.18
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-d5b7ee6d-8d8f-4603-9a20-843f35fae857@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c6fe81191bd74f7e6ae9ce96a4837df9485f3ab8:

  RISC-V: relocate DTB if it's outside memory region (2022-04-29 07:59:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.18-rc8

for you to fetch changes up to c932edeaf6d6e6cc25088e61c3fcf585c30497c0:

  riscv: dts: microchip: fix gpio1 reg property typo (2022-05-19 16:47:29 -0700)

----------------------------------------------------------------
RISC-V Fixes for 5.18

* A fix for the fu540-c000 device tree to avoid a schema check failure
  on the DMA node name.
* A fix to the PolarFire SOC device tree for a typo.

----------------------------------------------------------------
Neither of these is particularly high impact so no big deal if it's too late
for 5.18, but I figured there's no reason to wait as they're also very unlikely
to break anything.

----------------------------------------------------------------
Conor Paxton (1):
      riscv: dts: microchip: fix gpio1 reg property typo

Krzysztof Kozlowski (1):
      riscv: dts: sifive: fu540-c000: align dma node name with dtschema

 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
