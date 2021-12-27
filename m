Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D764648031F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 19:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhL0SAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 13:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhL0SAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 13:00:43 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E78C06173E;
        Mon, 27 Dec 2021 10:00:42 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so33602346wrr.8;
        Mon, 27 Dec 2021 10:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OPoQgTS1KmVFy90W+NvwmeK9gvsrVLDXWCHILurYpF4=;
        b=R6a1sE60uGxkTSpchGmaw0fcubKH43ijxIMCNwBV0tRzTrlu1VljnquWFpLBo5Ydvu
         v83W/iKkvv9yFHIF7bHaMawQa7eTPSp5RQ+jukanfcEILTo8MKkjQRdvV7Fdgw1xrHJA
         uFDzcdBKS3LiG7ksWv7Cwe6y2hOVZlJkvPXcpotucohOS90+Z9pEXmJah3ENfWj515Zp
         SKgRCh1Ny+SGqZu9WcyO8dpu1KShg8WM4MULg6xgEj+268mTNm+LjNEirbt2hqyaXCw3
         FlOzA5HVb61WoqtltTVuAi0uOvFxzXdZod69NXCIlJlYjOcH9iD//6CXlLnQM48aZzd5
         TEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OPoQgTS1KmVFy90W+NvwmeK9gvsrVLDXWCHILurYpF4=;
        b=QTDMuLX8nZAn686kQnMtENxtDR0oREnPXikmoFeVCz7iw122/jxWTWlRuv6thvYbRo
         /uDFTD1GnUI902r2uHOZpbScK8i5lqEjkVhLIWxlB5eN6kZJcoA1Axr0nsG9SqNDlyYo
         oD+oH/CevpypE5m10uJqTHwq8GCcZJG2Oe8BDT4pD5lEY1SSVdIO2flASRBOyF/C8/sT
         JLUt4UkqQ9QRjkSDEWqykOhGWLiEa5+wngZg575N+W47mS6EIR6xC+CjX+FcjhbfMPK6
         dQjrD15pfpRRRZAmXSGphU9gFrxCaX6riMciJTSGjF0bdyYWUTTKMM6sw2KzTbC7SyzD
         Wm1Q==
X-Gm-Message-State: AOAM531I1iAp51Q6IDh1A5DdkHlPPJIa7t0JbL1lAS+eEvha0NRZNQVP
        T1gSiOpfdHsC4oOgGZXWq82UFTZPzp4=
X-Google-Smtp-Source: ABdhPJzH3wWk4vzNSxrurF8PiDQCpZOr2Tvtc+/Setuzmad0Ya+yIxzDoJRnDBxWyxG9Z1YJddhgMA==
X-Received: by 2002:adf:de84:: with SMTP id w4mr12966739wrl.67.1640628041292;
        Mon, 27 Dec 2021 10:00:41 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c4b2-f800-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c4b2:f800:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id o11sm18572946wmq.15.2021.12.27.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 10:00:40 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] ARM: dts: meson: Fix the UART compatible strings
Date:   Mon, 27 Dec 2021 19:00:24 +0100
Message-Id: <20211227180026.4068352-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211227180026.4068352-1-martin.blumenstingl@googlemail.com>
References: <20211227180026.4068352-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dt-bindings for the UART controller only allow the following values
for Meson6 SoCs:
- "amlogic,meson6-uart", "amlogic,meson-ao-uart"
- "amlogic,meson6-uart"

Use the correct fallback compatible string "amlogic,meson-ao-uart" for
AO UART. Drop the "amlogic,meson-uart" compatible string from the EE
domain UART controllers.

Fixes: ec9b59162fd831 ("ARM: dts: meson6: use stable UART bindings")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 3be7cba603d5..26eaba3fa96f 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -59,7 +59,7 @@ hwrng: rng@8100 {
 			};
 
 			uart_A: serial@84c0 {
-				compatible = "amlogic,meson6-uart", "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart";
 				reg = <0x84c0 0x18>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				fifo-size = <128>;
@@ -67,7 +67,7 @@ uart_A: serial@84c0 {
 			};
 
 			uart_B: serial@84dc {
-				compatible = "amlogic,meson6-uart", "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart";
 				reg = <0x84dc 0x18>;
 				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
@@ -105,7 +105,7 @@ saradc: adc@8680 {
 			};
 
 			uart_C: serial@8700 {
-				compatible = "amlogic,meson6-uart", "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart";
 				reg = <0x8700 0x18>;
 				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
@@ -228,7 +228,7 @@ ir_receiver: ir-receiver@480 {
 			};
 
 			uart_AO: serial@4c0 {
-				compatible = "amlogic,meson6-uart", "amlogic,meson-ao-uart", "amlogic,meson-uart";
+				compatible = "amlogic,meson6-uart", "amlogic,meson-ao-uart";
 				reg = <0x4c0 0x18>;
 				interrupts = <GIC_SPI 90 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
-- 
2.34.1

