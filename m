Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3297650A239
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389215AbiDUOaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388988AbiDUOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:30:01 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2373CA4B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:10 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so5536505fac.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgLvbeMn2iDNegBocEklYCDXrN23lnjAntKQ7pZtu0I=;
        b=mqxut536y9YX4W3RhwhcaWtdJdPhGnTR19Mm7vxf926tWT25Vs6yt//6m7Pm3pU+E7
         OzFE8cb8sm2BVpfpoINJ+1ZGyDYv+W6Jg5PDQ4L8LeI5XiQ8j87dhc7ASj8nhAA00RWS
         8qWjt32itz8IzVu52yEsg3w4//zX1CoPJj6hB5aPCceT0paHRUuhrR+nD8+YLXqPUcm6
         MPaemLrLtIlvsOf+OcjH2WYEBhu37N/IIWlm/c8nlAUnnONsDeCRQWfL4dgSfpTO9TuP
         lCg5FlYfJ1A6LUzX1MF5fXZVkvtc3MS3VGq9Vi9cbUxq7RkCku4jOcND5TDnrdMO5H9A
         L2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgLvbeMn2iDNegBocEklYCDXrN23lnjAntKQ7pZtu0I=;
        b=QbWtCur3fu0Z+lo5VPMunccCwcmLNEggMcn5xlUz97TTyXvfZUki7ONQSY2FbuRnaz
         qRmFefN9avPQKd43zmw1fWZISQTYcadDgm8xWy4oMtM7EljVyOQATcpD0TGgbjpyGAjk
         IQg+neYjAPA/Vblpz1wgVbAzxJ/wOnIiY8fb3rKyXVkxse/NZf8bJyAeoLEz2XyCB0Bg
         G1kRKQ6uD0AREFpe2Js2K8jlySxutMKmy09LkIivUkFdlh6mAraco0C/+JNvnyDZpKDk
         KAWDAy1l71A1bspc7P1na4OoJepI2GdCRzFHXh2eKkdzeZbGwMqELxnJMU+GiCAIGvWW
         HDxQ==
X-Gm-Message-State: AOAM5324Zrjz7ScbKJt2Abjq0xUBpaS8qH6hHbiXLLT+noHsmYx+8TuM
        3YNPxuETurrjOp3zhV/at+BKog==
X-Google-Smtp-Source: ABdhPJyP4ZFs4mDUywPisM57Go2GbRof6cWBdKQGkkjX+0upz8VVSL7Mf4nYeQJQiUNgThzT8wikBw==
X-Received: by 2002:a05:6870:304e:b0:dd:ed4f:10a6 with SMTP id u14-20020a056870304e00b000dded4f10a6mr4103763oau.28.1650551229597;
        Thu, 21 Apr 2022 07:27:09 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568302a8e00b006054e841915sm4296295otu.73.2022.04.21.07.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:27:08 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8350: Define GPI DMA engines
Date:   Thu, 21 Apr 2022 09:26:48 -0500
Message-Id: <165055095990.2574292.211638944498065102.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220412215137.2385831-1-bjorn.andersson@linaro.org>
References: <20220412215137.2385831-1-bjorn.andersson@linaro.org>
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

On Tue, 12 Apr 2022 14:51:35 -0700, Bjorn Andersson wrote:
> The Qualcomm SM8350 has three GPI DMA engines, add definitions for
> these.
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sm8350: Define GPI DMA engines
      commit: bc08fbf49bc87e7613717e41674303905a9934fc
[2/3] arm64: dts: qcom: sm8350: Add GENI I2C/SPI DMA channels
      commit: ddc97e7d1765cb2bf6089e211dae8e0b63cb3892
[3/3] arm64: dts: qcom: sm8350-hdk: Enable &gpi_dma1
      commit: 83b8347a858d06f7d070663cc3898215d3d299a0

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
