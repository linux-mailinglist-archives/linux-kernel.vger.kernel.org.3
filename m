Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8491651D0E0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389279AbiEFFtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389259AbiEFFtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:49:19 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0B418371;
        Thu,  5 May 2022 22:45:32 -0700 (PDT)
X-UUID: e4f81d8e1d9c4eef92bb575f724971fd-20220506
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:16b711ea-c820-44a0-a1c3-3cd2ab4b618b,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:b5656916-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: e4f81d8e1d9c4eef92bb575f724971fd-20220506
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 62907079; Fri, 06 May 2022 13:45:28 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 6 May 2022 13:45:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 May 2022 13:45:27 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 May 2022 13:45:24 +0800
Message-ID: <559a1e189613484b8528dc4eaf19099e9162fcc6.camel@mediatek.com>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Mark Brown <broonie@kernel.org>, <kernel@collabora.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 6 May 2022 13:45:24 +0800
In-Reply-To: <20220505162537.byiwfe2ghomxhezl@notapiano>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
         <20220429203039.2207848-2-nfraprado@collabora.com>
         <4826c824-40ce-5726-ed95-5be069233ca7@collabora.com>
         <cbf2fcbae25408b95875278eb37e829bf4671430.camel@mediatek.com>
         <d1c548bb-8a36-79bf-498d-c909bf7e7679@collabora.com>
         <20220505162537.byiwfe2ghomxhezl@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-05 at 12:25 -0400, Nícolas F. R. A. Prado wrote:
> > 

> On Thu, May 05, 2022 at 10:52:45AM +0200, AngeloGioacchino Del Regno
> wrote:
> > Il 05/05/22 10:48, Jiaxin Yu ha scritto:
> > > On Thu, 2022-05-05 at 10:08 +0200, AngeloGioacchino Del Regno
> > > wrote:
> > > > Il 29/04/22 22:30, Nícolas F. R. A. Prado ha scritto:
> > > > > The Mediatek AFE PCM controller for MT8192 allows sharing of
> > > > > an I2S
> > > > > bus
> > > > > between two busses. Add a pattern for these properties in the
> > > > > dt-binding.
> > > > > 
> > > > > Signed-off-by: Nícolas F. R. A. Prado <
> > > > > nfraprado@collabora.com>
> > > > > ---
> > > > > 
> > > > >    Documentation/devicetree/bindings/sound/mt8192-afe-
> > > > > pcm.yaml | 5
> > > > > +++++
> > > > >    1 file changed, 5 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/sound/mt8192-
> > > > > afe-
> > > > > pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-
> > > > > afe-
> > > > > pcm.yaml
> > > > > index 7a25bc9b8060..5b03c8dbf318 100644
> > > > > --- a/Documentation/devicetree/bindings/sound/mt8192-afe-
> > > > > pcm.yaml
> > > > > +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-
> > > > > pcm.yaml
> > > > > @@ -54,6 +54,11 @@ properties:
> > > > >          - const: aud_infra_clk
> > > > >          - const: aud_infra_26m_clk
> > > > > +patternProperties:
> > > > > +  "^i2s[0-35-9]-share$":
> > > > > +    description: Name of the I2S bus that is shared with
> > > > > this bus
> > > > > +    pattern: "^I2S[0-35-9]$"
> > > > > +
> > > > >    required:
> > > > >      - compatible
> > > > >      - interrupts
> > > > > 
> > > > 
> > > > The only other way of doing this would be to complicate this in
> > > > the
> > > > driver
> > > > so that we can do something like
> > > > 
> > > > "i2s-share = <0 2>";  instead of  i2s0-share = "I2S2";
> > > > 
> > > > ...and I don't think that this would be any more
> > > > straightforward than
> > > > the
> > > > provided way.
> > > > 
> > > > There's an improvement that we can do to that pattern
> > > > description
> > > > though,
> > > > which would be explaining that declaring 'i2s0-share = "I2S2"'
> > > > means
> > > > that
> > > > I2S2's data pin will be used as DATA-OUT, while i2s0 is DATA-
> > > > IN.
> > > > 
> > > > Another thing that comes to mind here is that this is a
> > > > MediaTek
> > > > specific
> > > > property and *not* a generic one, which means that both the
> > > > driver
> > > > and
> > > > this binding should be fixed to get a "mediatek," prefix, so,
> > > > this
> > > > property
> > > > should - in reality - be "mediatek,i2s[0-35-9]-share" instead.
> > > > 
> > > > I think that everyone agrees about that, but let's see what the
> > > > others say.
> > > > 
> > > > Cheers,
> > > > Angelo
> > > 
> > > Hi Angelo,
> > > 
> > > 'i2s0-share = "I2S2"' means that if we want use I2S0, there need
> > > open
> > > I2S2 to provide clock. Conversely, if we want to use I2S2, we
> > > don't
> > > need to open I2S0. However, MediaTek I2S0 and I2S2 hardware are
> > > generally designed as input. So usually we use 'i2s0-share =
> > > "I2S1"'.
> > > Even numbers represent input, odd numbers represent output.
> > > 
> > > Yes, I think adding the "mediatek," prefix is the right way to
> > > define a
> > > non-generic property.
> > > 
> 
> Hi Jiaxin,
> 
> thank you for the insights.
> 
> > 
> > Hello Jiaxin,
> > 
> > if I get this correctly, i2s0-share = "I2S2" would be *invalid*...
> > as you
> > just explained, i2sX, where:
> > 
> > X = even number -> always DATA IN
> > X = odd number  -> always DATA OUT
> > 
> > ...this means that the dt-binding needs a pattern to specify that
> > only odd
> > can be assigned to only even.
> 
> So, the situation seems different at least on mt8192-asurada-
> spherion.
> Here, I2S8 is used for the headset microphone and I2S9 for the
> headset audio.
> Even for input and odd for output agree with Jiaxin's description.
> However, the
> input bus seems to be the main one, that is, disabling I2S8:
> 
> 	amixer cset name='UL2_CH1 I2S8_CH1' 0
> 	amixer cset name='UL2_CH2 I2S8_CH2' 0
> 
> not only disables the microphone but also the audio on the headset.
> If I add 
> 
> 	i2s9-share = "I2S8";
> 
> on the DT, then everything works, I can disable I2S8 without
> impacting the
> headset audio. So the pattern for the property on this platform is
> the opposite
> that Jiaxin mentioned. This tells me that we should keep the binding
> more
> generic (not assume where odds and evens go). I will still apply the
> other
> suggestions mentioned though.
> 
> Thanks,
> Nícolas
> 
Hi Nícolas,

From software point, I2S8 and I2S9 belong to different hardware, so if
you turn off I2S8 with CMD1, of course it will not affect I2S9.

CMD1:
amixer cset name='UL2_CH1 I2S8_CH1' 0
amixer cset name='UL2_CH2 I2S8_CH2' 0

Frome hardware point, I2S9 will use(share) I2S8's clock. If we don't
want the user to perceive this, the driver need to help do something.
So this property 'i2s9-share = "I2S8";' will be added to inform the
driver.

Best Regards,
Jiaxin Yu

> > Nicolas, take note! :-) :-)
> > 
> > Thanks,
> > Angelo
> > 
> > To unsubscribe, send mail to 
> > kernel-unsubscribe@lists.collabora.co.uk.

