Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F24D4E4B93
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbiCWDkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241596AbiCWDkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:40:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92F61CB00;
        Tue, 22 Mar 2022 20:38:39 -0700 (PDT)
X-UUID: 7823b751e6424cafa6dfa4eb38cc0079-20220323
X-UUID: 7823b751e6424cafa6dfa4eb38cc0079-20220323
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1788832817; Wed, 23 Mar 2022 11:38:34 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Mar 2022 11:38:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Mar
 2022 11:38:33 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Mar 2022 11:38:31 +0800
Message-ID: <9415f00e4f2012adc14592c684fa5b670e382ee8.camel@mediatek.com>
Subject: Re: [PATCH v8 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
From:   Axe Yang <axe.yang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
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
Date:   Wed, 23 Mar 2022 11:38:31 +0800
In-Reply-To: <Yjn8WVBdwiCrstx5@robh.at.kernel.org>
References: <20220321115133.32121-1-axe.yang@mediatek.com>
         <20220321115133.32121-2-axe.yang@mediatek.com>
         <YjkKURNzg8JPbXcg@robh.at.kernel.org>
         <b03df175f871ee9a6561862f5bd7bceb9cafbde1.camel@mediatek.com>
         <5d9c7655-b05e-aa77-d405-c1ec971daa77@collabora.com>
         <4e7a532814510b03b74455f5a924b50a70699ca1.camel@mediatek.com>
         <Yjn8WVBdwiCrstx5@robh.at.kernel.org>
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

Hi Rob,

Sorry, my last mail may mislead your understanding. Let me explain more
about this.

On Tue, 2022-03-22 at 11:42 -0500, Rob Herring wrote:
> On Tue, Mar 22, 2022 at 05:33:55PM +0800, Axe Yang wrote:
> > Hello AngeloGioacchino,
> > 
> > On Tue, 2022-03-22 at 09:42 +0100, AngeloGioacchino Del Regno
> > wrote:
> > > Il 22/03/22 02:35, Axe Yang ha scritto:
> > > > On Mon, 2022-03-21 at 18:29 -0500, Rob Herring wrote:
> > > > > On Mon, Mar 21, 2022 at 07:51:32PM +0800, Axe Yang wrote:
> > > > > > Extend interrupts and pinctrls for SDIO wakeup interrupt
> > > > > > feature.
> > > > > > This feature allow SDIO devices alarm asynchronous
> > > > > > interrupt to
> > > > > > host
> > > > > > even when host stop providing clock to SDIO card. An extra
> > > > > > wakeup
> > > > > > interrupt and pinctrl states for SDIO DAT1 pin state
> > > > > > switching
> > > > > > are
> > > > > > required in this scenario.
> > > > > > 
> > > > > > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > > > > > ---
> > > > > >   .../devicetree/bindings/mmc/mtk-sd.yaml       | 23
> > > > > > ++++++++++++++++++-
> > > > > >   1 file changed, 22 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/mmc/mtk-
> > > > > > sd.yaml
> > > > > > b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > > > index 297ada03e3de..f57774535a1d 100644
> > > > > > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > > > > > @@ -69,12 +69,23 @@ properties:
> > > > > >         - const: ahb_cg
> > > > > >   
> > > > > >     interrupts:
> > > > > > -    maxItems: 1
> > > > > > +    description:
> > > > > > +      Should at least contain MSDC GIC interrupt. To
> > > > > > support
> > > > > > SDIO
> > > > > > in-band wakeup, an extended
> > > > > > +      interrupt is required and be configured as wakeup
> > > > > > source
> > > > > > irq.
> > > > > > +    minItems: 1
> > > > > > +    maxItems: 2
> > > > > >   
> > > > > >     pinctrl-names:
> > > > > > +    description:
> > > > > > +      Should at least contain default and state_uhs. To
> > > > > > support
> > > > > > SDIO in-band wakeup, dat1 pin
> > > > > > +      will be switched between GPIO mode and SDIO DAT1
> > > > > > mode,
> > > > > > state_eint and state_dat1 are
> > > > > > +      mandatory in this scenarios.
> > > > > > +    minItems: 2
> > > > > >       items:
> > > > > >         - const: default
> > > > > >         - const: state_uhs
> > > > > > +      - const: state_eint
> > > > > > +      - const: state_dat1
> > > > > >   
> > > > > >     pinctrl-0:
> > > > > >       description:
> > > > > > @@ -86,6 +97,16 @@ properties:
> > > > > >         should contain uhs mode pin ctrl.
> > > > > >       maxItems: 1
> > > > > >   
> > > > > > +  pinctrl-2:
> > > > > > +    description:
> > > > > > +      should switch dat1 pin to GPIO mode.
> > > > > > +    maxItems: 1
> > > > > > +
> > > > > > +  pinctrl-3:
> > > > > > +    description:
> > > > > > +      should switch SDIO dat1 pin from GPIO mode back to
> > > > > > SDIO
> > > > > > mode.
> > > > > 
> > > > > How is this different than pinctrl-0?
> > > > 
> > > > pinctrl-0 contains default settings for all IO
> > > > pins(CLK/CMD/DAT).
> > > > pinctrl-1 contains settings for all IO pins(CLK/CMD/DAT) in UHS
> > > > mode.
> > > > pinctrl-3 is lightweight pinctrl-1, only keep SDIO DAT1 pin
> > > > function
> > > > switch part.
> > > > 
> > > 
> > > Is there any particular reason why we cannot simply select
> > > pinctrl-1
> > > again
> > > instead of pinctrl-3, apart from the virtually not existent
> > > overhead
> > > of one more mmio write?
> > 
> > No, there is no particular reason. 
> > I just want to do the pin function switch quick and clean. 
> > 
> > The intention of pinctrl-1 is to set the most initial state of IO
> > pins
> > in UHS mode. If I don't need to adjust IO settings any longer, it
> > is
> > okay to select pinctrl-1 state instead of pinctrl-3. 
> > But think about this scenarios: after initial SDIO IO pins to UHS
> > mode,
> > I want to adjust some IO related properties, such as driving
> > strength.
> > And I want to keep these settings because with new driving
> > strength,
> > the signal is better. I'd rather to choose pinctrl-3 but not
> > pinctrl-1, 
> > because I do not want the change be restored after next runtime
> > resume.
> 
> The pinctrl-X properties set modes, they aren't supposed to be a
> state 
> machine

I do use the pinctl-x properties to set modes, but not judge state from
pin state.

I need to time-multiplex SDIO DAT1 pin, shift it between GPIO mode and
SDIO IO mode, for example:

mmc2_pins_default {
	...
};

mmc2_pins_uhs {
        pins_clk {
                pinmux = <PINMUX_GPIO170__FUNC_B1_MSDC2_CLK>;
                drive-strength = <MTK_DRIVE_4mA>;
                bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
        };

        pins_cmd_dat {
                pinmux = <PINMUX_GPIO169__FUNC_B1_MSDC2_CMD>,
                         <PINMUX_GPIO171__FUNC_B1_MSDC2_DAT0>,
                         <PINMUX_GPIO172__FUNC_B1_MSDC2_DAT1>,
                         <PINMUX_GPIO173__FUNC_B1_MSDC2_DAT2>,
                         <PINMUX_GPIO174__FUNC_B1_MSDC2_DAT3>;
                input-enable;
                drive-strength = <MTK_DRIVE_6mA>;
                bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
        };
};

mmc2_pins_eint {
        pins_dat1 {
                pinmux = <PINMUX_GPIO172__FUNC_B_GPIO172>;
                input-enable;
                bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
        };
};

mmc2_pins_dat1 {
        pins_dat1 {
                pinmux = <PINMUX_GPIO172__FUNC_B1_MSDC2_DAT1>;
                input-enable;
                bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
        };
};

The pinctrl-1(mmc2_pin_uhs) here contain all SDIO IO pins, for the most
early initialize. I SELECT pinctrl-1 when I change SDIO to SDR104 mode,
before calibration.
And when SDIO bus is idle, I SELECT pinctrl-2(mmc2_pins_eint), use DAT1
as a interrupt line when steping into runtime suspend.
After resume, I SELECT pinctrl-3(mmc2_pins_dat1) to set DAT1 pin back
to SDIO IO mode.

I need all the pinctrl-x properties, and take the initiative to set pin
mode according to needs.


Best Regard,
Axe


