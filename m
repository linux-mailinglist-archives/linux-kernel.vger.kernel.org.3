Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A618751D100
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389321AbiEFGGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352700AbiEFGGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:06:25 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B302F443C7;
        Thu,  5 May 2022 23:02:42 -0700 (PDT)
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 74C7C83FE0;
        Fri,  6 May 2022 08:02:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1651816961;
        bh=Z6JLbnXAiYMSp2FdeFiH1qvkGhqXij7iZt8ohmD+Fdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sa4W3Sd0Qx+geFx86y7nd3S/aAmIt4kJqYpic3sPpGRuDFffzD8g14UwH8aGAmz3b
         k+SkfRj+/Vj6TArB1urT8EKHc8CgEFKaY+yRXtGGPobZzFeeQGvDkUwfxvvnmjAxN3
         Q98lnvvDSzvz3dOAc1s5hd3ZZOQV/VYwwgFLNxuif2TJtzrEaiQezA5albJHj/qxAu
         nGJw4rhIBQBQU1Q/POquqsoUOSE2STbyYZ36ksLtRIeghznOoXCSWghSrShV83cmKz
         olM1xO2XAIeGX0OnTp+af3B3BgReNcoOQXNeH8xYZe4wwHHC7/mOO/UyTF0ufljX3Z
         kWSV8eRwPvXhA==
Received: by janitor.denx.de (Postfix, from userid 108)
        id 2B168A0114; Fri,  6 May 2022 08:02:41 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from xpert.denx.de (xpert.denx.de [192.168.0.4])
        by janitor.denx.de (Postfix) with ESMTPS id F2B82A0165;
        Fri,  6 May 2022 08:02:21 +0200 (CEST)
Received: by xpert.denx.de (Postfix, from userid 535)
        id DEACA3E098D; Fri,  6 May 2022 08:02:21 +0200 (CEST)
From:   Philip Oberfichtner <pro@denx.de>
Cc:     Philip Oberfichtner <pro@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.winker@de.bosch.com
Subject: [PATCH v5 3/4] dt-bindings: arm: Add bosch acc board
Date:   Fri,  6 May 2022 07:59:47 +0200
Message-Id: <20220506055948.971924-3-pro@denx.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220506055948.971924-1-pro@denx.de>
References: <20220506055948.971924-1-pro@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding for the Bosch ACC board, based on i.MX6 Dual.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: matthias.winker@de.bosch.com

---

Changes in v5: none
Changes in v4: none
Changes in v3: none
Changes in v2: Acked-by Krzysztof
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 08bdd30e511c..9deb568761c1 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -192,6 +192,7 @@ properties:
         items:
           - enum:
               - auvidea,h100              # Auvidea H100
+              - bosch,imx6q-acc           # Bosch ACC i.MX6 Dual
               - boundary,imx6q-nitrogen6_max
               - boundary,imx6q-nitrogen6_som2
               - boundary,imx6q-nitrogen6x
-- 
2.34.1

