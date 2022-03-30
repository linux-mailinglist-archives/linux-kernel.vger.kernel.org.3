Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A834ED062
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 01:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351888AbiC3XuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 19:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbiC3XuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:50:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35FE13F72
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:48:35 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x31so13741479pfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=qBPGxp5mcQc4QZY8fFiZjVaI3n1akSFYZ8khR08Ev/8=;
        b=eKehRzx3Bdx40er/MgtTkPeSzGb096H8wDgKvamKLh2skigPsj/2DEy/2gN1MkWuJb
         j292p+zlwkmHLoPKAxCZjM5wufHYcjiXSSPXDx+5yRx9Fr7ECbsHalHXWpHiEVP4/otX
         osFrFJN0i3zvZFqhyWseZn/6fvyeTHbZf09v7xuuT1usUhh91ysN+7T7sAKP6x1nDY59
         917uca5QAEAsE+RpBcE+5hr6v9vzlhJh8dzkezP1bzf1+zlF3UfMkPwnye7NPCVXoD5v
         FXifhOb5ZYoSIfHf3lUHf1eUYz18A6pxne5MiPgpTaQUYRT/M0VEfb514o8b21FDSqgm
         7AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=qBPGxp5mcQc4QZY8fFiZjVaI3n1akSFYZ8khR08Ev/8=;
        b=s8EpdfbcIZLPEAs4ighMfqRS5G35NoDF8bg27WKPW5zBNmRlGopBxaQqQVEhOc6Cxo
         mwxyXGziVEoje5FO8JNKZDyIcJ4mwonXRHMw2cWTqdaeRMP6cBCv9EduQ3ux9AswGkTd
         r6OyIYCgi5hJNq/cEYLuDgK+qB6Y0aP79PNtGszvk4KlYRziexjkgkZ/T5s4wsoU09VK
         98jiSwwmftWhbbiwaSVDYlq0tHvaVwl1p3Xd5EMzB6wGE8xPWThtjUO4Ff62O9bLSULX
         MQJpUqhL64TRpfvGMI6AKAHbD8kOpOgv/sMUaJAkhjTHpyRkYxxbvkkuj23cZTeF94PC
         DneQ==
X-Gm-Message-State: AOAM531bXLd2h1mK9tYn742mYXsJqI50X49OvHlLXioGDkPC08vQXdHn
        G6IFkyuR4shbdALWMp+l+49fwA==
X-Google-Smtp-Source: ABdhPJw0eTer3uAW+Qu+xSBIF5rbYg9osobJhrjnYEvqPlPLOMX3LZkn6jvKpGKDimlZWzaSUKjlTg==
X-Received: by 2002:a63:6f44:0:b0:398:31d6:e37f with SMTP id k65-20020a636f44000000b0039831d6e37fmr8177965pgc.177.1648684115385;
        Wed, 30 Mar 2022 16:48:35 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a001ad000b004fb358ffe86sm16629736pfv.137.2022.03.30.16.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 16:48:35 -0700 (PDT)
Subject: [PATCH 1/3] RISC-V: defconfig: Drop redundant SBI HVC and earlycon
Date:   Wed, 30 Mar 2022 16:47:37 -0700
Message-Id: <20220330234739.1956-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
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

As of 3938d5a2f936 ("riscv: default to CONFIG_RISCV_SBI_V01=n") we no
longer default to enabling SBI-0.1 support, so these dependent configs
no longer have any effect.  Remove them to avoid clutter.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/defconfig      | 2 --
 arch/riscv/configs/rv32_defconfig | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 7cd10ded7bf8..74df9e1dd2d2 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -64,8 +64,6 @@ CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
-CONFIG_HVC_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index e0e5c7c09ab8..cabfd6a5b47b 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -62,8 +62,6 @@ CONFIG_INPUT_MOUSEDEV=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
-CONFIG_HVC_RISCV_SBI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
-- 
2.34.1

