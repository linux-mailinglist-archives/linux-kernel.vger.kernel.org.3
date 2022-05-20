Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4969A52F27E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352694AbiETSSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352647AbiETSSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:18:06 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F55703E8;
        Fri, 20 May 2022 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1653070635;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ahWdEMbl1ITjRZGu9zLhkJoGFwL7yRoh+iDJtNVABwI=;
    b=noTyiePXuYCD11EpccYfjq1PJy68bWghUPDvE1hxhH17zYSNr9d1+UIsyutGOcoXIq
    rHDitvgGwJ0593QqsSzdwZ7paTXIcp9ND58C2TXoHiUpAr9yENMEGxlr+2aRbYj5otlZ
    pMSEuwxJ3qe1w4quzBW/5Z0tMLrduIVC+FURBaGJvwsqVUWPygEEtymsufDwUz24XQzF
    HvPd7rzDJEEV0jfwSL54knGoIQ6tQHqwQJBlMjesWbwPXuOAICgmRnC9zh/+eMs0RWuo
    q81bQfa4pgcYB8+HHOf0SDtMfq5S7BcAphEkTZQQyHt/Vjo/3repiwkBuvOYeqkPisKC
    oGyg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrK85lg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id 9056edy4KIHFHeW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 20 May 2022 20:17:15 +0200 (CEST)
Date:   Fri, 20 May 2022 20:17:13 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] dt-bindings: arm: qcom: fix Longcheer L8150
 compatibles
Message-ID: <YofbFnl0dZ6MheNQ@gerhold.net>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
 <20220520123252.365762-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520123252.365762-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:32:45PM +0200, Krzysztof Kozlowski wrote:
> The MSM8916 Longcheer L8150 uses a fallback in compatible:
> 
>   msm8916-longcheer-l8150.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
>     ['longcheer,l8150', 'qcom,msm8916-v1-qrd/9-v1', 'qcom,msm8916'] is too long
> 
> Fixes: b72160fa886d ("dt-bindings: qcom: Document bindings for new MSM8916 devices")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index b7dd61df7ec0..e15012035093 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -160,11 +160,15 @@ properties:
>        - items:
>            - enum:
>                - alcatel,idol347
> -              - longcheer,l8150
>                - samsung,a3u-eur
>                - samsung,a5u-eur
>            - const: qcom,msm8916
>  
> +      - items:
> +          - const: longcheer,l8150
> +          - const: qcom,msm8916-v1-qrd/9-v1
> +          - const: qcom,msm8916
> +
>        - items:
>            - enum:
>                - sony,karin_windy
> -- 
> 2.32.0
> 
