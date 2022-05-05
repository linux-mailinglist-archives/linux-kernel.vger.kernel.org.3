Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30351C25F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380551AbiEEOXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiEEOXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:23:38 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74835A581;
        Thu,  5 May 2022 07:19:59 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id k25-20020a056830169900b00605f215e55dso3006401otr.13;
        Thu, 05 May 2022 07:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DFmU3bB4XPToeXRmwdLwJrVFlyKt5rvtvjjuZuWJjM0=;
        b=ARkgZ0w+t7zvG5RrJk7DvDiKpWRjD4AyLbUefxeADQd8hKAfqYFkWILihyMPoyfisA
         cvpawxzToZ3KZLnswWKLc80Puuyc8gDz7jy+CAZqkFb2bXJU3IqlNo54r6o0uywt+I0s
         uF2yIzd3X16WIf/vafvmywTwUm/X69HoJ6opy/kQBKZdTwzn+JNXyOWGqpXiyJM0+9PT
         wsD4FHEJ4zFR54bVgakIia6gbFLUERgWpgI0itEhSBroOHGoPcAuRF9/E+LdDF5ETndg
         pwGNDrK6RhxnJtYlCCMVg+TGZlfrsMi2E38Y9EGfomVI5tA2jb5uHNRRlGR19w8hgLIF
         rIdw==
X-Gm-Message-State: AOAM532FGdNNqYrlWQBmzTNINPWVXdcQGWtcL84m9PPzquTwRIP+eUyb
        D2rxii5brlDWZOgebYRvkw==
X-Google-Smtp-Source: ABdhPJww82Ke8WD/s2vuFaLiYXbwCJuO8OUCgIhRKNz28znZv+E5dG5ObG4va7gRi4szpcFYNLF9nA==
X-Received: by 2002:a9d:6e83:0:b0:605:4a01:1d8c with SMTP id a3-20020a9d6e83000000b006054a011d8cmr9446080otr.174.1651760398945;
        Thu, 05 May 2022 07:19:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r41-20020a056870582900b000e92295f8acsm543810oap.2.2022.05.05.07.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:19:58 -0700 (PDT)
Received: (nullmailer pid 3822543 invoked by uid 1000);
        Thu, 05 May 2022 14:19:57 -0000
Date:   Thu, 5 May 2022 09:19:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH qcom v2] spi: dt-bindings: qcom,spi-geni-qcom: allow
 three interconnects
Message-ID: <YnPdDY9E2EFoonHK@robh.at.kernel.org>
References: <20220505065233.28476-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505065233.28476-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 05 May 2022 08:52:33 +0200, Krzysztof Kozlowski wrote:
> Recent Qualcomm Geni SPI nodes, e.g. on SM8450, come also with three
> interconnects.  This fixes dtbs_check warnings like:
> 
>   sm8450-qrd.dtb: spi@a98000: interconnects: [[46, 1, 0, 46, 4, 0], [47, 2, 0, 48, 12, 0], [49, 1, 0, 50, 1, 0]] is too long
>   sm8450-qrd.dtb: spi@a98000: interconnect-names: ['qup-core', 'qup-config', 'qup-memory'] is too long
> 
> Fixes: 5bdcae1fe1c5 ("spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Fix for a commit in MSM/Bjorn's tree.
> 
> Changes since v1:
> 1. Correct error msg (Rob).
> ---
>  .../devicetree/bindings/spi/qcom,spi-geni-qcom.yaml          | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
