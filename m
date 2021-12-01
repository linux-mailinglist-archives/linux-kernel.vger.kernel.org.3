Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF034659E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353792AbhLAXfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:35:23 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:33286 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343755AbhLAXfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:35:21 -0500
Received: by mail-oi1-f175.google.com with SMTP id q25so52039454oiw.0;
        Wed, 01 Dec 2021 15:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7pZzwhXbreD6p1hc3NmKUUGTsNKUInbqDRu810jE210=;
        b=0+Du2VwvSr1B8lrIgl88dzz9xybp5LUuMz8e130nlmQkC+c/28I4hS0pd8Pl/SQqE4
         vjv8X8XN62yyMbz4Af/RGiXuLgqydQ4+eWi3Clfm+yyGCbh/D2cZmuCBetzNkLn4mhfo
         Tfbv2naUpWR5bP1quW8Vu6HdOEpe5ywWcugHUzxW/DsPyHSHA02i8qvaiFTZIA6uqvox
         mv7gT1cAQ5FM6pqjs70pGu9hlhLK4o2XicUmUU01nJSMlSaChWklcYRCR08hdxH9ysAl
         4nDqVe25GpmjSNMRxhRBs3JftRkKjxnORPcty2LMUNz45YfUZu3tZztLXZfj2HVnfunc
         /Xvg==
X-Gm-Message-State: AOAM532DudNNMRf2kDI4QbX3UZ6VV6NrUnXMFPKaZx5dsVWZfdItBLHD
        zAGdbOCoCPOe1KAnmVBl0A==
X-Google-Smtp-Source: ABdhPJwSnxKMhrBthHOXT9LkZdEuqk9hwzgd2f0EOsBoWQBJqpnUbqf/NCKJIcDnHSTYm1wQmzoFAw==
X-Received: by 2002:a05:6808:171b:: with SMTP id bc27mr1460567oib.21.1638401519882;
        Wed, 01 Dec 2021 15:31:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e28sm605537oiy.10.2021.12.01.15.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 15:31:59 -0800 (PST)
Received: (nullmailer pid 3212732 invoked by uid 1000);
        Wed, 01 Dec 2021 23:31:58 -0000
Date:   Wed, 1 Dec 2021 17:31:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alex Bee <knaerzche@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: gpu: mali-bifrost: Allow up to two
 clocks
Message-ID: <YagF7jJD4fvtr2ut@robh.at.kernel.org>
References: <20211126151729.1026566-1-knaerzche@gmail.com>
 <20211126151729.1026566-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126151729.1026566-2-knaerzche@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 04:17:26PM +0100, Alex Bee wrote:
> Commit b681af0bc1cc ("drm: panfrost: add optional bus_clock")
> added an optional bus_clock to support Allwinner H6 T-720 GPU.

That's midgard and this is bifrost... Driver changes are somewhat 
irrelevant.

> Increase the max clock items in the dt-binding to reflect this.
> 
> Bifrost GPU in Rockchip RK3568 SoCs also has a core and a bus clock
> and it gets added here in a (very) similar way it was done for
> allwinner,sun50i-h6-mali compatible in arm,mali-midgard binding.

I guess that one is insufficient.

> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  .../bindings/gpu/arm,mali-bifrost.yaml        | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index 6f98dd55fb4c..2849a7a97d73 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -39,7 +39,14 @@ properties:
>        - const: gpu
>  
>    clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: core
> +      - const: bus
>  
>    mali-supply: true
>  
> @@ -118,6 +125,17 @@ allOf:
>          power-domains:
>            maxItems: 1
>          sram-supply: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3568-mali
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2

           clock-names:
             minItems: 2

> +      required:
> +        - clock-names

       else:
         properties:
           clocks: 
             maxItems: 1

           clock-names: 
             maxItems: 1

>  
>  examples:
>    - |
> -- 
> 2.30.2
> 
> 
