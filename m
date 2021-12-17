Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB4A479536
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 20:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbhLQT54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 14:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhLQT5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 14:57:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B7DC061574;
        Fri, 17 Dec 2021 11:57:47 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j18so6130238wrd.2;
        Fri, 17 Dec 2021 11:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdysGXdTy+3TZBw7R9cw+LisV1Ndm6W0415d+TGMhCY=;
        b=pxeagsDGNrQVitn44DRzQfGy8d+GGjGuKOTiIAMdIHeOrYgHIcpNBQg4F0wK5FTdL8
         3Ae6wxj6PfDehFJrQ6kzOxVYC/0PIoUeRPU8QpCUGND7FawfV7/oxPwUVHBvgnUwLn+q
         d3CC0s6Jmp0k0ndPYoosFWXklvQIDUeaW0T7ZPHSiTEl3Nm2ANK/+emk+yqjuHoB6kHK
         VBGx8bw4g+ROTudwT2OKxuQ4Iv6+wDvJSIepjlNRc9Mp9sF5pnPJ/L66ob7ZL7Cz5VP/
         BsPBXD6MCQ2DBjeX/AytWi3Iu/qdijQVBZlZouMAVx0/oMdPVyXFfawugm+JJGV2wDJz
         YynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pdysGXdTy+3TZBw7R9cw+LisV1Ndm6W0415d+TGMhCY=;
        b=NebIsSSe7a3o8oD3q6GaNvtbOtQQ4KXPUYnQZVVbtqjbaBVKq9ps/sy14X1SW0cj8I
         gvRzZYk4aShr+ulyXIyt/trdd411Rl+9fpTaqROG3jCAaXnsfw7VlgFVeCB2rPTA8/jG
         R2+V5QTYOMnMLyHQSJtO60r/KBzjL4SQ2FSsZlceKsEoYE2J0MUd2KAAdY57PEVsNe81
         TtHhdSC3dGIAvtnwzf3+VM9HX05TPg9bJSyDEw3bnxjVjnPdXOwRW5vNEJvJQOq9Q5YN
         QlwNK0tViL4aEs5k1mXCA0rn0CqGKpJ9mZqYmegSmwjrAr2fcaKhlt2bvo1zcYa08mmF
         3hMw==
X-Gm-Message-State: AOAM532/ZPaVhCAE9IJIzNow/RQdV6wtpiqt7W4BlsblXIhJHA3ylYxi
        9XtujZVn4uppp7dSmv9DYhCg505+yjZB2A==
X-Google-Smtp-Source: ABdhPJwYyBxcJ045RgxyVdQRDDQgg/UGebYXwCxLP6/MWl/YtWWo/VehH1bzR3fhgk0gmpvCasNKUw==
X-Received: by 2002:adf:efc6:: with SMTP id i6mr3689981wrp.428.1639771065406;
        Fri, 17 Dec 2021 11:57:45 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id y15sm11667631wry.72.2021.12.17.11.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 11:57:45 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] ARM: dts: mstar: Switch to compatible "sstar,ssd20xd-timer" on infinity2m
Date:   Fri, 17 Dec 2021 20:57:27 +0100
Message-Id: <20211217195727.8955-7-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217195727.8955-1-romain.perier@gmail.com>
References: <20211217195727.8955-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines the real oscillators as input of timer1 and timer2 and
switch to "sstar,ssd20xd-timer".

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-infinity2m.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m.dtsi b/arch/arm/boot/dts/mstar-infinity2m.dtsi
index 6d4d1d224e96..080a18b9effb 100644
--- a/arch/arm/boot/dts/mstar-infinity2m.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity2m.dtsi
@@ -6,6 +6,14 @@
 
 #include "mstar-infinity.dtsi"
 
+/ {
+	clk_timer: timer_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <432000000>;
+	};
+};
+
 &cpus {
 	cpu1: cpu@1 {
 		device_type = "cpu";
@@ -20,3 +28,13 @@ smpctrl: smpctrl@204000 {
 		status = "disabled";
 	};
 };
+
+&timer1 {
+	compatible = "sstar,ssd20xd-timer";
+	clocks = <&clk_timer>;
+};
+
+&timer2 {
+	compatible = "sstar,ssd20xd-timer";
+	clocks = <&clk_timer>;
+};
-- 
2.34.1

