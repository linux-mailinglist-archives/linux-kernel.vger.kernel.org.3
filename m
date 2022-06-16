Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C377E54DA45
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359082AbiFPGJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359016AbiFPGJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:09:33 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C708C2E9DD;
        Wed, 15 Jun 2022 23:09:29 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 41B063200A57;
        Thu, 16 Jun 2022 02:09:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 16 Jun 2022 02:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655359767; x=1655446167; bh=Q6
        7Ot5tdbFGVjczMQOtyiP3EgCUjO/QaLYKLX+IzOvo=; b=eyFK0Vy99b3mJB/2NK
        fT1vC3q0wpxdZxR6Egmp65PmMxB08X14az1d72oN3D9SyD11p8w28Gi5cULbrz18
        cihax6t8H4fq5SOlqf6N3PqUb5dGlEoWO/12aduSmB8irN/MJzxMAdZQVrjo5k1/
        RbLLX7l4hUqb7gKwXo1Q7GxjElFbfaPh3oIAlLyVDGaVvR9lOCOGlz6E0tA3saJZ
        CMzZgXE/53s3R8iH6+0ZWlZcYyJNkpAa7UmdYchCoXlFY6Z6/dXUkeOyIerxJ3VI
        s47VuwRUz289oCS5s5pV4qA5Fs+7cFDH/lmECUIZfhXaBKG4jF0N+glOxx3cqYd2
        Bj+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655359767; x=1655446167; bh=Q67Ot5tdbFGVj
        czMQOtyiP3EgCUjO/QaLYKLX+IzOvo=; b=UwcL5PYe3LP6t/voujdgO89tALhl+
        7iojztLB1Yr50yWzUBUjx+Wrx2KDX5V+AiM6ChCk4aqPyCLPnihQeb/3FFajFRIa
        P02ZG3eHJRf82mbxO1V2/F6LFE2OBj9E7721uMQ4kkKGCOPUyKiIMsuQWLbdfPx4
        80vQn/JUJ9I+Fb1Sb9VxBKX88HmGT9VtmakSDzyOdOtEypSIaFLOM3xaeSEHFoKe
        txyp3lSGRruLU5Q8xXd5WOOMjhREMKK7avfyREWz6s0QfcVtIFyLFt95WbscrOd3
        0QB81t/7QMevEFoUY8rOZYcEzVnUphIyyNIlv5qAYIpBkyUMflYQTpyMg==
X-ME-Sender: <xms:F8mqYt6n9ZrB2dtrePeZSJpDyjXBkF5hkbY7Abzu9eNnO7Zr1YnDbg>
    <xme:F8mqYq4JCDwuKV2ZUTyIbDFL4giJ99JuF11K5g4j9hu6tMKZ4akB0ndx7Imsb7W_3
    N5lAexFIYB9O1Ymkw>
X-ME-Received: <xmr:F8mqYkfL5o_f2mZXAthD1Zi1guGVofk8XiFcDPHq91aacmxvE-to7OtpxmPZVoCqtVWN7ZyZVoxE-Ik6yvtluhFGX_16fr5ZCtYwJABienOroDt5oykGU0Uele1MzRjneYfUZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvvddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:F8mqYmLDPdwWV-JYxHn0iIGEfglpct-1D4sEX7lNDPzvc_ss_4iqNw>
    <xmx:F8mqYhIBcpohnLBz-vbe_Z0hw4XPPMk_OEQgODSIeUMJTDvAgt1QSQ>
    <xmx:F8mqYvw8_0j6HE0hYwTiKHzF7SShcwbkYJ4lsoTdrqXFqp6pJeTSDA>
    <xmx:F8mqYo8TC0uGegXBmx8_S-WMF16UvJaLjL6j75Dd6yoKGxZ214akIA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jun 2022 02:09:27 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: axp22x/axp809: Add GPIO controller nodes
Date:   Thu, 16 Jun 2022 01:09:15 -0500
Message-Id: <20220616060915.48325-5-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616060915.48325-1-samuel@sholland.org>
References: <20220616060915.48325-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These PMICs all contain a GPIO controller. Now that the binding is
documented, wire up the controller in the device tree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/arm/boot/dts/axp22x.dtsi | 18 ++++++++++++++++++
 arch/arm/boot/dts/axp809.dtsi | 19 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index a020c12b2884..5c233c84be92 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -67,6 +67,24 @@ battery_power_supply: battery-power {
 		status = "disabled";
 	};
 
+	axp_gpio: gpio {
+		compatible = "x-powers,axp221-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		/omit-if-no-ref/
+		gpio0_ldo: gpio0-ldo-pin {
+			pins = "GPIO0";
+			function = "ldo";
+		};
+
+		/omit-if-no-ref/
+		gpio1_ldo: gpio1-ldo-pin {
+			pins = "GPIO1";
+			function = "ldo";
+		};
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
diff --git a/arch/arm/boot/dts/axp809.dtsi b/arch/arm/boot/dts/axp809.dtsi
index ab8e5f2d9246..da92b105f3b0 100644
--- a/arch/arm/boot/dts/axp809.dtsi
+++ b/arch/arm/boot/dts/axp809.dtsi
@@ -50,4 +50,23 @@ &axp809 {
 	compatible = "x-powers,axp809";
 	interrupt-controller;
 	#interrupt-cells = <1>;
+
+	axp_gpio: gpio {
+		compatible = "x-powers,axp809-gpio",
+			     "x-powers,axp221-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		/omit-if-no-ref/
+		gpio0_ldo: gpio0-ldo-pin {
+			pins = "GPIO0";
+			function = "ldo";
+		};
+
+		/omit-if-no-ref/
+		gpio1_ldo: gpio1-ldo-pin {
+			pins = "GPIO1";
+			function = "ldo";
+		};
+	};
 };
-- 
2.35.1

