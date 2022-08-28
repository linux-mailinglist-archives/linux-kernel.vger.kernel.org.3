Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A155A3C74
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 08:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiH1GyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 02:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbiH1GyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 02:54:10 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F7E543F3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:54:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z8so6722653edb.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=p/rzzBcgXmWVakaeVkh9CyW0j/OXk8c0gjvamjm41Zs=;
        b=nCevo1lWGTnJ/M4/PqfK0XBXURmAexwcMGWHAHQJg9s8Mr8pSyB1Ap/Fi17duDAGDF
         iOQCIl4Uas7NRH6ZAsWyRUgw8Sn3Fxo8Z7LC4sJbINdpYYfwwy0n6myICBNnHvMkZc1V
         5UH3OTTeKh07HamU8MEkufmgCb+0XULiaL5glheTWQKSeyJAHqN+MmXpTQDC4j2ORmxJ
         /U6IJ5c6dbFZpgYZ+2Rl1pPMwm4zws9lBBdoX5mGL91UPF22k6oE4H31THpu/AZcN285
         iPrMcOLGvnKLRpkfAi7DwjbqhfHeNKTUouLgwKt3fOOyLojCoGlxvQPO1sHr5Lbuq6eI
         Wi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=p/rzzBcgXmWVakaeVkh9CyW0j/OXk8c0gjvamjm41Zs=;
        b=iSypbEDc2aT3TOJbWR15Z6RYQ5lw10EFqG6Y/Ioj2pppKWcmyfBkg9q4lg3mgnpANM
         C7fR/UR+eDqbszHYSag0T+peiWfmvfVylvf1hV3IkwwpUqaj+O8gcdtR7/4vtjdwRNEy
         YPRaY2bqx1EEzDgwbUJiGKzxF6zOKk5AJwFu2hnb87lAWkpM32NTtJF4h619LpyM+/py
         wablskqJPOLOxKcclphxiqZAC6KZoPp/1rvaEjMH6AHfQasM98Mj4u+EfUdG4TDpruuR
         Q0vP/AvRFmOSFx//eDRZSboA3Xih8oiuzjnyK09T0+IN4hNNSrUL8Ywl0I8ukai9Q+7l
         EZ8w==
X-Gm-Message-State: ACgBeo32JyTz25CJ4ntmZn/U+KgQ1HFf8Gf+7gFchg+av3W+p0rB1JNZ
        Vbj0Yoiu/uCysVRtWsY6LV9b36PEC5U=
X-Google-Smtp-Source: AA6agR7+qvqFkMDOg1vdKVfvTiUdxddvCaF/RsL2qKRY0P2/186lUiTuBiRVhwGx+Tad/oQquwifXA==
X-Received: by 2002:a05:6402:4449:b0:445:cdb6:2de9 with SMTP id o9-20020a056402444900b00445cdb62de9mr12430516edb.59.1661669646820;
        Sat, 27 Aug 2022 23:54:06 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b0073d03cb868csm2872724eju.75.2022.08.27.23.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 23:54:06 -0700 (PDT)
Date:   Sun, 28 Aug 2022 08:54:04 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] staging: vt6655: Rename macro MACvSelectPage1
Message-ID: <8aa03e089613d49be7acedcb60a19a0133e96baa.1661666677.git.philipp.g.hortmann@gmail.com>
References: <cover.1661666677.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661666677.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename MACvSelectPage1 macro to VT6655_MAC_SELECT_PAGE1 to avoid
CamelCase which is not accepted by checkpatch.pl and to clean up
namespace. Remove unnecessary line break.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/card.c        | 2 +-
 drivers/staging/vt6655/channel.c     | 2 +-
 drivers/staging/vt6655/device_main.c | 6 +++---
 drivers/staging/vt6655/mac.c         | 4 ++--
 drivers/staging/vt6655/mac.h         | 3 +--
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index a4ebe59df5b8..1b2ba6793ead 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -545,7 +545,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 	spin_lock_irqsave(&priv->lock, flags);
 
 	/* Set to Page1 */
-	MACvSelectPage1(priv->port_offset);
+	VT6655_MAC_SELECT_PAGE1(priv->port_offset);
 
 	/* RSPINF_b_1 */
 	vnt_get_phy_field(priv, 14,
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index ae6bf9493611..4122875ebcaa 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -116,7 +116,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 		spin_lock_irqsave(&priv->lock, flags);
 
 		/* set HW default power register */
-		MACvSelectPage1(priv->port_offset);
+		VT6655_MAC_SELECT_PAGE1(priv->port_offset);
 		RFbSetPower(priv, RATE_1M, priv->byCurrentCh);
 		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWRCCK);
 		RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 283119bbe2fb..cd748b1665bb 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -400,7 +400,7 @@ static void device_init_registers(struct vnt_private *priv)
 	}
 
 	if (priv->local_id > REV_ID_VT3253_B1) {
-		MACvSelectPage1(priv->port_offset);
+		VT6655_MAC_SELECT_PAGE1(priv->port_offset);
 
 		iowrite8(MSRCTL1_TXPWR | MSRCTL1_CSAPAREN, priv->port_offset + MAC_REG_MSRCTL + 1);
 
@@ -1587,14 +1587,14 @@ static void vnt_configure(struct ieee80211_hw *hw,
 			spin_lock_irqsave(&priv->lock, flags);
 
 			if (priv->mc_list_count > 2) {
-				MACvSelectPage1(priv->port_offset);
+				VT6655_MAC_SELECT_PAGE1(priv->port_offset);
 
 				iowrite32(0xffffffff, priv->port_offset + MAC_REG_MAR0);
 				iowrite32(0xffffffff, priv->port_offset + MAC_REG_MAR0 + 4);
 
 				VT6655_MAC_SELECT_PAGE0(priv->port_offset);
 			} else {
-				MACvSelectPage1(priv->port_offset);
+				VT6655_MAC_SELECT_PAGE1(priv->port_offset);
 
 				multicast =  le64_to_cpu(multicast);
 				iowrite32((u32)multicast, priv->port_offset +  MAC_REG_MAR0);
diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 8485cd0a81c0..742391b24afb 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -213,7 +213,7 @@ void MACvSaveContext(struct vnt_private *priv, unsigned char *cxt_buf)
 	/* read page0 register */
 	memcpy_fromio(cxt_buf, io_base, MAC_MAX_CONTEXT_SIZE_PAGE0);
 
-	MACvSelectPage1(io_base);
+	VT6655_MAC_SELECT_PAGE1(io_base);
 
 	/* read page1 register */
 	memcpy_fromio(cxt_buf + MAC_MAX_CONTEXT_SIZE_PAGE0, io_base,
@@ -240,7 +240,7 @@ void MACvRestoreContext(struct vnt_private *priv, unsigned char *cxt_buf)
 {
 	void __iomem *io_base = priv->port_offset;
 
-	MACvSelectPage1(io_base);
+	VT6655_MAC_SELECT_PAGE1(io_base);
 	/* restore page1 */
 	memcpy_toio(io_base, cxt_buf + MAC_MAX_CONTEXT_SIZE_PAGE0,
 		    MAC_MAX_CONTEXT_SIZE_PAGE1);
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index a14b38a96ec6..3af8abc305b1 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -539,8 +539,7 @@
 
 #define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, iobase + MAC_REG_PAGE1SEL)
 
-#define MACvSelectPage1(iobase)				\
-	iowrite8(1, iobase + MAC_REG_PAGE1SEL)
+#define VT6655_MAC_SELECT_PAGE1(iobase) iowrite8(1, iobase + MAC_REG_PAGE1SEL)
 
 #define MACvSetRFLE_LatchBase(iobase)                                 \
 	vt6655_mac_word_reg_bits_on(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_RFLEOPT)
-- 
2.37.2

