Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673CD5348AC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbiEZCPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiEZCPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:15:07 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786188BD1E;
        Wed, 25 May 2022 19:15:05 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id v66so703431oib.3;
        Wed, 25 May 2022 19:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dS7BGICfJRdN0Dp6ljA4hc836kJO+DBbe/QeceHATOQ=;
        b=rC1Up9p6g6Nq7auqVjefmV9oPZTGf53HMwOZy+RNi6Ex61kCeZahvf7Gd2YInXNkCF
         Is7DKg8DuKznYfNoo0EJmBRmu+qGDRM8PIqqWaO/UjaR0TGnF6k0KFXdhgsYC5haEv2X
         k5JGcCbeZlDqvtJMaiFncm1fVJOPiyR6fuSPI6yXPabY1JBJOaLPplWsp6FK1yUW0byq
         BvN9egxfKnYTHNjdR9anCwaVCGk3c4xYi29H9Wxzng1h5idCvs+nD8skTSC3ZmFCQbpr
         oOlnQSiZPuCcVemzVYK2ibzAODxMn5OgGc9rgfP7T2bxko3UAD1/CBgyEBtgYt80rLXd
         Q6Xw==
X-Gm-Message-State: AOAM530hmY+fdX3ElXdHl9AR4dPDB6NqJFBqQuiudMpjV5iVKipJ2pel
        5bcd/h9F+wKZKjG3QJJBoaK3GVUyHw==
X-Google-Smtp-Source: ABdhPJw+utf7ninoh0FppE1cApjPRHRmvfHDBcouXgEiUIZj7vbjFQ++d4nEkaNLvSaX4Q97GhrC6A==
X-Received: by 2002:aca:f056:0:b0:32b:887:bf35 with SMTP id o83-20020acaf056000000b0032b0887bf35mr50250oih.98.1653531304698;
        Wed, 25 May 2022 19:15:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 123-20020aca0781000000b00328e70cae5csm205315oih.43.2022.05.25.19.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:15:04 -0700 (PDT)
Received: (nullmailer pid 2924813 invoked by uid 1000);
        Thu, 26 May 2022 02:15:03 -0000
Date:   Wed, 25 May 2022 21:15:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] dt-bindings: arm: qcom: fix MSM8916 MTP compatibles
Message-ID: <20220526021503.GA2924760-robh@kernel.org>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
 <20220520123252.365762-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520123252.365762-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 14:32:46 +0200, Krzysztof Kozlowski wrote:
> The order of compatibles for MSM8916 MTP board is different:
> 
>   msm8916-mtp.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
>     ['qcom,msm8916-mtp', 'qcom,msm8916-mtp/1', 'qcom,msm8916'] is too long
> 
> Fixes: 9d3ef77fe568 ("dt-bindings: arm: Convert QCom board/soc bindings to json-schema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
