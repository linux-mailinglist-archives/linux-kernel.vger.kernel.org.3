Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4515651458F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356673AbiD2Jnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356627AbiD2Jnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:43:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C3238AD;
        Fri, 29 Apr 2022 02:40:10 -0700 (PDT)
X-UUID: 144feaeb2add4d3b98ffa866a261fc3c-20220429
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:e54a13ef-e425-4c35-a96e-b8fa1264c69f,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:faefae9,CLOUDID:f0372d2f-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 144feaeb2add4d3b98ffa866a261fc3c-20220429
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1916973249; Fri, 29 Apr 2022 17:40:04 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 29 Apr 2022 17:40:03 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Apr 2022 17:40:02 +0800
Message-ID: <5e400f7ccb3b208a033e2ad8f220331851ff9c7e.camel@mediatek.com>
Subject: Re: [v4 16/18] dt-bindings: mediatek: mt8186: add
 mt8186-mt6366-da7219-max98357 document
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <broonie@kernel.org>, <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <tzungbi@google.com>, <linux-mediatek@lists.infradead.org>,
        <trevor.wu@mediatek.com>, <matthias.bgg@gmail.com>,
        <aaronyu@google.com>, <julianbraha@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 29 Apr 2022 17:40:02 +0800
In-Reply-To: <YmqlNV31FrcAyuN9@robh.at.kernel.org>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
         <20220428093355.16172-17-jiaxin.yu@mediatek.com>
         <YmqlNV31FrcAyuN9@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-28 at 09:31 -0500, Rob Herring wrote:
> On Thu, Apr 28, 2022 at 05:33:53PM +0800, Jiaxin Yu wrote:
> > Add document for mt8186 board with mt6366, da7219 and max98357.
> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > ---
> >  .../sound/mt8186-mt6366-da7219-max98357.yaml  | 71
> > +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/mt8186-
> > mt6366-da7219-max98357.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-
> > da7219-max98357.yaml
> > b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-
> > max98357.yaml
> > new file mode 100644
> > index 000000000000..55e8649f2aea
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-
> > max98357.yaml
> > @@ -0,0 +1,71 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: 
> > http://devicetree.org/schemas/sound/mt8186-mt6366-da7219-max98357.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mediatek MT8186 with MT6366, DA7219 and MAX98357 ASoC sound
> > card driver
> > +
> > +maintainers:
> > +  - Jiaxin Yu <jiaxin.yu@mediatek.com>
> > +
> > +description:
> > +  This binding describes the MT8186 sound card.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt8186_mt6366_da7219_max98357_sound
> 
> s/_/-/
> 
Got it.
> > +
> > +  mediatek,platform:
> > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> > +    description: The phandle of MT8186 ASoC platform.
> > +
> > +  headset-codec:
> > +    type: object
> 
>        additionalProperties: false
Ditto.
> 
> > +    properties:
> > +      sound-dai:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> 
> sound-dai already has a type, so drop and define how many entries.
> 
Ditto.
> > +    required:
> > +        - sound-dai
> > +

The indentation of this line is incorrect. I will fix it.

> > +  playback-codecs:
> > +    type: object
> 
>        additionalProperties: false
> 
Got it.
> > +    properties:
> > +      sound-dai:
> > +        minItems: 2
> > +        maxItems: 3
> 
> If more than 1 entry, then you need to define what each one is and
> the 
> order. Just like reg, interrupts, clocks, etc.
> 
Hi Rob,

Should I correct them as below?

---
properties:
  sound-dai:
    minItems: 2
    maxItems: 3
    items:
      - items:
          - description: xxx
          - description: yyy
          - description: zzz

> > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Drop
> 
Got it.
> > +    required:
> > +        - sound-dai
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - mediatek,platform
> > +  - headset-codec
> > +  - playback-codecs
> > +
> > +examples:
> > +  - |
> > +
> > +    sound: mt8186-sound {
> > +        compatible =
> > "mediatek,mt8186_mt6366_da7219_max98357_sound";
> > +        mediatek,platform = <&afe>;
> > +        pinctrl-names = "aud_clk_mosi_off",
> > +                        "aud_clk_mosi_on";
> > +        pinctrl-0 = <&aud_clk_mosi_off>;
> > +        pinctrl-1 = <&aud_clk_mosi_on>;
> > +
> > +        headset-codec {
> > +            sound-dai = <&da7219>;
> > +        };
> > +
> > +        playback-codecs {
> > +            sound-dai = <&anx_bridge_dp>,
> > +                        <&max98357a>;
> > +        };
> > +    };
> > +
> > +...
> > -- 
> > 2.25.1
> > 

