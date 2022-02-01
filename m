Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595A34A53D9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiBAALJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiBAALH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:11:07 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1671CC06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:11:07 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l24-20020a17090aec1800b001b55738f633so620113pjy.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+cijBLvhJxxRYTV1vDRfsp76gMHCb5POk8j3TEiH8M=;
        b=Jm2CaDN2N7qqGbiD2LddLHmzL00xLkXv3Y3pOSGVcnR7GXM8amxWj2yM/Sle/RNG+S
         f0i0SumDRisGYCqyxMGl4b1wnjKO3oBK8VAKQEOjXmriLtMaL4N+usgJvc2y7F532veE
         IEZcTA3+GAq//gjof5wktp2Ofbrf2vXKPkBuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+cijBLvhJxxRYTV1vDRfsp76gMHCb5POk8j3TEiH8M=;
        b=A5lpg5JC/KR3pe8OoiyS7542hyvhj3RO17nxWx92PPZc9jtoUHu+41py2HTx0gyiNW
         xgL/INKAlrY7JgS3acqOiLRe6KM04qcNKcW0qE2oXEPoQ0ZnmJJ5LOMGD3jNbra9fl3F
         0AodEvaoj4LttewcLewJQsy36mhHmbZBrTIonpxPATTjOpB0M+gcSdIDR+6gl+3gW5dV
         ePo79YvQxk1isB+HS4znpfF3JauM84rtlcJ2mjJSyBbY3sdgrBBxFhBXmLu8IxXAQYPO
         Z4CrK159TXxIUXvOBv0/KjTT3pxQMbA04kUtZw7LmJueOKPUivbu4SoBvCwmsG3PWpOv
         Wcwg==
X-Gm-Message-State: AOAM5334ACmkvvHv/gqSgKLAMqAtBGcNIyDvauGOsBK8w7kTKSTVYdag
        l1GVi/czlp5ERSc/w0H9YOqD4w==
X-Google-Smtp-Source: ABdhPJxTTHmLgX2FBxja2v32QILtVmEmRq+EQJCtJOkQ8TcW1LZIjWolmzbSDg7hA1u4ZNmSzIyxrw==
X-Received: by 2002:a17:90b:4c43:: with SMTP id np3mr36977906pjb.88.1643674266633;
        Mon, 31 Jan 2022 16:11:06 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:c47e:986d:769b:ead2])
        by smtp.gmail.com with ESMTPSA id oj5sm424024pjb.53.2022.01.31.16.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 16:11:06 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>, mka@chromium.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] arm64: dts: qcom: sc7180-trogdor: Add "-regulator" suffix to pp3300_hub
Date:   Mon, 31 Jan 2022 16:10:38 -0800
Message-Id: <20220131161034.1.I7b284531f1c992932f7eef8abaf7cc5548064f33@changeid>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220201001042.3724523-1-dianders@chromium.org>
References: <20220201001042.3724523-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the other fixed regulators have the "-regulator" suffix. Add it
to pp3300_hub to match.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 7d8bf66e8ffe..78296ed6fd29 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -284,7 +284,7 @@ pp3300_fp_tp: pp3300-fp-tp-regulator {
 		vin-supply = <&pp3300_a>;
 	};
 
-	pp3300_hub: pp3300-hub {
+	pp3300_hub: pp3300-hub-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "pp3300_hub";
 
-- 
2.35.0.rc2.247.g8bbb082509-goog

