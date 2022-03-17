Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE84DBC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355648AbiCQBII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343725AbiCQBH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:07:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EBE1BEBD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:06:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q13so3181453plk.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JvLDVbDDgbp0yNCGRRURLsKBk/XllLTzcyEp1TF0KUo=;
        b=PRkbCtsXHTB57k+4a4eBSqG/fVFlU0qGBWCrJ0/MhTEHIqVuE5K8MPEmI/PjxK/zFV
         sGNJW44o6VQz8zhaQ7yOrVVb7LbvHWOdaZEKg3hFFUpnyayUm8f2O5CZBLSvN0Q5rafR
         VR90mvph3Atwbf+BShZ9hblUpBnw98VJA3tb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JvLDVbDDgbp0yNCGRRURLsKBk/XllLTzcyEp1TF0KUo=;
        b=kSmNWT2QXRN8ZAw3cvuwmHEdgV4zCaAYvok+BZuCol1Enfwg/umhyn4B3r7L/U6tnx
         JNG9jHqOa5ue3ISr9jarU4QQ/R5ee8curSLcUL25nPIuPOM3hqq6E2WFRZuBu11IO11a
         ZPvQmmeVjp5xoodPGum7FJTi98OmrcEFtGmxOjtIEQpkmqUssZtng2+SPSAt2m42X9Y6
         QuQVSelCVvAWsvEGLC4GXIb6isJPH8TFJ0kUGbaJ/Sy9xhkrLm5XU4cncQT6SIPSeS9O
         3wIU925zw5jQY4ovitQ0QMlFb9bN7X5H0IztuAlfqengVyDeGIlwYOi1RD5ZN3R1ZiX1
         NfRw==
X-Gm-Message-State: AOAM530j7sucLtWk3xC3NFzqQP3gRVy0Y2dYPZQzW4Jcu6A4gy99Uvfz
        xg15Bp51sNGMxaLfP5CMwLQOrA==
X-Google-Smtp-Source: ABdhPJy+en968FQATdRXl3SZ6Q+LOtWTG56qirSD/XRFWyWoeul7smFZUJMjLCzcV7qvAaSU6jwyMQ==
X-Received: by 2002:a17:902:b597:b0:151:e24e:a61e with SMTP id a23-20020a170902b59700b00151e24ea61emr2615241pls.66.1647479204063;
        Wed, 16 Mar 2022 18:06:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:dec5:e3f8:cbd7:f5a7])
        by smtp.gmail.com with ESMTPSA id s14-20020a056a0008ce00b004f66dcd4f1csm5093923pfu.32.2022.03.16.18.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 18:06:43 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH 2/2] arm64: dts: qcom: Fully describe fingerprint node on Herobrine
Date:   Wed, 16 Mar 2022 18:06:40 -0700
Message-Id: <20220317010640.2498502-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
In-Reply-To: <20220317010640.2498502-1-swboyd@chromium.org>
References: <20220317010640.2498502-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the fingerprint node on Herobrine to match the fingerprint DT
binding. This will allow us to drive the reset and boot gpios from the
driver when it is re-attached after flashing. We'll also be able to boot
the fingerprint processor if the BIOS isn't doing it for us.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Depends on https://lore.kernel.org/r/20220317005814.2496302-1-swboyd@chromium.org

 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 984a7faf0888..282dda78ba3f 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -396,13 +396,16 @@ ap_spi_fp: &spi9 {
 	cs-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
 
 	cros_ec_fp: ec@0 {
-		compatible = "google,cros-ec-spi";
+		compatible = "google,cros-ec-fp";
 		reg = <0>;
 		interrupt-parent = <&tlmm>;
 		interrupts = <61 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&fp_to_ap_irq_l>, <&fp_rst_l>, <&fpmcu_boot0>;
+		boot0-gpios = <&tlmm 68 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 78 GPIO_ACTIVE_LOW>;
 		spi-max-frequency = <3000000>;
+		vdd-supply = <&pp3300_fp_mcu>;
 	};
 };
 
-- 
https://chromeos.dev

