Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CF64EE57E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243590AbiDAAp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiDAApz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:45:55 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E2319322A;
        Thu, 31 Mar 2022 17:44:06 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id q129so1298836oif.4;
        Thu, 31 Mar 2022 17:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RGQN36fupBzgDgpYYq41OYqPsrM7TxMOo2nnd7qf6a8=;
        b=p8qdyAlGldL8eXf2rGLIzU8pK9tPo67FS9Xg4IUR59I0fs0m6+q+skHM4JKmrLKK2+
         U4TOzgIkpZBh88b6NV/NYMzfZnjLW6o4Jrph2zhkUUF4MqM+2btD6lfrSwLTU8tdE41A
         F3izoTIyQR5g2wWDvteZF/lrEpgxzZkQUcLblvGpd54BndBfJS5JHeRTh6+R94qdxLu3
         5oiBEzAJP8terz3LaXjm735mcUybKYw8dQtxTpZ/5ny94rcLmGayb36A+v6mOluVSPef
         4waMRLCWEiI/YOBz6bZAYkD73ezgJ+bTKHNHepS7lVLvHBWS7etefX4uxhjYIqKTMWzO
         hxtQ==
X-Gm-Message-State: AOAM532ysKTeNJoWWcXeqnmJagTo3KZPlOdM9BRkbBGRcpXTrWjPQhA5
        Y0QprwHlhibA+Bqu1EByTA==
X-Google-Smtp-Source: ABdhPJwpD21u4oW/SUSDwMY8sZQu20PgRsvBTHW6LOzRdj1Z6666xBC0UEDvpdjX2iqcai1oRF1siw==
X-Received: by 2002:aca:905:0:b0:2ee:f62a:e08e with SMTP id 5-20020aca0905000000b002eef62ae08emr3656953oij.54.1648773846080;
        Thu, 31 Mar 2022 17:44:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m24-20020a9d73d8000000b005c942e2281dsm500962otk.76.2022.03.31.17.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 17:44:05 -0700 (PDT)
Received: (nullmailer pid 1804134 invoked by uid 1000);
        Fri, 01 Apr 2022 00:44:04 -0000
Date:   Thu, 31 Mar 2022 19:44:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: davinci: list contents of GPIO hogs
Message-ID: <YkZK1OzF5Wq2bDma@robh.at.kernel.org>
References: <20220328191153.171241-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328191153.171241-1-krzysztof.kozlowski@linaro.org>
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

On Mon, Mar 28, 2022 at 09:11:53PM +0200, Krzysztof Kozlowski wrote:
> The hogs children should list allowed properties, otherwise any property
> would be accepted.  Simplify also GPIO hog node name pattern.

Only if 'gpio-hog' is missing, because the gpio-hog.yaml schema will 
check every node with that property.

Hogs are allowed on any GPIO controller, but I don't think we to 
duplicate what's here on every schema.

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/gpio/gpio-davinci.yaml        | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.yaml b/Documentation/devicetree/bindings/gpio/gpio-davinci.yaml
> index f32e09ef937c..e5b91c65dcb0 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-davinci.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.yaml
> @@ -76,12 +76,21 @@ properties:
>      const: 2
>  
>  patternProperties:
> -  "^(.+-hog(-[0-9]+)?)$":
> +  "^.+-hog(-[0-9]+)?$":
>      type: object
> +    properties:
> +      gpio-hog: true
> +      gpios: true
> +      input: true
> +      output-high: true
> +      output-low: true
> +      line-name: true
>  
>      required:
>        - gpio-hog
>  
> +    additionalProperties: false
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.32.0
> 
> 
