Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1C34BD75D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbiBUHFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:05:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345790AbiBUHFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:05:05 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FAC5FAC;
        Sun, 20 Feb 2022 23:04:38 -0800 (PST)
X-UUID: 1b285ebb4d624eda838e4a2c5c83752d-20220221
X-UUID: 1b285ebb4d624eda838e4a2c5c83752d-20220221
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <axe.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 889575141; Mon, 21 Feb 2022 15:04:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Feb 2022 15:04:32 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Feb 2022 15:04:31 +0800
Message-ID: <21fa48195101b91c09b266f1c4f40eda5d127fdb.camel@mediatek.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: add cap-sdio-async-irq flag
From:   Axe Yang <axe.yang@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 21 Feb 2022 15:04:31 +0800
In-Reply-To: <CAPDyKFr8bV+1uTbuhMObvORLGJHsvZHUONJkdY54MXPPRWL5Qw@mail.gmail.com>
References: <20220119103212.13158-1-axe.yang@mediatek.com>
         <20220119103212.13158-2-axe.yang@mediatek.com>
         <CAPDyKFr8bV+1uTbuhMObvORLGJHsvZHUONJkdY54MXPPRWL5Qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-14 at 16:23 +0100, Ulf Hansson wrote:
> On Wed, 19 Jan 2022 at 11:32, Axe Yang <axe.yang@mediatek.com> wrote:
> > 
> > Asynchronous interrupt is a mechanism that allow SDIO devices alarm
> > interrupt when host stop providing clock to card. Add a DT flag to
> > enable this feature if it is supported by SDIO card.
> > 
> > Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5
> > +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc-
> > controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-
> > controller.yaml
> > index 513f3c8758aa..16fb06f88471 100644
> > --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > @@ -165,6 +165,11 @@ properties:
> >      description:
> >        eMMC hardware reset is supported
> > 
> > +  cap-sdio-async-irq:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      SDIO async interrupt is supported.
> 
> We already have a DT property for this, I believe.
> 
> "wakeup-source" is probably what you want, but we have additional
> properties that are related to this too. See more below.
> 
> > +
> >    cap-sdio-irq:
> >      $ref: /schemas/types.yaml#/definitions/flag
> >      description:
> 
> The above, "cap-sdio-irq", informs whether the SDIO IRQs can be
> supported at all, by the host controller.
> 
> The property "keep-power-in-suspend" informs whether we can preserve
> the power to the card during a suspend/resume cycle. This should be
> needed in your case too, I think.
> 
> In other words, you may need to combine "cap-sdio-irq",
> "wakeup-source" and "keep-power-in-suspend" to describe your HW.
> 
> However, what perhaps is missing, is a common MMC/SDIO binding that
> let us describe an optional irq-line, which sometimes is being used
> for the wakeup irq. In the sdhci-omap case, we look for an irq
> mapping
> towards "wakeup" if specified in the "interrupt-names" property.
> 
> In some case, when the SDIO card supports an out-of-band IRQ line,
> the
> similar should be specified in the child-node corresponding to the
> SDIO card.
> 
> 

Yes, the intention of the patchset is to wakeup SDIO host in
runtime/system suspend state within SDIO DAT1(in-band wakeup).

I will implement it with "wakeup-source", thanks for your review.

