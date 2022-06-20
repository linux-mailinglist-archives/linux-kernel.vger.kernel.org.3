Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0A05518FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242086AbiFTMct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242398AbiFTMcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:32:42 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD4F13F05;
        Mon, 20 Jun 2022 05:32:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25KCWMbv004303;
        Mon, 20 Jun 2022 07:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655728342;
        bh=O3wOPFel2p9ibgr0WvLvqkGUcUI5oKjGaC6/OAwe0B8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oHV6UTIZ9kBc2MH2qU6IZ5zbL/NiI2php58FZ/UghAZdFMxA01PkEsLMb5LmIcRo7
         Y3Qg/qgW4/5cwCvBPMajnVzO6kyTBCR3kNa0ji9y2Ur2p0eW2iZNAooMJqHeH1DCQa
         9Z/FLDh+VUcEgPXKAiSeCtr2hd0a2ppw0M0l66sA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25KCWMsu102989
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jun 2022 07:32:22 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Jun 2022 07:32:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Jun 2022 07:32:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25KCWLv6018203;
        Mon, 20 Jun 2022 07:32:22 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        DRI Devel List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 1/2] dt-bindings: display: ti,am65x-dss: Add am625 dss compatible
Date:   Mon, 20 Jun 2022 18:02:16 +0530
Message-ID: <20220620123217.25809-2-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620123217.25809-1-a-bhatia1@ti.com>
References: <20220620123217.25809-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add ti,am625-dss compatible string.
The DSS IP on TI's AM625 SoC is an update from the DSS on TI's AM65X
SoC. The former has an additional OLDI TX to enable a 2K resolution on
OLDI displays or enable 2 duplicated displayw with a smaller resolution.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 .../devicetree/bindings/display/ti/ti,am65x-dss.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 5c7d2cbc4aac..0fc77674eb50 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -19,7 +19,9 @@ description: |
 
 properties:
   compatible:
-    const: ti,am65x-dss
+    enum:
+      - ti,am65x-dss
+      - ti,am625-dss
 
   reg:
     description:
-- 
2.36.1

