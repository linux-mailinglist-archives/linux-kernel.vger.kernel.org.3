Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C790524D75
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348979AbiELMuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353985AbiELMtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:49:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA35424E022
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id z2so10046803ejj.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iyLgDkdQHyZAkcqdjwAb1osRIT28CWJKpvenchINumw=;
        b=JdLkQLmHfAHy9A7YLF7J2qNbjiUoDHrM7P4JAtchg/RdUvu9GL5EIUQdu5KuSVEOU+
         LeD745fz88MA7UGUhk8tJ7YbHGs0bg+j/+Y5yHQHU8ZFsbwhGS34EysnRxNUem6paDn9
         kri2xDtw8cl5IAOyftiRAmUt2QH1lpXGCX/7fAB2owB4onsAPGUjlKHqf6tW89sbLeVY
         m4MJ3exP/EjqWQTPGC90jN9NlRJsBlD45V/jFTwJlEJUNErWYZSlX+c2RbS5Au+ANz9l
         mnQ7uI70FmEQrwwlzmMwqUQvMsS6QGZElfb2YNuH8gnc0MVicgT74k0PFMIBj1Wx1RlP
         26ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iyLgDkdQHyZAkcqdjwAb1osRIT28CWJKpvenchINumw=;
        b=daZGFzSnqn+wAp2PNdF1JyRi8op3Z1LAdv1HedqZAuFyUjhffxK83furmESkrBXKlj
         ZQ91p63ZwRTVkhilKfyklcbRxtSXkAw654/wOU55ntXH7nBNj9Yvl+wbQ8Sxi0Vam0gm
         d2s/DaZgPQoPMhQaOYHyrQWPdw/uf3FNncMpM56gGBmFKzyb+QzAVLz77kmKYaAnRa2c
         mv3kWdtr+Qwt/hMDfNEg6tZJTiEUIGZXfVu9eqFEBqS5FM2rlNBnIeimQlmsNPr3tDCH
         pqWcipLj4a0dciW5zEbMYDc/BUjHXVQUqOc/XR+L/bByU6EO2P8uqisw98+ewg+gtxsf
         Ulrg==
X-Gm-Message-State: AOAM530jBbEoQhSsMvtmqPStuWeouYNpEMO9omK2znrf1DGzS0NDTQVV
        szc21xM7ONZhjstNW6Q8VTH1Ww==
X-Google-Smtp-Source: ABdhPJz3DcrS0XnZld/BLlHleyGDnDxfRB0k0ZwXdVVvRVsQEwmYKD/Trh4sgAO5bFmxGD/348dkoQ==
X-Received: by 2002:a17:907:9609:b0:6f4:d4d7:7c82 with SMTP id gb9-20020a170907960900b006f4d4d77c82mr29492507ejc.483.1652359763207;
        Thu, 12 May 2022 05:49:23 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-58.xnet.hr. [88.207.98.58])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170906828300b006f3ef214dc2sm2109475ejx.40.2022.05.12.05.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:49:22 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 08/11] arm64: dts: marvell: rename temp sensor nodes
Date:   Thu, 12 May 2022 14:49:02 +0200
Message-Id: <20220512124905.49979-8-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512124905.49979-1-robert.marko@sartura.hr>
References: <20220512124905.49979-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the temperature sensor nodes to use "temp-sensor" which matches
their device class instead of IC specific naming.

Remove the status = "okay" which is not required as its default anyway.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index b89c7455612d..f21a855fc608 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -152,14 +152,12 @@ &i2c1 {
 	scl-gpios = <&gpionb 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpionb 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
-	nct375@48 {
-		status = "okay";
+	temp-sensor@48 {
 		compatible = "ti,tmp75c";
 		reg = <0x48>;
 	};
 
-	nct375@49 {
-		status = "okay";
+	temp-sensor@49 {
 		compatible = "ti,tmp75c";
 		reg = <0x49>;
 	};
-- 
2.36.1

