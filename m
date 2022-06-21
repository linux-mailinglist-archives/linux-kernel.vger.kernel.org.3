Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF4B5535FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350994AbiFUPZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352822AbiFUPZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:25:00 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58432AE1A;
        Tue, 21 Jun 2022 08:24:57 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LDgiiZ018406;
        Tue, 21 Jun 2022 17:24:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=RsE/APcQQK1texPnT6NzF71SOQYNfmPJVFG9QWYVjZ0=;
 b=Uq1MZd9ZRFg/93798ERfOAyo8icRfma+0na5gh4sJkGiijX+DS31l7zYxY8ej04A70mc
 T3et5S6+EDMwYgdUzrbnf/cXZgN0iKytiykYI0bkEnMiJQx69FuAUYlU2T8OEhbg6SxF
 5WljxvyrKnlTdW1WHrN1fvp8YQPaule9Yw/fAgAFMi2cW+rcK3EexP6ftfMnt6scw/JJ
 slQB6uSFeF9XfDzH/263a8jiG3EPkPYw36+FODB6uDmlhLgqlukUXV8KxYcQozQGr+lz
 NA/7v3JlLobYNrgeywXoENCbj8zpLHWDsjC+7MX6e5Z4NXqpR3+/bgzdEM+8vgLKoPeN uQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3guau52emq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 17:24:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C82AA100038;
        Tue, 21 Jun 2022 17:24:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C34EB22ECD3;
        Tue, 21 Jun 2022 17:24:37 +0200 (CEST)
Received: from localhost (10.75.127.49) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Tue, 21 Jun
 2022 17:24:36 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>
CC:     <stern@rowland.harvard.edu>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 3/4] dt-bindings: usb: dwc2: document TPL support
Date:   Tue, 21 Jun 2022 17:23:49 +0200
Message-ID: <20220621152350.145745-4-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621152350.145745-1-fabrice.gasnier@foss.st.com>
References: <20220621152350.145745-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_08,2022-06-21_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target peripheral list (TPL) is used to identify targeted devices
during Embedded Host compliance testing. The user can add "tpl-support"
in the device tree to enable it.
Document TPL support as described in usb-hcd.yaml.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 8d22a9843ba58..1bfbc6ef16eb5 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -11,6 +11,7 @@ maintainers:
 
 allOf:
   - $ref: usb-drd.yaml#
+  - $ref: usb-hcd.yaml#
 
 properties:
   compatible:
@@ -161,6 +162,8 @@ properties:
       property is used.
     $ref: /schemas/graph.yaml#/properties/port
 
+  tpl-support: true
+
 dependencies:
   port: [ usb-role-switch ]
   role-switch-default-mode: [ usb-role-switch ]
-- 
2.25.1

