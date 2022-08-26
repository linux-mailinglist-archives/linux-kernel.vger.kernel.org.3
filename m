Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8231C5A2BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344705AbiHZPtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbiHZPs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:48:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C94C7404
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:48:31 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id g189so1765916pgc.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 08:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Mf80pPSOt68AVyO6JRAxIAPhPC5Lg00EXSnvADeGlwc=;
        b=CczP7/mGYxwFCyTdD8tvgGZ/PJEzMOXFl503j1qb+YoVvVMnhwrZ0fq+Y5ekCacgWS
         7WZW9ejgt3/4Xki3XewdfCJETl+lOoezPg/DvP3ez808rjkC4RfY4rFeUEpQOFPYSK69
         AY4K0JbzAI1sNcubxs0rzfihDMYm0ozuK1uKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Mf80pPSOt68AVyO6JRAxIAPhPC5Lg00EXSnvADeGlwc=;
        b=uEVTLZy+ZK/mwR0diWhp7iBYEcCE1rOiMjZJlMg21pCJ6Ty80r8F2aSPlKztLOBXD3
         UIxCP/G1GPHkTHfI0WEyLRQQv8GCtuUCh+AUTYlKEHGvFcgffcmxVWgUVYGDpZFfNLbn
         2Nl6Vw9lLtLgImkNDD9EJQP5sUuwRp8aX7qV3RqY8j9HqOrA3yEM+Lll9BuZbzoLEKeJ
         LL720OL8NXSjQosbnxgDyNlUtBdEkdOF3tHMhlOJTML4ISq2OOb3dx1Z+rTW44fVIzUH
         +rZBUUQ6d/BM0+BY3WUTiw5M0bCfNHdrezakOjPjziqxYr+qzkRclpVLuQnEofo2LXpP
         Bc8w==
X-Gm-Message-State: ACgBeo1h0fpV0VcPIoa6Ge1likBbb2fN5ke325Hhy/aWsodWpu/vI/Hs
        r2R4vmYkmGWvP37obUyZKg2ArVdLf8ysxQ==
X-Google-Smtp-Source: AA6agR7l0tJ6T0uxcqDa1jUTXaa8LBhJu4T6X5A5koZMODWC23lbcnZhB3dqXlIYTt+QmuaUrOfNZA==
X-Received: by 2002:a63:43c7:0:b0:429:7abb:aaf7 with SMTP id q190-20020a6343c7000000b004297abbaaf7mr3659377pga.204.1661528910700;
        Fri, 26 Aug 2022 08:48:30 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:87ff:bd4c:214b:f283])
        by smtp.gmail.com with UTF8SMTPSA id n7-20020a170902e54700b0016a6caacaefsm1745330plf.103.2022.08.26.08.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 08:48:30 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7280-herobrine: Don't enable the USB 2.0 port
Date:   Fri, 26 Aug 2022 08:48:27 -0700
Message-Id: <20220826084813.1.I8c9a771fcf4d1cfb6e8e0ef17a153143af9a644d@changeid>
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

The USB 2.0 port of sc7280 is currently not used by any herobrine
board. Delete the device tree entries that enable it.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
I was also told that the 2.0 port is for the Embedded USB Debugger
(EUD) only, but I'm not sure if that's true. From the Linux side
it looks like a regular dwc3 controller.

 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 3f8996c00b05..b2f0404d3f71 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -606,18 +606,6 @@ &usb_1_qmpphy {
 	status = "okay";
 };
 
-&usb_2 {
-	status = "okay";
-};
-
-&usb_2_dwc3 {
-	dr_mode = "host";
-};
-
-&usb_2_hsphy {
-	status = "okay";
-};
-
 /* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
 
 &dp_hot_plug_det {
-- 
2.37.2.672.g94769d06f0-goog

