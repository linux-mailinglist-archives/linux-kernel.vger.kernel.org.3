Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE45348B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiEZCP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiEZCP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:15:58 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516228BD1E;
        Wed, 25 May 2022 19:15:57 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-e5e433d66dso712753fac.5;
        Wed, 25 May 2022 19:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=usvo+LXEy/xvRPmpW3r9809ni4QaGMbq/6uU4Mrt3Wc=;
        b=s8NO9VkrTWhtQftPsro2PY7gg6YrmLzAwUW1hU93karYNL5rRpa5lPKRnrauT61F2s
         Uzfqd538IY3HMPJDh9TN6wzm7R1v54Bh5c6JJ5dltIEpxFMKNVzPEo6KyG2ke3hvOkrL
         yVZyl/ck28eOG7cMwc0TiiGoQV/sDCVQcH4g+own/XfIXi4Voc3Y13KMnl9Q+gwXca+9
         rsJGB5sA8bLG35wPoxaMc1B2JNRJ7zSXmFgRNnEZAVs1kzIFfgWMJWvxOZVtoNmJB/Nk
         IcXIhftDTx3ZHtK+XoTWM0WM+pxiQ5j3okc3gY5e/gMyxsaePFs6tWVU/laDKUjzUU/m
         Gshw==
X-Gm-Message-State: AOAM533Znouyfj4O2VbAhVx0xMSvvWgzyMODeT3FTDH8OsM/oPIDOuh+
        Lt9fGVdXAH268vJ/Jru35A==
X-Google-Smtp-Source: ABdhPJyJ42lvrQ2R5OasaSvQXGmJQx6JB7DGjthc28eqk0R9RBdep4sXbb9VwpmiEcxIFFkIYTzwtw==
X-Received: by 2002:a05:6870:899d:b0:f2:6a4a:ae03 with SMTP id f29-20020a056870899d00b000f26a4aae03mr57614oaq.116.1653531356614;
        Wed, 25 May 2022 19:15:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z15-20020a056870738f00b000f1bc45ba21sm198777oam.14.2022.05.25.19.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:15:56 -0700 (PDT)
Received: (nullmailer pid 2926307 invoked by uid 1000);
        Thu, 26 May 2022 02:15:55 -0000
Date:   Wed, 25 May 2022 21:15:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 6/9] dt-bindings: arm: qcom: add missing MSM8994 board
 compatibles
Message-ID: <20220526021555.GA2926255-robh@kernel.org>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
 <20220520123252.365762-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520123252.365762-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 14:32:49 +0200, Krzysztof Kozlowski wrote:
> Document several board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
