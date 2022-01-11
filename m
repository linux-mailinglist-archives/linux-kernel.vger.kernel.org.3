Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A77B48AEC5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbiAKNp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbiAKNp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:45:57 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37962C06173F;
        Tue, 11 Jan 2022 05:45:57 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s1so33082806wra.6;
        Tue, 11 Jan 2022 05:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iijtj/QUK6WABJsTECmjaPeb1MGgaakWJBsRpJ2iseM=;
        b=lm0LhEb4eFpH/C3I36RuOoBqL9Bp+vklw+a8+f9mfXtVqHeQ99x1legaVwfWYbVewe
         lceAtuiVnB+JcL9W6o915S1mOSBQqMqedqOTYDBzuzdkdDbafGY04whg51CUPk5vh6fO
         XzRkMzkuAKO0H20Q80IU2604lwBozC8ULt9ouaIJdOXn5rMm+UOXJnjC75yzMi5WhuJW
         FQPQDOz9JIKmjVZEMrmhzrC5xJiLVxrAAl4X8GmbcL5DV7nWFLQKbkPm7KyxM0dB82Yt
         vzLfnZ6rKTopCXm3l7QJSTvcNprNWyPz657xsLAH9EkpNwtpHQWSCAsRu+SXHSSQnJ58
         Cs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iijtj/QUK6WABJsTECmjaPeb1MGgaakWJBsRpJ2iseM=;
        b=q/1m7NsbsQXx9DVlmXo4oYDCGbKg83fUx5PJQA1wQ+SPiptBwap9tLxIDWtaIR4qU4
         Wa/12sNjefaw0yjj51qwedjk4wQHvvZ140cS/g1XB2dAJbD8Ds9VBgJKkYmF3xV8vaa8
         TuU3gjuDYCc5+u7n3SqXtjrcon0Ul3tqd7SYU/jGFVpwQcGRMhqJCXQvB/M09giSRmkG
         JFF5CJ9fQ+0CzbOzxSVMk/JNRfb/JYeG8orO9vtMMAI3Sqss0P+enyqqOwL0aA5UJbtJ
         uQ25y37dBE+LrHaJVVDHqgb5Z8AQIkSHk7MlB7kxpRpdnKcLCU90zD7r4g0ZBbQ3Ya8W
         O40A==
X-Gm-Message-State: AOAM530WAzs/YjsaSKk1SU1yAGxXjymv6lxaSo2f3g45OthgRLQcXHHg
        VlQlMueMQqBLFvVvdQjtaHJELKDqIMs=
X-Google-Smtp-Source: ABdhPJw2PpH0k8BFDKNlgwERtgNiDMLbMUyLHXgDMezgM+q1jHmKusxAoJ2RBLCuMMVuvD42pzCdsw==
X-Received: by 2002:adf:d216:: with SMTP id j22mr3905617wrh.577.1641908755647;
        Tue, 11 Jan 2022 05:45:55 -0800 (PST)
Received: from localhost.localdomain.at (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id r1sm10758449wrz.30.2022.01.11.05.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 05:45:55 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: ti: k3-am64-main: add RTI watdog nodes
Date:   Tue, 11 Jan 2022 14:45:48 +0100
Message-Id: <20220111134552.800704-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the needed bus mappings for the two main RTI memory ranges and
the required device tree nodes in the main domain.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 18 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi      |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 5ad638b95ffc..83cd48144789 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -974,6 +974,24 @@ ecap2: pwm@23120000 {
 		clock-names = "fck";
 	};
 
+	main_rti0: watchdog@e000000 {
+			compatible = "ti,j7-rti-wdt";
+			reg = <0x00 0xe000000 0x00 0x100>;
+			clocks = <&k3_clks 125 0>;
+			power-domains = <&k3_pds 125 TI_SCI_PD_EXCLUSIVE>;
+			assigned-clocks = <&k3_clks 125 0>;
+			assigned-clock-parents = <&k3_clks 125 2>;
+	};
+
+	main_rti1: watchdog@e010000 {
+			compatible = "ti,j7-rti-wdt";
+			reg = <0x00 0xe010000 0x00 0x100>;
+			clocks = <&k3_clks 126 0>;
+			power-domains = <&k3_pds 126 TI_SCI_PD_EXCLUSIVE>;
+			assigned-clocks = <&k3_clks 126 0>;
+			assigned-clock-parents = <&k3_clks 126 2>;
+	};
+
 	icssg0: icssg@30000000 {
 		compatible = "ti,am642-icssg";
 		reg = <0x00 0x30000000 0x00 0x80000>;
diff --git a/arch/arm64/boot/dts/ti/k3-am64.dtsi b/arch/arm64/boot/dts/ti/k3-am64.dtsi
index 120974726be8..84bd07cd1824 100644
--- a/arch/arm64/boot/dts/ti/k3-am64.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64.dtsi
@@ -71,6 +71,8 @@ cbass_main: bus@f4000 {
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x02330400>, /* First peripheral window */
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
 			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIE_CORE */
+			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x00000100>, /* Main RTI0 */
+			 <0x00 0x0e010000 0x00 0x0e010000 0x00 0x00000100>, /* Main RTI1 */
 			 <0x00 0x0f000000 0x00 0x0f000000 0x00 0x00c44200>, /* Second peripheral window */
 			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripheral window */
 			 <0x00 0x30000000 0x00 0x30000000 0x00 0x000bc100>, /* ICSSG0/1 */
-- 
2.34.1

