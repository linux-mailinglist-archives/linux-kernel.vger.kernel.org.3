Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D04860E2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 08:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiAFHKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 02:10:13 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:38260 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234429AbiAFHKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 02:10:12 -0500
X-UUID: 8ea96f7b9d844bf38ad79796b36d1f34-20220106
X-UUID: 8ea96f7b9d844bf38ad79796b36d1f34-20220106
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yc.hung@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1291158459; Thu, 06 Jan 2022 15:10:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Jan 2022 15:10:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Jan 2022 15:10:08 +0800
Message-ID: <3e00db1d4fe71938b0274331cd49b96bdddccea4.camel@mediatek.com>
Subject: Re: [PATCH v3] dt-bindings: dsp: mediatek: add mt8195 dsp document
From:   YC Hung <yc.hung@mediatek.com>
To:     Daniel Baluta <daniel.baluta@gmail.com>
CC:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "Rob Herring" <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        <trevor.wu@mediatek.com>, <allen-kh.cheng@mediatek.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Date:   Thu, 6 Jan 2022 15:10:08 +0800
In-Reply-To: <CAEnQRZBH4uwMmyBLY2bCtY9QZooBiK5PqF3T+4K8WAtQV1QN-Q@mail.gmail.com>
References: <20220103043202.6524-1-yc.hung@mediatek.com>
         <CAEnQRZBH4uwMmyBLY2bCtY9QZooBiK5PqF3T+4K8WAtQV1QN-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

My mistake. Thanks for review and comments. I have updated v4 to fix
it. Thanks
On Wed, 2022-01-05 at 17:53 +0200, Daniel Baluta wrote:
> On Mon, Jan 3, 2022 at 1:00 PM YC Hung <yc.hung@mediatek.com> wrote:
> > 
> > From: "YC Hung" <yc.hung@mediatek.com>
> > 
> > This patch adds mt8195 dsp document. The dsp is used for Sound Open
> > Firmware driver node. It includes registers,  clocks, memory
> > regions,
> > and mailbox for dsp.
> > 
> > Signed-off-by: yc.hung <yc.hung@mediatek.com>
> 
> The code patch should be created against original source code from
> Rob's tree. Here it seems the patch is against v2.
> 
> This isn't going to work! Because when Rob will try to apply the
> patch
> it will fail since he doesn't have (and doesnt need to have)
> your previous versions.
> 
> So, please keep the changes history (that's a good thing!) but always
> rebase your patch on maintainer's tree.
> 
> 
> > ---
> > Changes since v2:
> >   Remove useless watchdog interrupt.
> >   Add commit message more detail description.
> > 
> > Changes since v1:
> >   Rename yaml file name as mediatek,mt8195-dsp.yaml
> >   Refine descriptions for mailbox, memory-region and drop unused
> > labels
> >   in examples.
> > ---
> > ---
> >  .../devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml | 12 --------
> > ----
> >  1 file changed, 12 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-
> > dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-
> > dsp.yaml
> > index bde763191d86..779daa786739 100644
> > --- a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-
> > dsp.yaml
> > +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-
> > dsp.yaml
> > @@ -27,14 +27,6 @@ properties:
> >        - const: cfg
> >        - const: sram
> > 
> > -  interrupts:
> > -    items:
> > -      - description: watchdog interrupt
> > -
> > -  interrupt-names:
> > -    items:
> > -      - const: wdt
> > -
> >    clocks:
> >      items:
> >        - description: mux for audio dsp clock
> > @@ -75,8 +67,6 @@ required:
> >    - compatible
> >    - reg
> >    - reg-names
> > -  - interrupts
> > -  - interrupt-names
> >    - clocks
> >    - clock-names
> >    - memory-region
> > @@ -95,8 +85,6 @@ examples:
> >         reg = <0x10803000  0x1000>,
> >               <0x10840000  0x40000>;
> >         reg-names = "cfg", "sram";
> > -       interrupts = <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH 0>;
> > -       interrupt-names = "wdt";
> >         clocks = <&topckgen 10>, //CLK_TOP_ADSP
> >                  <&clk26m>,
> >                  <&topckgen 107>, //CLK_TOP_AUDIO_LOCAL_BUS
> > --
> > 2.18.0
> > 

