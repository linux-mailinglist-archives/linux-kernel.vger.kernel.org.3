Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E39A496AA6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 08:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiAVHcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 02:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiAVHc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 02:32:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849B8C06173B;
        Fri, 21 Jan 2022 23:32:29 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s18so3782367wrv.7;
        Fri, 21 Jan 2022 23:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vQPxP47/SI1S5KWtgWG+VbRHmE9OA9+/Jfo9crf1SUM=;
        b=VYkOYhzeDSKuwhEEvi+w/G4AoJ4AwR2N66fCvdT80WOuzy68msz8FaG663DO+TruuJ
         0U9G80k757Rjhs2GuvbTTKhTrxQpCyRf8hMQCFTPQ7pzIHF53nOklvGkNQnI7QqPb2Y3
         oI29WF96Eyy75ElMMKVones1q4BlWeAkvsfyfod/wEKt0P5MPS0qf48BfXAdnOzcX/R1
         YtketIMq0nFtU4trK1Zezy9bbBqBPPFCPY82MpPqn+i5pLHmMsi7Ea4XapMM7okkr88p
         DWGpg0++o+q7qqNIjCVRxfPyy0oJ11Kr1ZBm+1xeeu1M4zOdRl/Ey18Ud79nsRzOCmUo
         m5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vQPxP47/SI1S5KWtgWG+VbRHmE9OA9+/Jfo9crf1SUM=;
        b=Al+WYYdD8WpA1JQkGqvt3B9w3oC5I6xpEHeV46m/jOVFcQu4vsFefYePlr2heMrFmH
         XDCVQRnEDfWaIlY7P44P7QLgt/7b0tVGn0iGzp92jgS+gO+N6dxcE6pqlvdBng600o9L
         HAglAokbjp6pTvh19/JfaIg/AxOsULfIcRVeWm4/1AfyuNKt6ZMXpFSUvy+Gg0BqkNoz
         eZYtGP424YBQFs7VIGZ5zAvpiete0SYdOvtWP+0sdkd4Pbd13GCINy4+60UHnJWptaT9
         wvJGJ/rE/E66FrbNHOLWTYxOzkhonm4cenUADROzyRXX7/K3BvX8wRG2xwIih7fVuh1+
         ZKuA==
X-Gm-Message-State: AOAM530Br2U1Mv63tEPeXWBWXwC4pHd+m3ZoZh9xTyJVwAYPrGGplml8
        MCkS6Ha4+h85WHNCgrUjv34=
X-Google-Smtp-Source: ABdhPJyHVe7oK5iQ/081jmH9XrPsNUo/9dNQ/COldDs2uJnD5Z1Q5FUbsF4G3/d1kz0/AJnVWwJPAQ==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr6747530wrs.490.1642836748058;
        Fri, 21 Jan 2022 23:32:28 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i8sm8970485wmq.23.2022.01.21.23.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 23:32:27 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Furkan Kardame <furkan@fkardame.com>
Subject: [PATCH 1/3] arm64: dts: meson: add BL32 reserved-memory region to GT-King
Date:   Sat, 22 Jan 2022 07:32:19 +0000
Message-Id: <20220122073221.2398-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220122073221.2398-1-christianshewitt@gmail.com>
References: <20220122073221.2398-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an additional reserved memory region for the BL32 trusted firmware
shipping in Beelink g12b devices. This fixes a long running issue with
boxes booting from Vendor u-boot where the board wedges during boot or
soon after due to the (un)reserved region being overwritten.

Fixes commit c5522ff9c729 ("arm64: dts: meson-g12b-gtking: add initial device-tree")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
index 5d96c1449050..58a300d6b545 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
@@ -19,6 +19,14 @@
 		rtc1 = &vrtc;
 	};
 
+	reserved-memory {
+		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
+		secmon_reserved_bl32: secmon@5300000 {
+			reg = <0x0 0x05300000 0x0 0x2000000>;
+			no-map;
+		};
+	};
+
 	spdif_dit: audio-codec-1 {
 		#sound-dai-cells = <0>;
 		compatible = "linux,spdif-dit";
-- 
2.17.1

