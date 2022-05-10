Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C00A522318
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348415AbiEJRvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348408AbiEJRvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:51:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5E35BE42
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:47:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so2781661pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 10:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=367qNbwirVd+MUQc+PspfP8JIegI5pq9wxFX9cOdhFo=;
        b=CvZeRbMp5y9U0xF39VEeLR4NsUywJTxn9fdetZJfQ8g2a4GQsyDJ8qa8xmQYntNIcG
         hRQCSvQO8A0YpkT5agT6nlhEmjONdMHOfPqtTMroBmlal1MfxlZdyWswkaM84dbDyJHe
         FEo26YvGo2JNTs//yLB7VqNATrn3cXj7PCzRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=367qNbwirVd+MUQc+PspfP8JIegI5pq9wxFX9cOdhFo=;
        b=Y70Fp9fOrcmergxGFUjwPnFd5uRkumKwXQdbrxItPC3xin5VaWEbU4n8WQtkcB/CBT
         dxnKRlB5eZLHQlECFfdzXbpR3L2eYwEy1Sa+4E1IwZM9nifHMKpDtn2Uk71znDfLaDAU
         mnJ52HddLejn2AnlXXxxFtTQIlg21E4+BM4y4b6Yh0vilKR4mhk0bnfms91uHXGujz8u
         KIAPc0F/XWJrVM+E5sFPhSn9GULkwmqB3l9fi0A4lMo0n7e48mo6XRvjy4auA7BsxozM
         H6O8sZV4txso+tnmOlCKy9RXrGlXRuJsR16hIxx3lvq5tSA8nrAZmtXjPQy+vAX4oFBM
         quNQ==
X-Gm-Message-State: AOAM532HaWSIvk46oSmy9NCwIKkbuSxYNsBKOpGj6QgMbCKvEvu/w3Bb
        YbfaAbQK0vh13NbB0FZ9kZbvVw==
X-Google-Smtp-Source: ABdhPJzN08jhOreepCFVwSZ/2YiQp/sSTa2TK/dtA0gPTWJg3tibeCGtia05AlnKlwj6psiSwzZATw==
X-Received: by 2002:a17:90a:4417:b0:1ca:a861:3fbf with SMTP id s23-20020a17090a441700b001caa8613fbfmr1059545pjg.80.1652204832700;
        Tue, 10 May 2022 10:47:12 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:fb50:1192:2874:d4a2])
        by smtp.gmail.com with UTF8SMTPSA id h2-20020a170902f54200b0015e8d4eb264sm2398677plf.174.2022.05.10.10.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 10:47:12 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7280: Set modem FW path for Chrome OS boards
Date:   Tue, 10 May 2022 10:47:08 -0700
Message-Id: <20220510104656.1.Id98b473e08c950f9a461826dde187ef7705a928c@changeid>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the path of the modem FW for SC7280 Chrome OS boards in
the 'remoteproc_mpss' node.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
index 9f4a9c263c35..995c5bd12549 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
@@ -89,6 +89,8 @@ &remoteproc_mpss {
 	compatible = "qcom,sc7280-mss-pil";
 	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
 	memory-region = <&mba_mem>, <&mpss_mem>;
+	firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
+			"qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
 };
 
 /* Increase the size from 2.5MB to 8MB */
-- 
2.36.0.512.ge40c2bad7a-goog

