Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD4551C24A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380609AbiEEOYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380599AbiEEOYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:24:15 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD6D193FF;
        Thu,  5 May 2022 07:20:33 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-e2fa360f6dso4344685fac.2;
        Thu, 05 May 2022 07:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vzqz6FgkHgQ8EniUOuNjBHnJzOWW3pdkav0ThtyUQnQ=;
        b=W6HR/Q8tM3f6TP/nZaoIVD4zr+2XAFGqpImpx8c+XUNHur+GjubuEQu2gf/i2F0Jl8
         1/HFyP43lZ3EwqIdhdD3NEQvS1pljyVqIaKyvIq2r+vU3bb38anktCWUQFBejZ4h85yu
         yqZpbRuNe1W1wMJs41MeGmaDnPLfBbNBjvA7vlgvg2V1o5cHBCbmo6yQ2kGVcCruv1c0
         wA9Gn4ZgO0iCkt+zBSmaioaPKZKgKVKqrIbowAVpEce97j+wkQXcsbeYZv00dRaN/qrp
         P0DZxbcLSRN0Z0zbagSN+zltMAAV55Wo7xwrt8dcTHoI0LaxtL4UeQP7CF8Eg6ScyL8+
         PPXA==
X-Gm-Message-State: AOAM5310zDHDYBkbX4SLPRuLHyPtqB6ld6soj+XgJeYf4voeLuQH/zFe
        BlvNGQC5V/dLww3fBoSATfiNnAsNvA==
X-Google-Smtp-Source: ABdhPJz4DlPBVWQONAg4ym9e8yyZQTit7xviSy1h9ZjibUHaV+StsKu9oJeN3tjEUuMO7rc4dVXGHA==
X-Received: by 2002:a05:6870:6097:b0:e1:a94d:9a38 with SMTP id t23-20020a056870609700b000e1a94d9a38mr2381338oae.191.1651760432478;
        Thu, 05 May 2022 07:20:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n20-20020a056870e41400b000e686d1388esm502530oag.40.2022.05.05.07.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:20:31 -0700 (PDT)
Received: (nullmailer pid 3823380 invoked by uid 1000);
        Thu, 05 May 2022 14:20:31 -0000
Date:   Thu, 5 May 2022 09:20:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH 01/13] dt-bindings: soc: qcom: aoss: document
 qcom,sm8450-aoss-qmp
Message-ID: <YnPdLwu5vhCCHDw/@robh.at.kernel.org>
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
 <20220504131923.214367-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504131923.214367-2-krzysztof.kozlowski@linaro.org>
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

On Wed, 04 May 2022 15:19:11 +0200, Krzysztof Kozlowski wrote:
> Add compatible for qcom,sm8450-aoss-qmp with qcom,aoss-qmp as a
> fallback.  This fixes dtbs_check warnings like:
> 
>   sm8450-hdk.dtb: power-controller@c300000: compatible:0: 'qcom,sm8450-aoss-qmp' is not one of
>     ['qcom,sc7180-aoss-qmp', 'qcom,sc7280-aoss-qmp', 'qcom,sc8180x-aoss-qmp', 'qcom,sdm845-aoss-qmp',
>      'qcom,sm6350-aoss-qmp', 'qcom,sm8150-aoss-qmp', 'qcom,sm8250-aoss-qmp', 'qcom,sm8350-aoss-qmp']
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
