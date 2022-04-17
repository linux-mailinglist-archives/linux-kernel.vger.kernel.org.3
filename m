Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0897D504982
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 23:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiDQVHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 17:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiDQVH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 17:07:29 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40DA21A9;
        Sun, 17 Apr 2022 14:04:52 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q12so15443222pgj.13;
        Sun, 17 Apr 2022 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+AwEQfitiTvfcOtvfzcgPuKP2jkfk8P1mRbhBkGL9Es=;
        b=RskpvdxGD/lUC2qzJH3SWyRdYXCw6kUM9ZFhDrHFrhwxFROxmQzr+h5hKW85cVXwE6
         bYd2Jt7h3W03sveVWjEduL29aWn076N+FVW+R6T6nhUA5B8+OtJosYhgBkDGvIJdG5Sv
         GGGHD0o+gVHJOUoXWzosCoZ+1Y5Sdy1Hg7fF9gz2pwnIejCWp7GvFnONMoDqF0UJ5kmh
         qhmOwHblbnqiUusZpKd5JJleeae2JWekYHPG04dxZ+JeeII2+Jt5EXXgIxlchTzEVKzq
         FCXIjM1JWBiJ2skFDs3ifrxlkWD53qZ0AAKa3cc3EkUUFbvKn1SGlqNF1IrhbGqALCaG
         ejVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+AwEQfitiTvfcOtvfzcgPuKP2jkfk8P1mRbhBkGL9Es=;
        b=MO4GIR5mKJguQ66ub44Vc/YdV/QWf7d1C1IkjkzQ2ZRaiSDPXTijLpsDUdLcEpHLCI
         CdwcitHhse58H+6F2YkQGeLBI3WyaqyGqRBS8YBZP+NeMHDjHgBbfO2MMmGFA6G2u+LS
         q9jBX0lYIV4RXY07QyAPvpT9ePAP8q5c7VsvybUNMzAzBBJ4J9ZVpIgeDEIFVi9ObJwr
         jIGk4kHjR0gWMfCXpFCBztueh31hK8+sOURti6V62wKAf0vSqjjoz5CCxO5ObVSvObSP
         Z/cfjQdL0420Y5iaHk/gg02uzFOqnCmjgaN7khL4XtmsXljrUH+lo0be78B18WmxgmLR
         2IaQ==
X-Gm-Message-State: AOAM531DFISMo+DsaUuymGNHkxPQp2FmmIDgmtgITVL9w208AMDqEd1Z
        i0ZefS2qF8PS/sr3LXdIebg=
X-Google-Smtp-Source: ABdhPJxE8ow3mtYpWhM7SnhvI5FVUz0eZ3lUVLt2j+h9QAoesvIuJ8s68joQgK0MiFu/iKH6Ylg8Xg==
X-Received: by 2002:a63:e709:0:b0:3a9:f988:c595 with SMTP id b9-20020a63e709000000b003a9f988c595mr1625231pgi.435.1650229492245;
        Sun, 17 Apr 2022 14:04:52 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id 137-20020a63078f000000b0039d9c13cd39sm10547711pgh.67.2022.04.17.14.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 14:04:52 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 3/6] arm64: dts: qcom: msm8996: User generic node name for DMA
Date:   Mon, 18 Apr 2022 02:34:33 +0530
Message-Id: <20220417210436.6203-4-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
References: <20220417210436.6203-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom BAM DT spec expects generic DMA controller node name as
"dma-controller" to enable validations.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v3: Add Krzysztof R-b tag
---
v2: No change
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index b9a48cfd760f..c4cfab92a44e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -707,7 +707,7 @@ tsens1: thermal-sensor@4ad000 {
 			#thermal-sensor-cells = <1>;
 		};
 
-		cryptobam: dma@644000 {
+		cryptobam: dma-controller@644000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x00644000 0x24000>;
 			interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

