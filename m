Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44574AD041
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 05:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346869AbiBHEQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 23:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346823AbiBHEQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:16:10 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843E8C0401E9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:16:08 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s24so11650245oic.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 20:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=meg7+yv6P7H8I92kpKfauROnFr9HsA0YXfhHxqWngtI=;
        b=dr5T7eGTpDkLpbHAPWk/W+0fNT4iFBiMOR5forHMawNckWzkb8xk5t6eDbOF8xJL0s
         BjabzolWc7kR3wbRVdAbxN69q7pcdyeIeT/q47C4re07HQ1h7VK8cPEeMMvqB6gteuK8
         DFSEJLhk2lMPO81u2BKgCRQIglnfdqiS+GJu5fM6W68glkIzF5wbLXRxxH/v1L+mpa50
         qcksJ1sYsCxjZKtM9T/I4/UOycYzo6tsmy/vQ5oo5sbAzEii75Eg8O2AoJiioN6M3S+r
         zv7EmvNh0pM6VzAR3oE3/17v2pRsujPbOjLvdvQ7rgREWC1sjlvVHalwX7X47rHj5QZI
         7hVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=meg7+yv6P7H8I92kpKfauROnFr9HsA0YXfhHxqWngtI=;
        b=7K6P31Jyz/0wRdqiLK2YMBNyPt4jx4ZEKYc0vKt624YFO5u2TKd2r49Bh9/nYBb+J9
         Fb934Ry5hKtq5Ctgzc+kH8yAUy+PCazWaAB+sBqH16yuMeyuO5W8iV54r+BHmR0h56Jd
         Zmn3CsJOeg0FG5paAxPs4BUumffeVY94DOT4bcwHGxWYAdTxYN2AIwyXSAvDcUFUSQl4
         BH4ZZAVzsmqYEh3apG25C42CQgWFwlGp36lck6bR1mWvnnlkL4m04mqHcbnaFraKblTl
         vWQH3lNd5oiAbkmOacQDABiFAg61c/GozmgdM6L4WlX2IMuzLQrFFoANJdHFrpXRc3yK
         0J4Q==
X-Gm-Message-State: AOAM530M6syh6ElmXqNFfMQM+8TAHmXpGlcQH05ON4vuN9H9g72mSDBV
        tCSt8oyI0QFEjAh13JFCPCaoPw==
X-Google-Smtp-Source: ABdhPJxY7TG0owTDc72qDPqILsBvxhKBVkq4JJzRy3UzM7q5BPPXyyFdbZeCRLP6HoRqqrhiwhYyqw==
X-Received: by 2002:a05:6808:200c:: with SMTP id q12mr1058135oiw.2.1644293767814;
        Mon, 07 Feb 2022 20:16:07 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id u3sm5009970oie.30.2022.02.07.20.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 20:16:07 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: c630: Add backlight controller
Date:   Mon,  7 Feb 2022 22:16:05 -0600
Message-Id: <20220208041606.144039-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo Yoga C630 uses the PWM controller in the TI SN65DSI86 bridge
chip to provide a signal for the backlight control and has TLMM GPIO 11
attached to some regulator that drives the backlight.

Unfortunately the regulator attached to this gpio is also powering the
camera, so turning off backlight result in the detachment of the camera
as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 58845a14805f..55fb7302245b 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -59,6 +59,7 @@ mode {
 	panel {
 		compatible = "boe,nv133fhm-n61";
 		no-hpd;
+		backlight = <&backlight>;
 
 		ports {
 			port {
@@ -98,6 +99,12 @@ sn65dsi86_refclk: sn65dsi86-refclk {
 
 		clock-frequency = <19200000>;
 	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&sn65dsi86 1000000>;
+		enable-gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &adsp_pas {
@@ -419,6 +426,7 @@ sn65dsi86: bridge@2c {
 		clock-names = "refclk";
 
 		no-hpd;
+		#pwm-cells = <1>;
 
 		ports {
 			#address-cells = <1>;
-- 
2.32.0

