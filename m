Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D684D57C692
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiGUIjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiGUIjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:39:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F21F7E832
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:39:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 6so1011636pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/BNkggYGO5wbhXNiM6UQj7ulNxqOcTRhO0RLDvuzKM=;
        b=jdCG6+nifZGncJSVnMdZqWcPjB8hTEnufni1x24Oe2zkcR6ptHZNYFJrjGjt5OfhID
         FH9IMr+HFxCZaLnyI2Bky2/JAJNvjn3uFpBEP8luR59eI4vrZNfvUXosVYBL4rsfH7CX
         rxiyS8JXf6tbqMladHEzyG9kguZI0+2IFtbi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/BNkggYGO5wbhXNiM6UQj7ulNxqOcTRhO0RLDvuzKM=;
        b=wtUw7oICOIC5J5sxvds4cCqspcVfdmi3F7zn7TpHlxfk/2LznX+skOsfu5g8pJYD4m
         B7MiW3NpMU7dy/J3DEZL/AtcMeCGcj1TB9G8IiJU3tQPFROWoNwvExw0F9do/PJjzdcf
         xeyZ66Kw3G7P2FsALzmSJNb73Q1Im9wxYlQRbkxsXC/TJCDZrKIEkjYphDIpJvXroAj1
         1KUbFr5c/i+KBbZ8hnjKzsy6vMMgQKMx8WbBbUfdsyhw+23UhSo5v4YMSQMbYgD+Y6wn
         Y+jAfXO394fD3NBFjid+O0OqmISO5uDqoiSFiH3ViT/NXEtue5fn9OpwKS7aEsZ7dZFM
         6Rrg==
X-Gm-Message-State: AJIora9Jb5gTQFfe8u1Z0Njr9WHPEGaVE0P3qCXk3jUp8MQyxkDZr5vA
        rddtsETaV76f9TDVu1fYXCrffg==
X-Google-Smtp-Source: AGRyM1u2dh8hcZHr6mbWIJJwSX9EOohj8nIWfo64hoGPL2tA8Bq50XE9v2BEM8Gz72vRy0bGBjk0GQ==
X-Received: by 2002:a63:1759:0:b0:40d:5aba:4bb0 with SMTP id 25-20020a631759000000b0040d5aba4bb0mr37760805pgx.496.1658392753209;
        Thu, 21 Jul 2022 01:39:13 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903121200b0016cd74e5f87sm1025943plh.240.2022.07.21.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 01:39:12 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v4 3/3] arm64: dts: qcom: sc7280: Include sc7280-herobrine-audio-rt5682.dtsi in herobrine-r1
Date:   Thu, 21 Jul 2022 08:38:49 +0000
Message-Id: <20220721083849.1571744-4-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220721083849.1571744-1-judyhsiao@chromium.org>
References: <20220721083849.1571744-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include sc7280-herobrine-audio-rt5682.dtsi in herobrine-r1
as it uses rt5682 codec.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
index c1647a85a371..98280436813d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-herobrine.dtsi"
+#include "sc7280-herobrine-audio-rt5682.dtsi"
 
 / {
 	model = "Google Herobrine (rev1+)";
-- 
2.37.0.170.g444d1eabd0-goog

