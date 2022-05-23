Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDB5531DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiEWVfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiEWVfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:35:32 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B71AFAD7;
        Mon, 23 May 2022 14:35:31 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-d39f741ba0so20013131fac.13;
        Mon, 23 May 2022 14:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=21fVV3K7uR7kIMeuvkJxyKGEyMab9A5XAQ8v8L7cvv4=;
        b=eu9nDFIX18d7InxX+E0CGet12dDNih81CbLIorPSea3rJZ2kFCHjUaJ3Amos22nMaa
         rXz9ZkgpgXHLSNv95zroLUWeiU+MPyXoS8SafSpaJwVjciQEQuovUhEbFdr0xDFN3iKl
         5nnCnoJZAWs1NLB39NhP++Lg679LspG+WXmUGzfUHfl9PkBwRU/KKOwlwtsNAXGhtJl+
         Dp/aKbAjATrRgv1NB9yqvx3h1MVqiUeqZFnLlT3sGXz/hCMB6yowi0coCUyeTUuI1MAb
         gH3De4jzKNoJXbpjvTUy3mTGFmS/KD2iKtA1R/T17IGqmCgW7ff6G97tQwvUUVMVnLGg
         PSKQ==
X-Gm-Message-State: AOAM530Nvo7qYdABJpwf6lzRIYwYTWyTbW6Tl/tIYjC1fHUOBPAKSoQu
        JZwua1dxLWLalU6V5in4AQ==
X-Google-Smtp-Source: ABdhPJz51kKeyTgJE1T6i86x5hCXYv2n1s+1kgWg51kba8nF+s/Dc2URwpsMdwdyiYNp7Tn9pQlERA==
X-Received: by 2002:a05:6870:9106:b0:f2:8c7c:edbe with SMTP id o6-20020a056870910600b000f28c7cedbemr613044oae.277.1653341729967;
        Mon, 23 May 2022 14:35:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d130-20020a4a5288000000b0035eb4e5a6besm4710618oob.20.2022.05.23.14.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 14:35:29 -0700 (PDT)
Received: (nullmailer pid 2231067 invoked by uid 1000);
        Mon, 23 May 2022 21:35:28 -0000
Date:   Mon, 23 May 2022 16:35:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH 1/2] dt-bindings: leds: lp50xx: correct reg/unit
 addresses in example
Message-ID: <20220523213528.GA2227380-robh@kernel.org>
References: <20220518082215.14358-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518082215.14358-1-krzysztof.kozlowski@linaro.org>
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

On Wed, May 18, 2022 at 10:22:14AM +0200, Krzysztof Kozlowski wrote:
> The multi-led node defined address/size cells, so it intended to have
> children with unit addresses.
> 
> The second multi-led's reg property defined three LED indexes within one
> reg item, which is not correct - these are three separate items.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Kyle Swenson <kyle.swenson@est.tech>
> ---
>  .../devicetree/bindings/leds/leds-lp50xx.yaml | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
> index f12fe5b53f30..dc1ac905bb91 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
> @@ -99,35 +99,41 @@ examples:
>                 color = <LED_COLOR_ID_RGB>;
>                 function = LED_FUNCTION_CHARGING;
>  
> -               led-0 {
> +               led@0 {
> +                   reg = <0x0>;
>                     color = <LED_COLOR_ID_RED>;
>                 };
>  
> -               led-1 {
> +               led@1 {
> +                   reg = <0x1>;
>                     color = <LED_COLOR_ID_GREEN>;
>                 };
>  
> -               led-2 {
> +               led@2 {
> +                   reg = <0x2>;
>                     color = <LED_COLOR_ID_BLUE>;
>                 };
>            };
>  
>            multi-led@2 {
>              #address-cells = <1>;
> -            #size-cells = <2>;
> -            reg = <0x2 0x3 0x5>;
> +            #size-cells = <0>;
> +            reg = <0x3>, <0x4>, <0x5>;

The unit-address is 2, but the reg value is 3?

>              color = <LED_COLOR_ID_RGB>;
>              function = LED_FUNCTION_STANDBY;
>  
> -            led-6 {
> +            led@3 {
> +              reg = <0x3>;
>                color = <LED_COLOR_ID_RED>;
>              };
>  
> -            led-7 {
> +            led@4 {
> +              reg = <0x4>;
>                color = <LED_COLOR_ID_GREEN>;
>              };
>  
> -            led-8 {
> +            led@5 {
> +              reg = <0x5>;
>                color = <LED_COLOR_ID_BLUE>;
>              };
>           };
> -- 
> 2.32.0
> 
> 
