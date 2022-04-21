Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366AC50A264
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389372AbiDUObX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389314AbiDUOa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:30:28 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA5C3E5F5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:33 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 12so5753981oix.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7Omfp8qxTFOxdaAFMRCs/6HBwzH1tM1JfZpT1G5B5o=;
        b=tfwlqNeY90oUcSGRlCxZtVWtY2iPjpnZ9BVMUrxZcNrPJA7Om9qhN8B0avJXZ2RBZO
         YI7THbzi5gOGv8BX9Ymee8UevMg05FSwSjy/IDBUK4DZ1f7iYIXs5zr8If5zNePd5aHn
         WjXy5gU2+mBcTzugz0WM1Zfw58HSbX4RZao1oBYsdyOLD8tOgcukXvts0c4WcQ2yR/1h
         oXGclqeGAI65bVf+jSXqFoQHP/7aFqZJlErGhVWOBPGjMbV6yGkBttXjyUR0FdXm6mE7
         bZMu1xYZ9srq0DV1GO/LWi2bH9RBECR9LQ43Ss4VLnVR1YcmJDdhGWiUw//7OXPjx/nS
         FeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7Omfp8qxTFOxdaAFMRCs/6HBwzH1tM1JfZpT1G5B5o=;
        b=TVEcdwuifKs6Dlal2spzk8r7jaGMVgrDXtr1dvmREcBtL20ghJcM5EcSRcp/gDKhAq
         vLlTYZHdnjoC+iG1wgBCguD82u5pIRu3Lq81lUk3FVJuZbW+vcdVCs3h9wiri1jPG69G
         0jXqqBATy7yRUox8MR54acqDCHrrnbcCCw4XlTE4IHnLwQ0ozRY0jgvz2DrBbgQFDc15
         3grqv8pxXQmv8miuramfIHhIuPqJMU2DJzDyP6OalmMBly/ulqrPmBQt1Z826Trv3bEG
         LdPWuQQ7qiJXT45PXtjNW8l9ws2Gdg8x93D+VoCV6Suxc3xYQ5/O1FA3oke9IwplqLSM
         z2xA==
X-Gm-Message-State: AOAM533tZAY9WwcOLpPRKdTWdXnk7IXyFADyvvPEtKHV8sy2L/MEMBOO
        l3axN0HH+aTzxWxMlp7TJ555RF/wRg7CN305
X-Google-Smtp-Source: ABdhPJyxHm7q3JV4wpfp91Ur5qj5rZ0BiwRzvn/dy+Dt+2TmEcdfxIVioZ2xOwUrLEeqayOdmc6xdA==
X-Received: by 2002:a05:6808:144f:b0:322:f5ac:b370 with SMTP id x15-20020a056808144f00b00322f5acb370mr13700oiv.120.1650551253101;
        Thu, 21 Apr 2022 07:27:33 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568302a8e00b006054e841915sm4296295otu.73.2022.04.21.07.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:27:32 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 0/7] arm64: dts: qcom: sm8450: Add QUP and DMA nodes
Date:   Thu, 21 Apr 2022 09:27:08 -0500
Message-Id: <165055095990.2574292.3587423704527745863.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220414101630.1189052-1-vkoul@kernel.org>
References: <20220414101630.1189052-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 15:46:23 +0530, Vinod Koul wrote:
> This series adds the gpi_dma nodes followed by the i2c and spi nodes for the
> three qups found in the SM8450 SoC.
> 
> While at it, iommus was missing for qup0/qup1, so fix that up too.
> 
> Lastly enable the spi and i2c nodes found on the QRD board.
> 
> [...]

Applied, thanks!

[1/7] arm64: dts: qcom: sm8450: Add gpi_dma nodes
      commit: b9c8433083097327cad19fbf633fb0735a008315
[2/7] arm64: dts: qcom: sm8450: Fix missing iommus for qup
      commit: 488922c1a372579bf2caf40933e7459e3c86276f
[3/7] arm64: dts: qcom: sm8450: Add qup nodes for qup0
      commit: a84e88e9a00334f1468a9f69a77091dbe80b7a3b
[4/7] arm64: dts: qcom: sm8450: Add qup nodes for qup1
      commit: 1a380216fd6fcf7135b2b413bb9431fc98e2fa23
[5/7] arm64: dts: qcom: sm8450: Add qup nodes for qup2
      commit: ba640cd31342b45dcf2f95f6ca7dcbc46629919f
[6/7] arm64: dts: qcom: sm8450: Fix missing iommus for qup1
      commit: 67ebdc6dd1e2049fd9620f0572bc81a809afbe24
[7/7] arm64: dts: qcom: sm8450-qrd: Enable spi and i2c nodes
      commit: d953239726e971ecaee45d86b4bcd605be839b2a

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
