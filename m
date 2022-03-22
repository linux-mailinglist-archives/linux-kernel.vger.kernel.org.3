Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0194E3BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiCVJff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbiCVJfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:35:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90DC2BD9;
        Tue, 22 Mar 2022 02:34:02 -0700 (PDT)
X-UUID: 46a6609a7c0344a881cf0174cf2a8715-20220322
X-UUID: 46a6609a7c0344a881cf0174cf2a8715-20220322
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 845900133; Tue, 22 Mar 2022 17:33:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 22 Mar 2022 17:33:56 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Mar 2022 17:33:55 +0800
Message-ID: <4e7a532814510b03b74455f5a924b50a70699ca1.camel@mediatek.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
From:   Axe Yang <axe.yang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rob Herring" <robh@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        "Eric Biggers" <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 22 Mar 2022 17:33:55 +0800
In-Reply-To: <5d9c7655-b05e-aa77-d405-c1ec971daa77@collabora.com>
References: <20220321115133.32121-1-axe.yang@mediatek.com>
         <20220321115133.32121-2-axe.yang@mediatek.com>
         <YjkKURNzg8JPbXcg@robh.at.kernel.org>
         <b03df175f871ee9a6561862f5bd7bceb9cafbde1.camel@mediatek.com>
         <5d9c7655-b05e-aa77-d405-c1ec971daa77@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello AngeloGioacchino,

On Tue, 2022-03-22 at 09:42 +0100, AngeloGioacchino Del Regno wrote:
> Il 22/03/22 02:35, Axe Yang ha scritto:
> > On Mon, 2022-03-21 at 18:29 -0500, Rob Herring wrote:
> > > On Mon, Mar 21, 2022 at 07:51:32PM +0800, Axe Yang wrote:
> > > > Extend interrupts and pinctrls for SDIO wakeup interrupt
> > > > feature.
> > > > This feature allow SDIO devices alarm asynchronous interrupt to
> > > > host
> > > > even when host stop providing clock to SDIO card. An extra
> > > > wakeup
> > > > interrupt and pinctrl states for SDIO DAT1 pin state switching
> > > > are
> > > > required in this scenario.
> > > > 
> > > > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > > > ---
> > > >   .../devicetree/bindings/mmc/mtk-sd.yaml       | 23
> > > > ++++++++++++++++++-
> > > >   1 file changed, 22 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > index 297ada03e3de..f57774535a1d 100644
> > > > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > @@ -69,12 +69,23 @@ properties:
> > > >         - const: ahb_cg
> > > >   
> > > >     interrupts:
> > > > -    maxItems: 1
> > > > +    description:
> > > > +      Should at least contain MSDC GIC interrupt. To support
> > > > SDIO
> > > > in-band wakeup, an extended
> > > > +      interrupt is required and be configured as wakeup source
> > > > irq.
> > > > +    minItems: 1
> > > > +    maxItems: 2
> > > >   
> > > >     pinctrl-names:
> > > > +    description:
> > > > +      Should at least contain default and state_uhs. To
> > > > support
> > > > SDIO in-band wakeup, dat1 pin
> > > > +      will be switched between GPIO mode and SDIO DAT1 mode,
> > > > state_eint and state_dat1 are
> > > > +      mandatory in this scenarios.
> > > > +    minItems: 2
> > > >       items:
> > > >         - const: default
> > > >         - const: state_uhs
> > > > +      - const: state_eint
> > > > +      - const: state_dat1
> > > >   
> > > >     pinctrl-0:
> > > >       description:
> > > > @@ -86,6 +97,16 @@ properties:
> > > >         should contain uhs mode pin ctrl.
> > > >       maxItems: 1
> > > >   
> > > > +  pinctrl-2:
> > > > +    description:
> > > > +      should switch dat1 pin to GPIO mode.
> > > > +    maxItems: 1
> > > > +
> > > > +  pinctrl-3:
> > > > +    description:
> > > > +      should switch SDIO dat1 pin from GPIO mode back to SDIO
> > > > mode.
> > > 
> > > How is this different than pinctrl-0?
> > 
> > pinctrl-0 contains default settings for all IO pins(CLK/CMD/DAT).
> > pinctrl-1 contains settings for all IO pins(CLK/CMD/DAT) in UHS
> > mode.
> > pinctrl-3 is lightweight pinctrl-1, only keep SDIO DAT1 pin
> > function
> > switch part.
> > 
> 
> Is there any particular reason why we cannot simply select pinctrl-1
> again
> instead of pinctrl-3, apart from the virtually not existent overhead
> of one more mmio write?

No, there is no particular reason. 
I just want to do the pin function switch quick and clean. 

The intention of pinctrl-1 is to set the most initial state of IO pins
in UHS mode. If I don't need to adjust IO settings any longer, it is
okay to select pinctrl-1 state instead of pinctrl-3. 
But think about this scenarios: after initial SDIO IO pins to UHS mode,
I want to adjust some IO related properties, such as driving strength.
And I want to keep these settings because with new driving strength,
the signal is better. I'd rather to choose pinctrl-3 but not pinctrl-1, 
because I do not want the change be restored after next runtime resume.

Regards,
Axe



