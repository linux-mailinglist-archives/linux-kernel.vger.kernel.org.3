Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A494EAC47
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiC2Lax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiC2Lav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:30:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1673214F93
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:29:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id yy13so34491011ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QJ3sC/t70LEUe1k/Ybtt0gQ1+jBw2FypHaPeEbZau8E=;
        b=Eb+onHVtFHOiDmyJa9YW2+6P+7LXOKuH+PhG40LXodKwZABkaP+3/IJ+8g4XRk0bi2
         wXJCQHuxFO0zLNHTUWcJMOGEH0iKHOQVANDSIG0tbPawQJ2P5ER+mXEoOahlnDsbZSLt
         /U9OH5q34ablJbBxehQT+VQjQu5+DGPFqBWWXyEABGiT3P0hrzYD9M7OnxANdm5gdPp8
         YjQP8mj5/Yd5FDqyeWEh9jceGfByu+Sr0gqmaxZiD/ARH7njRmOr6o3YlnczikEEwrIr
         7pgnCO1KDk++UKsigsJYvBW6Yx8LcV59aKxLROKle/IX6uUwrLHViU20GHj9IQGM3Yzl
         GrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QJ3sC/t70LEUe1k/Ybtt0gQ1+jBw2FypHaPeEbZau8E=;
        b=Q1BTjqF3OjzvgzosiRJWCbLrXD0dFP4tB1mNPXSAHIwaSS+trG3Zk1jrK7OEMH28WP
         RKmmk5jnz+LK1NfWuU7VOQL2mh5Tn8Hyg1lZJbNjMZhom5kDITYsElgFcw1WPMQ/rTzk
         RRxevHA8IFbw8cEBr863D2eAwX2SX/n+IQjRFatlEQdr4I39lEZq4PXm6rCFXga9J2Kf
         +JZqwb26hoO1f4VevCVnZs/TMArOhk7dD+7i7A6l5SvlLVoVE+vhoNz/YmaxTD7PLq3g
         H19H5n08Z+yvOjQK20ynpbrASaLUpjRJqJVINlPfIzZD202tFX9Bh+vzwHvp73rTC0oq
         R/0w==
X-Gm-Message-State: AOAM533SkD9HmAWTlZRuoTQFCnXTHI/g64cnSr+C+dQX0mu0mMDTR0zy
        Hf9XB4qwqoiYcMepWws/2V+q82Ka3K5BAt1G
X-Google-Smtp-Source: ABdhPJwGMtkyl3aQuRT+u4vQ03fmmEd5ZJOFmpBSzFl+cEmJeGOL6GCE4AXU7TXXNqfy/qkyjsshsA==
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id nd14-20020a170907628e00b006d9c6fa6168mr33827327ejc.132.1648553346957;
        Tue, 29 Mar 2022 04:29:06 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id t19-20020a056402525300b0041952a1a764sm8510909edd.33.2022.03.29.04.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:29:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] spi: dt-bindings: qcom: convert qcom,spi-qup to DT schema
Date:   Tue, 29 Mar 2022 13:28:58 +0200
Message-Id: <20220329112902.252937-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The DTS patches are independent and silence warnings pointed
out by schema.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  ARM: dts: qcom: ipq4019: align dmas in SPI with DT schema
  arm64: dts: qcom: msm8916: align dmas in SPI with DT schema
  arm64: dts: qcom: qcs404: align clocks in SPI with DT schema
  spi: dt-bindings: qcom,spi-qup: convert to dtschema

 .../devicetree/bindings/spi/qcom,spi-qup.txt  | 103 ------------------
 .../devicetree/bindings/spi/qcom,spi-qup.yaml |  82 ++++++++++++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi           |   8 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  24 ++--
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  36 +++---
 5 files changed, 116 insertions(+), 137 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml

-- 
2.32.0

