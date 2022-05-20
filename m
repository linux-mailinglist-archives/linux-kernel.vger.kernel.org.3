Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36A452ECAD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349601AbiETMv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349575AbiETMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:51:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB9337039;
        Fri, 20 May 2022 05:51:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F1D721F423B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653051102;
        bh=aGNhalei7MTlis1YULrl5Fs8KJfg4KuWW/LGY2qYzzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YzxX2VQ5Lmit5fkHF5MGtIeY6eXozJ2LH+ZiqMZsQvCbmZ7tNDR1f7sPEKwFp3RKc
         mckQrai2C+dyB3GdIj+hB41WEqMDYPvKNmutzoSyPWnvPZf3FIZ+gysI21tFw4p22f
         Z2XbTbJEOEpgwldgd7YgXAVy5/jkrb9Yj7+ZpBDDJVAW9huA+jaQ6VKqUldqNPWsqj
         eLsh2NUKMDYR9AcijhJUxq6ayfEQiX/SGed7RgSVRabQ72TYWcsnfRYaWvl/5AF5QS
         qg7LoKlXrtpVJ3DeGTEFY4V98ffQyJR1yr0RFCSrqXJ0DNN1Ko+yMq5GwyghW2SrzH
         L3MsoZ0lLstZQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        mkorpershoek@baylibre.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Input: mtk-pmic-keys - Add kerneldoc to driver structures
Date:   Fri, 20 May 2022 14:51:28 +0200
Message-Id: <20220520125132.229191-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
References: <20220520125132.229191-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enhance human readability, add kerneldoc to all driver structs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 30 +++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c31ab4368388..8e4fa7cd16e6 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -34,6 +34,13 @@
 #define MTK_PMIC_HOMEKEY_INDEX	1
 #define MTK_PMIC_MAX_KEY_COUNT	2
 
+/**
+ * struct mtk_pmic_keys_regs - PMIC keys per-key registers
+ * @deb_reg:             Debounced key status register
+ * @deb_mask:            Bitmask of this key in status register
+ * @intsel_reg:          Interrupt selector register
+ * @intsel_mask:         Bitmask of this key in interrupt selector
+ */
 struct mtk_pmic_keys_regs {
 	u32 deb_reg;
 	u32 deb_mask;
@@ -50,6 +57,11 @@ struct mtk_pmic_keys_regs {
 	.intsel_mask		= _intsel_mask,		\
 }
 
+/**
+ * struct mtk_pmic_regs - PMIC Keys registers
+ * @keys_regs:           Specific key registers
+ * @pmic_rst_reg:        PMIC Keys reset register
+ */
 struct mtk_pmic_regs {
 	const struct mtk_pmic_keys_regs keys_regs[MTK_PMIC_MAX_KEY_COUNT];
 	u32 pmic_rst_reg;
@@ -85,15 +97,31 @@ static const struct mtk_pmic_regs mt6358_regs = {
 	.pmic_rst_reg = MT6358_TOP_RST_MISC,
 };
 
+/**
+ * struct mtk_pmic_keys_info - PMIC Keys per-key params
+ * @keys:                Pointer to main driver structure
+ * @regs:                Register offsets/masks for this key
+ * @keycode:             Key code for this key
+ * @irq:                 Keypress or press/release interrupt
+ * @irq_r:               Key release interrupt (optional)
+ * @wakeup:              Indicates whether to use this key as a wakeup source
+ */
 struct mtk_pmic_keys_info {
 	struct mtk_pmic_keys *keys;
 	const struct mtk_pmic_keys_regs *regs;
 	unsigned int keycode;
 	int irq;
-	int irq_r; /* optional: release irq if different */
+	int irq_r;
 	bool wakeup:1;
 };
 
+/**
+ * struct mtk_pmic_keys - Main driver structure
+ * @input_dev:           Input device pointer
+ * @dev:                 Device pointer
+ * @regmap:              Regmap handle
+ * @keys:                Per-key parameters
+ */
 struct mtk_pmic_keys {
 	struct input_dev *input_dev;
 	struct device *dev;
-- 
2.35.1

