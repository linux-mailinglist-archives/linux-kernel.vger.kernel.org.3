Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6226D4DAE5E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 11:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355180AbiCPKmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiCPKmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:42:23 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47C351307;
        Wed, 16 Mar 2022 03:41:07 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6C5F122175;
        Wed, 16 Mar 2022 11:41:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647427265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DPPJIrs/ip4AnRk5llyCXrUGkeu8OP+mPOKHFm3forQ=;
        b=YusVqu5efshConZd0AqaGilfW/vz+PG0ba+KH62L3+AQV8o2r5V521zyqUWvpt1DvQDQmr
        1tbMYOdMW229O9pY7jMdUfav2nj1y6egtE+Tq+O9ICT0w1W4DsW/lGX7J76giKn1DpLJ8V
        WFMGR+dtgkVZocuuGsEL+QTDQDonTwY=
From:   Michael Walle <michael@walle.cc>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        linux-kernel@vger.kernel.org, heiko.thiery@gmail.com,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2] dt-bindings: arm: fsl: add IMX8MN DDR3L eval board
Date:   Wed, 16 Mar 2022 11:41:00 +0100
Message-Id: <20220316104100.783068-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
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
---
changes since v1:
 - order entries alphabetically

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 08bdd30e511c..37da3a267c94 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -834,6 +834,7 @@ properties:
               - beacon,imx8mn-beacon-kit  # i.MX8MN Beacon Development Kit
               - bsh,imx8mn-bsh-smm-s2     # i.MX8MN BSH SystemMaster S2
               - bsh,imx8mn-bsh-smm-s2pro  # i.MX8MN BSH SystemMaster S2 PRO
+              - fsl,imx8mn-ddr3l-evk      # i.MX8MN DDR3L EVK Board
               - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
               - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
               - gw,imx8mn-gw7902          # i.MX8MM Gateworks Board
-- 
2.30.2

