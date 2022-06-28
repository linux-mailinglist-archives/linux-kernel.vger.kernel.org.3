Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6755EF14
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiF1UPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiF1UPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:15:19 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F933DA4A;
        Tue, 28 Jun 2022 13:09:41 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id s17so13992394iob.7;
        Tue, 28 Jun 2022 13:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SDJBY+ZeASoeM7vQn8Id3dYSLfSmtbet8rA42TclzBk=;
        b=MlFcdkDp0fhPf85zCJm5TCjoGAdpK8rePwJLDeR6bBj23GSzpgAYgJeDBgfNkb7ziv
         Ux9ro0DufJ97SWPTr/uXhuFe2oWHQLzkP+dyK07cxTGsrCAlF1F73M+p/d2aqmQgl1FL
         1oUohFZpFg1mrk71gVJeCal0LCH7/6fsca/oZdMGvnvLFj7AuVwcqQQkr2a4lnFS0/48
         KLIS5yjq/32aJhReupOx9oMbeqo7pK37K/q6VNNHUku61enBUFJCRKYUr1dqaBLgRjoP
         hZbwUsws760RgWkXGYAZ05fSibi/2QzwNvy8mkYHp848tkSuNWsGNRx6wobyOLqOCpna
         zneA==
X-Gm-Message-State: AJIora/jTvvshX+r+qk7EwHypixGsQdRoMJhmw/Fjr69sGVfrrJ2tVKL
        W57G/jylXh2WcqR1Y8JcVzi9ze0XgA==
X-Google-Smtp-Source: AGRyM1vzz7HPIhSWKykINsqWzk1rWD9FRHy+C0QD6JICeW3aqG8X2ql/+Wk1iaWAwJcjoC5BooTPcg==
X-Received: by 2002:a05:6638:111:b0:33a:3a10:c0a5 with SMTP id x17-20020a056638011100b0033a3a10c0a5mr12223527jao.81.1656446980422;
        Tue, 28 Jun 2022 13:09:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u10-20020a02b1ca000000b00339da678a7csm6387082jah.78.2022.06.28.13.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:09:40 -0700 (PDT)
Received: (nullmailer pid 898325 invoked by uid 1000);
        Tue, 28 Jun 2022 20:09:38 -0000
Date:   Tue, 28 Jun 2022 14:09:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: arm/fvp-base-revc: Remove 'panel-dpi'
 compatible
Message-ID: <20220628200938.GB694214-robh@kernel.org>
References: <20220610204057.2203419-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610204057.2203419-1-robh@kernel.org>
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

On Fri, Jun 10, 2022 at 02:40:57PM -0600, Rob Herring wrote:
> The rtsm-display panel timing node was removed in commit 928faf5e3e8d
> ("arm64: dts: fvp: Remove panel timings"). Without the node, 'panel-dpi'
> is not needed either.
> 
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/boot/dts/arm/fvp-base-revc.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ping!

> 
> diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> index a496e39e6204..5f6f30c801a7 100644
> --- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> +++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> @@ -186,7 +186,7 @@ smmu: iommu@2b400000 {
>  	};
>  
>  	panel {
> -		compatible = "arm,rtsm-display", "panel-dpi";
> +		compatible = "arm,rtsm-display";
>  		port {
>  			panel_in: endpoint {
>  				remote-endpoint = <&clcd_pads>;
> -- 
> 2.34.1
> 
