Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E44E58CE6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbiHHTOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244277AbiHHTNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:13:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B642E17069;
        Mon,  8 Aug 2022 12:13:52 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 278JDbx1053366;
        Mon, 8 Aug 2022 14:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659986017;
        bh=SW/cdAkxl5/7ReQWjTpfkx//xzzgl4M6vEgKW44fcPo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ewm3F5dBzmpUQl9qSLmqBoM+B2W9bgtLrdCDc1XfoXbUjY0Cq/Fx1gpKkgbguS6it
         001slOcgqdn61DhC7qqTK/b1HnsBs+djfnkf5jmlifmRp3SRSKYkWEbpYYkC+MNWPn
         D7zASmMaDFqK3x5JLyfkTMyVXsOkLatRgwRYV1r0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 278JDbd6040388
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Aug 2022 14:13:37 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 8
 Aug 2022 14:13:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 8 Aug 2022 14:13:37 -0500
Received: from uda0500628.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 278JDaYO054740;
        Mon, 8 Aug 2022 14:13:36 -0500
From:   Daniel Parks <danielrparks@ti.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 1/6] dt-bindings: crypto: ti,sa2ul: add pka subdevice
Date:   Mon, 8 Aug 2022 14:12:50 -0500
Message-ID: <42d04e9ec43d10f978cee1dd974bbfdccf121d85.1659985696.git.danielrparks@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1659985696.git.danielrparks@ti.com>
References: <cover.1659985696.git.danielrparks@ti.com>
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

The PKA (aka eip29t2) is a subdevice of the SA2UL on k3.

Signed-off-by: Daniel Parks <danielrparks@ti.com>
---
 Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
index 02f47c2e7998..e4adb8192608 100644
--- a/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
+++ b/Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml
@@ -64,8 +64,14 @@ patternProperties:
     type: object
     description:
       Child RNG node for SA2UL
 
+patternProperties:
+  "^pka@[a-f0-9]+$":
+    type: object
+    description:
+      Child PKA node for SA2UL
+
 required:
   - compatible
   - reg
   - power-domains
-- 
2.17.1

