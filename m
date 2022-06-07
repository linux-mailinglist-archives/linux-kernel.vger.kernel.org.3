Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4B953F81E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbiFGIY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiFGIYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:24:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B791057B;
        Tue,  7 Jun 2022 01:24:20 -0700 (PDT)
X-UUID: 97fbe40a365248e4a122303a026299da-20220607
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:eba2f219-2af2-4a81-a52a-1f30e8a0b4d1,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.5,REQID:eba2f219-2af2-4a81-a52a-1f30e8a0b4d1,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:2a19b09,CLOUDID:2edb747e-c8dc-403a-96e8-6237210dceee,C
        OID:7f8671649113,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 97fbe40a365248e4a122303a026299da-20220607
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1882884305; Tue, 07 Jun 2022 16:24:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 7 Jun 2022 16:24:14 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 7 Jun 2022 16:24:13 +0800
Message-ID: <c46ef886f908067d10b1cb9f37b3e41e6157c71d.camel@mediatek.com>
Subject: Re: [RESEND v12 1/3] dt-bindings: mmc: mtk-sd: extend interrupts
 and pinctrls properties
From:   Axe Yang <axe.yang@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
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
        <angelogioacchino.delregno@collabora.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 7 Jun 2022 16:24:12 +0800
In-Reply-To: <CAPDyKFr25qbAb9DdCpu6Cp9NyK35YAv745Duw_ht7BQc+pQF=A@mail.gmail.com>
References: <20220525015140.384-1-axe.yang@mediatek.com>
         <20220525015140.384-2-axe.yang@mediatek.com>
         <CAPDyKFr25qbAb9DdCpu6Cp9NyK35YAv745Duw_ht7BQc+pQF=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-03 at 09:28 +0200, Ulf Hansson wrote:
> On Wed, 25 May 2022 at 03:51, Axe Yang <axe.yang@mediatek.com> wrote:
> > 
> > Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> > This feature allow SDIO devices alarm asynchronous interrupt to
> > host
> > even when host stop providing clock to SDIO card. An extra wakeup
> > interrupt and pinctrl states for SDIO DAT1 pin state switching are
> > required in this scenario.
> > 
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > ---
> >  .../devicetree/bindings/mmc/mtk-sd.yaml       | 50
> > ++++++++++++++++++-
> >  1 file changed, 49 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > index 2a2e9fa8c188..e83bf10281d6 100644
> > --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> > @@ -72,12 +72,27 @@ properties:
> >        - const: ahb_cg
> > 
> >    interrupts:
> > -    maxItems: 1
> > +    description:
> > +      Should at least contain MSDC GIC interrupt. To support SDIO
> > in-band wakeup, an extended
> > +      interrupt is required and be configured as wakeup source
> > irq.
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: msdc
> > +      - const: sdio_wakeup
> > 
> >    pinctrl-names:
> > +    description:
> > +      Should at least contain default and state_uhs. To support
> > SDIO in-band wakeup, dat1 pin
> > +      will be switched between GPIO mode and SDIO DAT1 mode,
> > state_eint and state_dat1 are
> > +      mandatory in this scenarios.
> > +    minItems: 2
> >      items:
> >        - const: default
> >        - const: state_uhs
> > +      - const: state_eint
> 
> Don't you need something along the lines of the below instead? I mean
> the "state_eint" isn't always needed, right?
> 
> oneOf:
>   - items:
>       - const: default
>       - const: state_uhs
>     - items:
>         - const: default
>         - const: state_uhs
>         - const: state_eint
> 
No, it is not always needed. 
As Rob said, the 'minItems: 2' makes the 3rd item optional.
Combine 'minItems' and 'description' fields, it is easy for others to
understand how to set pinctrl related properities.

Anyway, If you insist 'oneOf' is the better way, I can update that in
next version. What do you think?

And thanks to your comment, I found a mistake in 'description', I
should remove descriptions related to 'state_dat1', and I will update
that in next version.

And do you have any comment on patch 2/3 and 3/3?


Regards,
Axe


