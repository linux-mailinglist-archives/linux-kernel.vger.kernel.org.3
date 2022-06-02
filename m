Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED0953B6E6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiFBKTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiFBKTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:19:34 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB5B29750C;
        Thu,  2 Jun 2022 03:19:32 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 252AJT3V046212;
        Thu, 2 Jun 2022 05:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654165169;
        bh=Mgi01VdWoBHJG539zC3MX7L+PpWL13Bzb5RCK20NZWY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Yl6PNveEwjJZkkQ5CXA9yZWGTpSgQB3I7J21V9G95Ke/JNsbWrqMfFwk8tLxiSSOu
         RBFtNEWl5tfLSI5P727jKh9KyoH8ctOZdP+R5+4UKFY2OCd/dvUzC2KiWEZU9T0De+
         lseWc6cyUU/w4NJA8Bl9V4WuPY8yE4K+bfrTxj0E=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 252AJTtF022146
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Jun 2022 05:19:29 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Jun 2022 05:19:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Jun 2022 05:19:29 -0500
Received: from a0393678ub.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 252AJKGE063560;
        Thu, 2 Jun 2022 05:19:27 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Suman Anna <s-anna@ti.com>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: remoteproc: pru: Update bindings for K3 AM62x SoCs
Date:   Thu, 2 Jun 2022 15:49:19 +0530
Message-ID: <20220602101920.12504-3-kishon@ti.com>
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

Update the PRU remoteproc bindings for the PRU cores on AM62x SoCs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
index 5b67837b7fce..cd55d80137f7 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml
@@ -37,6 +37,7 @@ properties:
       - ti,am3356-pru   # for AM335x SoC family (AM3356+ SoCs only)
       - ti,am4376-pru   # for AM437x SoC family (AM4376+ SoCs only)
       - ti,am5728-pru   # for AM57xx SoC family
+      - ti,am625-pru    # for PRUs in K3 AM62x SoC family
       - ti,am642-pru    # for PRUs in K3 AM64x SoC family
       - ti,am642-rtu    # for RTUs in K3 AM64x SoC family
       - ti,am642-tx-pru # for Tx_PRUs in K3 AM64x SoC family
-- 
2.17.1

