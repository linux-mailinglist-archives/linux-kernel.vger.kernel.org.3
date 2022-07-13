Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC4C572CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbiGMFCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiGMFBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:01:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B10DC182
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:01:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m16so12620841edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dO402Qp/UiplTcX+zawtxiNoCCJUNwrPAz1ETlXXyB0=;
        b=ZFtYMyXlafqD/fFTenIwbIxD5u7url7fnHZ+7++LYDJimZDWclkaLUH3upBnuunarh
         jXJswBpaSscx+pFwujsKOt8w1+hLJHcHEgAHo+62bDppKDW0OBHQohuk8oAefmEc016L
         MJHPeXapdp04dDaT3kh11OEqY6ascG2b7r0/e3fjjHB26QcjDBQ9a4JxCIEyxkJrLiTA
         kS1U9u9zkj6BkiOc9gumDCFRhgQfkU+ga2TmGQDn731r4zwiqpGXCMgDP+IRpJXxc6GM
         U8tuELojUzA8s0cqcINM1Uppv/56v52QOdvO/T7b9g40NtdYiY8BdwGck5+p9gAriGdf
         0yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dO402Qp/UiplTcX+zawtxiNoCCJUNwrPAz1ETlXXyB0=;
        b=mtcN1AFd5CZAJi3yi8dHcRvYjyGqtTMCRcXQKbQt3XbByBX0zOEb9q1bNPvNWTtWI6
         uHA/oC8Aonjve9HYyivY72jvRlsodu6I24rM8M5+4cm1RXExKknkVJoGzijIGFrr+7x5
         7n4PJhebz6R5Vo17b5eEknt4vj78bVNlVEBy2YupIiG+OqwOoqDZ6gb8k9VOtIZSfV/G
         SjQGUv7Bj7XP+R0mg80dePEs1/pkjZmkUAdZRvP9jNNonC4HdKixrdZufQjK2cVWEdLd
         VVODAZSqsxmzFgIU9plTqX+QcMOK5o7opI44hgQmnhm7KhaPWy2WV39+PvrPKr/70X5c
         yshg==
X-Gm-Message-State: AJIora8XqR9L/Wy4Ovrmbxnib7KiszU9431ewdZxP2pCJ11a192wbSXt
        sAMDULLpSF59r49OVZYjpQA=
X-Google-Smtp-Source: AGRyM1sqaYxBhPgcaxroNuFcefanukLM+0mu3OhJ3l7+1HQijjQEzR4/DlnXIaDqII+hhjx8cmdoWw==
X-Received: by 2002:a05:6402:2985:b0:439:651b:c1f4 with SMTP id eq5-20020a056402298500b00439651bc1f4mr2236736edb.276.1657688472308;
        Tue, 12 Jul 2022 22:01:12 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id h5-20020a0564020e8500b0043a7404314csm7142422eda.8.2022.07.12.22.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:01:11 -0700 (PDT)
Date:   Wed, 13 Jul 2022 07:01:10 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] staging: vt6655: Rename MACvRegBitsOff
Message-ID: <e6bea6707f20a53d0631dd1f477ce72d36cd6f3e.1657657918.git.philipp.g.hortmann@gmail.com>
References: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of a macro that uses CamelCase which is not
accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/card.c        |  2 +-
 drivers/staging/vt6655/device_main.c | 24 ++++++++++++------------
 drivers/staging/vt6655/mac.c         | 10 +++++-----
 drivers/staging/vt6655/mac.h         |  2 +-
 drivers/staging/vt6655/power.c       |  6 +++---
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 54a12c97aa16..ec70a1f611d4 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -367,7 +367,7 @@ void CARDbRadioPowerOff(struct vnt_private *priv)
 		break;
 	}
 
-	MACvRegBitsOff(priv->port_offset, MAC_REG_HOSTCR, HOSTCR_RXON);
+	vt6655_mac_reg_bits_off(priv->port_offset, MAC_REG_HOSTCR, HOSTCR_RXON);
 
 	bb_set_deep_sleep(priv, priv->local_id);
 
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index bcf35a89730e..92583ee8bffd 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1322,13 +1322,13 @@ static int vnt_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	case NL80211_IFTYPE_STATION:
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		MACvRegBitsOff(priv->port_offset, MAC_REG_RCR, RCR_UNICAST);
+		vt6655_mac_reg_bits_off(priv->port_offset, MAC_REG_RCR, RCR_UNICAST);
 
 		vt6655_mac_reg_bits_on(priv->port_offset, MAC_REG_HOSTCR, HOSTCR_ADHOC);
 
 		break;
 	case NL80211_IFTYPE_AP:
-		MACvRegBitsOff(priv->port_offset, MAC_REG_RCR, RCR_UNICAST);
+		vt6655_mac_reg_bits_off(priv->port_offset, MAC_REG_RCR, RCR_UNICAST);
 
 		vt6655_mac_reg_bits_on(priv->port_offset, MAC_REG_HOSTCR, HOSTCR_AP);
 
@@ -1351,16 +1351,16 @@ static void vnt_remove_interface(struct ieee80211_hw *hw,
 	case NL80211_IFTYPE_STATION:
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		MACvRegBitsOff(priv->port_offset, MAC_REG_TCR, TCR_AUTOBCNTX);
-		MACvRegBitsOff(priv->port_offset,
-			       MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
-		MACvRegBitsOff(priv->port_offset, MAC_REG_HOSTCR, HOSTCR_ADHOC);
+		vt6655_mac_reg_bits_off(priv->port_offset, MAC_REG_TCR, TCR_AUTOBCNTX);
+		vt6655_mac_reg_bits_off(priv->port_offset,
+					MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
+		vt6655_mac_reg_bits_off(priv->port_offset, MAC_REG_HOSTCR, HOSTCR_ADHOC);
 		break;
 	case NL80211_IFTYPE_AP:
-		MACvRegBitsOff(priv->port_offset, MAC_REG_TCR, TCR_AUTOBCNTX);
-		MACvRegBitsOff(priv->port_offset,
-			       MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
-		MACvRegBitsOff(priv->port_offset, MAC_REG_HOSTCR, HOSTCR_AP);
+		vt6655_mac_reg_bits_off(priv->port_offset, MAC_REG_TCR, TCR_AUTOBCNTX);
+		vt6655_mac_reg_bits_off(priv->port_offset,
+					MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
+		vt6655_mac_reg_bits_off(priv->port_offset, MAC_REG_HOSTCR, HOSTCR_AP);
 		break;
 	default:
 		break;
@@ -1478,8 +1478,8 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 			vt6655_mac_reg_bits_on(priv->port_offset, MAC_REG_TCR, TCR_AUTOBCNTX);
 		} else {
-			MACvRegBitsOff(priv->port_offset, MAC_REG_TCR,
-				       TCR_AUTOBCNTX);
+			vt6655_mac_reg_bits_off(priv->port_offset, MAC_REG_TCR,
+						TCR_AUTOBCNTX);
 		}
 	}
 
diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index 8e789ce055cd..688f7c685c97 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -337,7 +337,7 @@ bool MACbSafeRxOff(struct vnt_private *priv)
 	}
 
 	/* try to safe shutdown RX */
-	MACvRegBitsOff(io_base, MAC_REG_HOSTCR, HOSTCR_RXON);
+	vt6655_mac_reg_bits_off(io_base, MAC_REG_HOSTCR, HOSTCR_RXON);
 	/* W_MAX_TIMEOUT is the timeout period */
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
 		if (!(ioread8(io_base + MAC_REG_HOSTCR) & HOSTCR_RXONST))
@@ -392,7 +392,7 @@ bool MACbSafeTxOff(struct vnt_private *priv)
 	}
 
 	/* try to safe shutdown TX */
-	MACvRegBitsOff(io_base, MAC_REG_HOSTCR, HOSTCR_TXON);
+	vt6655_mac_reg_bits_off(io_base, MAC_REG_HOSTCR, HOSTCR_TXON);
 
 	/* W_MAX_TIMEOUT is the timeout period */
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
@@ -423,7 +423,7 @@ bool MACbSafeStop(struct vnt_private *priv)
 {
 	void __iomem *io_base = priv->port_offset;
 
-	MACvRegBitsOff(io_base, MAC_REG_TCR, TCR_AUTOBCNTX);
+	vt6655_mac_reg_bits_off(io_base, MAC_REG_TCR, TCR_AUTOBCNTX);
 
 	if (!MACbSafeRxOff(priv)) {
 		pr_debug(" MACbSafeRxOff == false)\n");
@@ -436,7 +436,7 @@ bool MACbSafeStop(struct vnt_private *priv)
 		return false;
 	}
 
-	MACvRegBitsOff(io_base, MAC_REG_HOSTCR, HOSTCR_MACEN);
+	vt6655_mac_reg_bits_off(io_base, MAC_REG_HOSTCR, HOSTCR_MACEN);
 
 	return true;
 }
@@ -730,7 +730,7 @@ bool MACbPSWakeup(struct vnt_private *priv)
 		return true;
 
 	/* Disable PS */
-	MACvRegBitsOff(io_base, MAC_REG_PSCTL, PSCTL_PSEN);
+	vt6655_mac_reg_bits_off(io_base, MAC_REG_PSCTL, PSCTL_PSEN);
 
 	/* Check if SyncFlushOK */
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 3303b9ba3bee..16f2b77e1371 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -551,7 +551,7 @@ do {									\
 	iowrite16(reg_value | (bit_mask), iobase + reg_offset);		\
 } while (0)
 
-#define MACvRegBitsOff(iobase, reg_offset, bit_mask)			\
+#define vt6655_mac_reg_bits_off(iobase, reg_offset, bit_mask)			\
 do {									\
 	unsigned char reg_value;					\
 	reg_value = ioread8(iobase + reg_offset);			\
diff --git a/drivers/staging/vt6655/power.c b/drivers/staging/vt6655/power.c
index c8a456305e1d..8527ad3eff48 100644
--- a/drivers/staging/vt6655/power.c
+++ b/drivers/staging/vt6655/power.c
@@ -66,7 +66,7 @@ void PSvEnablePowerSaving(struct vnt_private *priv,
 
 	if (wListenInterval >= 2) {
 		/* clear always listen beacon */
-		MACvRegBitsOff(priv->port_offset, MAC_REG_PSCTL, PSCTL_ALBCN);
+		vt6655_mac_reg_bits_off(priv->port_offset, MAC_REG_PSCTL, PSCTL_ALBCN);
 		/* first time set listen next beacon */
 		vt6655_mac_reg_bits_on(priv->port_offset, MAC_REG_PSCTL, PSCTL_LNBCN);
 	} else {
@@ -98,10 +98,10 @@ void PSvDisablePowerSaving(struct vnt_private *priv)
 	MACbPSWakeup(priv);
 
 	/* clear AutoSleep */
-	MACvRegBitsOff(priv->port_offset, MAC_REG_PSCFG, PSCFG_AUTOSLEEP);
+	vt6655_mac_reg_bits_off(priv->port_offset, MAC_REG_PSCFG, PSCFG_AUTOSLEEP);
 
 	/* clear HWUTSF */
-	MACvRegBitsOff(priv->port_offset, MAC_REG_TFTCTL, TFTCTL_HWUTSF);
+	vt6655_mac_reg_bits_off(priv->port_offset, MAC_REG_TFTCTL, TFTCTL_HWUTSF);
 
 	/* set always listen beacon */
 	vt6655_mac_reg_bits_on(priv->port_offset, MAC_REG_PSCTL, PSCTL_ALBCN);
-- 
2.37.0

