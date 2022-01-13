Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99C948D19A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 05:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiAMESP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 23:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiAMERy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 23:17:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB72AC061751;
        Wed, 12 Jan 2022 20:17:53 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t24so18232329edi.8;
        Wed, 12 Jan 2022 20:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4UM72dZzLG8h7HX4iWc1dAAmQjii4BapFiL5lJRjgwk=;
        b=nyJmLfTv83X0o1n/RQ+fuehHwKeanFXB5hh9Q36aLn5ic0ACfADCC1WXgYw62E8NCQ
         yVQpScT7jQLuswl0zGga90YQqHgIf9/OOFISdspX7khKSETVEUGuxOXpVEZyP+0UCVwj
         8MerJ7rCrYJre2k+9RVeeXDl4Eo3uIiGHihl+3nZi9tXwiy24upJAiLz6Cb/fm5sJqLB
         tKECS3o4Tz8+f11WbvvmNd305UfXg51IghnRpVoA/GgSKwpJQrZp0NM3X1HdNJDZkGBd
         HKdWeWnIZEV4DtZ8VSdd5gN3MowKIuz+kXX3qqrU3YWA/7wFPW9C6KlPmWE0ha9EV5a9
         Mpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4UM72dZzLG8h7HX4iWc1dAAmQjii4BapFiL5lJRjgwk=;
        b=u0Hu+7U24eJxHvRCNHzKh7Kqc45crj+CEognDPh53LOPwxhdMERbCVRTRbU30SNdbO
         650No/la3rDXdkcXcFKJSfl9ZsZRuD7cncXdDWmrLmORIt37gYtoXUK2AYz70Oj42r6M
         bwQ9mHW3HkBPaPdghZeMPS5OEvtuLagMMUPxj2I/1NckmMjiFemaylQqchFPlUHBC+rs
         eJTCqV2W7UbpvsEl/k6r/prWFiibhq1iIVotlffK0Tt3b0jb+UszKKsnKq0PC/DjmXqE
         NwphLBwL29Xz4ELT+QT+38pYdb3mQHSRJoVZbCJgzrjMY+YIyDCvbog+X2ZnfaGYjwTL
         1S1A==
X-Gm-Message-State: AOAM533EyRHVHiyoffDzrQCxyx9QPcggGzhD0qCB6RzNqb4IGoTiSjiK
        Wh4/qKJURWDfMpScwy0Q+f1A+i9vTqvQ3Zw6
X-Google-Smtp-Source: ABdhPJzUJ+bzVbwLG7tXK2UqutsDV//vAnNkw1izayWTa5ShXzy0T7/In/4n96RgDfq8EkuFksy8Vw==
X-Received: by 2002:a05:6402:3596:: with SMTP id y22mr2510394edc.340.1642047472442;
        Wed, 12 Jan 2022 20:17:52 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id eb14sm651822edb.16.2022.01.12.20.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 20:17:52 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/3] arm64: dts: meson: add Broadcom WiFi to P212 dtsi
Date:   Thu, 13 Jan 2022 04:17:44 +0000
Message-Id: <20220113041746.16040-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113041746.16040-1-christianshewitt@gmail.com>
References: <20220113041746.16040-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The P212 has a combined WiFi/BT module. The BT side is already enabled
in the dtsi but the WiFi side is not. Let's tweak SDIO speed (in-line
with other GXL/GXM devices) and enable the WiFi module.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index 05cb2f5e5c36..c635e5858929 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -113,7 +113,7 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	max-frequency = <50000000>;
+	max-frequency = <100000000>;
 
 	non-removable;
 	disable-wp;
@@ -125,6 +125,11 @@
 
 	vmmc-supply = <&vddao_3v3>;
 	vqmmc-supply = <&vddio_boot>;
+
+	brcmf: wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+	};
 };
 
 /* SD card */
-- 
2.17.1

