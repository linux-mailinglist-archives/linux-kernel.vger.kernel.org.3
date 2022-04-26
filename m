Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B431D510C58
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355938AbiDZXBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353328AbiDZXA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:00:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4420931340
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:57:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso288366pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 15:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z9pldSbABWlALe30nll+EqJHPLENAkssKS7uwEiOKks=;
        b=VtVIjWUvoftyfpavtyYQnP8Il2FpVnrZ6jfoy68vndksr7US7LwN29KqB+VoEMerqN
         Vrz3+YkOue35YVPShw9eN1AcFa9B63+jx3sIt+nIPfIwCWr2TydEZEkdT4BUeIyvV9Iq
         DDDde0ZsTmCaE905KYapsFMZIaGZYTlNEkxqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z9pldSbABWlALe30nll+EqJHPLENAkssKS7uwEiOKks=;
        b=HP+FNqMbGia2erWoFhrag5Q7sz92e+w7dbEiyF6AN72lzdl15yluWMjD0rpu0G/yKI
         YWHfuzZG7Gyi2f2jREsQwDmT6lE3Bag9meBjW0s8uhdrCwqJYYhvSMbzGOubAwnH2IHA
         +Dh6vZ2cYq/SZ4wsWDrDt2Lett7tsyGBFdsJeMbecwekuPapPBmpAVS7QYE8bFGK++7W
         Ka6LNGDWhqtr+cK7J9fvqx74IuXLWPD1xElWBitkSXnBlEdNO/DZ6hCe3keXlESrMd9E
         HMIl2FFSBptgWOFH6hcnEAWhTNLD/xmFxGroy9w9kAuXN6UMYM45s7tqZcZkwEk+iIUj
         ZmPA==
X-Gm-Message-State: AOAM531ZMVTDrq5EIaoI1jCWjDIYAi+J3tdX/uGoJefFoMBS9zTJo0kz
        7thRs6Nv1Y8Z0NOzQdGvCYMyLw==
X-Google-Smtp-Source: ABdhPJxRQWaWCgVT2ZIYdnD1s8zBw6rQYK2b3848WTPzlp5QMCboNsrd+HqF5c6T+VO+13AwAytvUw==
X-Received: by 2002:a17:902:8304:b0:155:d594:5c04 with SMTP id bd4-20020a170902830400b00155d5945c04mr25289971plb.105.1651013869766;
        Tue, 26 Apr 2022 15:57:49 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:bb92:4a51:f085:243c])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090adc8100b001d9424e49c1sm4201329pjv.44.2022.04.26.15.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 15:57:49 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7180-trogdor: Remove cros-ec keyboard from detachables
Date:   Tue, 26 Apr 2022 15:57:47 -0700
Message-Id: <20220426225748.324759-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trogdor devices that have a detachable keyboard still have a
non-detachable keyboard input device present because we include the
cros-ec-keyboard.dtsi snippet in the top-level sc7180-trogdor.dtsi file
that every variant board includes. We do this because the
keyboard-controller node also provides some buttons like the power
button and volume buttons. Unfortunately, this means we register a
keyboard input device that doesn't do anything on boards with a
detachable keyboard. Let's delete the rows/columns properties of the
device node to indicate that there isn't a matrix keyboard on these
boards.

Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: "Joseph S. Barrera III" <joebar@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi   | 5 +++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index c81805ef2250..4173623cc241 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -119,6 +119,11 @@ &i2c9 {
 	status = "disabled";
 };
 
+&keyboard_controller {
+	/delete-property/keypad,num-rows;
+	/delete-property/keypad,num-columns;
+};
+
 &panel {
 	compatible = "boe,nv110wtm-n61";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index bff2b556cc75..7205062e88b4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -121,6 +121,11 @@ &camcc {
 	status = "okay";
 };
 
+&keyboard_controller {
+	/delete-property/keypad,num-rows;
+	/delete-property/keypad,num-columns;
+};
+
 &panel {
 	compatible = "samsung,atna33xc20";
 	enable-gpios = <&tlmm 12 GPIO_ACTIVE_HIGH>;
-- 
https://chromeos.dev

