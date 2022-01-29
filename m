Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3B4A324F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 23:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346477AbiA2WO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 17:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243417AbiA2WO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 17:14:56 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C50C061714;
        Sat, 29 Jan 2022 14:14:56 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id j2so29020268ejk.6;
        Sat, 29 Jan 2022 14:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=DXPthL+w0sdicyR+iIc/KNdalpGrrMEJ6fWoyKs18sc=;
        b=S6lJTj3fb50uw/51dj+LRu9dMlOpmRhbp2bDakv2Vx4bXoOY7efD33zovna3DbLe2I
         odXvFY90OhKQhCc5Wv+X0cmMmT0ECb7YAWkxDFLA/fPH8Lje9XBmKa+s6iA0ePi88OK7
         DayuqboH5O2oHpa3hf7vP33hWPA4UU+yb1ox7yWapKLRSKYF7Yy4r/1pL3lRrn5iIT0l
         51v/g8CfuBVqWVjIf0grKKRGo3F7M43KX3vBZ3mlW22oee4/BjUk9R5w9CNsP1TOYyUm
         qVqAT2L5eMTqMQQZxcF+0UbLeU4QdW/W7tuT8DOZ9sq1u56SOmXrrj2RfTAaHgdtrmHf
         x3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=DXPthL+w0sdicyR+iIc/KNdalpGrrMEJ6fWoyKs18sc=;
        b=24V8EufzpGMPixYSifmWz/8cbchBs8IGsmv1/CmuNUnWHgG7vokbFulVDusuCu5xZO
         D7mekFHWL2KA2vEjxZloQINP5hZUDp7x//F5c1zsb4U3WZRvlpi64dDcMSoaZECISh5j
         FkN7TWYkfsmaXQos5V6PZBAvtqswsZkvkpJGpBGAOVTO1hTAdMZI7ivzlqb5+FVKfQ6I
         dJLLqsjQygceQKavS2crp5SyhY+o55HLMF4+lLRo/k+7HB1XJa0hpjGzPIF0eINmsBpA
         IUcIKpP70ILPZYQzm2ciNvSv/1t5PbK9FiWhfMw9DLUKCPF8rG+tfkdfCvATlVgk/ds+
         lQxA==
X-Gm-Message-State: AOAM5333JqJxsUW3HrJpvvE9uDMHhyYgCUgAjec5Zt/ScVZHS4ycKDOZ
        o1ipySsjCwF2jyGLlUD+CAzEGIRplD1qkA==
X-Google-Smtp-Source: ABdhPJwFMzyc1rBAyO75lWJSNKxvOk61CJhL2rtuRKsbQmGDNdUxd+t40kGylnizKqk6p6evNBX1kQ==
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr2687608ejc.356.1643494495014;
        Sat, 29 Jan 2022 14:14:55 -0800 (PST)
Received: from adroid (027-177-184-091.ip-addr.vsenet.de. [91.184.177.27])
        by smtp.gmail.com with ESMTPSA id gj10sm7158005ejb.192.2022.01.29.14.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 14:14:54 -0800 (PST)
Date:   Sat, 29 Jan 2022 23:14:52 +0100
From:   Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>
Subject: [PATCH] ARM: dts: add 533 MHz step to p4note GPU opp table
Message-ID: <20220129221452.GA36524@adroid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The p4note devices support 533 MHz GPU speed, so let's make use of it.

Signed-off-by: Martin Jücker <martin.juecker@gmail.com>
---
 arch/arm/boot/dts/exynos4412-p4note.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index 4ae6eb3091c4..d277b2337ae0 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -355,6 +355,13 @@ &gpu {
 	status = "okay";
 };
 
+&gpu_opp_table {
+	opp-533000000 {
+		opp-hz = /bits/ 64 <533000000>;
+		opp-microvolt = <1075000>;
+	};
+};
+
 &hsotg {
 	vusb_a-supply = <&ldo12_reg>;
 	dr_mode = "peripheral";
-- 
2.25.1

