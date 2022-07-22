Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5713257E20D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiGVNHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbiGVNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:07:13 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4D01140;
        Fri, 22 Jul 2022 06:07:07 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M9svFk006924;
        Fri, 22 Jul 2022 15:06:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=cw2AD1st0JuNEu+P5TanJG8XAn7GOmY0IA1vt5jOvSc=;
 b=VUWjrAGK2D/FJgQjr81KKp7RIqvI+3GqWZ4x8XEvZPsxnme2Wop+iVg3JMKrvrF/kqDM
 3XAUP6cY0Rzmph++qU5dppvGelfOUd4ISoOqXsVcj6mLeqbCSIgNgRKZF+c39zGTnC09
 mhkMJXUJEdTRRws0qhHaEHD7sJffcuZRfxV0EYDmUTH3CGYIMJ+izRPUujWiqgDs1+Un
 s4odqOG5aO1exwDeINeGhsZoZmegFQDfRmWYnwyUhuhtAta9NxfzVLkFw8ti0C5qAH7G
 Rb67acMhGs0FKLOGEWMWSKb99+8zyh28XLlj1aHMW+Rns2R35jP+lMLCt8EGRIu0fwBg GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hbnp6jxv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 15:06:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 23FB810002A;
        Fri, 22 Jul 2022 15:06:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1EC46228A4F;
        Fri, 22 Jul 2022 15:06:41 +0200 (CEST)
Received: from localhost (10.75.127.51) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 22 Jul
 2022 15:06:38 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mka@chromium.org>,
        <alexandre.torgue@foss.st.com>
CC:     <arnd@arndb.de>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <amelie.delaunay@foss.st.com>
Subject: [PATCH 1/4] dt-bindings: usb: generic-ehci: allow usb-hcd schema properties
Date:   Fri, 22 Jul 2022 15:05:51 +0200
Message-ID: <20220722130554.236925-2-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722130554.236925-1-fabrice.gasnier@foss.st.com>
References: <20220722130554.236925-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_04,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow properties and usb-device child nodes as defined in usb-hcd.yaml, by
using unevaluatedProperties: false. By the way, remove the "companion"
property as it's redundant with usb-hcd.yaml.
As example, this allows an onboard hub, to be described in generic-ehci
controller node:
usb {
  compatible = "generic-ehci";
  #address-cells = <1>;
  #size-cells = <0>;
  /* onboard HUB */
  hub@1 {
    compatible = "usb424,2514";
    reg = <1>;
    vdd-supply = <&v3v3>;
  };
};

Without this, dtbs_check complains on '#address-cells', '#size-cells',
'hub@1' do not match any of the regexes: 'pinctrl-[0-9]+'
From schema: ..../generic-ehci.yaml

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 1e84e1b7ab271..e50c1cfaa1972 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -130,11 +130,6 @@ properties:
       Set this flag to indicate that the hardware sometimes turns on
       the OC bit when an over-current isn't actually present.
 
-  companion:
-    $ref: /schemas/types.yaml#/definitions/phandle
-    description:
-      Phandle of a companion.
-
   phys:
     minItems: 1
     maxItems: 3
@@ -155,7 +150,7 @@ required:
   - reg
   - interrupts
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.25.1

