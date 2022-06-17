Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1285500B8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383674AbiFQXZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383500AbiFQXZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:25:31 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523AC6622C;
        Fri, 17 Jun 2022 16:25:30 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id d123so5950230iof.10;
        Fri, 17 Jun 2022 16:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9t+RTHlMGnTIMzkuniBS/cRBo0RFDQfHVRvCE6rQ+lk=;
        b=X6LTPLMQXynsJcmZMfGkHSUrCM3jSqb1WWTT4wXY8cOBmG2A7S5sqYNuwJOilMIfbO
         9lV4FDOQnxQVDfIH5NpcLALZWfngVsdfsKOyS6MqUYjaT1NUw+eNNWx8EbQdepnuoiCy
         C18KZjfkRzpd/5umWw1xqSdWcvvKQDGpVXn1tZbToHPnp3s0ClVeThMq88TUVcMLlxra
         ziTA/BcNQth5QG3Qq1/eXrLoXoId4mTNWgzhE6fq3q0M5wEqrDxrRWVz3sHOdniZdxw/
         ZlktRSW/QBZsi2UUscRlrCIJrWlmWFCUoCc+hGDfhlIEwotIqwIUxtr2avoWx/OLXkAQ
         eLuQ==
X-Gm-Message-State: AJIora/a4uBAxVrnpxLFcsGW++XGGOril9RxGYZ48xxB9M/yECfNL83N
        UnVegHUYsC1zwYH7w1+vcg==
X-Google-Smtp-Source: AGRyM1vv8dGfZ8d6eH4xBrD0ZZY9f3vkhZfNHWKMYkfzEMy6bJj+y3ZJxm4fbfo0jwgLRRJDIs3GWg==
X-Received: by 2002:a05:6638:481c:b0:336:2f15:70fc with SMTP id cp28-20020a056638481c00b003362f1570fcmr3976515jab.163.1655508329524;
        Fri, 17 Jun 2022 16:25:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id o2-20020a6bbe02000000b00669de60a268sm3128595iof.21.2022.06.17.16.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 16:25:29 -0700 (PDT)
Received: (nullmailer pid 2632617 invoked by uid 1000);
        Fri, 17 Jun 2022 23:25:28 -0000
Date:   Fri, 17 Jun 2022 17:25:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] dt-bindings: display: delete ilitek,ili9341.txt
Message-ID: <20220617232528.GA2628998-robh@kernel.org>
References: <20220617213706.376730-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617213706.376730-1-mail@conchuod.ie>
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

On Fri, Jun 17, 2022 at 10:37:07PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> ilitek,ili9341.txt was replaced by ilitek,ili9341.yaml but the txt

panel/ilitek,ili9341.yaml


> binding was not deleted. Do so.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/display/ilitek,ili9341.txt       | 27 -------------------
>  1 file changed, 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9341.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/ilitek,ili9341.txt b/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
> deleted file mode 100644
> index 169b32e4ee4e..000000000000
> --- a/Documentation/devicetree/bindings/display/ilitek,ili9341.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -Ilitek ILI9341 display panels
> -
> -This binding is for display panels using an Ilitek ILI9341 controller in SPI
> -mode.
> -
> -Required properties:
> -- compatible:	"adafruit,yx240qv29", "ilitek,ili9341"

"adafruit,yx240qv29" is not in the schema.

> -- dc-gpios:	D/C pin
> -- reset-gpios:	Reset pin

Neither is this. It is in panel-common.yaml, but 'unevaluatedProperties' 
needs to be used instead to allow it. Or add 'reset-gpios: true'.

> -
> -The node for this driver must be a child node of a SPI controller, hence
> -all mandatory properties described in ../spi/spi-bus.txt must be specified.
> -
> -Optional properties:
> -- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)
> -- backlight:	phandle of the backlight device attached to the panel
> -
> -Example:
> -	display@0{
> -		compatible = "adafruit,yx240qv29", "ilitek,ili9341";
> -		reg = <0>;
> -		spi-max-frequency = <32000000>;
> -		dc-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
> -		reset-gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
> -		rotation = <270>;
> -		backlight = <&backlight>;
> -	};
> -- 
> 2.36.1
> 
> 
