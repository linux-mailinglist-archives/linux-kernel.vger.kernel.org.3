Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6725A3C73
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 08:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiH1GyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 02:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiH1GyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 02:54:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1BE4F1AB
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:53:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u9so10077969ejy.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 23:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=1clvh7sbseYUW4IbmWFpAESVQFsQwA5j3fmCSQQcU8w=;
        b=IF2by2Cf/Vy9SkdDmgxevln5gJ36bp+QdkJL326U+jLewiCNPeB7EPb960SuFJcuMB
         6J7aEQw3UJgU/AmcafptWNiNKlGABk+aZveQdDE+XK8VvvCZAWK7Tey+L5qlT5ltRALy
         47rku6pRsW510IeBVh8jk9jTnwwHwxdwlxVKLtiFEJOPd4bK4RnS7bc6qjKh5n3aAXGz
         kjaYji2xes/dgBd1/fhYpqKbmJPb1TUH8wLzML9JdCfu1OnzcxqZeUJBgKVDtr7jIokb
         S7B1KJ9WXBY51kAgNJ5C+UU2oxIOvSEVfLm5pLm4sXA05FuBkm25FVEIDsB9Zuad2xRb
         wJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=1clvh7sbseYUW4IbmWFpAESVQFsQwA5j3fmCSQQcU8w=;
        b=RPcFb8oyT037wdRaaDJl6EYtxkYiu90wvXQo1Kjjh9zx7QzwT9LRSFOHdXnAluO6oc
         knf2oM5qSnkS28qgHIHyD2DV+3FPe2BpmQX+yqoYkKNS9Dc2f7/dgm/4UJ2R+Zln1fMR
         8RvLtm0eijpqKxmH66rJW7OSJZAvtpRUQ3K3LudB2rbGAe3mM4RXdgmMoAkhXhsY+m39
         NsrSYXlOQPZf2DNbz3ngq6UzMd21OcktiqFBJZeaIwYPYjX5JU+rMF8H955vFv19zlmM
         9BnZnDL8UDrWpiSN/rm1SL2TyjSsB8kHK4MAlFgTU46LeYGSpsXIt5iXGf5VLiyWfoVV
         ABbg==
X-Gm-Message-State: ACgBeo1OJDWF+PNEjPe4ziZ5L+oxWT6zU0tbEfmntCFwklCjTZHfvR8n
        Xs23Cq+nu1M4+MQMq+KZtrY=
X-Google-Smtp-Source: AA6agR4z0QgaeG02D+C1O+TRewtalZtVEoEkKx/IaDD+qGzjiFkjZuW9YiGBDWbrqPd/hfZ2XHT4yw==
X-Received: by 2002:a17:907:2894:b0:741:4e40:94fe with SMTP id em20-20020a170907289400b007414e4094femr2934174ejc.606.1661669637638;
        Sat, 27 Aug 2022 23:53:57 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090609b100b0073022b796a7sm2907352eje.93.2022.08.27.23.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 23:53:57 -0700 (PDT)
Date:   Sun, 28 Aug 2022 08:53:55 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] staging: vt6655: Rename macro MACvSelectPage0
Message-ID: <a656aa0e04c43654ba22b764cb00e27898efbe5f.1661666677.git.philipp.g.hortmann@gmail.com>
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

Rename MACvSelectPage0 macro to VT6655_MAC_SELECT_PAGE0 to avoid
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
index c442a1e580ab..a4ebe59df5b8 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -643,7 +643,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 				   &byRsvTime);
 	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_72);
 	/* Set to Page0 */
-	MACvSelectPage0(priv->port_offset);
+	VT6655_MAC_SELECT_PAGE0(priv->port_offset);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index e926f9829a15..ae6bf9493611 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -121,7 +121,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWRCCK);
 		RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
 		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWROFDM);
-		MACvSelectPage0(priv->port_offset);
+		VT6655_MAC_SELECT_PAGE0(priv->port_offset);
 
 		spin_unlock_irqrestore(&priv->lock, flags);
 	}
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 8e2a976aaaad..283119bbe2fb 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -404,7 +404,7 @@ static void device_init_registers(struct vnt_private *priv)
 
 		iowrite8(MSRCTL1_TXPWR | MSRCTL1_CSAPAREN, priv->port_offset + MAC_REG_MSRCTL + 1);
 
-		MACvSelectPage0(priv->port_offset);
+		VT6655_MAC_SELECT_PAGE0(priv->port_offset);
 	}
 
 	/* use relative tx timeout and 802.11i D4 */
@@ -1592,7 +1592,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
 				iowrite32(0xffffffff, priv->port_offset + MAC_REG_MAR0);
 				iowrite32(0xffffffff, priv->port_offset + MAC_REG_MAR0 + 4);
 
-				MACvSelectPage0(priv->port_offset);
+				VT6655_MAC_SELECT_PAGE0(priv->port_offset);
 			} else {
 				MACvSelectPage1(priv->port_offset);
 
@@ -1601,7 +1601,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
 				iowrite32((u32)(multicast >> 32),
 					  priv->port_offset + MAC_REG_MAR0 + 4);
 
-				MACvSelectPage0(priv->port_offset);
+				VT6655_MAC_SELECT_PAGE0(priv->port_offset);
 			}
 
 			spin_unlock_irqrestore(&priv->lock, flags);
diff --git a/drivers/staging/vt6655/mac.c b/drivers/staging/vt6655/mac.c
index dcc649532737..8485cd0a81c0 100644
--- a/drivers/staging/vt6655/mac.c
+++ b/drivers/staging/vt6655/mac.c
@@ -219,7 +219,7 @@ void MACvSaveContext(struct vnt_private *priv, unsigned char *cxt_buf)
 	memcpy_fromio(cxt_buf + MAC_MAX_CONTEXT_SIZE_PAGE0, io_base,
 		      MAC_MAX_CONTEXT_SIZE_PAGE1);
 
-	MACvSelectPage0(io_base);
+	VT6655_MAC_SELECT_PAGE0(io_base);
 }
 
 /*
@@ -245,7 +245,7 @@ void MACvRestoreContext(struct vnt_private *priv, unsigned char *cxt_buf)
 	memcpy_toio(io_base, cxt_buf + MAC_MAX_CONTEXT_SIZE_PAGE0,
 		    MAC_MAX_CONTEXT_SIZE_PAGE1);
 
-	MACvSelectPage0(io_base);
+	VT6655_MAC_SELECT_PAGE0(io_base);
 
 	/* restore RCR,TCR,IMR... */
 	memcpy_toio(io_base + MAC_REG_RCR, cxt_buf + MAC_REG_RCR,
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index b6c4f2bb096a..a14b38a96ec6 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -537,8 +537,7 @@
 
 /*---------------------  Export Macros ------------------------------*/
 
-#define MACvSelectPage0(iobase)				\
-	iowrite8(0, iobase + MAC_REG_PAGE1SEL)
+#define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, iobase + MAC_REG_PAGE1SEL)
 
 #define MACvSelectPage1(iobase)				\
 	iowrite8(1, iobase + MAC_REG_PAGE1SEL)
-- 
2.37.2

