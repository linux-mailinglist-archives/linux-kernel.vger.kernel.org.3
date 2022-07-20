Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0AB57BE3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiGTTCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiGTTCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:02:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F150D7391E;
        Wed, 20 Jul 2022 12:02:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u5so4388585wrm.4;
        Wed, 20 Jul 2022 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=0pANhEh8I8cua75bgAZ44HbjWJ/WBJy1hZ/Ve54QZ6A=;
        b=nXfl6Mc360gBtIT5C5FFR3rBLRtJKKDbO+vpiboyCsIlFpcpZnJ+gak1To8l2ujH10
         E9dpMV99+utOjdrEztCcVwd3x8UUeyjacVhbCbZGUDF/Xbj/ib7wxiRSLh7Cx0VTjFKx
         OQiLIafDcX5R1WPCnyseAXJEWtySIUfeWj1Q2VpI1upAsVPJfKr6mk324E65/I7TvKR5
         9BZkF5QHeKENJMzPUw2kTw1it8AlKGoLzt/XJ7jMSZYHdLp8QQJ8BgIJMxBYWNyNpbd2
         687J5GG4EtSFKRUv7j3J+LY/X8MgsL83YqG4rzj+zhoPbgGff/mbjYPQxZZ3kiFMxecp
         mAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0pANhEh8I8cua75bgAZ44HbjWJ/WBJy1hZ/Ve54QZ6A=;
        b=Ef2ZrZxax4W6cv+vIS1GFPmUkOTsU7Q2AOn0SAiKcJmtUorK9SOCETwx/OeNO3Cb2l
         WN4t4MYSlgsZ9WP4Qpokb0ZwimRiJHqmn45Hwo5zY5qMAKmtMbJfVfzyiWuqnaD9+IOS
         /xs0I1uXu42Wp0fdBH98bXvbPY6HCXHpxuG29YrJ3qiVY9bCeUk9Cy5vJIMHql+vzAeS
         Qe2288Owx13pqdlQVD0Tb3EFfxsRoiSXbzB7R4Rg+acNw3jTPA/Wqa+E/Ech2/zkd20S
         52vAbtt1p6Rof5Eff7aBEIFnAh6FIc1ANw/TnQk1u6I0PG+6xFJ48kUhff/0RrFKSpPX
         vH5w==
X-Gm-Message-State: AJIora83Ul9ESb8G9P6I8ZmRkwXzxkaJfyab64gHHxPob0654g0kkVq3
        TTvy/KurED3uXtHXch2kyJg=
X-Google-Smtp-Source: AGRyM1uRbS8EQdqAN7cCOCIrmlQgpd9cr9PVT3M1YFeaVcEiPAqUMcunBarh+9qKPoHAFjE+wP2gfw==
X-Received: by 2002:a05:6000:1c01:b0:21e:2de6:817 with SMTP id ba1-20020a0560001c0100b0021e2de60817mr8859049wrb.570.1658343740362;
        Wed, 20 Jul 2022 12:02:20 -0700 (PDT)
Received: from felia.fritz.box (200116b826a11f00b9fa8830955362e6.dip.versatel-1u1.de. [2001:16b8:26a1:1f00:b9fa:8830:9553:62e6])
        by smtp.gmail.com with ESMTPSA id u16-20020a5d5150000000b0021e529efa60sm49206wrt.1.2022.07.20.12.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:02:20 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] dma-mapping: update comment after dmabounce removal
Date:   Wed, 20 Jul 2022 21:02:08 +0200
Message-Id: <20220720190208.11270-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e3217540c271 ("ARM/dma-mapping: remove dmabounce") removes the
config DMABOUNCE. A comment to the function __dma_page_cpu_to_dev() refers
to this removed config DMABOUNCE.

Remove the obsolete explanation, but keep the recommendation not to use
__dma_page_cpu_to_dev() and use dma_sync_* functions instead.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mm/dma-mapping.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index e68d1d2ac4be..16c2cdd04639 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -679,8 +679,7 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
 
 /*
  * Make an area consistent for devices.
- * Note: Drivers should NOT use this function directly, as it will break
- * platforms with CONFIG_DMABOUNCE.
+ * Note: Drivers should NOT use this function directly.
  * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
  */
 static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
-- 
2.17.1

