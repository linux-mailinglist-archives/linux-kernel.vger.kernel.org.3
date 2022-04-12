Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8E44FD442
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389611AbiDLJX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377781AbiDLHxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:53:49 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E1A5006D;
        Tue, 12 Apr 2022 00:31:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23C7VJQZ049715;
        Tue, 12 Apr 2022 02:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649748679;
        bh=mLT0K9e6BMmKkRt/WWpSLI31BeDlL6touk1+htRp8O0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=K4wQyvAQ8T68dwqIUvGt7/511VO3Ew8yg3G1Afoef0/cmJr15WtwxDTrOcg2FLpQr
         kI8tE4Dl7ZIxvlTaH9pkGHAUghX5V5Q1lwhh7cAfuErCZqYGElv5TrVsduw7R+RJFh
         07QaSw9NyZ+/O6spQoMbUnNR4cV5fF5o5PqFW+uo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23C7VJio031075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Apr 2022 02:31:19 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Apr 2022 02:30:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 12 Apr 2022 02:30:19 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23C7UIDO026771;
        Tue, 12 Apr 2022 02:30:19 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <linux-crypto@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <krzysztof.kozlowski+dt@linaro.org>, <j-choudhary@ti.com>,
        <robh+dt@kernel.org>
Subject: [PATCH 1/2] dt-bindings: crypto: ti,sa2ul: Add a new compatible for AM62
Date:   Tue, 12 Apr 2022 13:00:15 +0530
Message-ID: <20220412073016.6014-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220412073016.6014-1-j-choudhary@ti.com>
References: <20220412073016.6014-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the AM62 version of sa3ul to the compatible list.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
index a410d2cedde6..02f47c2e7998 100644
--- a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
+++ b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
@@ -15,6 +15,7 @@ properties:
       - ti,j721e-sa2ul
       - ti,am654-sa2ul
       - ti,am64-sa2ul
+      - ti,am62-sa3ul
 
   reg:
     maxItems: 1
-- 
2.17.1

