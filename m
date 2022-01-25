Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFAC49AC5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiAYG0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:26:21 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:58894 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S245346AbiAYGVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 01:21:52 -0500
X-UUID: eb6ac2ceb41d4d1d9cb8b2e768a12f91-20220125
X-UUID: eb6ac2ceb41d4d1d9cb8b2e768a12f91-20220125
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1135649776; Tue, 25 Jan 2022 14:21:33 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 25 Jan 2022 14:21:33 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 14:21:33 +0800
Message-ID: <102ea6303dd16fdf9ec931d0a1845a93afe92545.camel@mediatek.com>
Subject: Re: [PATCH v9 2/3] dt-bindings: pinctrl: mt8195: Add
 mediatek,drive-strength-adv property
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "David Matlack" <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        "Marc Zyngier" <maz@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        <chunfeng.yun@mediatek.com>
Date:   Tue, 25 Jan 2022 14:21:33 +0800
In-Reply-To: <18f7a647-6153-6d38-dff1-727b9592b01e@gmail.com>
References: <20220112114724.1953-1-tinghan.shen@mediatek.com>
         <20220112114724.1953-3-tinghan.shen@mediatek.com>
         <18f7a647-6153-6d38-dff1-727b9592b01e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-13 at 17:31 +0100, Matthias Brugger wrote:
> [dopping Maciej, Paolo and Sean Christopherson]
> 
> On 12/01/2022 12:47, Tinghan Shen wrote:
> > Extend driving support for I2C pins on SoC mt8195.
> > This property is already documented in mediatek,mt8183-pinctrl.yaml.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Looks good to me. Linus please let me know when you are queuing this patch and 
> I'll take the rest of the series. Another option is, that you provide an 
> Acked-by and I can take the whole set through my branch.
> 
> Regards,
> Matthias

Hi Matthias,

I want to send next version to update the CC list of this series, but I'm not sure 
whether this will break the conversation between you and Linus.

Is it ok to send next version? or waiting the response?

Best regards,
TingHan

> 
> > ---
> >   .../bindings/pinctrl/pinctrl-mt8195.yaml      | 35 +++++++++++++++++++
> >   1 file changed, 35 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
> > b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
> > index 328ea59c5466..4db4899af6b1 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
> > @@ -98,6 +98,32 @@ patternProperties:
> >             drive-strength:
> >               enum: [2, 4, 6, 8, 10, 12, 14, 16]
> >   
> > +          mediatek,drive-strength-adv:
> > +            description: |
> > +              Describe the specific driving setup property.
> > +              For I2C pins, the existing generic driving setup can only support
> > +              2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
> > +              can support 0.125/0.25/0.5/1mA adjustment. If we enable specific
> > +              driving setup, the existing generic setup will be disabled.
> > +              The specific driving setup is controlled by E1E0EN.
> > +              When E1=0/E0=0, the strength is 0.125mA.
> > +              When E1=0/E0=1, the strength is 0.25mA.
> > +              When E1=1/E0=0, the strength is 0.5mA.
> > +              When E1=1/E0=1, the strength is 1mA.
> > +              EN is used to enable or disable the specific driving setup.
> > +              Valid arguments are described as below:
> > +              0: (E1, E0, EN) = (0, 0, 0)
> > +              1: (E1, E0, EN) = (0, 0, 1)
> > +              2: (E1, E0, EN) = (0, 1, 0)
> > +              3: (E1, E0, EN) = (0, 1, 1)
> > +              4: (E1, E0, EN) = (1, 0, 0)
> > +              5: (E1, E0, EN) = (1, 0, 1)
> > +              6: (E1, E0, EN) = (1, 1, 0)
> > +              7: (E1, E0, EN) = (1, 1, 1)
> > +              So the valid arguments are from 0 to 7.
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > +
> >             bias-pull-down:
> >               description: |
> >                 For pull down type is normal, it don't need add RSEL & R1R0 define
> > @@ -268,4 +294,13 @@ examples:
> >             bias-pull-down;
> >           };
> >         };
> > +
> > +      i2c0-pins {
> > +        pins {
> > +          pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
> > +                   <PINMUX_GPIO9__FUNC_SCL0>;
> > +          bias-disable;
> > +          mediatek,drive-strength-adv = <7>;
> > +        };
> > +      };
> >       };
> > 

