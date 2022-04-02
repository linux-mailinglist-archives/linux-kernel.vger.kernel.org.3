Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25084F0030
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354162AbiDBJlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239835AbiDBJlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:41:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02611143443
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 02:39:31 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c7so7469622wrd.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XhV4HSZrMAi+yhoQY81OkkuHq2F23KHAg72528AqqLM=;
        b=cuuDYgOnVXMfDSWJ9FK4GOX4dJrbCpXFo1MSeNMzg7cKUUz/66coAEuV3xcNo/BBA4
         G0WIkEKTi6OPRPfUwMBLH1EHYkYQ1scfiFMCMmGgIQ6FQt3Tw3YFmmsLJFN2cfkaTOur
         XURRtl3hCm0bjtXMZ+159WaJzIgJD0rt/WaMS9KQPlXKqwJmfBYrwJyu90eMF3yiM1/b
         wy2E1/QmLMUaXJWQ+pmGvMAWmi3bJfssXymZF5QuQFoVQZZGyBieCoY4RtmfnF8u0oX+
         HTJrra3pJEFWXQN9quhWPfuC18xBBtqKUzAZsa9/yaMQ3c/oj7HvSRWjpdFMd31v79sI
         dx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhV4HSZrMAi+yhoQY81OkkuHq2F23KHAg72528AqqLM=;
        b=UdKOl40DII3xXZE34/Mxo6cPaXb85W/iuZyh35kWO7tOWbeUva/nqNiSjFTHFKl/Yp
         7YhdrcsTe+5cOfu2CKmMpezr7/hIQVRLqYD8boARQ/psFu7pfbSR0krFhhHH2tHozbeF
         zUBYTuQ/eLbTmvCZZt0lq3f/wzlLytSgO83eeCVliazm9PtU/8ve+w72xPwnAAqjM/cm
         69ZhOfEtPvuBvZ72XWdebG01P5fb/avo8oWgohmkKoyQRok7bknw82jWrgdeSwD5krTt
         Yazg6GeSTRFPMLV+rTFa9AK8Cf3ICWvqjCsnCWQBvdMT1XnJ6mPkOrCpbGb+Tn8Udi9A
         1oWg==
X-Gm-Message-State: AOAM532t+zNaflfoj9Gzw4l0BcDq7LWgP5YkldWxgqxCZ52ZY6DVhG27
        +GlaiiIs1tGm8IQKpXyXYeGWAA==
X-Google-Smtp-Source: ABdhPJw9Hg6ggkP86eCOBRotSKXYb7G5OP1NFWjKanrvcLI+qo8OtYOPe5VorEypNLw69YMnp6DSwg==
X-Received: by 2002:a05:6000:18ae:b0:204:62a:20f4 with SMTP id b14-20020a05600018ae00b00204062a20f4mr11136100wri.640.1648892369609;
        Sat, 02 Apr 2022 02:39:29 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm5265713wry.53.2022.04.02.02.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 02:39:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] arm64: dts: qcom: msm8916: rename WCNSS child name to bluetooth
Date:   Sat,  2 Apr 2022 11:39:18 +0200
Message-Id: <20220402093919.50084-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220402093919.50084-1-krzysztof.kozlowski@linaro.org>
References: <20220402093919.50084-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "bluetooth" is more popular and more descriptive than "bt", for a
Bluetooth device.  The WCNSS DT schema will expect such naming.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index cf0482fdf69d..9a496b7b78fb 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1788,7 +1788,7 @@ wcnss_ctrl: wcnss {
 
 					qcom,mmio = <&pronto>;
 
-					bt {
+					bluetooth {
 						compatible = "qcom,wcnss-bt";
 					};
 
-- 
2.32.0

