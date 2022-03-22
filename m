Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7D84E446E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbiCVQnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbiCVQnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:43:32 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F0C7463C;
        Tue, 22 Mar 2022 09:42:04 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id e4so17008603oif.2;
        Tue, 22 Mar 2022 09:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f19PtgxgIFInjc+IlAHkQp6KzpsdEzJgw42yMBWHdQg=;
        b=kQwgwdEcuemqrF7dnyGxmc0ir6Qoi1GS5OZ0cVJfR5Q7FkCZsYRlPThQoDUuKVBORT
         XZmJPnpsWyK+MuD+LnqFoQ8emgOsH14FNlj7vtys5k10XsyZ7DXtssOUPeHK6KNyUMKg
         xxo5EjrBuTyDnJl2hkTBzK5Qb1H7QuAON2DbZGQe0duGwlDYQi/jBt+CLevzIe82I7Gm
         l9iP2lc0wWgr65BjT5GdEz+Z1yMh6IIXB16ni1TCe84WMk23SGf5F8e5oIoupPViV/8O
         7ZxAUzn/TGKmjOiz3r/FqkSvbBWMZp+lylm4ETUagQ+ZsbKEIxd2lcWbou0OzbhLXF/c
         WcYA==
X-Gm-Message-State: AOAM530CV+bAmYyHZnrSoTiiNtCvA6l29EASPvGwbsDnTfUJ6UsiK7pg
        Z/5OABcD2v0hs5/8qKaSbw==
X-Google-Smtp-Source: ABdhPJy77nVIsmtyMrQZ89IidhxzPS7fqu8uM2zZDvVPEioBV9LTEyx/xmCMVJUZEAwG9u6Urw0D7Q==
X-Received: by 2002:aca:eb58:0:b0:2d9:deea:2014 with SMTP id j85-20020acaeb58000000b002d9deea2014mr2513406oih.83.1647967324171;
        Tue, 22 Mar 2022 09:42:04 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s125-20020acaa983000000b002ecdbaf98fesm8932484oie.34.2022.03.22.09.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 09:42:03 -0700 (PDT)
Received: (nullmailer pid 2149693 invoked by uid 1000);
        Tue, 22 Mar 2022 16:42:01 -0000
Date:   Tue, 22 Mar 2022 11:42:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
Message-ID: <Yjn8WVBdwiCrstx5@robh.at.kernel.org>
References: <20220321115133.32121-1-axe.yang@mediatek.com>
 <20220321115133.32121-2-axe.yang@mediatek.com>
 <YjkKURNzg8JPbXcg@robh.at.kernel.org>
 <b03df175f871ee9a6561862f5bd7bceb9cafbde1.camel@mediatek.com>
 <5d9c7655-b05e-aa77-d405-c1ec971daa77@collabora.com>
 <4e7a532814510b03b74455f5a924b50a70699ca1.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e7a532814510b03b74455f5a924b50a70699ca1.camel@mediatek.com>
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

On Tue, Mar 22, 2022 at 05:33:55PM +0800, Axe Yang wrote:
> Hello AngeloGioacchino,
> 
> On Tue, 2022-03-22 at 09:42 +0100, AngeloGioacchino Del Regno wrote:
> > Il 22/03/22 02:35, Axe Yang ha scritto:
> > > On Mon, 2022-03-21 at 18:29 -0500, Rob Herring wrote:
> > > > On Mon, Mar 21, 2022 at 07:51:32PM +0800, Axe Yang wrote:
> > > > > Extend interrupts and pinctrls for SDIO wakeup interrupt
> > > > > feature.
> > > > > This feature allow SDIO devices alarm asynchronous interrupt to
> > > > > host
> > > > > even when host stop providing clock to SDIO card. An extra
> > > > > wakeup
> > > > > interrupt and pinctrl states for SDIO DAT1 pin state switching
> > > > > are
> > > > > required in this scenario.
> > > > > 
> > > > > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > > > > ---
> > > > >   .../devicetree/bindings/mmc/mtk-sd.yaml       | 23
> > > > > ++++++++++++++++++-
> > > > >   1 file changed, 22 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > > b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > > index 297ada03e3de..f57774535a1d 100644
> > > > > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > > @@ -69,12 +69,23 @@ properties:
> > > > >         - const: ahb_cg
> > > > >   
> > > > >     interrupts:
> > > > > -    maxItems: 1
> > > > > +    description:
> > > > > +      Should at least contain MSDC GIC interrupt. To support
> > > > > SDIO
> > > > > in-band wakeup, an extended
> > > > > +      interrupt is required and be configured as wakeup source
> > > > > irq.
> > > > > +    minItems: 1
> > > > > +    maxItems: 2
> > > > >   
> > > > >     pinctrl-names:
> > > > > +    description:
> > > > > +      Should at least contain default and state_uhs. To
> > > > > support
> > > > > SDIO in-band wakeup, dat1 pin
> > > > > +      will be switched between GPIO mode and SDIO DAT1 mode,
> > > > > state_eint and state_dat1 are
> > > > > +      mandatory in this scenarios.
> > > > > +    minItems: 2
> > > > >       items:
> > > > >         - const: default
> > > > >         - const: state_uhs
> > > > > +      - const: state_eint
> > > > > +      - const: state_dat1
> > > > >   
> > > > >     pinctrl-0:
> > > > >       description:
> > > > > @@ -86,6 +97,16 @@ properties:
> > > > >         should contain uhs mode pin ctrl.
> > > > >       maxItems: 1
> > > > >   
> > > > > +  pinctrl-2:
> > > > > +    description:
> > > > > +      should switch dat1 pin to GPIO mode.
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  pinctrl-3:
> > > > > +    description:
> > > > > +      should switch SDIO dat1 pin from GPIO mode back to SDIO
> > > > > mode.
> > > > 
> > > > How is this different than pinctrl-0?
> > > 
> > > pinctrl-0 contains default settings for all IO pins(CLK/CMD/DAT).
> > > pinctrl-1 contains settings for all IO pins(CLK/CMD/DAT) in UHS
> > > mode.
> > > pinctrl-3 is lightweight pinctrl-1, only keep SDIO DAT1 pin
> > > function
> > > switch part.
> > > 
> > 
> > Is there any particular reason why we cannot simply select pinctrl-1
> > again
> > instead of pinctrl-3, apart from the virtually not existent overhead
> > of one more mmio write?
> 
> No, there is no particular reason. 
> I just want to do the pin function switch quick and clean. 
> 
> The intention of pinctrl-1 is to set the most initial state of IO pins
> in UHS mode. If I don't need to adjust IO settings any longer, it is
> okay to select pinctrl-1 state instead of pinctrl-3. 
> But think about this scenarios: after initial SDIO IO pins to UHS mode,
> I want to adjust some IO related properties, such as driving strength.
> And I want to keep these settings because with new driving strength,
> the signal is better. I'd rather to choose pinctrl-3 but not pinctrl-1, 
> because I do not want the change be restored after next runtime resume.

The pinctrl-X properties set modes, they aren't supposed to be a state 
machine.

Rob
