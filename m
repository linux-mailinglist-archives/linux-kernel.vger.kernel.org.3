Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83492519C16
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347663AbiEDJqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbiEDJp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:45:59 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CAE26AC8;
        Wed,  4 May 2022 02:42:22 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2446C7E6018201;
        Wed, 4 May 2022 11:42:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=RSjmW4IjUGZ/bQ/two1rZ1aHlJIVLGx+97yQ1s1zd4A=;
 b=JkwE7esC89R64iqYz9q+1Wyv3tHA6csHuhH/W/gaRAX4Y4FkcHsPpLsJVGsDP/PlPKM/
 x9vw1JMYyrXVDV9S09ff5LYhUicrDOW6+K3cQBxgnbSDZpclUUCtS6E95K2nqCMsB8kd
 oNhtKpfAN/o5Pz+bvMomqiEq914ff0Xua2ygEjgPbfRo+1CyZG3pZ4at1lwo4bkwQriP
 BuDMchsW0nD6qgsqFBdJtBTjBQJ+Lv1NohNy40Mqirl3ETJko6qrt3ga/eYgSSQO3OaU
 GdZVkGDZQSk+PB7VCzWl7HFBGv759H0xXjPQF+KSRf3wmloGoyd1RP0xLJXbXUy5q15a rg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3frthjubws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 11:42:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 28C9610002A;
        Wed,  4 May 2022 11:41:58 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 114BE216EE0;
        Wed,  4 May 2022 11:41:58 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 4 May 2022 11:41:57
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH] dt-bindings: remoteproc: Fix phandle-array parameters description
Date:   Wed, 4 May 2022 11:41:43 +0200
Message-ID: <20220504094143.1272200-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.24.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_03,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the FIXME by appropriate description.

Fixes: 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas")
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 .../bindings/remoteproc/st,stm32-rproc.yaml      | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
index be3d9b0e876b..da50f0e99fe2 100644
--- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
@@ -43,8 +43,8 @@ properties:
     items:
       - items:
           - description: Phandle of syscon block
-          - description: FIXME
-          - description: FIXME
+          - description: The offset of the trust zone setting register
+          - description: The field mask of the trust zone state
 
   interrupts:
     description: Should contain the WWDG1 watchdog reset interrupt
@@ -101,8 +101,8 @@ properties:
     items:
       - items:
           - description: Phandle of syscon block
-          - description: FIXME
-          - description: FIXME
+          - description: The offset of the power setting register
+          - description: The field mask of the PDDS selection
 
   st,syscfg-m4-state:
     $ref: "/schemas/types.yaml#/definitions/phandle-array"
@@ -111,8 +111,8 @@ properties:
     items:
       - items:
           - description: Phandle of syscon block with the tamp register
-          - description: FIXME
-          - description: FIXME
+          - description: The offset of the tamp register
+          - description: The field mask of the Cortex-M4 state
 
   st,syscfg-rsc-tbl:
     $ref: "/schemas/types.yaml#/definitions/phandle-array"
@@ -122,8 +122,8 @@ properties:
     items:
       - items:
           - description: Phandle of syscon block with the tamp register
-          - description: FIXME
-          - description: FIXME
+          - description: The offset of the tamp register
+          - description: The field mask of the Cortex-M4 resource table address
 
   st,auto-boot:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.24.3

