Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E360486894
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241891AbiAFRcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241964AbiAFRby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:31:54 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A8DC034004
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:31:53 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a5so2252232wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TbWlOa+hsmRbWWmesGbsstTW9dDTf4G9JG7ns6wKhLk=;
        b=CnyIcB/jT2CzxEgA8+7z04Q/WRIVwcZ7FSSASbZr+SAWAH27O8u99CH0TlLvRxk30a
         gvrN0iM1D8tp1XxQkLapSl30zJeDofCxaXF7Y13KShhfqli/AoXJAS3mZeTcMAXul/Zr
         LkjoEvShnzzVueWuBL5ARM2eOC1yzKAyiEKB80hcbsGL4Ahzm/iGCo161CW4kX3C/+LW
         XR0WacWaoAK7slEtVM27QhYK7XSvB5aLqFV5y9DsWkh0WtjJk7mlth1AmyS1nscO1/V9
         QnKvlnH+ELGWrvbhw5EKQzSMM5v8s53zNR7TJyUbfbMvdfCUbuxZB2iic0vwB9di/Onc
         uyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbWlOa+hsmRbWWmesGbsstTW9dDTf4G9JG7ns6wKhLk=;
        b=RCv1jqbW53sibNed2mQYEvdw5orpfusG8O+XdGjuU0WTF0TgTZ5brhCTAryxUhloV8
         a89ej/x5DiO6fGO4IIuFhKu756DYolddejAuOguEleHIPDF7Zidj3TKW+r45Tdu+mtuz
         VmRCB1yi+Zko0rfEHtnnw/2zd/2DeykrqSrhdDhESH+t9HVMOXfCInfG2Motcyremo7J
         RDuOoR7i00N091sgIYDoLMlijkfj0TKby/sRBQQQzJWEztACrzxAc+1cZz3CplM7XJiG
         kbBjM5QVy3rjwAafms6RRP6JqEiR3dCtcW3NQeteEd0Vlgdhs/wlwoo4Xzj362eF/4ai
         4gVw==
X-Gm-Message-State: AOAM5332yUQOUSjFgZMaU3g5qX3212g1//P4+jGj+7co8reAPcH034uU
        +Zgd67rR4NVCZTLC/HKWnZeTaA==
X-Google-Smtp-Source: ABdhPJzgRYpe8Pq6PgoaGLcgywxFdk/+bxopSnyz+zfHBQ2gLvT1aTDCwo4b+VSz+LHGmHGsg3uHeg==
X-Received: by 2002:a5d:5552:: with SMTP id g18mr52284534wrw.488.1641490311708;
        Thu, 06 Jan 2022 09:31:51 -0800 (PST)
Received: from localhost.localdomain ([81.178.195.252])
        by smtp.gmail.com with ESMTPSA id b16sm2575594wmq.41.2022.01.06.09.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:31:51 -0800 (PST)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/7] dt-bindings: iio: adc: document qcom-spmi-rradc
Date:   Thu,  6 Jan 2022 17:31:26 +0000
Message-Id: <20220106173131.3279580-3-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106173131.3279580-1-caleb.connolly@linaro.org>
References: <20220106173131.3279580-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding docs for the Qualcomm SPMI RRADC found in PMICs like
PMI8998 and PMI8994

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/adc/qcom,spmi-rradc.yaml     | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
new file mode 100644
index 000000000000..11d47c46a48d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-rradc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC Round Robin ADC
+
+maintainers:
+  - Caleb Connolly <caleb.connolly@linaro.org>
+
+description: |
+  The Qualcomm SPMI Round Robin ADC (RRADC) provides interface to clients to read the
+  voltage, current and temperature for supported peripherals such as the battery thermistor
+  die temperature, charger temperature, USB and DC input voltage / current and battery ID
+  resistor.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pmi8998-rradc
+      - qcom,pm660-rradc
+
+  reg:
+    description: rradc base address and length in the SPMI PMIC register map
+    maxItems: 1
+
+  qcom,batt-id-delay-ms:
+    description:
+      Sets the hardware settling time for the battery ID resistor.
+    enum: [0, 1, 4, 12, 20, 40, 60, 80]
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pmic_rradc: adc@4500 {
+          compatible = "qcom,pmi8998-rradc";
+          reg = <0x4500>;
+          #io-channel-cells  = <1>;
+      };
+    };
+...
-- 
2.34.1

