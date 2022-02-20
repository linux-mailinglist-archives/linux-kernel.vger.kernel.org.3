Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE74BD179
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244721AbiBTUa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:30:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiBTUay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:30:54 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E438C522D4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:30:32 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m17so25259314edc.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 12:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ElSqKc4cA4ptRtjuOUBsN95Rc6vUSk4leDCw/n+cQR8=;
        b=FcRiLkds7TS4z1hAlP1NFZaxrhQumregUC5nFy9a5g/mlr/4eB+FsrQ9fXBbZHUrSh
         ivZ5QBs65fPFGN+iQkLYAk5Rf5hlQzWjqWdqMnxrTcSc2VfWILm6RbcUqZoPcmCIH26t
         MhXrz8YlX1Y/eALUsDrie9HcU1wkCZZLiQL5GDWU7jFxVFZW/XlZUNuNK0k+UlWnHG2J
         /UniKJrTq14ENhTeNUxuE9LbDud4A69UXjK7PnHSMzBN/ji1yOL1gf1u2Bfchrx8iSsm
         t5Zm0VbnrXtFLMwOMUphR5ksoNcsAxG4wB9soVjA9YJv9Tj3aG2uad1tELrEcIn+ANJB
         L33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ElSqKc4cA4ptRtjuOUBsN95Rc6vUSk4leDCw/n+cQR8=;
        b=2g9N/AHJ5wzujfOnCkOIqJzfNhcpTZwoKmTc1SrunvWu4yFcM+hdS05UAMwRzlnYuH
         SAJs0CZUtjGON7aui4cMDwts5RzB8/5UhVw/+yKKQsKxRup30gz65kYcpTIGj87Obewo
         heygJbq7+Vkt6lJjWWAcYbBgMJHdtfiQWCZHfrpGBulHEAWS0oXdLUUxFsgYRcIf20aw
         NhD34C4sX3mLhuVhJgFZncgkelE7mPthv4w90vXQMnjWwF85kK8uZ7Kciz699+KlBvMd
         jF/s6ThVSFchnRE5JCLJs767Bh3seG7wBYa6p6K79QGc88fqlpztZD0WfjmZSS+0blgE
         Ce4Q==
X-Gm-Message-State: AOAM530Qgcpa8xZ8KCUK5YYP7swluwtOKvgAv/KkKYq1GSDO23Hf/OVP
        81KoXKUOVnXxgalVQFvdbv0=
X-Google-Smtp-Source: ABdhPJzJNCyTmTZ4lJrH1ReCXIi2yG0+Pz7XO3TAI4DqwWkh+ufNdxeEO+t13WVBVwqodJVVPUR+FA==
X-Received: by 2002:aa7:c789:0:b0:410:dd40:d458 with SMTP id n9-20020aa7c789000000b00410dd40d458mr19087589eds.3.1645389031467;
        Sun, 20 Feb 2022 12:30:31 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id p25sm4443953ejn.33.2022.02.20.12.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 12:30:31 -0800 (PST)
Date:   Sun, 20 Feb 2022 21:30:29 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: vt6656: Fix CamelCase warnings in mac.h and
 mac.c
Message-ID: <505ae2999ea93318e3745c69d8e36e2c108d9fd0.1645386791.git.philipp.g.hortmann@gmail.com>
References: <cover.1645386791.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645386791.git.philipp.g.hortmann@gmail.com>
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
index 05af9ca7d69c..4ceecee3e82a 100644
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
+#define EN_CFG_PKT_BURST_MO	BIT(2)
 
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

