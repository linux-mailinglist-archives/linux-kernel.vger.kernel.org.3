Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543764941C8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244751AbiASUcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357339AbiASUcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:32:14 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E57C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:32:14 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so2697116pju.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwsflDgvI505/t3UhW0BwfP38dYCTKy65mKeXmMyTyw=;
        b=RLT9d9TpGUOWh5DKrG8VAcsEP0GmJ1cgSg7Qw/D4EvELZej0kEMIItMUJ5E6/+5wrY
         EpdaGYCsx4dC4xZhFV+O5Py3WA3WWxYn+izdFo4jFN3qAiolyQpOyjgCw/nGG/czXYZM
         JuoEGKpr4DPXqpIik/ApT2mmbNdJ7LZjTJGjMybPjW2tF+IW0lKv04xBSkXiJC9uTfGP
         HHMy4oTyehA3Ib+3FK3Yss09UVgUmZzTmM4hiacw6QWKh7oQTbf3NK180jSmGQt2RO3a
         dSTNd08Tk3TxXaGoIDPQLviU0Qw507CW/qY2pvC+OEEz7GGKW2XdSx3qeIcLosBHkBTW
         sWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwsflDgvI505/t3UhW0BwfP38dYCTKy65mKeXmMyTyw=;
        b=GC1y5EFURXwCNaEJahh6mulgV3sNxAhgLm3sHjB8R4W8kIzcbHO+0fzDZ7HoCwlGyi
         FPAuHw0MjMZe/deZ3p32dm/blU0UX8mSgqNee+hkrs/j5JJA/ClP1hjW6x2CbTIgNbc0
         AfRm3xEIpHNr82WMbDg4ri3q07AaAdjrQNg9mDUasRTHm9aXLTqFXZxSOjG5t6molsyC
         XDv12+gMvuHof5Ur0ixof8ypO6eMWz5OGuk9504GEg7aHBPbZSvSOIQR2IUXVD+7wqu9
         ZbbYbJKYqIy5vi4QIxng3q0j08zfrWUC9fMYLkw5x+/awa0PjUwfQzri2DLI6qKYMb7I
         rlpg==
X-Gm-Message-State: AOAM530+E2fQaffrSqmOHcnUd3Duha8ua5OwMur+VyqJt9zAtjIG+fUz
        vTHiurZJGdskXVvc5HCqb+A84A==
X-Google-Smtp-Source: ABdhPJzR8RsGmSCP59KaXeZcZ2RONSqBSLHC6zlef0+G3rfVJ/fwAIQeOopH8GykNFFpCffKXvN7fA==
X-Received: by 2002:a17:903:32c2:b0:14a:2099:eb38 with SMTP id i2-20020a17090332c200b0014a2099eb38mr34751945plr.58.1642624334053;
        Wed, 19 Jan 2022 12:32:14 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1f3a:47e5:8bff:a3f8:a494:acd0])
        by smtp.gmail.com with ESMTPSA id x13sm6807552pjq.43.2022.01.19.12.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 12:32:13 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, bjorn.andersson@linaro.org,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 3/4] arm64: dts: qcom: sm8150: Add pdc interrupt controller node
Date:   Thu, 20 Jan 2022 02:01:32 +0530
Message-Id: <20220119203133.467264-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220119203133.467264-1-bhupesh.sharma@linaro.org>
References: <20220119203133.467264-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pdc interrupt controller for sm8150.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 6012322a5984..cc4dc11b2585 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1626,6 +1626,16 @@ system-cache-controller@9200000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,sm8150-pdc", "qcom,pdc";
+			reg = <0 0x0b220000 0 0x400>, <0 0x17c000f0 0 0x60>;
+			qcom,pdc-ranges = <0 480 94>, <94 609 31>,
+					  <125 63 1>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sm8150-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
-- 
2.33.1

