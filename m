Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567624986B3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244566AbiAXR0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:26:53 -0500
Received: from fwd1.porkbun.com ([52.10.174.57]:36316 "EHLO fwd1.porkbun.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244541AbiAXR0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:26:50 -0500
Received: by fwd1.porkbun.com (Postfix, from userid 497)
        id 898CB41690; Mon, 24 Jan 2022 17:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1643044689;
        bh=gxvgpUI7CywQc3XL9HhVRlq8qejwxf/AG4pnQ/62QdA=;
        h=From:To:Cc:Subject:Date;
        b=Y0LKzux3Euveb6p+BeFD4kp4Qk/S09Le9YmB90sPioiIhTKx5cY0oUO3oTimdVuZd
         gXEK1M+wDXy7OVJMukDI4Selk0yF+YAT8mMagXxGYmT54TvD4U2HnN2GJaDXH3dzXC
         xUxfOhRCpcrYbcxqpk7nZ5M/LTEeVxvqJIjeVE/c=
X-Spam-Checker-Version: SpamAssassin 3.4.3 (2019-12-06) on
        ip-172-31-37-14.us-west-2.compute.internal
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU autolearn=unavailable
        autolearn_force=no version=3.4.3
Received: from rayyan-pc.broadband (unknown [90.242.138.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: rayyan@ansari.sh)
        by fwd1.porkbun.com (Postfix) with ESMTPSA id 90D0140A88;
        Mon, 24 Jan 2022 17:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1643044562;
        bh=gxvgpUI7CywQc3XL9HhVRlq8qejwxf/AG4pnQ/62QdA=;
        h=From:To:Cc:Subject:Date;
        b=BiSVUl/wwpkQgTnAVh4a0DMXUOb21tKHJOHXnL3S7PmogxWbXpP/3m3SpCajX2hnd
         oSfRFmzbHzn47yahXhSoWs9deqpYPjA4DpjcItvVTno/nEFG7U/EKlwCPmEbpCg/OD
         CLNoNMGKQC63WCgnaQG4tAc6QB+6waj5ligx0CPA=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: pinctrl: qcom,pmic-mpp: Document PM8226 compatible
Date:   Mon, 24 Jan 2022 17:15:36 +0000
Message-Id: <20220124171538.18088-1-rayyan@ansari.sh>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Device Tree binding for PM8226 MPPs.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
index 35c846f59979..df79274d0ec3 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
@@ -21,6 +21,7 @@ properties:
           - qcom,pm8019-mpp
           - qcom,pm8038-mpp
           - qcom,pm8058-mpp
+          - qcom,pm8226-mpp
           - qcom,pm8821-mpp
           - qcom,pm8841-mpp
           - qcom,pm8916-mpp
-- 
2.34.1

