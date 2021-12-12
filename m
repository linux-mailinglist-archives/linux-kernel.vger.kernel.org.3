Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A617C471C2A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhLLSTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhLLSTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:19:17 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFD9C061714;
        Sun, 12 Dec 2021 10:19:16 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t9so23550551wrx.7;
        Sun, 12 Dec 2021 10:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nGnrWr0NF5OLbuEiP1aIoxLo7fEMlnWLFbea+5BaBr8=;
        b=eaVe1QK1XhzqumJqDuFZ34lO907+y5E4M/gufqJPI6YkEOMlQ+WBbDVkbrbTxzeXej
         g9rZ5L6qM/eXeV9/gG9kg57h8yoW0CxKWoARMmXg4Bkvl85/cVBDL7vbw97YU2M1n2mL
         X427RMVcvHrSTqgFptMbqbGjynR3CQQwl5EuiBWspLGH4G2/Z8gqs2a2oVrEYCJR46OG
         FZIO1Uks/Vqz5Moe89hwGfppUBh3yP8ljOwi+yLILgn76gGkr6WX2e6uoFHtf+PiWLyj
         1IFxX/Y08yvXJ4tmXmo60cE8JJKUX4xlHVl6mUoGWZB/Yv1THgYv3TpPm/WXC5qdCEM7
         Pugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nGnrWr0NF5OLbuEiP1aIoxLo7fEMlnWLFbea+5BaBr8=;
        b=g2RWuTg9AgNbQmIpRVOEG92YeCWo0jVYtJkMijJPN8BVmemTiPxpyvfiaIiNwmZB5s
         ztvWnVe3gsT2NSi9t93Wzadu9MCrJS5RmHwMieWGT6xIhP8c9agq2p1bPiXpl3IclfTV
         nTjlhR0zyLC3WihuxRs4j9tAhqogjvNa73s5N2FS8+/KtgW/pc4hIysRLvestuZYSGjk
         upII9Jvkl+nX8pMw/0okO/kC6e1l2ewUmltsOgAHXILaH7jt4FrqWl/RzHc182p9/YLG
         +h8srzxAxTF2Y3UPwwygtzYmSxZVw51UMdvG2lGUGk5B37eD1Bh+cGu7hT2q4T00yZFt
         XXIw==
X-Gm-Message-State: AOAM533qA+B+EJV2gyXwd86NaVNJsNvbQ/1QqTFCWSH4wasCvqbtTqU3
        KJBcat1AGstwbUOOFB0iiIt+DtpQ+ug=
X-Google-Smtp-Source: ABdhPJyn8pA8sPgkLFSoPF9DUCjBtKTIOpXF3rhgdgPJFGZl5kYFWa6rYmv/W+xv3ZFgjZS+DGP4hA==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr27009896wrx.156.1639333154821;
        Sun, 12 Dec 2021 10:19:14 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id m20sm4933803wmq.11.2021.12.12.10.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:19:14 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] ARM: dts: mstar: Switch to compatible "sstar,ssd20xd-timer" on infinity2m
Date:   Sun, 12 Dec 2021 19:19:06 +0100
Message-Id: <20211212181906.94062-7-romain.perier@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211212181906.94062-1-romain.perier@gmail.com>
References: <20211212181906.94062-1-romain.perier@gmail.com>
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
2.33.0

