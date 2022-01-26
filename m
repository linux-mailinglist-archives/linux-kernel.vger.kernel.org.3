Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E70249D5F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiAZXM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:12:26 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:42947 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiAZXMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:12:24 -0500
Received: by mail-oi1-f174.google.com with SMTP id v67so2552963oie.9;
        Wed, 26 Jan 2022 15:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xF+nnpVLRNl0gR0VbUu+6BC7RiRLwruKFeIoUDQYsOU=;
        b=nJfTyv5LULemvV5njAnHRwn9eyfNb7p7xY09/NWqd9GEyl/1fKrqeeJaWR/mxTvW8H
         X/P+r7jRDZIeWHlC0abJmSUSu8bag2e0fYdA+fJZxHA/mPh5pg3+bo+k/LW5p3uKjwJS
         QLTSTLmiBWIZWUqQk0PkkWC0zND6LcHChtXvWAXi5M4P9ICsuQ915GgvUijk3KRSAf/B
         Ki+R+MddioiO2jRUORnc2Sv+7FSO3NpH1gm04BkNHJl6c8IFDmq26WxIjIUFSJikRsA6
         Rf9ZXiMOZ0D1t8DZweUW1FrCkVa7htpplYUVEjYZdDd+RWbaowSd01yRC0g69F+RVMIr
         YPTQ==
X-Gm-Message-State: AOAM5309GIpjcAMGgFGPAEqucpybfdQbkMzJEQ8PYgzsceipViR1iLrV
        KxCUT/5bpYN+TSMTTKvWvxsQsLEjsg==
X-Google-Smtp-Source: ABdhPJxbe/wimPcU/8v9Gn/8YgC39rvcc6nIrYr1XE2rwWmJywk1g/XV2bGMWP6rvw6ZbXxW7HZi5A==
X-Received: by 2002:a05:6808:1b06:: with SMTP id bx6mr5525385oib.176.1643238743567;
        Wed, 26 Jan 2022 15:12:23 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id c13sm2887354otf.5.2022.01.26.15.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 15:12:22 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio/adc: qcom,spmi-iadc: Fix 'reg' property in example
Date:   Wed, 26 Jan 2022 17:12:17 -0600
Message-Id: <20220126231217.1633935-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QCom SPMI PMIC child nodes are defined to have a single address cell,
but the example has an erroneous size cell. Remove it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
index 27e3108661c0..2a94db688830 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
@@ -51,7 +51,7 @@ examples:
         #size-cells = <0>;
         pmic_iadc: adc@3600 {
             compatible = "qcom,spmi-iadc";
-            reg = <0x3600 0x100>;
+            reg = <0x3600>;
             interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
             qcom,external-resistor-micro-ohms = <10000>;
             #io-channel-cells  = <1>;
-- 
2.32.0

