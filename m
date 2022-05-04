Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA4B51AEF6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377967AbiEDU0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377969AbiEDU0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:26:48 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B7E4F448;
        Wed,  4 May 2022 13:23:11 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id n24so2324138oie.12;
        Wed, 04 May 2022 13:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ySBOubiPulo913haM4WoQ1mv/TU5CEHMQ1toV9XVhMc=;
        b=FCXUdLEbcOxpcjp7ADFVzzL2Gzc4xU1gZLDS/KjuhAimejAP23RYfyfr0XrNcUaWen
         bkoIy8uojZhLQKS5WmbTRQTW6a2qtL1e10vhkQwhLC4ADIvLYIae3lgGw45upQZXuyhP
         6nqxhafn8/W7XBCo07/91jRd6P5B9FKVQRR+KT0WQWTVRHIQRIibvfRTg0Afc7JWISKZ
         zYHncbxKha3ocQJRo6n3GuNwunjQHu3eDc0I60MZUa0wO/IDt55qYSyEVjS9zBomB8hM
         7ClopJjeMCnkJ7HC5JLq2uaBfepzUv4B6KLtW6XVvySbkcBFzGzwoE4W6m5/iTFoFbQE
         W8Aw==
X-Gm-Message-State: AOAM530iV1vlhHpOjEtzE/2q188qJr21NsRXkp1i/keuFMzuYj3xK4Mj
        3HWGC4nz2CVT4jedV8vD1Q==
X-Google-Smtp-Source: ABdhPJzACW6AvH0oEJr8UNPH9HL8vuoKqEyRonyCY12D3tqsWHQUGMaQ5zgSLXG56C5vPug6oW5P/A==
X-Received: by 2002:a05:6808:d48:b0:326:2d1f:1c0f with SMTP id w8-20020a0568080d4800b003262d1f1c0fmr637501oik.43.1651695790838;
        Wed, 04 May 2022 13:23:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o14-20020a0568080f8e00b00325cda1ff8bsm4649538oiw.10.2022.05.04.13.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 13:23:10 -0700 (PDT)
Received: (nullmailer pid 2163645 invoked by uid 1000);
        Wed, 04 May 2022 20:23:09 -0000
Date:   Wed, 4 May 2022 15:23:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: media: rockchip-vpu: Add RK3568 JPEG
 compatible
Message-ID: <YnLgrVJcdkYgNvEO@robh.at.kernel.org>
References: <20220427224438.335327-1-frattaroli.nicolas@gmail.com>
 <20220427224438.335327-2-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427224438.335327-2-frattaroli.nicolas@gmail.com>
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

On Thu, Apr 28, 2022 at 12:44:36AM +0200, Nicolas Frattaroli wrote:
> The RK3568 and RK3566 have a VPU node solely dedicated to JPEG
> encoding. This patch adds a compatible for it, and also allows
> the bindings to only come with a vepu interrupt.

Sounds like this might be more than just JPEG, so I'm assuming this will 
get sent again.
 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> index bacb60a34989..cd62b44c34c3 100644
> --- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> @@ -22,6 +22,7 @@ properties:
>            - rockchip,rk3288-vpu
>            - rockchip,rk3328-vpu
>            - rockchip,rk3399-vpu
> +          - rockchip,rk3568-jpeg-vepu
>            - rockchip,px30-vpu
>        - items:
>            - const: rockchip,rk3188-vpu
> @@ -40,6 +41,7 @@ properties:
>    interrupt-names:
>      oneOf:
>        - const: vdpu
> +      - const: vepu
>        - items:
>            - const: vepu
>            - const: vdpu
> -- 
> 2.36.0
> 
> 
