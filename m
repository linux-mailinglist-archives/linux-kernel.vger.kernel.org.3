Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33794D0F34
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 06:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244912AbiCHFcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 00:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiCHFcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 00:32:54 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA59E22BDD;
        Mon,  7 Mar 2022 21:31:56 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w4so5703291ply.13;
        Mon, 07 Mar 2022 21:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hiUrRh/uATVOX1+aHRWh4+aeBSESk33jWex+kUURwWo=;
        b=Utxu4sdRZu4+h+E5/qL7v7mDI49/jQgVPS9IAzKcJo/Orve+rXnMuvmt3e+U2X6W9l
         zmSnZcRsTynjpCL2g3LWUg7uDGoV5ARa1YpPmw/ZoxY4ICc93Is5wrCKap2BbzURBGyu
         HpLR8SWSg+NeN8XSyJaYFJIRXF/Ce+eXQN5Ha6NR0uEs9mVbmYbX4gNpvWXNurzjH5WT
         +c8yMOOuIO69jZnz0/5kJJb01nx2on1l/HlZsQfIb0sdfx7HIdl+PcByky06LQYsIc4j
         p5vWtegQMpSOiJtkdPos9PzEwJfRp3/wxkhpfWnCdPoGcl/A39AIW4svDFrBU+1hzBSi
         EShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hiUrRh/uATVOX1+aHRWh4+aeBSESk33jWex+kUURwWo=;
        b=LgN/xqRSwlDdJtrCVw2mUiUflF5JRt7E/YMXvbN5rvs5tYETetKCr64HEMF2XOmaAA
         MMMmXWIKdisEuFFYWjT8Td5xMS3p+K/s+u6+XUNZ9BhvNSDwv2KwP3XE/X/J7IPRJpMj
         lKs+LqA21iF5bsAYU4OthtnVyA0ASKZgsq4Z0HcMniLHrfzVS/GyjeMkP3TnYRoML7GO
         hwxPkTpiA4dVvwDYXRbRROJJAmss7rSMGaRz1J7gQEjJWMEdyMPjJsqa+RHqRmS5XNq3
         y5cnQnBRSqrhuyXxRklslItQM/WPSwbpEUjI3BuDQJwEETyEGwFWtFJBnPPDe84W2CTk
         9VEQ==
X-Gm-Message-State: AOAM5327zHLCZcc+vykdPj9k4r7KCWl8OP2Yb3Ux8Tsv/SOaXNG4Am5z
        NNK+umGGzlyTftuTfc1QzoA=
X-Google-Smtp-Source: ABdhPJwl4O8t3/F+lQ1DHtrkAA/Nmy/m4vC+JAaimXJeoIhsGf0BbLUqaRQDJPJFGCeI01BWwPX0Rg==
X-Received: by 2002:a17:90a:2e0e:b0:1bc:dbe:2d04 with SMTP id q14-20020a17090a2e0e00b001bc0dbe2d04mr2904368pjd.74.1646717516466;
        Mon, 07 Mar 2022 21:31:56 -0800 (PST)
Received: from 9a2d8922b8f1 ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id d15-20020a056a00198f00b004f7109da1c4sm4460620pfl.205.2022.03.07.21.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 21:31:56 -0800 (PST)
Date:   Tue, 8 Mar 2022 11:01:51 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] arm: dts: integrator: Update spi node properties
Message-ID: <20220308053151.GA67373@9a2d8922b8f1>
References: <20220307205357.66322-1-singh.kuldeep87k@gmail.com>
 <20220307205357.66322-3-singh.kuldeep87k@gmail.com>
 <f686aeeb-e033-927f-89bf-fad239ad70df@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f686aeeb-e033-927f-89bf-fad239ad70df@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 10:57:40PM +0100, Krzysztof Kozlowski wrote:
> On 07/03/2022 21:53, Kuldeep Singh wrote:
> > SPI clock name for pl022 is "sspclk" and not "spiclk".
> > Fix below dtc warning:
> > clock-names:0: 'spiclk' is not one of ['SSPCLK', 'sspclk']
> > 
> > Also, update node name to spi instead of ssp to enable spi bindings
> > check.
> > 
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > ---
> >  arch/arm/boot/dts/integratorap-im-pd1.dts | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/integratorap-im-pd1.dts b/arch/arm/boot/dts/integratorap-im-pd1.dts
> > index d47bfb66d069..ebe938556645 100644
> > --- a/arch/arm/boot/dts/integratorap-im-pd1.dts
> > +++ b/arch/arm/boot/dts/integratorap-im-pd1.dts
> > @@ -178,12 +178,12 @@ uart@200000 {
> >  		clock-names = "uartclk", "apb_pclk";
> >  	};
> >  
> > -	ssp@300000 {
> > +	ssp0: spi@300000 {
> 
> Is the alias used anywhere? Why adding it?

I added an alias so as not to lose originality. At other places, ssp is
used more specifically for spi controller node and since here I need to
enable bindings check, so I mentioned both.

There are other platforms too which are using the same notation and
personally, I couldn't find any harm in this.

Regards
Kuldeep
