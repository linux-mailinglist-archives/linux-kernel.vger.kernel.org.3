Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFAF52FE65
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347285AbiEUQrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355468AbiEUQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:46:08 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEBADF9A
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:07 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id m11so1206922ljc.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=stngkL0RmyeNZ/fdBaP2L/F7X3WyYtQ0gVTbEDDbddg=;
        b=SMthyzGRbzKJc/rV+q6hhRGMvt44E5G9ac5+8ykipclkMwlSimPbMoVRSPlgCiU1vr
         qFp5oVGBZ4fCXxjykXKzkA3SCiDq2Wm2JGOKruHldrv1YNXgKZBr0McJkMtYiU0Jpg3b
         yjUMyTAtB8QXl2vbhfefvAcLVNWkm2HHna9BOVTWXHBG/POhIpB6xGeod6Djhr1j/mK9
         Jc1+VSuju/DLfEJ81aYtn15q13tcFwMlRpjpIIVgsYeMxnUuEgkMp/l4XSBPUeBUptdr
         k7JUcMTXsZalJOIo4Bjpn1kkmXhH3NsmIpXXMn0GvKvMunn0Ae2YMOrklB3mxoLNLKpq
         vNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=stngkL0RmyeNZ/fdBaP2L/F7X3WyYtQ0gVTbEDDbddg=;
        b=3UHCwdaZs1iAcWPTPWtYKG53a2Gdqn/KQ7XyygrNMz7qyT01XoSmqZsvGkGQJHnvW2
         k1pAdSzZV7LnjiJfCxpkQOQoor6mORMJMKuwseT/nX5TpyV7MRRrwjfn6fdo8Zq56HEj
         U/x+2xhKHxjB/QpnvYEyd/RPDASRNqgFIZv7q1LDn8eXd7KcHDfqZuTBiTSqJ7oWGk8A
         q2h+uaeSsM7aW0Im/52JLxEwEWBVn2CgVY+CmC2mVWXqRaeQSC4Ir+NFti8BdQQaYS7u
         ttnHGoIIVAdcJqPMIqTUQO5ZC1/NdoJG8fAPLWaD3vE91Xlgc6HNFvn5jvwvuoSn/M2O
         TjRw==
X-Gm-Message-State: AOAM531tiJJRkFdWCPNeCtA6IcvDPDMHqp9yfPlyrxpU26a7DKPgUGcE
        UpwW+0tgznP1zfy/gBG1ofOX6g==
X-Google-Smtp-Source: ABdhPJygyX/Tk5i8nH+7Dtf7xniCJXE2hnCZ/hjaeA4lAmJSyoGVAf10EhM/cRhBlZ4FM7kT0D0Gvg==
X-Received: by 2002:a2e:a90b:0:b0:253:cb9a:65fd with SMTP id j11-20020a2ea90b000000b00253cb9a65fdmr8358348ljq.417.1653151567093;
        Sat, 21 May 2022 09:46:07 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f26-20020a19ae1a000000b0047255d211cesm1114282lfc.253.2022.05.21.09.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 09:46:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 12/12] arm64: dts: qcom: msm8998-mtp: correct board compatible
Date:   Sat, 21 May 2022 18:45:50 +0200
Message-Id: <20220521164550.91115-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
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

Add qcom,msm8998 SoC fallback to the board compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-mtp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
index 66540d2ca13b..db240a3207dc 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-mtp.dts
@@ -7,7 +7,7 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. MSM8998 v1 MTP";
-	compatible = "qcom,msm8998-mtp";
+	compatible = "qcom,msm8998-mtp", "qcom,msm8998";
 
 	qcom,board-id = <8 0>;
 };
-- 
2.32.0

