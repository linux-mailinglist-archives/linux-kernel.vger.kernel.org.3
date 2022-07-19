Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C225794F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiGSIJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiGSIJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:09:13 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7F3357D2;
        Tue, 19 Jul 2022 01:09:11 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26J88nMf051584;
        Tue, 19 Jul 2022 03:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1658218129;
        bh=LOvLTtdoguKuBhYsL4AKtA8lq3cPn9YzUP+bjBI0Ilw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DEgyD4f7qvBrFdBr0TZERYcfcuEmC64KR3YUBXq9zruRBW7uPfUjm6x7NRljEUqzc
         4Xfxad864tMjS00FzZOGkRnzpDlNbzijA/0wcxxQHy1T23hsCuEWOL6HA608yMDEYk
         95ewDxgEokl/z2sfNAYNJ/lcsdLZ5UhguqvBDTIM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26J88nGs091734
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jul 2022 03:08:49 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Jul 2022 03:08:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Jul 2022 03:08:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26J88m6O121325;
        Tue, 19 Jul 2022 03:08:49 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Darren Etheridge <detheridge@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/8] dt-bindings: display: ti,am65x-dss: Add IO CTRL property for AM625 OLDI
Date:   Tue, 19 Jul 2022 13:38:39 +0530
Message-ID: <20220719080845.22122-3-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220719080845.22122-1-a-bhatia1@ti.com>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add am625-io-ctrl dt property to provide access to the control MMR
registers for the OLDI TXes.

These registers are used to control the power input to the OLDI TXes as
well as to configure them in the Loopback test mode.

The MMR IO controller device has been updated since the AM65x SoC and
hence a newer property is needed to describe the one in AM625 SoC.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 .../bindings/display/ti/ti,am65x-dss.yaml     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 11d9b3821409..672765ad1f30 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -118,12 +118,33 @@ properties:
       and OLDI_CLK_IO_CTRL registers. This property is needed for OLDI
       interface to work.
 
+  ti,am625-oldi-io-ctrl:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description:
+      phandle to syscon device node mapping OLDI IO_CTRL registers, for
+      AM625 SoC. The mapped range should point to OLDI0_DAT0_IO_CTRL,
+      and map the registers up till OLDI_LB_CTRL. This property allows
+      the driver to control the power delivery to the OLDI TXes and
+      their loopback control as well.
+
   max-memory-bandwidth:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Input memory (from main memory to dispc) bandwidth limit in
       bytes per second
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: ti,am65x-dss
+then:
+  properties:
+    ti,am625-oldi-io-ctrl: false
+else:
+  properties:
+    ti,am65x-oldi-io-ctrl: false
+
 required:
   - compatible
   - reg
-- 
2.37.0

