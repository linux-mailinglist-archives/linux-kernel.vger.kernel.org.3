Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17F74AF8CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbiBIRxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbiBIRw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:52:59 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C4EC0613C9;
        Wed,  9 Feb 2022 09:53:02 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id q8so3265095oiw.7;
        Wed, 09 Feb 2022 09:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jjLEFWIWQKYzTsSeUGIWjYdkxGer3/xMi2PwBJGGpJ0=;
        b=SLKaBSRvaV5hmebcXedl+ZsEaDXOi1qN5Yq6SVlVAfaOAnzZ/KwpDGH++IDmV87won
         eJveOMgN2eMfmeJDvmwFIocPzvGCTioE2Hx3VmAXgCDrxEqkvjs6AT5muKTHQMT7/P6p
         ZOj64ExFaBOD9F2mggJkRhbSvvxI6CPEEEXBMC0DCymeKQmucD6wX/ZOxE5CgsQUWxA/
         UR8XPk/8opoZGFIzJIOScHmbHQOROJVPrBgr/utsv2KgIAbiYM6TRJOMycFHETJ5suS0
         t65RT/S0b82s4rtHNU5IlTPqNkLUCZlztn+p3QAO5DlCv8TNSJQQH4+6eRNAypfJWVDo
         1O1g==
X-Gm-Message-State: AOAM530bZOPGFAWJDCL9hVw045PVI47ExnKDTc1SjDYH9tDnRwRM2C25
        OGz1q4uZLVNP/v9V0f/jJVz/EPimGw==
X-Google-Smtp-Source: ABdhPJyYraVR9hcwF5D1ZdgFnfaKFpusUnkRjrgrPoeG09rhPI5ujkyyR5lkg6pf8bCg0abLwyG8DQ==
X-Received: by 2002:a05:6808:2196:: with SMTP id be22mr1460341oib.210.1644429181680;
        Wed, 09 Feb 2022 09:53:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n13sm7669693ooj.34.2022.02.09.09.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 09:53:00 -0800 (PST)
Received: (nullmailer pid 587746 invoked by uid 1000);
        Wed, 09 Feb 2022 17:52:59 -0000
Date:   Wed, 9 Feb 2022 11:52:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Alex Bee <knaerzche@gmail.com>, Liang Chen <cl@rock-chips.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5 1/5] dt-bindings: gpu: mali-bifrost: describe clocks
 for the rk356x gpu
Message-ID: <YgP/e29ZPgBW/c05@robh.at.kernel.org>
References: <20220209085110.3588035-1-michael.riesch@wolfvision.net>
 <20220209085110.3588035-2-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209085110.3588035-2-michael.riesch@wolfvision.net>
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

On Wed, Feb 09, 2022 at 09:51:06AM +0100, Michael Riesch wrote:
> From: Alex Bee <knaerzche@gmail.com>
> 
> The Bifrost GPU in Rockchip RK356x SoCs has a core and a bus clock.
> Reflect this in the SoC specific part of the binding.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> [move the changes to the SoC section]
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  .../devicetree/bindings/gpu/arm,mali-bifrost.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index 63a08f3f321d..21409c8d3813 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -159,6 +159,21 @@ allOf:
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
> +        clock-names:
> +          items:
> +           - const: core
> +           - const: bus

Please don't invent new names. We already have 'gpu' and 'bus' defined. 
'core' and 'gpu' sound like the same thing to me, and the h/w doesn't 
have different clocks from vendor to vendor.

Rob
