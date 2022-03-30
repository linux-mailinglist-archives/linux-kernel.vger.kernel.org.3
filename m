Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63DD4ED065
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351917AbiC3Xui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351887AbiC3XuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:50:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1D417E0A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:48:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b15so20329759pfm.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=mbvQcvzRMWuLzmRogAceckeWGzUztkwWXFc3ujFTsg4=;
        b=hKV3NtwLlixYyPl3wYg91OPT9ev6NMYgYVcW66JImWNV4H6l/6QD6bu/oZiuPvb7sU
         5c8wjhHFBrwPjLGHIWwLfasYWOKBYez82T6uiRd9tEBtKc/Ss0PPdxCegGZ2+Iov5gDo
         fv8EC2gXx/eL3evXObW0dxrjs+T8yl8ytIuSdoJ+jRxyWTsZtn6YOkuyJA27F1dn1E+p
         KFW7TRR7tJNQICZ1fSgt5g9NqKs5v5bSvp0z5XYkLvNZ3h0fdtmMamnoRJVsqrijGOsI
         Rl1PywIQbfbX86u+RNGW52gA6f8iVv/nOyyWFRIbWlbgsSFU+IH/iRjtQx5lCiRfQIap
         axKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=mbvQcvzRMWuLzmRogAceckeWGzUztkwWXFc3ujFTsg4=;
        b=5ongp4M6IoURv1oJHIjKqxJOSey1fWKMw15GOL0mbhbWA7q2DHUWeQI4WbG1dzkGwU
         FT1oqDEDqR+AiNAnFV2FlXbYf93mxCA95ilNC2CaGkyRHc5QeqeH+XfwdhDgSJxBAklh
         ylwovARyFoCXoKvVuGCoGUxZl9KnmtqvD5SPMzR8mweK+7nbYx+1Z/f47Er8rSsu/LIn
         qsKuROQE1I7GD67VFbvhCnX0GDn+/Pl+Tw+46sLiCozh1zVawRfh7L8F7vK0EstJsLmo
         9PgBkYy+yZXOW+hbWEzzp0gc71MskEDoqs9lUCtawOx5vh4pPsazCA0ZyDt4dSYkt9ib
         1VQQ==
X-Gm-Message-State: AOAM531I8EinDFXHjb6Gu4SIUMJ+TEC1zlDBhZjpK99raxjaL1XWAhCq
        0Go+EsCfe/pa8oppY09zKz+b1w==
X-Google-Smtp-Source: ABdhPJxUfdCHemwktOqu1uVW7qEFwNUDvkbDuengsBjhft82tKgxYanWnnNscNq7+SEqmDqfxxpj4w==
X-Received: by 2002:a05:6a00:130e:b0:4cc:3c7d:4dec with SMTP id j14-20020a056a00130e00b004cc3c7d4decmr2142386pfu.32.1648684116701;
        Wed, 30 Mar 2022 16:48:36 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id g70-20020a636b49000000b003823dd39d41sm20075524pgc.64.2022.03.30.16.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 16:48:36 -0700 (PDT)
Subject: [PATCH 2/3] RISC-V: K210 defconfigs: Drop redundant MEMBARRIER=n
Date:   Wed, 30 Mar 2022 16:47:38 -0700
Message-Id: <20220330234739.1956-2-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330234739.1956-1-palmer@rivosinc.com>
References: <20220330234739.1956-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, heinrich.schuchardt@canonical.com,
        atishp@atishpatra.org, mchitale@ventanamicro.com,
        alexandre.ghiti@canonical.com, damien.lemoal@opensource.wdc.com,
        axboe@kernel.dk, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

As of 93917ad50972 ("RISC-V: Add support for restartable sequence") we
have support for restartable sequences, which default to enabled.  These
select MEMBARRIER, so disabling it is now redundant.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

I'm not actually sure this is the right way to go: presumably the K210
defconfigs had MEMBARRIER=n for a reason (maybe just size?), so we might
actually want to move to RSEQ=n instead?  As usual: I don't test on the
K210, so I'm not exactly sure what the constraints are.
---
 arch/riscv/configs/nommu_k210_defconfig        | 1 -
 arch/riscv/configs/nommu_k210_sdcard_defconfig | 1 -
 arch/riscv/configs/nommu_virt_defconfig        | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 3f42ed87dde8..2438fa39f8ae 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -21,7 +21,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_AIO is not set
 # CONFIG_IO_URING is not set
 # CONFIG_ADVISE_SYSCALLS is not set
-# CONFIG_MEMBARRIER is not set
 # CONFIG_KALLSYMS is not set
 CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index af64b95e88cc..9a133e63ae5b 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -13,7 +13,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_AIO is not set
 # CONFIG_IO_URING is not set
 # CONFIG_ADVISE_SYSCALLS is not set
-# CONFIG_MEMBARRIER is not set
 # CONFIG_KALLSYMS is not set
 CONFIG_EMBEDDED=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index e1c9864b6237..5269fbb6b4fc 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -19,7 +19,6 @@ CONFIG_EXPERT=y
 # CONFIG_AIO is not set
 # CONFIG_IO_URING is not set
 # CONFIG_ADVISE_SYSCALLS is not set
-# CONFIG_MEMBARRIER is not set
 # CONFIG_KALLSYMS is not set
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
-- 
2.34.1

