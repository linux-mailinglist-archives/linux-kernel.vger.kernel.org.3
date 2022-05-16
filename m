Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5616528A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343717AbiEPQcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343721AbiEPQcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:32:43 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858FB3B547;
        Mon, 16 May 2022 09:32:38 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G9UaEM011421;
        Mon, 16 May 2022 16:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=5eQKPqTL8VvFLcV6LAqdC4Ocn8wipBmR9jjrFCjg04U=;
 b=gSikURcx2FcS7rhE7clIoLfCRfOfx8yGVNibgHVaxLvsxjfTE9vd+3u10p8H/5AKC3nK
 AaGWrcxN2HcqAQkGyDHbNjmRx2I6qgfnbepBKTHEj/ieVS3P4uobwkFl4IjT3dJGvSZG
 txqTowpviddb4vzP4dpiu/cHYP2NyhlMovmLgg4BR6uO1YWmkFEryTYCysWWsEF5XKaw
 LFN3+ty6jCY+mHNB4UQ5oFj4oXlZPPhOVqeErgE0+h/tRTmjEuXmWbtsIBejH4Z/XDvu
 5OnPLm9FqsQ8tt4Q/ItttEZGQKfJ489pHrC6Ez++j8X7+0VjaavEGAHtpXRhNFAwuGHu iw== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3g3gk4qtun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 16:32:29 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id A4B4855;
        Mon, 16 May 2022 16:32:28 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 64DE748;
        Mon, 16 May 2022 16:32:28 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v8 6/8] dt-bindings: arm: hpe: add GXP Support
Date:   Mon, 16 May 2022 11:33:44 -0500
Message-Id: <20220516163347.44890-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220516163347.44890-1-nick.hawkins@hpe.com>
References: <20220516163347.44890-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: s_2t-MOwXKgEHBL7IB76DOA3FAn5Nb8J
X-Proofpoint-GUID: s_2t-MOwXKgEHBL7IB76DOA3FAn5Nb8J
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_15,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160092
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v8:
* No change
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

