Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818A34B0A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239268AbiBJKAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:00:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239249AbiBJKAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:00:01 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2254BD2;
        Thu, 10 Feb 2022 01:59:54 -0800 (PST)
X-UUID: 20a137188a8c45cc8ed18260cb1c5dc4-20220210
X-UUID: 20a137188a8c45cc8ed18260cb1c5dc4-20220210
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 44955023; Thu, 10 Feb 2022 17:59:48 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 10 Feb 2022 17:59:47 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Feb
 2022 17:59:46 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Feb 2022 17:59:45 +0800
Message-ID: <12deb1b056a68e742979c7dcaf1e2c627b982825.camel@mediatek.com>
Subject: Re: [PATCH v2, 1/7] dt-bindings: media: mtk-vcodec: Adds decoder
 dt-bindings for lat soc
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rob Herring" <robh@kernel.org>
CC:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 10 Feb 2022 17:59:45 +0800
In-Reply-To: <f807c862-d327-5b12-7443-c4fed6e1ef6a@collabora.com>
References: <20220128035440.24533-1-yunfei.dong@mediatek.com>
         <20220128035440.24533-2-yunfei.dong@mediatek.com>
         <YgQl8CtttQ99+8lB@robh.at.kernel.org>
         <aa72bec2064e25990e1a3641b920cb5528cfccd4.camel@mediatek.com>
         <f807c862-d327-5b12-7443-c4fed6e1ef6a@collabora.com>
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

Hi AngeloGioacchino,

Thanks for your suggestion.
On Thu, 2022-02-10 at 09:40 +0100, AngeloGioacchino Del Regno wrote:
> Il 10/02/22 04:06, yunfei.dong@mediatek.com ha scritto:
> > Hi Rob,
> > 
> > Thanks for your suggestion.
> > On Wed, 2022-02-09 at 14:37 -0600, Rob Herring wrote:
> > > On Fri, Jan 28, 2022 at 11:54:34AM +0800, Yunfei Dong wrote:
> > > > Adds decoder dt-bindings for compatible "mediatek,mtk-vcodec-
> > > > lat-
> > > > soc".
> > > 
> > > What's lat soc? How does this relate to what's already there in
> > > this
> > > binding.
> > > 
> > 
> > lat soc is another hardware, is related with some vdec larb ports.
> > Won't be used to decode, but must to write it in dtsi, or hardware
> > can't work well.
> 
> Hello Yunfei,
> 
> as a suggestion, writing the meaning of the "LAT" acronym may also
I'm very sorry, I can't write the meaning of the "LAT" acronym. You can
regards it as an hardware.

> help to clear some doubts around (please, also do that in the yaml
> file,
> other than the commit description).
> 
I will add detail message for this hardware in next patch. And this
hardware only be used for mt8195 at now.

> Thank you!
> Angelo
> 
Best Regards,
Yunfei Dong
> > 
> > Need to enable clock/power/iommus, no interrupt.
> > > The subject space is limited, avoid saying the same thing twice
> > > (dt-bindings).
> > > 
> > 
> > Best Regards,
> > Yunfei Dong
> > > > 
> > > > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > > > ---
> > > >   .../media/mediatek,vcodec-subdev-decoder.yaml | 49
> > > > +++++++++++++++++++
> > > >   1 file changed, 49 insertions(+)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > > > subdev-
> > > > decoder.yaml
> > > > b/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > > > subdev-
> > > > decoder.yaml
> > > > index 6415c9f29130..a3c892338ac0 100644
> > > > --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > > > subdev-decoder.yaml
> > > > +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-
> > > > subdev-decoder.yaml
> > > > @@ -189,6 +189,55 @@ patternProperties:
> > > >   
> > > >       additionalProperties: false
> > > >   
> > > > +  '^vcodec-lat-soc@[0-9a-f]+$':
> > > > +    type: object
> > > > +
> > > > +    properties:
> > > > +      compatible:
> > > > +        const: mediatek,mtk-vcodec-lat-soc
> > > > +
> > > > +      reg:
> > > > +        maxItems: 1
> > > > +
> > > > +      iommus:
> > > > +        minItems: 1
> > > > +        maxItems: 32
> > > > +        description: |
> > > > +          List of the hardware port in respective IOMMU block
> > > > for
> > > > current Socs.
> > > > +          Refer to bindings/iommu/mediatek,iommu.yaml.
> > > > +
> > > > +      clocks:
> > > > +        maxItems: 5
> > > > +
> > > > +      clock-names:
> > > > +        items:
> > > > +          - const: sel
> > > > +          - const: soc-vdec
> > > > +          - const: soc-lat
> > > > +          - const: vdec
> > > > +          - const: top
> > > > +
> > > > +      assigned-clocks:
> > > > +        maxItems: 1
> > > > +
> > > > +      assigned-clock-parents:
> > > > +        maxItems: 1
> > > > +
> > > > +      power-domains:
> > > > +        maxItems: 1
> > > > +
> > > > +    required:
> > > > +      - compatible
> > > > +      - reg
> > > > +      - iommus
> > > > +      - clocks
> > > > +      - clock-names
> > > > +      - assigned-clocks
> > > > +      - assigned-clock-parents
> > > > +      - power-domains
> > > > +
> > > > +    additionalProperties: false
> > > > +
> > > >   required:
> > > >     - compatible
> > > >     - reg
> > > > -- 
> > > > 2.25.1
> > > > 
> > > > 
> 
> 

