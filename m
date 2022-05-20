Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F8F52F27A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiETSR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352603AbiETSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:16:47 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B662ED58;
        Fri, 20 May 2022 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1653070572;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=gbY8Ly+SgWvx4lZZsE36qDSwqHJmarMcDOr8/OKncyw=;
    b=Nem9+xzzzTMcUAZqOnUvzds9NC1kY+OKyLcgaKMYV2Kp2B9lsG7mFxUyoBga4tCU6u
    U5ocqOVRrG09Ge8kIEgo6ssfalnXDPz75/vw0dGxlnC/GxkWDPkdHYwfbyOy8HM8ZPQU
    sCyWzIfknd7mJ2VsgjRAbEcDdD5wQvH6HfHLfxFkjWgbuK5eUY4OBOdcEBlX4gAwMiXB
    3lxRCSyWWRqRa6yIwutq+zImC0g1Hdlg8uelQui73Z3EwjpaAPDFn81Mk5qVQbAE6Ms7
    3dtwNe7TVEgaUSc1ESXJ+b80Vu6M8VLSSr53JvBbg3qdQIF3gsqS5wLAT7TsTsN7JKxM
    ZQZQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrK85lg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id 9056edy4KIGBHeP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 20 May 2022 20:16:11 +0200 (CEST)
Date:   Fri, 20 May 2022 20:16:05 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/9] dt-bindings: arm: qcom: fix Alcatel OneTouch Idol 3
 compatibles
Message-ID: <Yofa5et7kd6UpS0C@gerhold.net>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:32:44PM +0200, Krzysztof Kozlowski wrote:
> The MSM8916 Alcatel OneTouch Idol 3 does not use MTP fallbacks in
> compatibles:
> 
>   msm8916-alcatel-idol347.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
>     ['alcatel,idol347', 'qcom,msm8916'] is too short
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: e9dd2f7204ed ("dt-bindings: arm: qcom: Document alcatel,idol347 board")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 5c06d1bfc046..b7dd61df7ec0 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -153,14 +153,13 @@ properties:
>            - const: qcom,msm8974
>  
>        - items:
> -          - enum:
> -              - alcatel,idol347
>            - const: qcom,msm8916-mtp/1
>            - const: qcom,msm8916-mtp
>            - const: qcom,msm8916
>  
>        - items:
>            - enum:
> +              - alcatel,idol347
>                - longcheer,l8150
>                - samsung,a3u-eur
>                - samsung,a5u-eur
> -- 
> 2.32.0
> 
