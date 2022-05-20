Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA952EC57
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349486AbiETMlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349336AbiETMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:40:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85382F0;
        Fri, 20 May 2022 05:40:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E96BB1F462B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653050444;
        bh=x06V/XCPzZpmYAgHXtWkmjUfcFKK5jjJPN9DpP31Kf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCgpRhpqMw/ZILDXfIXuNwSGMGuhlTYvHEygdNCG1eH2qI0jLyRRDUa7Aye9np1nV
         KwZKc2Ot/lDUwGKswK5NfQ65IwflRg2Bpm63k3hUQYZhm3EbZdi/UtGJLeB9h/fgtX
         Dddji/ANIrrp6oMbS6b3tI5dubjyWLHOVkZXpcdYDcrj6UrhCPyGbRe4LvEvCK981v
         l6rSpENJmrUGVTZBbhoFqm3HJ3FCC8mk1yvvV6kT25IXgFxnDerQM2RrA/q6LOlSJ+
         fQywzCUNb9VTAWVX5vDoLa9BvI3y7SFyLk4cwRIr86R8R3PeY2JF0UYJn4Q8DtZlYU
         tAenNqqD0cTzg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        zhiyong.tao@mediatek.com, henryc.chen@mediatek.com,
        johnson.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] soc: mediatek: pwrap: Add kerneldoc for struct pwrap_slv_type
Date:   Fri, 20 May 2022 14:40:34 +0200
Message-Id: <20220520124039.228314-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520124039.228314-1-angelogioacchino.delregno@collabora.com>
References: <20220520124039.228314-1-angelogioacchino.delregno@collabora.com>
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

In preparation for adding new members with name abbreviations describe
the struct pwrap_slv_type with kerneldoc to enhance human readability.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index d0c79ee4c56b..76b1f7bc8217 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1155,11 +1155,17 @@ struct pwrap_slv_regops {
 	int (*pwrap_write)(struct pmic_wrapper *wrp, u32 adr, u32 wdata);
 };
 
+/**
+ * struct pwrap_slv_type - PMIC device wrapper definitions
+ * @dew_regs:      Device Wrapper (DeW) register offsets
+ * @type:          PMIC Type (model)
+ * @regops:        Register R/W ops
+ * @caps:          Capability flags for the target device
+ */
 struct pwrap_slv_type {
 	const u32 *dew_regs;
 	enum pmic_type type;
 	const struct pwrap_slv_regops *regops;
-	/* Flags indicating the capability for the target slave */
 	u32 caps;
 };
 
-- 
2.35.1

