Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7E64FE3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356675AbiDLOiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356584AbiDLOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:38:07 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52BC5C642;
        Tue, 12 Apr 2022 07:35:49 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A482622248;
        Tue, 12 Apr 2022 16:35:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1649774146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQzkjs08QLIF3IQTGjnM6UZsJDyLmHDtfKMOkdE5VCA=;
        b=CQl/uZJsNLazORWSxqZhY+Aqi/dBxl/SDxT3quo9HDZDMBGtslUl9VdcmEsG7ufPrAmbrT
        SbGj2ZsPYHC3Zsjo2oLMVnV2BLahV6e+EoH73iqylhsTVNCPuH0xq595oo0/hSrst8UL+c
        KbOgB/4ODPLqIm4faQG9JJ9BqjT4Ui8=
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: fsl: add IMX8MN DDR3L eval board
Date:   Tue, 12 Apr 2022 16:32:37 +0200
Message-Id: <20220412143238.1925059-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220412143238.1925059-1-michael@walle.cc>
References: <20220412143238.1925059-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This eval board features an IMX8MN UltraLite and has DDR3L RAM. The
product part number is 8MNANOD3L-EVK.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Heiko Thiery <heiko.thiery@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
changes since v2:
 - none, just reposted together with patch to add actual device tree

changes since v1:
 - order entries alphabetically

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b6cc34115362..d65b7d52bdd6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -881,6 +881,7 @@ properties:
               - beacon,imx8mn-beacon-kit  # i.MX8MN Beacon Development Kit
               - bsh,imx8mn-bsh-smm-s2     # i.MX8MN BSH SystemMaster S2
               - bsh,imx8mn-bsh-smm-s2pro  # i.MX8MN BSH SystemMaster S2 PRO
+              - fsl,imx8mn-ddr3l-evk      # i.MX8MN DDR3L EVK Board
               - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
               - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
               - gw,imx8mn-gw7902          # i.MX8MM Gateworks Board
-- 
2.30.2

