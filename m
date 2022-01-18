Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4514349137E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbiARBiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243993AbiARBiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C7AC06161C;
        Mon, 17 Jan 2022 17:38:13 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id q25so72923522edb.2;
        Mon, 17 Jan 2022 17:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T1aRqKg5tbRVk7Rr0Ygh/atd2LFDmFDftsLr9R4FVoI=;
        b=hwzFSgEjbkiG9V8Q5NQeqIIYNcCBHx75NrWdIOugJWHTs22pxVQ5IYg9nXMdez8huZ
         v03GhnxNRhYwBMYyQfYTsnN+Wmd+KORbgWed3addo5qP824NtLDkiVJ1qRs0Lzi1G8cn
         Pwu+kmrsj+tPJP/7oF9YrmwV7hY/Jm+YhpDnWfEvoHCeF6I/SJ1dQvQgYPO16Z9gvaCE
         mlHmtrVjtddR0hZGY2V3Fl51wjiBVPNwHhUyEBF8lL1H4ZIxMZUPKJUh8Y4whJyD1SNS
         xDZxVG4o0qg9nCucvFM+i9utiLS37/wpHk0WlExv1C+VwMszFYSW9Mp6lx/taz5ZdD83
         XKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T1aRqKg5tbRVk7Rr0Ygh/atd2LFDmFDftsLr9R4FVoI=;
        b=FPOdUrXahlJk6cMUPLEh9S/ivq8qib9CsDkehHRYdG3NKNmixV+/bYOCTfp8TETr3q
         s32nvuMy0je2QNgutRrGnSkpGM6s+F2ERlmzcBsBbQkAnI2EmTNeMYme6jYzlTPxOKc6
         uh06Mi1cSwLGHdi4vPY2XPz02CMdwS1XVaZDrzFUm/Ah1ncXWChAZyIyJ14OtrPbUlwJ
         a2ZYB379xfoNRfVYz8Mn5RYbzgwhvOXg3gZAwcSWUug7lyhAOYQ2p4f2ed6K0Xh1k9zt
         /SuKlZF8tEkYXM2kMKa23fDQyM6JrK8HksYJ4tM6Ym+tFSmylL5NOJJqNwK67nUivrsx
         O4Mg==
X-Gm-Message-State: AOAM5300O78jufGJcMU7aFJUWAd7NJT/VDfgdlO37q4nnjPaEo2JdPps
        zSNSaditce88w1Nz3hCUV/RZvQgiYJ0=
X-Google-Smtp-Source: ABdhPJxPjdYSrtrdPbF6kwliSqu3kvuIqeEMvgqG+Ld2xRzznyfme2GmrGby1MQfYgjT54aT0ma1mA==
X-Received: by 2002:a50:cd17:: with SMTP id z23mr23590587edi.287.1642469891562;
        Mon, 17 Jan 2022 17:38:11 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:11 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 02/17] ARM: dts: qcom: add gsbi6 missing definition for ipq8064
Date:   Tue, 18 Jan 2022 02:20:32 +0100
Message-Id: <20220118012051.21691-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gsbi6 missing definition for ipq8064.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cc6ca9013ab1..094125605bea 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -665,6 +665,33 @@ spi@1a280000 {
 			};
 		};
 
+		gsbi6: gsbi@16500000 {
+			status = "disabled";
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <6>;
+			reg = <0x16500000 0x100>;
+			clocks = <&gcc GSBI6_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			syscon-tcsr = <&tcsr>;
+
+			gsbi6_i2c: i2c@16580000 {
+				compatible = "qcom,i2c-qup-v1.1.1";
+				reg = <0x16580000 0x1000>;
+				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		gsbi7: gsbi@16600000 {
 			status = "disabled";
 			compatible = "qcom,gsbi-v1.0.0";
-- 
2.33.1

