Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8FE52C2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241761AbiERTBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241739AbiERTBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:01:43 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40416172;
        Wed, 18 May 2022 12:01:41 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id v65so3782892oig.10;
        Wed, 18 May 2022 12:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W1XfWqeHpHGKyhVP3IjfibSa08w3m2F+W7eDqY4BJWk=;
        b=V/Yev3t0+beAmlOxWv0ychQV7VG8yI/ylThTnBcZANR85FtqbOyCOft6Xl3h8J5+ny
         W8V713iSU2Mcv8CK8ldkTfacqbcTzoRz0pMijY+Fd0N4Q5uig9Bz7EneHcRG2P0jkfyt
         RuWZWOGFMjw80ZfLZA6bFFqImT28xhA5eoouYL/2dT3UPaiMRv3xWJu2KjyPK5Le9bG8
         gyP4rONH2z3K3YKokzc/mKgema+GAkkQjbg5vswgnAQS8ST5u++F6XcmCisx+TYkEBZ/
         196M0/uCj/rMv8MoKRZgmGUvOJe0L0jQYP9OodLmKSjLyBNU5FqBY9YSu+7hj0rIO7OX
         y2ew==
X-Gm-Message-State: AOAM533O6O5KrZNn2YsOzJ8eRaXwxci5aR0i3qrP+mgVCi4pfr0y7bx2
        o0LTD6sia5xlmLa9n4xRBA==
X-Google-Smtp-Source: ABdhPJx3AzWeH2RaB6ps124qilIE5vWBwX7O/ALy20cDqO3YYIi/EaVezZ+64QB+NVsfp9WTsgjsUw==
X-Received: by 2002:a05:6808:f08:b0:327:d194:cfa4 with SMTP id m8-20020a0568080f0800b00327d194cfa4mr659065oiw.158.1652900500974;
        Wed, 18 May 2022 12:01:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j7-20020a4a92c7000000b0035eb4e5a6b8sm1237331ooh.14.2022.05.18.12.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:01:40 -0700 (PDT)
Received: (nullmailer pid 3699883 invoked by uid 1000);
        Wed, 18 May 2022 19:01:39 -0000
Date:   Wed, 18 May 2022 14:01:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     max.krummenacher@toradex.com, Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/17] Revert "ARM: dts: imx6qdl-apalis: Avoid
 underscore in node name"
Message-ID: <20220518190139.GB3685644-robh@kernel.org>
References: <20220516115846.58328-1-max.oss.09@gmail.com>
 <20220516115846.58328-3-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516115846.58328-3-max.oss.09@gmail.com>
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

On Mon, May 16, 2022 at 01:58:30PM +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> The STMPE MFD device binding requires the child node to have a fixed
> name, i.e. with '_', not '-'. Otherwise the stmpe_adc, stmpe_touchscreen
> drivers will not be probed.
> 
> Fixes: 56086b5e804f ("ARM: dts: imx6qdl-apalis: Avoid underscore in node name")
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> ---
> 
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index bd763bae596b..da919d0544a8 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -315,7 +315,7 @@
>  		/* ADC conversion time: 80 clocks */
>  		st,sample-time = <4>;
>  
> -		stmpe_touchscreen: stmpe-touchscreen {
> +		stmpe_touchscreen: stmpe_touchscreen {

In any case, the correct name would have been 'touchscreen' and 'adc'.

>  			compatible = "st,stmpe-ts";
>  			/* 8 sample average control */
>  			st,ave-ctrl = <3>;
> @@ -332,7 +332,7 @@
>  			st,touch-det-delay = <5>;
>  		};
>  
> -		stmpe_adc: stmpe-adc {
> +		stmpe_adc: stmpe_adc {
>  			compatible = "st,stmpe-adc";
>  			/* forbid to use ADC channels 3-0 (touch) */
>  			st,norequest-mask = <0x0F>;
> -- 
> 2.20.1
> 
