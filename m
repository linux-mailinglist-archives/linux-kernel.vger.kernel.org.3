Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDF34913A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244236AbiARBin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244240AbiARBiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:21 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91385C061401;
        Mon, 17 Jan 2022 17:38:17 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id u21so72856402edd.5;
        Mon, 17 Jan 2022 17:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BpXmrFxudKL8W5Cx8Bnpt3RVBWNWT+SMneB6ixtmjQ8=;
        b=kMiFovidL6x+zPwpOCTDgip97caB/sMs+MHMJULMq/SqRl6/Bl+fgJA9PA0eIil6M8
         wBjHI8lKaAqJi1qurVakMtvf+Nb0vJjM5YObyejkkTweqV1LU0UjM2xWhXoQ0OeLKgX9
         USf0VGmkDVjiAsf24EMRlCRN0PmWg2KJ5FXuN6wdylGqn3qUAttwYZmAmRP5Uej2P0yY
         u/Rl7LJsKsQJ6OSh11AZuC1VvYvH5SPx6EEaG5AmnHr+EZaeRVDtSZGW/cIOlthUVVxC
         1xiJmtSXXWs/+qMR/m0svqQzFmsTu99zHQFFYAI9mokRLtRJp0N4itXg9uv4MmblcJ16
         SiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BpXmrFxudKL8W5Cx8Bnpt3RVBWNWT+SMneB6ixtmjQ8=;
        b=pLH6N1+P14AHyzgwhxwwZpWgey1j6diHtvNDYVshC/EGlou0UZxb6kyOc4eViPG/33
         dv73Tr47njYNY5vGLIn9OlYjkdZ0OdS32b5O7mK9nNBb6Kb3frMVvahN9/ErD+YnEPpK
         rlS87X5ofTxwFkeGsxacV7qH+nKBfb0zL+hiXJms3Cuh65QQnVgRIwNyyAy/HX0HHWfe
         ChWBNojZ7sUkF7LCWp+uBe8iUIC2Dl48zMynhGkQS8Vw+UXK+oonYLYA29lRG1IYZWoI
         h2c27Y8U0+z1kA9qK2o/2vCwoARn5rH07mrG3ja5cRhmSd9DWrTt43mmiBr71iGWvk0b
         8f2Q==
X-Gm-Message-State: AOAM530gxR1kxj6PdlHx12oE914uskjY9sVFrsfHqaL5OjK+5N5+bV3G
        ab/HsS7kDdTy/TwajNaEseM=
X-Google-Smtp-Source: ABdhPJzlXNDZGdq+9pEp2Zij6Rkx+zEYi+scRShQ682wDCzMFIdhnoUfODtsc9hPK2MnxGu9EvKeSA==
X-Received: by 2002:aa7:c587:: with SMTP id g7mr19610382edq.109.1642469896094;
        Mon, 17 Jan 2022 17:38:16 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:15 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 07/17] ARM: dts: qcom: fix dtc warning for missing #address-cells for ipq8064
Date:   Tue, 18 Jan 2022 02:20:37 +0100
Message-Id: <20220118012051.21691-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtc warning for missing #address-cells for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index c8763997e0f7..856968a96498 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -352,6 +352,7 @@ qcom_pinmux: pinmux@800000 {
 			gpio-ranges = <&qcom_pinmux 0 0 69>;
 			#gpio-cells = <2>;
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 
@@ -473,6 +474,7 @@ mux {
 		intc: interrupt-controller@2000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			reg = <0x02000000 0x1000>,
 			      <0x02002000 0x1000>;
-- 
2.33.1

