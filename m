Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C93C53B8BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiFBMGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiFBMG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:06:29 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A82F243196;
        Thu,  2 Jun 2022 05:06:28 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 252C6OF9075023;
        Thu, 2 Jun 2022 07:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654171584;
        bh=f69nidx0rjtwKo5j6+YRsIqjQkHzP5dTRTLO7s/dj04=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MxsweVOO0uO1rtbH2ZzJh+9ts1U8RidLOuNMYWUp85zPnJ5XsT/dGGJH9kxH+5aRz
         VPCrto3trBPy2XblCpEfd4l9HTLdNfIJRNlAn6eQcxO6Bys1OqwcbgaoLJgZA5I1EZ
         aPmXTVaWeTjJUzY0VHg3LCWccbZcmR3kYvN6paKc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 252C6Oe4099066
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Jun 2022 07:06:24 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Jun 2022 07:06:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Jun 2022 07:06:23 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 252C6EEo054710;
        Thu, 2 Jun 2022 07:06:21 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 2/3] dt-bindings: soc: ti: pruss: Update bindings for K3 AM62x SoCs
Date:   Thu, 2 Jun 2022 17:36:12 +0530
Message-ID: <20220602120613.2175-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220602120613.2175-1-kishon@ti.com>
References: <20220602120613.2175-1-kishon@ti.com>
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

Update the PRUSS bindings for the PRUSSM instance present in
AM625 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index 20aec9b8fb5b..847873289f25 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -65,6 +65,7 @@ properties:
       - ti,am4376-pruss0 # for AM437x SoC family and PRUSS unit 0
       - ti,am4376-pruss1 # for AM437x SoC family and PRUSS unit 1
       - ti,am5728-pruss  # for AM57xx SoC family
+      - ti,am625-pruss   # for K3 AM62x SoC family
       - ti,am642-icssg   # for K3 AM64x SoC family
       - ti,am654-icssg   # for K3 AM65x SoC family
       - ti,j721e-icssg   # for K3 J721E SoC family
-- 
2.17.1

