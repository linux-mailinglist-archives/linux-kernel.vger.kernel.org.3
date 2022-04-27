Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B6D51125B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358782AbiD0Hal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358759AbiD0Hae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:30:34 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947F145520;
        Wed, 27 Apr 2022 00:27:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R7RIiC069270;
        Wed, 27 Apr 2022 02:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651044438;
        bh=V/QMDiD5MVUNbVQiFtXwcSvGsBodAJkZUju75qUY1xU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bC1WpgNMLgqjM0SGVovBT5qT8SppzQYHhyKEVF4LzEaYZsFXR00TilfqA5M0sWHPk
         vuE5MBi/DSkv5fuuRBZTA0JGatpZSrJH0rmxlLXq4CnCAinTnuifxfFy+mBzOTWqs2
         F8Ty+oPNF+B0dtDcP/mzOY7i8tAlxi3hdQGaLoXY=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R7RI8n063797
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 02:27:18 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 02:27:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 02:27:18 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R7RBgQ088380;
        Wed, 27 Apr 2022 02:27:15 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/2] dt-bindings: soc: ti: pruss: Update bindings for K3 AM62x SoCs
Date:   Wed, 27 Apr 2022 12:57:02 +0530
Message-ID: <20220427072703.4898-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427072703.4898-1-kishon@ti.com>
References: <20220427072703.4898-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the PRUSS bindings for the PRUSSM instance present in
AM625 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index 64461d432004..cf13e5179657 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -69,6 +69,7 @@ properties:
       - ti,am654-icssg   # for K3 AM65x SoC family
       - ti,j721e-icssg   # for K3 J721E SoC family
       - ti,am642-icssg   # for K3 AM64x SoC family
+      - ti,am625-pruss   # for K3 AM62x SoC family
 
   reg:
     maxItems: 1
-- 
2.17.1

