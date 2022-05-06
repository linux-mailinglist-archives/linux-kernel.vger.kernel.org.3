Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A7051DF8B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390122AbiEFTRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390140AbiEFTRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:17:33 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFA56D384;
        Fri,  6 May 2022 12:13:47 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246H227T020954;
        Fri, 6 May 2022 19:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=x0dDiG7u66shf/a/UAhv70FxV6tCfEqxVBufWwmcfOI=;
 b=hQiG9bX+6si7qPAZ6CiEAiOlwmujECkMiIwYb6/Nv+EIF9vgSY9n0sFxEDdlsSkbMdCN
 tRKtCRedarBrChtOgz3/FgZZQsIXLSzf7KcoTC1Hq2Mdb9WzOxmCsKVaOLCy7j7+mVx1
 68lFoZ0cBlq9xkvRFwiV7PtEiWOKwobEEBbnS8owsO2cF1sydLERUmPHHYs8azCCs/VM
 7JHPZvynxnNb1p1M4bIxTR3+njirBCvnrLulgv6Yaudvp3Y8OjlIZhbuI35LjbJ9hpw5
 0MykWjCWFbmR0yAiTjOrcQMnmmvP9fl2IhkDVNHaAlj8Q1JKyFOzbuntDXy5r+/Je58R kg== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fvys9d1y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 19:13:33 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id ACCA79D;
        Fri,  6 May 2022 19:13:32 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 6D8F948;
        Fri,  6 May 2022 19:13:32 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v7 6/8] dt-bindings: arm: hpe: add GXP Support
Date:   Fri,  6 May 2022 14:13:37 -0500
Message-Id: <20220506191339.78617-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506191339.78617-1-nick.hawkins@hpe.com>
References: <20220506191339.78617-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: EUc9NW3q5V_WCahkHCwsifnksQfwX08b
X-Proofpoint-ORIG-GUID: EUc9NW3q5V_WCahkHCwsifnksQfwX08b
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_07,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060097
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add support for HPE GXP. The GXP is based on the cortex a9 processor and
supports arm7.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---
v7:
* Resubmission to keep the patch series self contained. No change.
* Copied Reviewed-by tags from previous patch.
v6:
* Changed subject to match others in log.
* Changed the commit description.
* Changed the title in the .yaml from HPE BMC GXP SoC Driver to HPE BMC
  GXP platforms.
* Added the oneOf attribute
* Fixed commit description to be close to 75 characters per line
v5:
* Fix version log
v4:
* Removed gxp.yaml
* Created hpe,gxp.yaml based on reviewer input
v3:
* Created gxp.yaml
v2:
* No change
---
 .../devicetree/bindings/arm/hpe,gxp.yaml      | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/hpe,gxp.yaml

diff --git a/Documentation/devicetree/bindings/arm/hpe,gxp.yaml b/Documentation/devicetree/bindings/arm/hpe,gxp.yaml
new file mode 100644
index 000000000000..224bbcb93f95
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/hpe,gxp.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/hpe,gxp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE BMC GXP platforms
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+  - Jean-Marie Verdun <verdun@hpe.com>
+
+properties:
+  compatible:
+    oneOf:
+      - description: GXP Based Boards
+        items:
+          - enum:
+              - hpe,gxp-dl360gen10
+          - const: hpe,gxp
+
+required:
+  - compatible
+
+additionalProperties: true
+
+...
-- 
2.17.1

