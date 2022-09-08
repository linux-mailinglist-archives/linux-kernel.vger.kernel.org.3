Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BA25B2334
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiIHQMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiIHQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:12:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2146BF5C51;
        Thu,  8 Sep 2022 09:12:13 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AD3D96601FB8;
        Thu,  8 Sep 2022 17:12:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662653531;
        bh=SRRZEDOrigFe40m70uP1YOWQu2qUoAwATpVN85CzcVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDPSnmG0UfBIcXfnojcglupeBBvqwhIGgyQTiJG2yrEFFrW+KHmjVRnzK7wZTpb5g
         a2YXS6j9sGIKnS2F2UD9gyMjE+p/F3iRQZT/ryRH69sqCBc8rR2fPUpKrd2i7Bi5s4
         gonOnjVhA5Vhh8ftRQKYBJBXbmER6nVvTOaGLbfvdgDqqA/uklVrALNOhPJT1fWM0d
         CEI4GETryx6577pHhAh9R5wFjEZwXrbmUROvKbQHltXREKkr2ojZvPkKdsBSfVSCQz
         H0dzIq4mrrE80P24DPIiftk/8PrIf0NXvuFyWkocbGL5CJDAIJXvKfOaMzbpXr+ZNc
         q08piEW35Io9Q==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 07/10] arm64: dts: mediatek: kukui: Remove i2s-share properties
Date:   Thu,  8 Sep 2022 12:11:51 -0400
Message-Id: <20220908161154.648557-8-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908161154.648557-1-nfraprado@collabora.com>
References: <20220908161154.648557-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2sN-share properties were never documented in the dt-binding and
thus shouldn't be used. Now that the ASoC machine drivers are setting
the I2S clock sharing internally, these properties are no longer needed,
so remove them.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index b4b86bb1f1a7..42191b3025a9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -221,11 +221,6 @@ tboard_thermistor2: thermal-sensor2 {
 	};
 };
 
-&afe {
-	i2s3-share = "I2S2";
-	i2s0-share = "I2S5";
-};
-
 &auxadc {
 	status = "okay";
 };
-- 
2.37.3

