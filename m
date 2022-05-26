Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD0B5348A9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345996AbiEZCOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiEZCOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:14:50 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2B58BD0A;
        Wed, 25 May 2022 19:14:49 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 30-20020a9d0121000000b0060ae97b9967so163664otu.7;
        Wed, 25 May 2022 19:14:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dDKX+/BdbRuLFtge+Rxgi/kO4PBd/fnwdG8MGjWqIAo=;
        b=ea8DQ/8ME6IMhSmVXVNBUuAo91hgliB/k6dA+6tkksXyIKRB1vR4ZeR1Ol5cz6vX0i
         yVGe3MN8okKjPH+oeVlwXOtxpiNVuQ2wQWJ2ZWb8tSTGhV6gUEhG/zU3BP9HnXT8DrfJ
         fGk9MAoz8fogn9p7pZHs8rj3sIS2+vr4Q0qWduUiUpqFDWEQhi42LZk482Yhf4b/96jr
         xs0/4AmRDb17aiV6M6Q0cAXUt1N0gdO3TmeBfvFENg+SD71pRkCl3vKWPLyLkAhCPtaS
         CaJTzpDXf5Ra8xnA7fkjA++IDD9oub6Jmf7t4OhThD/HQihhBF4SucOw+X3EPy0g9Lnr
         0OBg==
X-Gm-Message-State: AOAM530yHOy++0j5THxFR0Y2oBeEwYXLFq9T3gMV9R3657aanPcS+oo9
        AGDs99SGgZllbtjWAAzdyQ==
X-Google-Smtp-Source: ABdhPJzrV6lu09/fzopU732wrL1+JsL7HKq89LHRIlx7MpsxQEo0E5YY0593lGg2Cb3EC31jGgzMlw==
X-Received: by 2002:a05:6830:2472:b0:60b:1150:5cfc with SMTP id x50-20020a056830247200b0060b11505cfcmr7609235otr.242.1653531287586;
        Wed, 25 May 2022 19:14:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t192-20020acaaac9000000b00325cda1ffa6sm216036oie.37.2022.05.25.19.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:14:46 -0700 (PDT)
Received: (nullmailer pid 2924288 invoked by uid 1000);
        Thu, 26 May 2022 02:14:45 -0000
Date:   Wed, 25 May 2022 21:14:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 2/9] dt-bindings: arm: qcom: fix Longcheer L8150
 compatibles
Message-ID: <20220526021445.GA2924255-robh@kernel.org>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
 <20220520123252.365762-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520123252.365762-2-krzysztof.kozlowski@linaro.org>
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

On Fri, 20 May 2022 14:32:45 +0200, Krzysztof Kozlowski wrote:
> The MSM8916 Longcheer L8150 uses a fallback in compatible:
> 
>   msm8916-longcheer-l8150.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
>     ['longcheer,l8150', 'qcom,msm8916-v1-qrd/9-v1', 'qcom,msm8916'] is too long
> 
> Fixes: b72160fa886d ("dt-bindings: qcom: Document bindings for new MSM8916 devices")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
