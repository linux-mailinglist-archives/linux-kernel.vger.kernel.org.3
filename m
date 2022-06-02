Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410D053B6DD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiFBKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbiFBKTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:19:33 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3972E297505;
        Thu,  2 Jun 2022 03:19:30 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 252AJRpl027473;
        Thu, 2 Jun 2022 05:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654165167;
        bh=5/Ey9lJRp5c0QL652Lo2nM+Y7evHwsaKSV8m+oiKwAI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WlNZ+m0+3NeiMYeObvj1Onu6c/USaI/faLol9X7LpTYpo1frUSnKU40iztlv+3FCw
         LSkGKBCX8+C5bXvD6csLitXw7z44Bi5d1QP6Cy+v+O33DGq/GLur+r/fjT2U4QJ4cJ
         UcvfuGSgoyWHI097FPy81UDQcyBc+wOKsr7TAcGU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 252AJRmP088414
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Jun 2022 05:19:27 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Jun 2022 05:19:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Jun 2022 05:19:26 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 252AJKGD063560;
        Thu, 2 Jun 2022 05:19:24 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Suman Anna <s-anna@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: remoteproc: pru: Re-arrange "compatible" in alphabetic order
Date:   Thu, 2 Jun 2022 15:49:18 +0530
Message-ID: <20220602101920.12504-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220602101920.12504-1-kishon@ti.com>
References: <20220602101920.12504-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-arrange "compatible" string in alphabetic order to decrease the
chance of conflicts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../devicetree/bindings/remoteproc/ti,pru-rproc.yaml          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
index d7c3a78e37e6..5b67837b7fce 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
@@ -36,17 +36,17 @@ properties:
     enum:
       - ti,am3356-pru   # for AM335x SoC family (AM3356+ SoCs only)
       - ti,am4376-pru   # for AM437x SoC family (AM4376+ SoCs only)
+      - ti,am5728-pru   # for AM57xx SoC family
       - ti,am642-pru    # for PRUs in K3 AM64x SoC family
       - ti,am642-rtu    # for RTUs in K3 AM64x SoC family
       - ti,am642-tx-pru # for Tx_PRUs in K3 AM64x SoC family
-      - ti,am5728-pru   # for AM57xx SoC family
-      - ti,k2g-pru      # for 66AK2G SoC family
       - ti,am654-pru    # for PRUs in K3 AM65x SoC family
       - ti,am654-rtu    # for RTUs in K3 AM65x SoC family
       - ti,am654-tx-pru # for Tx_PRUs in K3 AM65x SR2.0 SoCs
       - ti,j721e-pru    # for PRUs in K3 J721E SoC family
       - ti,j721e-rtu    # for RTUs in K3 J721E SoC family
       - ti,j721e-tx-pru # for Tx_PRUs in K3 J721E SoC family
+      - ti,k2g-pru      # for 66AK2G SoC family
 
   reg:
     items:
-- 
2.17.1

