Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEC1594E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 04:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiHPCIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 22:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiHPCHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 22:07:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5BE10E7B9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:00:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z12so10495580wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=F2rGFENzHI0E3i8mswF35hHoUMszy0CZxP2MWQKHpBQ=;
        b=SwigwelJnmy5DhbwCbX4EIFty2vdJVo6HL901+2tfj45cuM+Dm4xSkjCK5i5aB1ucr
         BogTShuXqf9zG5AWFiFvUfiIYTKNG+Gg/fdYxyYjBA0kqyQujK08eirJUAS6pF40YghK
         QHw3mHBtJLp0EJC/vs3bl/khLlZXi1+zp6i+VlHNGVUbEaOwZUEaJpRNj+e44esGtT3J
         IY6Ljvy2jvT6QOjEJwNIM3fhCw4sSXWsNBGueBXZvsWAf8E3OQ4Q5LdITTsM15uvvpFT
         oJGa+TnZX7IzahqmWQDHMWYfb701XbLihdRlnBqtunzTIdlATyWMi9NKr58jl2M0mYLM
         sl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=F2rGFENzHI0E3i8mswF35hHoUMszy0CZxP2MWQKHpBQ=;
        b=aAe7JzpI9AjREEY09qCA+ozUlGOBH7evsgPOGFDio6UMlkmrEL5o+zQbCw6Rz75xBM
         CsEUyXlTvwNGa3JGQJXd5ISMScCQlGCPKVCfGgrqbRCcgFgozJC9GpuiAYBX98+TvL2t
         GlWttm3SfzDphGCKt+r59X7PQ/Mq/GFnbEzdEJ+jj5hNv17V8Sc7ExHFpPor1gj4RNQ4
         Q18D8G5AGX9UWjm3O6j9qFrGRAIyW7rlBCdg4wi/UY3TdSx3QrXY35JPfbto8OHEXxNw
         EtO0xygnTwth39sD7IkRzYtoY5BEei0VlxEeJnns8VCX1wn0NCQb9IJxY8yB3+sGzstl
         hhkg==
X-Gm-Message-State: ACgBeo2E+U74XRANwaD0ZNYv7QsSCGg9no2WQK5kFcTS6CVCIl85TElL
        fRaqhvbZRMANYlCp0xavUDQ=
X-Google-Smtp-Source: AA6agR7uQBKz9p2RoPuPctiBHIoYB4Qu2te8eOPpUxlusmYdKqLIHMU/LCxGvX4St+OzDGJl/1h/uw==
X-Received: by 2002:adf:dbc1:0:b0:224:fc61:fef7 with SMTP id e1-20020adfdbc1000000b00224fc61fef7mr4956247wrj.312.1660600810584;
        Mon, 15 Aug 2022 15:00:10 -0700 (PDT)
Received: from localhost.localdomain ([105.235.130.28])
        by smtp.gmail.com with ESMTPSA id y10-20020adfee0a000000b00223664ab3a8sm10195480wrn.90.2022.08.15.15.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 15:00:10 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] phy: phy-mtk-tphy: Make USB PHY work on MT6735
Date:   Mon, 15 Aug 2022 22:58:59 +0100
Message-Id: <20220815215859.253962-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB PHY on MT6735 seems to be a TPHY V1, but the FMREG base
here is 0xf00 rather than 0x100. Since it is definitely not a V2
or later as it has shared registers, would this mean that it is
an even earlier revision, or one between V1 and V2? Or is the
address used currently in this driver wrong?

Furthermore, there is one additional step needed in the power on
sequence to make USB work on MT6735, which is to set the 10th bit
of U3P_U2PHYDTM1. This was found through trial and error by adding
the power on sequence from the downstream driver then stripping
parts of it until a critical part is found. This specific part[1]
was found under a comment saying "force enter device mode", but
there are other bits that are cleared/set under the same comment,
some of which are set in the same write as this bit, so it is
unclear whether this bit is the one (or the only one) responsible
for "forcing enter device mode". There is no documentation on this
register (or any port registers for that matter) so this bit's
name and function are unknown. Does anyone have more information
on this? And if no information were to be found, would leaving
this as a magic value, or with the placeholder name currently used
(P2C_FORCE_ENTER_DEVICE_MODE) be acceptable?

[1] https://gitlab.com/Tooniis/linux-samsung-grandpplte/-/blob/master/drivers/misc/mediatek/usb20/mt6735/usb20_phy.c#L404
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 8ee7682b8e93..f54b8a9872bf 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -23,7 +23,7 @@
 /* version V1 sub-banks offset base address */
 /* banks shared by multiple phys */
 #define SSUSB_SIFSLV_V1_SPLLC		0x000	/* shared by u3 phys */
-#define SSUSB_SIFSLV_V1_U2FREQ		0x100	/* shared by u2 phys */
+#define SSUSB_SIFSLV_V1_U2FREQ		0xf00	/* shared by u2 phys */
 #define SSUSB_SIFSLV_V1_CHIP		0x300	/* shared by u3 phys */
 /* u2 phy bank */
 #define SSUSB_SIFSLV_V1_U2PHY_COM	0x000
@@ -119,6 +119,7 @@
 
 #define U3P_U2PHYDTM1		0x06C
 #define P2C_RG_UART_EN			BIT(16)
+#define P2C_FORCE_ENTER_DEVICE_MODE	BIT(10)
 #define P2C_FORCE_IDDIG		BIT(9)
 #define P2C_RG_VBUSVALID		BIT(5)
 #define P2C_RG_SESSEND			BIT(4)
@@ -579,6 +580,8 @@ static void u2_phy_instance_power_on(struct mtk_tphy *tphy,
 		mtk_phy_set_bits(com + U3P_U2PHYDTM0, P2C_RG_SUSPENDM | P2C_FORCE_SUSPENDM);
 	}
 	dev_dbg(tphy->dev, "%s(%d)\n", __func__, index);
+
+	mtk_phy_set_bits(com + U3P_U2PHYDTM1, P2C_FORCE_ENTER_DEVICE_MODE);
 }
 
 static void u2_phy_instance_power_off(struct mtk_tphy *tphy,
-- 
2.37.1

