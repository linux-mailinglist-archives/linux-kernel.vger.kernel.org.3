Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071044BEC9A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbiBUVZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:25:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbiBUVZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:25:27 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17C112AF4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:25:02 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q17so32185566edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 13:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3iOaemryxFEi0e/+jdU0nqxQQNzituL4kMRU9dWLTYs=;
        b=Jh/ZCi75MemQA/Qs0viCHqUIzOrvPef7jBgD+1xx1DdQnQIFQwZa2oOJeptg2vqJo3
         m/OSthzCYeu0bSWecJYJKqletDZQ0BZhz3/Lve6ynf1NoyjnVzuScbX8do+eZ7eWf5ja
         IkZb2AeLWx0Wt5p2tr5i5BkkYWTLBMhivdmbEoIxV9GatL3vtz87WXFPixtLqQFaGNZP
         Wm81xmJtd/DmfUxmw4J7vkTZQE6ca9+J7lTqm0GdzAY5wZE5a4gNj5pZ3z2KRsZZuTFq
         A3M1HkD4ZQYGMUx5lSZr4rZMNsnywrWT5n45Xo4kLiRh4GufIinwU76vWhbmumT1VuyV
         4YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3iOaemryxFEi0e/+jdU0nqxQQNzituL4kMRU9dWLTYs=;
        b=XdrRjqiTlxI+am2q84IHEzqCyPpsPhzv9oB+aKHZJ9+k1FomUDPs8ddtPYHT9i0Rp1
         cUX16DWu4WLXQuNvEsUVGkhJqYiC4L1ubH1+mDUa0Wuv4drCeHWNC47z0gGCFVWIlS60
         zV7jQCJAezYItDQO2o0OPSiE3vwG2jYAUlPIHChQEDQE9t8NQM4lfXbMw9LQ3bXrbHkX
         WYgwXuIg3PbGyqqcSK6FTOMyzfW9BZVMH1Fb/x61/NXKd0eIcisZrzpjnjlx3pFsaCr8
         8/Szg8udF/50FqHn6Yco7u+eldh2zTIPzqoIB3xGJjVX+JTGKoquxPtDbLUV3Z0JZBfr
         07cw==
X-Gm-Message-State: AOAM5309gAzmRAVQ5ZJiB/coWsHsrn3zOSGwm4hDb9VZX5vRWtT/gOMl
        IcTRFMxm7sGUiV2k36MgLoY=
X-Google-Smtp-Source: ABdhPJyA2Ev7fa08B9hHevUNXo9Mg3QtTF2dSehbM7Tfai26QTSeZOWZ/ojfVE5NaMwtbm5pZ39dkw==
X-Received: by 2002:a50:fc05:0:b0:408:4d18:5070 with SMTP id i5-20020a50fc05000000b004084d185070mr23717566edr.365.1645478701457;
        Mon, 21 Feb 2022 13:25:01 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id e9sm4933398edy.53.2022.02.21.13.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 13:25:01 -0800 (PST)
Date:   Mon, 21 Feb 2022 22:24:59 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] staging: vt6656: Fix CamelCase warnings in mac.h and
 mac.c
Message-ID: <d04b36cc5446d1c996ac8bc71ff391d822cedd9d.1645477326.git.philipp.g.hortmann@gmail.com>
References: <cover.1645477326.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645477326.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warnings like:
CHECK: Avoid CamelCase: <EnCFG_BBType_a>
175: FILE: drivers/staging/vt6656/mac.h:175:
+#define EnCFG_BBType_a		0x00
and affected places in mac.c

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Changed EN_CFG_PKT_BURST_MO to EN_CFG_PKT_BURST_MD
---
 drivers/staging/vt6656/mac.c | 14 +++++++-------
 drivers/staging/vt6656/mac.h | 22 +++++++++++-----------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/vt6656/mac.c b/drivers/staging/vt6656/mac.c
index 4f1f9b03a678..49430c0a99b8 100644
--- a/drivers/staging/vt6656/mac.c
+++ b/drivers/staging/vt6656/mac.c
@@ -39,7 +39,7 @@ int vnt_mac_set_bb_type(struct vnt_private *priv, u8 type)
 	u8 data[2];
 
 	data[0] = type;
-	data[1] = EnCFG_BBType_MASK;
+	data[1] = EN_CFG_BB_TYPE_MASK;
 
 	return vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG0,
 			       MESSAGE_REQUEST_MACREG,	ARRAY_SIZE(data),
@@ -120,8 +120,8 @@ int vnt_mac_enable_protect_mode(struct vnt_private *priv)
 {
 	u8 data[2];
 
-	data[0] = EnCFG_ProtectMd;
-	data[1] = EnCFG_ProtectMd;
+	data[0] = EN_CFG_PROTECT_MD;
+	data[1] = EN_CFG_PROTECT_MD;
 
 	return vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG0,
 			       MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
@@ -132,7 +132,7 @@ int vnt_mac_disable_protect_mode(struct vnt_private *priv)
 	u8 data[2];
 
 	data[0] = 0;
-	data[1] = EnCFG_ProtectMd;
+	data[1] = EN_CFG_PROTECT_MD;
 
 	return vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG0,
 			       MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
@@ -142,8 +142,8 @@ int vnt_mac_enable_barker_preamble_mode(struct vnt_private *priv)
 {
 	u8 data[2];
 
-	data[0] = EnCFG_BarkerPream;
-	data[1] = EnCFG_BarkerPream;
+	data[0] = EN_CFG_BARKER_PREAM;
+	data[1] = EN_CFG_BARKER_PREAM;
 
 	return vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG2,
 			       MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
@@ -154,7 +154,7 @@ int vnt_mac_disable_barker_preamble_mode(struct vnt_private *priv)
 	u8 data[2];
 
 	data[0] = 0;
-	data[1] = EnCFG_BarkerPream;
+	data[1] = EN_CFG_BARKER_PREAM;
 
 	return vnt_control_out(priv, MESSAGE_TYPE_WRITE_MASK, MAC_REG_ENCFG2,
 			       MESSAGE_REQUEST_MACREG, ARRAY_SIZE(data), data);
diff --git a/drivers/staging/vt6656/mac.h b/drivers/staging/vt6656/mac.h
index 05af9ca7d69c..0ac845bd3c5a 100644
--- a/drivers/staging/vt6656/mac.h
+++ b/drivers/staging/vt6656/mac.h
@@ -172,20 +172,20 @@
 #define TFTCTL_TSFCNTREN	BIT(0)
 
 /* Bits in the EnhanceCFG_0 register */
-#define EnCFG_BBType_a		0x00
-#define EnCFG_BBType_b		BIT(0)
-#define EnCFG_BBType_g		BIT(1)
-#define EnCFG_BBType_MASK	(EnCFG_BBType_b | EnCFG_BBType_g)
-#define EnCFG_ProtectMd		BIT(5)
+#define EN_CFG_BB_TYPE_A	0x00
+#define EN_CFG_BB_TYPE_B	BIT(0)
+#define EN_CFG_BB_TYPE_G	BIT(1)
+#define EN_CFG_BB_TYPE_MASK	(EN_CFG_BB_TYPE_B | EN_CFG_BB_TYPE_G)
+#define EN_CFG_PROTECT_MD	BIT(5)
 
 /* Bits in the EnhanceCFG_1 register */
-#define EnCFG_BcnSusInd		BIT(0)
-#define EnCFG_BcnSusClr		BIT(1)
+#define EN_CFG_BCN_SUS_IND	BIT(0)
+#define EN_CFG_BCN_SUS_CLR	BIT(1)
 
 /* Bits in the EnhanceCFG_2 register */
-#define EnCFG_NXTBTTCFPSTR	BIT(0)
-#define EnCFG_BarkerPream	BIT(1)
-#define EnCFG_PktBurstMode	BIT(2)
+#define EN_CFG_NXTBTTCFPSTR	BIT(0)
+#define EN_CFG_BARKER_PREAM	BIT(1)
+#define EN_CFG_PKT_BURST_MD	BIT(2)
 
 /* Bits in the CFG register */
 #define CFG_TKIPOPT		BIT(7)
@@ -333,7 +333,7 @@
 #define PKT_TYPE_ERROR_CRC	BIT(1)
 #define PKT_TYPE_BSSID		BIT(0)
 
-#define Default_BI              0x200
+#define DEFAULT_BI		0x200
 
 /* MiscFIFO Offset */
 #define MISCFIFO_KEYETRY0	32
-- 
2.25.1

