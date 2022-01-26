Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C0049D533
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiAZWSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbiAZWST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:18:19 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B18C061755
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:18:16 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i30so916844pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ltUaf0P7+L7T6ZQurZSqM5no7v9v1dUYJbr17H6OFeE=;
        b=GLR7jiNk80+lc4ufxK9ZhAJsn9m6eraXUlEp18njsVAZbtmEBA9ZVPorH4qskiDTKi
         D49Ia7LJjcm+1/cWDCogGbroN9YMoMQa7fqe6q57AZOsVeDVaEc9eqVhkkHXdLhw1Ib4
         MfC5zBCeq7jIOynF0qwsduKkks7qL0qV45zn+iDwVAI3TkZcxHGic3qdCQnjibiGe6nd
         1bAQzLBM4jlf4QNWUPjhdG0ivNe7CVkt8pKeNvBVE9WnCL2T4l2mz9FgtPByQ6K7KhTv
         SEO3fzBiqupq03OzQwGdVaOi5X1WOepZIqYBfQimPhl5oFPEmliH0niHEtr/QEUJ70XQ
         pQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ltUaf0P7+L7T6ZQurZSqM5no7v9v1dUYJbr17H6OFeE=;
        b=6Q5YQBrTezrc8gv+rWp8hrQpoY6/fuU5bj8ll1VnsjK377AVSkmu/oQ/fO6qUoOuAr
         aab78bXtm8bOG3AVvFKvHVrrx/caNC5GN937bgjqNmA0xJp1TjCFDUfYKjs49/ylnIXX
         FN7hf5Bp2WowW2OmdGHwpC9oSENbOhEeyYjYIqbFKr/rgu8YdDMDlMCcJ9PLvjMjGrUb
         elqbRYzAow+bvRIvirrw3XkBTc9hCy0lVlUkext6GtTBrOhYuiAgbwsC1C9Ra2LVOrBI
         cldZ8aDMrfI4z9cVjEksp/idHw6NzgDOxt618MLxSOJ6sGyyPBXZJ02qtKeFaiaMhOue
         gmXQ==
X-Gm-Message-State: AOAM533qg5YdsR6BhOi0v00Kby08oo3qJ14bT6fthGNV/bo/J8w0bfTA
        KoF67ovvl67L7icm2WIAMuStyA==
X-Google-Smtp-Source: ABdhPJxB/gBmtmXsdGO6QIYNImm7PodEODZA1vSH9IXF5Dp/PLfyDkrfYVGRyE3evUCvjsvT3Y6LxQ==
X-Received: by 2002:a63:6c43:: with SMTP id h64mr700027pgc.120.1643235496462;
        Wed, 26 Jan 2022 14:18:16 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1f3a:4e9b:8fa7:36dc:a805:c73f])
        by smtp.gmail.com with ESMTPSA id t17sm4233742pgm.69.2022.01.26.14.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 14:18:16 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, agross@kernel.org, sboyd@kernel.org,
        tdas@codeaurora.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, bjorn.andersson@linaro.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 1/8] dt-bindings: net: qcom,ethqos: Document SM8150 SoC compatible
Date:   Thu, 27 Jan 2022 03:47:18 +0530
Message-Id: <20220126221725.710167-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126221725.710167-1-bhupesh.sharma@linaro.org>
References: <20220126221725.710167-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

SM8150 has a ethernet controller and needs a different configuration so
add a new compatible for this

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/net/qcom,ethqos.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.txt b/Documentation/devicetree/bindings/net/qcom,ethqos.txt
index fcf5035810b5..1f5746849a71 100644
--- a/Documentation/devicetree/bindings/net/qcom,ethqos.txt
+++ b/Documentation/devicetree/bindings/net/qcom,ethqos.txt
@@ -7,7 +7,9 @@ This device has following properties:
 
 Required properties:
 
-- compatible: Should be qcom,qcs404-ethqos"
+- compatible: Should be one of:
+		"qcom,qcs404-ethqos"
+		"qcom,sm8150-ethqos"
 
 - reg: Address and length of the register set for the device
 
-- 
2.34.1

