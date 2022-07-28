Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DA558455D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiG1RwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiG1Rvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:51:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9C774CC9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:51:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v18so2410349plo.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MeLnh0rabjFUt9GPWYnFusxmYFD63xDhBBKxQm/Xe2E=;
        b=WJkVfWqlO5MKqhzLt48P5aPy5h9mWBJeqgspIJDVus196oRpW0WDUAQteBPcWZY2z/
         Gip+HmFZrf7OPUZWz2uWofCr/lpVq35xWdaECrgE11x7GKt8/zsJt1Z9Mbu6NYdQia+D
         ismdqCjNccvQNmauP9DO0ZCeKQU8l8bs8GGR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MeLnh0rabjFUt9GPWYnFusxmYFD63xDhBBKxQm/Xe2E=;
        b=jQ0ZsS0XhGi3lsNoPMwMHqc3tQC1oZWLEH/e2p0oOrlX3wEk9h8Jw30cTYzLPJZIWV
         kVYPJ+fMJAPKAJIEkmfPwHq3Ple3V/lEyBW30BE7Vvga6mFiu12iCITzx7pJ6NVo883s
         qHbWCrMwvQxdipbDxhvybaAaUYQUaEusIvQq2sTblq9Ex9Yn6fnt1vY76N1AfK65z23e
         iR7X7OklYpl1dCRo0/1UqZTN2XXyX0ECyALh3KrITrJY9x0jn6c8fYWVKHBSCLFmDkGC
         MaSQLz7cMRVyFJafbbVgSWdvO+a8Yeq4tbmrQxNG/Btgd7SC/A0tPT2MkQYDHcGtapKW
         APDg==
X-Gm-Message-State: ACgBeo0LuI+H2U9AI1uO0M1jKhskjA8OQFpPWqUfiqKSfHffQYyuXrDB
        mxzd1qwqjWcjNgMatdTETkFSdhulgi1D1g==
X-Google-Smtp-Source: AA6agR7yxjxkWmktYJbcRF1Vs4zVcwK33yOxw5+tpNb/w4yg6CT9nnfZkcCoqWB5wVRHT1fPy2eyJg==
X-Received: by 2002:a17:902:f101:b0:16d:c0ae:acd5 with SMTP id e1-20020a170902f10100b0016dc0aeacd5mr20194plb.70.1659030707553;
        Thu, 28 Jul 2022 10:51:47 -0700 (PDT)
Received: from moragues-cloud.c.googlers.com.com (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090a3e4e00b001f315f73ef1sm2696136pjm.0.2022.07.28.10.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:51:47 -0700 (PDT)
From:   Bob Moragues <moragues@chromium.org>
X-Google-Original-From: Bob Moragues <moragues@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, swboyd@chromium.org, mka@chromium.org,
        Bob Moragues <moragues@chromium.org>,
        Bob Moragues <moragues@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Add support for zoglin
Date:   Thu, 28 Jul 2022 10:51:11 -0700
Message-Id: <20220728105005.v2.2.I7d57fb9c4806a8b3fe3501c766b64f4987c271ef@changeid>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
In-Reply-To: <20220728105005.v2.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
References: <20220728105005.v2.1.I5b9006878bdabd6493b866b46dbd6149968d545b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Moragues <moragues@chromium.org>

Zoglin is a Hoglin Chromebook with SPI Flash reduced from 64MB to 8MB.
Zoglin is identical to Hoglin except for the SPI Flash.
The actual SPI Flash is dynamically probed at and not specified in DTS.

Signed-off-by: Bob Moragues <moragues@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Bob Moragues <moragues@google.com>
---

Changes in v2:
- Fixed Signed-off-by
- Added reviews / acks

 arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index 6d324ac2dda1..98d09187fc69 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
-	compatible = "google,hoglin", "qcom,sc7280";
+	compatible = "google,zoglin", "google,hoglin", "qcom,sc7280";
 
 	/* FIXED REGULATORS */
 
-- 
2.37.1.455.g008518b4e5-goog

