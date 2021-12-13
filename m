Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF5947229E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhLMI1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhLMI1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:27:19 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F149AC06115E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:27:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x10so31988598edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMm67AIvcXY6qklTj1xMKUOirDsiafuBtic6EDXbrUI=;
        b=DTC7WGjdvAqdjanbrAxw5grBfcgQE37OeqT/pwC0Z2eG8+QPNAM6ZmOvObjH20NFlD
         w8RrRFpVCJ3SR8uLRF1DGeRAs2tyspzM5ovfUYKdAA7H4b87a/0jNW1UBQ3zSsoQbFK2
         7jqEbNJEEJ8j/Sjzwe8o+uPJv9H8ZrHsAcroGWKDen7Teyv/IQtz7ugWiMDq0ILvNu1J
         IU4v9K8t3VaiPyDjv32G/SXS6eJ87nH/ruw73oR3Y2Vv4HNfxITUpq0Cudue8S/rXFN6
         mCrvQY7YDDBs5i8xpfMvc92dQEr8qoSt4xLCNmRnZuYW6DhEhce1c4LKfU8EY1XTdpT9
         mFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMm67AIvcXY6qklTj1xMKUOirDsiafuBtic6EDXbrUI=;
        b=M2qOpDt4xxs9MNS/X9Hk4fn3renVTBMI0j+weQ3eXuTrrij4xuTdKpKmghllhi84j4
         9O8I1NQGPqKfw7u0SK0MX9CsXV5W1hBQ4NPOA+fS9lzECCK9w/IixOKSIOJDAi/HTu5p
         FyNPOahuusbHKx8CGz5nghWzLZjduQnhukudkGjqpTj97ew0FM2RZ9dR1iYkSTTqRXb2
         yw2Qy72bCyv5EA473ndruxEW6vMjs1F/QLpzuj1JbyBH+SzaPyucxggh+mkBvcdk2xk2
         dxTs6DJMUb7lYMZO7TPy80+YvGam1dR11hH2Iapk6DZEyy1CtnTh3qiv59jy3SJ2NbFk
         DSTg==
X-Gm-Message-State: AOAM531Oe2/luhLfdJ5OX8tSi0Ux1eOLpHsR3pN98hqzK6gz0PhEczug
        mukUVaGyAZwaPYZ14RnYnGS6RQ==
X-Google-Smtp-Source: ABdhPJxIY/9Ksv9VfDYjeCpOETIdPtwglBsGFiqhDKYDlmjLwPkjFgt7OAp+YsiBCBAG7DoZeqM9xQ==
X-Received: by 2002:a05:6402:b23:: with SMTP id bo3mr61598431edb.366.1639384034612;
        Mon, 13 Dec 2021 00:27:14 -0800 (PST)
Received: from localhost.localdomain ([2a02:a210:20c5:8c80:7d0a:cd68:c339:f426])
        by smtp.gmail.com with ESMTPSA id b11sm6062432ede.62.2021.12.13.00.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 00:27:14 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] dt-bindings: phy: qcom,qusb2: Add SM6350 compatible
Date:   Mon, 13 Dec 2021 09:26:05 +0100
Message-Id: <20211213082614.22651-5-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213082614.22651-1-luca.weiss@fairphone.com>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree compatible for the usb phy on SM6350 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
index aa2e409a1a09..e651a63a4be3 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
@@ -30,6 +30,7 @@ properties:
           - enum:
               - qcom,sc7180-qusb2-phy
               - qcom,sdm845-qusb2-phy
+              - qcom,sm6350-qusb2-phy
           - const: qcom,qusb2-v2-phy
   reg:
     maxItems: 1
-- 
2.34.1

