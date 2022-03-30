Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC7D4ED064
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351904AbiC3Xuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351891AbiC3XuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:50:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548CEAE4E
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:48:38 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z16so20318912pfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=uMi8FiJGdw1hSWyPivVKVtp/8/U1PGRylw+D5/i30Yc=;
        b=14gmg1klMYYePDa6VXo32RZDPb5C+8sMP6F4m/UFXM1qi6g+IvhztZfI+b5rYPg/qu
         WIGstSRYe1XuOwQx+KOmKRuCvedzLl3he43lysT1Lhw/LRpElOdwBFTwJFxekaoQtvbK
         0IvL/VN3azuobg7srm2NO5dWvvATE8Ef0R6dMEBXbTrSj54fHldTjiqDC17IqnORNIzc
         qV0lvUZkH/Sslz1W23g/ali1/5gvumNizW9hF7uWg2DYF3cKQ3cX28hjO7ChRr+VlCKz
         7Lv7I5r3CjXuiyOzgxM1RIg1OGxMC7i963+qCf+Xy9ViwSFeN3arbpkYOcZ7Lf0Ily/M
         FEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=uMi8FiJGdw1hSWyPivVKVtp/8/U1PGRylw+D5/i30Yc=;
        b=sbI1VI/5zvKMLnOQWmnvNNnGaCz45BxLDp61oelgeKpGzHD94W85TOqBsHnUFFDLmH
         cV6+8HRNHobIjmvze13g9+BNcPbCh1jNkgozQnVjx8crzA3Kckl7WqKdiSJUTXDD9oHy
         ennpxhOZ9qgREf1wO5Gs0ZQ62xgvTyIE1s0/FX2cDJYwge0xqARSzmKB7M3zsa+pEic5
         faJa6yETVfDgRCsf31hJ0QPuVDfmoXwPeFvDv/qunNgeUFOhD1GDGr4L1NFYgkps1IwI
         Dv4X4Sd+u1EpsHQDoCMl50lWAUCvj5Nyk4NM/FRseo1FIByHGBHIDTEQ8R8bO/GVquDz
         lZtw==
X-Gm-Message-State: AOAM5307eYcDmI0wW1UftDbGI+UOk2nVobdOrrPnoKRT9esKPXuefyVM
        To+tez/OUhgeOpAFwCHsaLw7jg==
X-Google-Smtp-Source: ABdhPJyBCUBpwiFEgy+YSHgNXEoiI9CiU1wc3B2s9DzUdnEP+7BnnP7cNSFHiO1jGdWv1Id9XE+W/w==
X-Received: by 2002:a63:e041:0:b0:381:1bac:ac85 with SMTP id n1-20020a63e041000000b003811bacac85mr8279847pgj.380.1648684117811;
        Wed, 30 Mar 2022 16:48:37 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090a708300b001c7e8ae7637sm7495497pjk.8.2022.03.30.16.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 16:48:37 -0700 (PDT)
Subject: [PATCH 3/3] RISC-V: defconfigs: Re-order CONFIG_DEBUG_MISC
Date:   Wed, 30 Mar 2022 16:47:39 -0700
Message-Id: <20220330234739.1956-3-palmer@rivosinc.com>
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

This has no functional effect, but is suggested by savedefconfig.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/nommu_k210_defconfig        | 2 +-
 arch/riscv/configs/nommu_k210_sdcard_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 2438fa39f8ae..172eaa6b935c 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -80,9 +80,9 @@ CONFIG_LSM="[]"
 CONFIG_PRINTK_TIME=y
 # CONFIG_SYMBOLIC_ERRNAME is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_DEBUG_MISC is not set
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 # CONFIG_FRAME_POINTER is not set
-# CONFIG_DEBUG_MISC is not set
 CONFIG_PANIC_ON_OOPS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_RCU_TRACE is not set
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index 9a133e63ae5b..09794b1aebf8 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -77,9 +77,9 @@ CONFIG_LSM="[]"
 CONFIG_PRINTK_TIME=y
 # CONFIG_SYMBOLIC_ERRNAME is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
+# CONFIG_DEBUG_MISC is not set
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
 # CONFIG_FRAME_POINTER is not set
-# CONFIG_DEBUG_MISC is not set
 CONFIG_PANIC_ON_OOPS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_RCU_TRACE is not set
-- 
2.34.1

