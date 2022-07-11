Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1A9570191
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiGKMCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiGKMCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:02:43 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE01A3DBF9;
        Mon, 11 Jul 2022 05:02:41 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e15so5951848edj.2;
        Mon, 11 Jul 2022 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=BWPy1/wLCTu6ilQ4qUtHXwXwf7Z3gLlHQb6cz3/Ocik=;
        b=Km4YSWpymZHkGx1rK7YmaWp5bO7T4ldo5feo4/eotjCLPx0cA4uhJ7EFb+nHLoMc0z
         n8a8f6Sd0JTo4jq+fK7He9B0gtwTn0AfeNcEpUHCkdozbEmU1gSBLDGkrZzehRLd4XSR
         HaM1NjnsXectLRiGhKY1Wd2EZOJznd3w2/v2zSlwUgtUZ3/ODINZUOi9XUpQxWUPgGIO
         YUxQH4CI6H/cSxO7DydgPsEVvvf6UN1B/8mh2tfxWuS+3XJFIJHdmoRLyYwSRL8HZ3Hc
         3A4KhZpWMItX33PeoMcCpKDbJjw7vONygOQag9qg7V91/nwFbdBJnNgqxqJ9yqAycdlF
         SQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BWPy1/wLCTu6ilQ4qUtHXwXwf7Z3gLlHQb6cz3/Ocik=;
        b=wvjTTMri/Tqc4SAE2Syn50ivvlPP+hQLZbIXoZKZKT1Q8BZ6Soe5aDhRLtpN7rbDYq
         lYheLCH57qJJrfSJvIEs/WZYrn/adnEZ3mMYJrrVdhCJ/G8tWsrxqO9hC101n+6rOjvo
         0Gk7uTT0iis+nmCFX0oClvhLeHW4AP3JXcXqrABDz/TSyAHePAQMeOPrR5DU2+/gh6y+
         GRotX+bTqzmAtRHXPbaPl4ibHn1TNyWI8HqqtlQB/i1C575+kqzxQbzK5+9Jb93jeg5p
         LDXwg1C+N+xIMPXs72sHChE7Wktw6QQcLR9Wg5hJHwOzCRBVEP34GbYRLTzeRHArOIoX
         49Yg==
X-Gm-Message-State: AJIora9LktsDEG3UeJHwq6Swrrip5+1chIeNvps1ycC9vfmZbUYNLjhS
        olvN/ik+y68/i0mBKU/o+yM=
X-Google-Smtp-Source: AGRyM1ve4fGvpX//Ha5C48qcrSCWGYrkCUCqWsQMWsnGm5i1oa0340q2eUVYe7/+FksBdB/Z3Ta2eQ==
X-Received: by 2002:a05:6402:84f:b0:437:6293:d264 with SMTP id b15-20020a056402084f00b004376293d264mr23916942edz.317.1657540960468;
        Mon, 11 Jul 2022 05:02:40 -0700 (PDT)
Received: from felia.fritz.box (200116b8266e42009c70ae84c5cabc2b.dip.versatel-1u1.de. [2001:16b8:266e:4200:9c70:ae84:c5ca:bc2b])
        by smtp.gmail.com with ESMTPSA id hx24-20020a170906847800b00722fadc4279sm2608036ejc.124.2022.07.11.05.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 05:02:39 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH SECOND RESEND] arm: davinci: remove reference to obsolete BLK_DEV_PALMCHIP_BK3710
Date:   Mon, 11 Jul 2022 14:02:29 +0200
Message-Id: <20220711120229.30806-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b7fb14d3ac63 ("ide: remove the legacy ide driver") removes the
definition of the config BLK_DEV_PALMCHIP_BK3710.

So, remove the obsolete references in the mach-davinci architecture.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
first send:
  https://lore.kernel.org/linux-arm-kernel/20210804123426.16947-3-lukas.bulwahn@gmail.com/

first resend:
  https://lore.kernel.org/linux-arm-kernel/20211011063624.12269-2-lukas.bulwahn@gmail.com/

another resend (as part of a larger series):
  https://lore.kernel.org/linux-arm-kernel/20211028141938.3530-6-lukas.bulwahn@gmail.com/
  
addition now in second resend:
  - added Arnd's Reviewed-by tag from
    https://lore.kernel.org/linux-arm-kernel/CAK8P3a2GGbik3r5BCKE2ZCkpFyzv8Q54z_iV84ZJ+kNXYUTMzw@mail.gmail.com/

 arch/arm/mach-davinci/board-dm644x-evm.c  | 3 +--
 arch/arm/mach-davinci/board-dm646x-evm.c  | 3 +--
 arch/arm/mach-davinci/board-neuros-osd2.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index ebdd5c334ac1..4cde283f7f03 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -828,8 +828,7 @@ static int davinci_phy_fixup(struct phy_device *phydev)
 	return 0;
 }
 
-#define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
-			 IS_ENABLED(CONFIG_PATA_BK3710))
+#define HAS_ATA		IS_ENABLED(CONFIG_PATA_BK3710)
 
 #define HAS_NOR		IS_ENABLED(CONFIG_MTD_PHYSMAP)
 
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index 28861fee493b..151e246c99b8 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -146,8 +146,7 @@ static struct platform_device davinci_aemif_device = {
 	.num_resources	= ARRAY_SIZE(davinci_aemif_resources),
 };
 
-#define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
-			 IS_ENABLED(CONFIG_PATA_BK3710))
+#define HAS_ATA		IS_ENABLED(CONFIG_PATA_BK3710)
 
 #ifdef CONFIG_I2C
 /* CPLD Register 0 bits to control ATA */
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 9748a2c12cc4..3b2298d686d5 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -160,8 +160,7 @@ static struct davinci_mmc_config davinci_ntosd2_mmc_config = {
 	.wires		= 4,
 };
 
-#define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
-			 IS_ENABLED(CONFIG_PATA_BK3710))
+#define HAS_ATA		IS_ENABLED(CONFIG_PATA_BK3710)
 
 #define HAS_NAND	IS_ENABLED(CONFIG_MTD_NAND_DAVINCI)
 
-- 
2.17.1

