Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2752E4E37B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbiCVDrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiCVDrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:47:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C881C91A;
        Mon, 21 Mar 2022 20:45:31 -0700 (PDT)
X-UUID: e2f1032bd75c4a44aedc03b14251f9a1-20220322
X-UUID: e2f1032bd75c4a44aedc03b14251f9a1-20220322
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1473736653; Tue, 22 Mar 2022 11:45:27 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Mar 2022 11:45:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 22 Mar
 2022 11:45:25 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Mar 2022 11:45:25 +0800
Message-ID: <0e909de12a52ae88633634d868bd5001eef1b830.camel@mediatek.com>
Subject: Re: [v5 1/4] ASoC: dt-bindings: mt8192-mt6359: add new compatible
 and new properties
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <broonie@kernel.org>, <tzungbi@google.com>,
        <angelogioacchino.delregno@collabora.com>, <aaronyu@google.com>,
        <matthias.bgg@gmail.com>, <trevor.wu@mediatek.com>,
        <linmq006@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 22 Mar 2022 11:45:24 +0800
In-Reply-To: <YjkLVwvxvOKr30qL@robh.at.kernel.org>
References: <20220319114111.11496-1-jiaxin.yu@mediatek.com>
         <20220319114111.11496-2-jiaxin.yu@mediatek.com>
         <YjkLVwvxvOKr30qL@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-21 at 18:33 -0500, Rob Herring wrote:
> On Sat, Mar 19, 2022 at 07:41:08PM +0800, Jiaxin Yu wrote:
> > 1. Adds new compatible string "mt8192_mt6359_rt1015p_rt5682s" for
> > machines
> > with rt1015p and rt5682s.
> > 2. Adds new property "mediatek,headset-codec" for getting headset
> > codecs.
> > 3. Adds new property "mediatek,speaker-codec" for getting speaker
> > codecs.
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > ---
> >  .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 29
> > +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-
> > rt1015-rt5682.yaml
> > b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-
> > rt5682.yaml
> > index a781e7aaaa38..aa0476eedd38 100644
> > --- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-
> > rt5682.yaml
> > +++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-
> > rt5682.yaml
> > @@ -18,6 +18,7 @@ properties:
> >      enum:
> >        - mediatek,mt8192_mt6359_rt1015_rt5682
> >        - mediatek,mt8192_mt6359_rt1015p_rt5682
> > +      - mediatek,mt8192_mt6359_rt1015p_rt5682s
> >  
> >    mediatek,platform:
> >      $ref: "/schemas/types.yaml#/definitions/phandle"
> > @@ -27,6 +28,25 @@ properties:
> >      $ref: "/schemas/types.yaml#/definitions/phandle"
> >      description: The phandle of HDMI codec.
> >  
> > +patternProperties:
> > +  "^mediatek,headset-codec$":
> 
> Fixed string, not a pattern. Move to 'properties'. Drop the vendor 
> prefix too.
> 
Hi Rob,

I originally referred to simple-card.yaml and move "xxx.yyy" to the
patternProperties.

Such as:
# use patternProperties to avoid naming "xxx,yyy" issue
patternProperties:
  "^simple-audio-card,widgets$":
    $ref: "#/definitions/widgets"

But your comment is more reasonable. I will move them to 'properties'
and drop the vendor prefix. Thanks for your review.


> > +    description: Holds subnode which indicates headset dai.
> > +    type: object
> > +    properties:
> > +      sound-dai:
> > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Standard property, don't need a type or description. Just how many
> and 
> what each one is if more than 1.

Should I describe them as below?

properties:
...
  speaker-codec:
    type: object
    properties:
      sound-dai:
         maxItems: 1
...

> 
> > +        description: List of phandles to the headset codec nodes.
> 
> More than 1?
> 

Sorry, the description here is incorrect, there is only one phandle.

> > +    additionalProperties: false
> > +
> > +  "^mediatek,speaker-codec$":
> > +    description: Holds subnode which indicates speaker dai.
> > +    type: object
> > +    properties:
> > +      sound-dai:
> > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> > +        description: List of phandles to the speaker codec nodes.
> 
> Same here.
> 
> > +    additionalProperties: false
> > +
> >  additionalProperties: false
> >  
> >  required:
> > @@ -44,6 +64,15 @@ examples:
> >                          "aud_clk_mosi_on";
> >          pinctrl-0 = <&aud_clk_mosi_off>;
> >          pinctrl-1 = <&aud_clk_mosi_on>;
> > +
> > +        mediatek,headset-codec {
> > +            sound-dai = <&rt5682>;
> > +        };
> > +
> > +        mediatek,speaker-codec {
> > +            sound-dai = <&rt1015_l>,
> > +                        <&rt1015_r>;
> > +        };
> >      };
> >  
> >  ...
> > -- 
> > 2.18.0
> > 
> > 

