Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6FF57C43F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiGUGMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiGUGMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:12:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D707AB01;
        Wed, 20 Jul 2022 23:12:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q5so866713plr.11;
        Wed, 20 Jul 2022 23:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drWqUOesH6j18Q/j83y/2/spkHUtKTZKcE3ccf/wsyY=;
        b=OF6zWbm4Yk1jFhUIpiM6u6FMgIcfvoAsgZ6ovnfazRt4IDeG8O2MAFq16hcKC3Ij/r
         vBsXypbpnuPnpk/Bun9fpoit5cCJGo7iYox5P/V/+ElkOxw7Ep8z51AlhYdtZOhnCb7A
         G9xhkfE1I2wzot1K/fL+DPGtW0uj1os0NJlhS3dOgdUB79sxXtD5wPx31ekref58p5Uo
         V8YonP49bKQ4s67ByTR7RliAhSXCwqZ2ND8S5qreHBn8UBDIN7fWmZvedj1EUHNB/6TH
         ijZFzBUwmbeMQt6UdIGIt07L68vrn9bhQ3eU8wnqh/MouzAAV6Q7dWAexiVpeQVzuywD
         bL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drWqUOesH6j18Q/j83y/2/spkHUtKTZKcE3ccf/wsyY=;
        b=L+SxNJAdGprS8g0q3Cypd3G79ZWWqaT45tXVioiiaSA5i4qgM+kBvFunBja+2KQk9E
         OYggOCEnljC30RFLvP4vej6XocKEwdoUDP8Hci6HBA73NBwLT0l7F6NsNUuehWBwb/m2
         8++P4n32U6RdunTag95MOIu4JfiUss/Hev2SiqeRY5bBZf4PHCwCWDOpHWRsV5dgAwgE
         IUWXahIkw9FM5xlDDjtjo6yJay1Z8RJIslD32EDXdivE7KlAj/jgalhhWeTYZdqvFfUb
         hDFYM3lI/pvpULHJc55VN59Sx9LCx6WpFi3tIFM43DIaA5nARJ9yzoTfiUlKRj5fdKvE
         uKsA==
X-Gm-Message-State: AJIora+mahezO5BCaZtUrLDs2hgmtP2CGxPn26HfZTsOBSGeMKszVlQe
        XxBUJgF6O3W07v3PA1d5NaI=
X-Google-Smtp-Source: AGRyM1v6AWHC+c6EDZFxv0ZMJMj6Ku5xpBIgbe0Tf9/iw7e7ksxiE+Zyu07dZT/Nltm/wg9ZhFX6nQ==
X-Received: by 2002:a17:90b:1d8a:b0:1f0:419f:66b1 with SMTP id pf10-20020a17090b1d8a00b001f0419f66b1mr9805074pjb.119.1658383925293;
        Wed, 20 Jul 2022 23:12:05 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:46a:8b75:f825:a44d:6d0d:6d6e])
        by smtp.gmail.com with ESMTPSA id 13-20020a62170d000000b0052ba782f4cbsm744998pfx.7.2022.07.20.23.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:12:05 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v2 5/6] usb: typec: tcpci_rt1711h: Add compatible id with rt1715
Date:   Thu, 21 Jul 2022 14:11:43 +0800
Message-Id: <20220721061144.35139-6-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
References: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add compatible id with rt1715, and add initial setting for
specific support PD30 command.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index e65b568959e9..3316dfaeee0d 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -17,6 +17,7 @@
 
 #define RT1711H_VID		0x29CF
 #define RT1711H_PID		0x1711
+#define RT1715_DID		0x2173
 
 #define RT1711H_PHYCTRL1	0x80
 #define RT1711H_PHYCTRL2	0x81
@@ -28,6 +29,7 @@
 			    (((ck300) << 7) | ((ship_off) << 5) | \
 			    ((auto_idle) << 3) | ((tout) & 0x07))
 #define RT1711H_AUTOIDLEEN_MASK	BIT(3)
+#define RT1711H_ENEXTMSG_MASK	BIT(4)
 
 #define RT1711H_RTCTRL11	0x9E
 
@@ -46,6 +48,7 @@ struct rt1711h_chip {
 	struct device *dev;
 	struct regulator *vbus;
 	bool src_en;
+	u16 did;
 };
 
 static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
@@ -82,8 +85,9 @@ static struct rt1711h_chip *tdata_to_rt1711h(struct tcpci_data *tdata)
 
 static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 {
-	int ret;
 	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
+	struct regmap *regmap = chip->data.regmap;
+	int ret;
 
 	/* CK 300K from 320K, shipping off, auto_idle enable, tout = 32ms */
 	ret = rt1711h_write8(chip, RT1711H_RTCTRL8,
@@ -91,6 +95,14 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
 	if (ret < 0)
 		return ret;
 
+	/* Enable PD30 extended message for RT1715 */
+	if (chip->did == RT1715_DID) {
+		ret = regmap_update_bits(regmap, RT1711H_RTCTRL8,
+					 RT1711H_ENEXTMSG_MASK, 0xFF);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* I2C reset : (val + 1) * 12.5ms */
 	ret = rt1711h_write8(chip, RT1711H_RTCTRL11,
 			     RT1711H_RTCTRL11_SET(1, 0x0F));
@@ -246,7 +258,11 @@ static int rt1711h_check_revision(struct i2c_client *i2c)
 		dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
 		return -ENODEV;
 	}
-	return 0;
+	ret = i2c_smbus_read_word_data(i2c, TCPC_BCD_DEV);
+	if (ret < 0)
+		return ret;
+	dev_info(&i2c->dev, "did is 0x%04x\n", ret);
+	return ret;
 }
 
 static int rt1711h_probe(struct i2c_client *client,
@@ -265,6 +281,8 @@ static int rt1711h_probe(struct i2c_client *client,
 	if (!chip)
 		return -ENOMEM;
 
+	chip->did = ret;
+
 	chip->data.regmap = devm_regmap_init_i2c(client,
 						 &rt1711h_regmap_config);
 	if (IS_ERR(chip->data.regmap))
@@ -315,6 +333,7 @@ static int rt1711h_remove(struct i2c_client *client)
 
 static const struct i2c_device_id rt1711h_id[] = {
 	{ "rt1711h", 0 },
+	{ "rt1715", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt1711h_id);
@@ -322,6 +341,7 @@ MODULE_DEVICE_TABLE(i2c, rt1711h_id);
 #ifdef CONFIG_OF
 static const struct of_device_id rt1711h_of_match[] = {
 	{ .compatible = "richtek,rt1711h", },
+	{ .compatible = "richtek,rt1715", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rt1711h_of_match);
-- 
2.25.1

