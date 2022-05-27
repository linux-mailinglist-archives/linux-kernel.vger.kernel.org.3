Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CCE535F49
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351299AbiE0Lce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbiE0Lcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:32:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B9B11838;
        Fri, 27 May 2022 04:32:31 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id v9so4613196lja.12;
        Fri, 27 May 2022 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gi1UXUaZy4pumdEIliaXakvgNV0H8sr+r4h0aX/ZCIw=;
        b=JOiBepAxKKOu/v5KC00CHfLz2phzG8AFNsrfTxcshRMkn/WzFMQtGM3zMnwJKylSZ1
         Zk/TvetfANf+bt/y9NslL55kd3f37zL5/OG+MOsA2wgFmKQIFi5Hl8duYBsV5uUdZuUk
         +yQ9td11tfzJt6TUJt4ySHWzqxVK1WUV/I5EKIlLfA2OAwxEzvcgxzKoRPrTO5rYK5cM
         1zVBk6kp1FVKVEeUKhsYXW1sSoG2kZT00bTvPhkupe8c2DTq5TO19+gIwZOvMjI+/adU
         Qqdrsttsd1vUL9NHWtHMQmGvK6W2VIdbEaUrAPdIn+T+36QILDTo2joi9NerKwPGj6W2
         Gn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gi1UXUaZy4pumdEIliaXakvgNV0H8sr+r4h0aX/ZCIw=;
        b=Nh7DIOkRzvp2Q0c6wlxcueHET86Fchosk0NjZkzpJtuJ77ZoJKi+xxeytmr77h0N0y
         ZOqJbLLJbloEE5Nyk+t3uTU68BEMGgNpT2OMrgIXNPf3i3y+N6NStGdHuzHGq4tGvWHC
         xPJKqsDcSGy1rAolKbvRZgCLTxu4mjT+B24hvciwHl+y7tYKW9EHOmpvAah+Gsa2tcnK
         K9j83QJ7BWuHwvx8WV39c5Bx6rcc6RdZauNrVdpIhd9tGu15ld3BLpiBxBfx+X3QkxjY
         /EpjqKT6Y7kFX2S+FJS28EH7GBbkw4FAXcVr8mhJAUDHCqDVF6jVfl9ZKI27Rm8bGnF0
         IgBA==
X-Gm-Message-State: AOAM530fT98yyFm4l3Pek8NxG4RVhBsacpAuxtlZl+45ILuhNg3DmLqS
        mzois0NOyPEnVlGxQG1tsI4=
X-Google-Smtp-Source: ABdhPJwn3VUpymr4pB83ygQF9tcXJs2d1Rl7hxKlQK0W3fsTn1uiv0z3umubTI0YxrlbcprHw2nrTQ==
X-Received: by 2002:a2e:8e78:0:b0:253:c31b:d059 with SMTP id t24-20020a2e8e78000000b00253c31bd059mr23920180ljk.393.1653651150144;
        Fri, 27 May 2022 04:32:30 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id w19-20020a05651c119300b00253b5bb829esm977037ljo.98.2022.05.27.04.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 04:32:29 -0700 (PDT)
Date:   Fri, 27 May 2022 14:32:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Pratyush Yadav <p.yadav@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: Move 'rx-sample-delay-ns' to
 spi-peripheral-props.yaml
Message-ID: <20220527113226.x62neigmrnljxtph@mobilestation>
References: <20220525210053.2488756-1-robh@kernel.org>
 <20220526054642.zw44mgw2bd2u5v76@ti.com>
 <20220526135404.GA3831942-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526135404.GA3831942-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 08:54:04AM -0500, Rob Herring wrote:
> On Thu, May 26, 2022 at 11:16:42AM +0530, Pratyush Yadav wrote:
> > Hi Rob,
> > 
> > On 25/05/22 04:00PM, Rob Herring wrote:
> > > SPI bus per device properties must be defined in spi-peripheral-props.yaml
> > > for unevaluatedProperties checks to work correctly on device nodes.
> > > 
> > > This has the side effect of promoting 'rx-sample-delay-ns' to be a
> > > common property, but functionally it's no different if it was defined in
> > > a Synopsys specific schema file.
> > 
> > Functionally it is no different, but does this property make sense for 
> > other controllers? If not then I don't see why we should pollute the 
> > common list with controller-specific ones. For one, this now no longer 
> > makes it obvious that this property should only be used with the 
> > Synopsys controller. And if you keep making small exceptions for other 
> > controllers too, soon the common list will be full of controller 
> > properties and it will be a mess finding out what belongs to who.
> 

> There's at least one other case already:
> 
>   cdns,read-delay:
>     $ref: /schemas/types.yaml#/definitions/uint32
>     description:
>       Delay for read capture logic, in clock cycles.

What about creating the schemas hierarchy for the device-specific
properties as I already suggested in the other thread? Like this:

https://lore.kernel.org/linux-ide/20220527101057.b5z7ase6y4naoxvk@mobilestation

-Sergey

> 
> 
> Too many common properties is not a problem we have. Too many custom 
> properties doing the same thing is the problem.
> 
> Rob
