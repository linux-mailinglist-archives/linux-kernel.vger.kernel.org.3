Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74415A520F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiH2Qoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiH2Qon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:44:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501957EFF2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:44:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f24so5800500plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qLN8fBo6PyBt7E99VZUSZQ3s6EIjif7d4pGqJZoTYK8=;
        b=AWOO90lMcEYDvhomUOFe3IJEk9k7PehD16RoavUH+k3tVdP29oyJnKhNKlJeLpmH/G
         N4adaaiJcJM9I5+1ZiAzIMcyrnSOQG5YjURrKnH6yFQb/ZXdSigPXVFZ3lIbwLcXODoD
         3fTjkc/kk/K1Z8kMkpcCx3uWjP3ZyHBMSDK0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qLN8fBo6PyBt7E99VZUSZQ3s6EIjif7d4pGqJZoTYK8=;
        b=LbsxbE8LSkBi+jiTSrvDKa3DA/MLhUwqYaFIVc7yIMhlnEbpi3n5EtXVKN1Rgesfpd
         JDIz0AnFjytH1zNaZTB757zrd+kTkd6eDBGQHbvljJfDBxUJjmH2KODhVEI+G2th2nwa
         iI1S/S6xA8qGtA4rtgiRkllfPwNCBNQ7VgU//gWcWEr3SP8APNajtgGAOxUZGnAokJxk
         oufyV3Fj6bBMwBU3kynwRhFnRQTt3e5FT+ixGuwIWa3d2JI7ktS6MXSjr/Emmi5Ql/D4
         askfjA6BJ9/j0SM5LTm5By/p8QpvCVD8f+wEmSQYGLaAiIAp4RZhOSsATftqZzlItcbU
         Bu6A==
X-Gm-Message-State: ACgBeo2CJJCKOiCNsq6eF4rdD+zviH0m+n+xF94ghIyWn1b3eVo3+rBz
        iS+eJ+vIALouC/hJUq3smbwUcQ==
X-Google-Smtp-Source: AA6agR4apsS+tj9IjFo34eaXpnXJQGrN7w2evDtE4E2ZScswf9Oeucx97W3O6v2+bP4nHo2MIiSYtg==
X-Received: by 2002:a17:90b:35c5:b0:1fd:9087:6a70 with SMTP id nb5-20020a17090b35c500b001fd90876a70mr12414100pjb.158.1661791481886;
        Mon, 29 Aug 2022 09:44:41 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:49ac:6e1:90a2:a0e0])
        by smtp.gmail.com with UTF8SMTPSA id e8-20020a17090301c800b001729da53673sm7863682plh.14.2022.08.29.09.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 09:44:41 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7280-qcard: Add alias 'wifi0'
Date:   Mon, 29 Aug 2022 09:44:38 -0700
Message-Id: <20220829094435.1.I4534cf408373478dd6e84dc8b9ddd0d4e1a3f143@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the alias 'wifi0' for the WiFi interface on the Qcard. The alias
is needed by the BIOS which patches the WiFi MAC address read from
the VPD (Vital Product Data) into the device tree.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index 7adf31bb9827..7cd91df7a118 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -28,6 +28,7 @@ aliases {
 		bluetooth0 = &bluetooth;
 		serial0 = &uart5;
 		serial1 = &uart7;
+		wifi0 = &wifi;
 	};
 
 	pm8350c_pwm_backlight: backlight {
-- 
2.37.2.672.g94769d06f0-goog

