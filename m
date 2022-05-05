Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D943551C516
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381957AbiEEQ3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380217AbiEEQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:29:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C207318E1C;
        Thu,  5 May 2022 09:25:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 393751F45ABD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651767943;
        bh=us6VQcZonVRZDNCqwnPC3/ZUDrCZ5LkU3g8yGafttv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DsrqAmPPKwC1WvZxKzkbXTRjRJEiP/WizLShBmIu304hhlhhHNQSz9qLISwTIbG4W
         v+6C9yOSV7c/7M3TEtnFvJe94HChoUgbpjOn6Wq2SqjrQtu0kwsVmCwnUlmEmIBirc
         Po88xEbIChaOX6eNz/QE3ZfTlD8UWv0968oKjyBsx0JJoQrR9SVC1tIhACa4HxuwZG
         WLyeqN2LlBDs+gUf5pcSTlu3ulu/pfIYCtS/nxaM7Dy24gZUCy/W8KtsAuNrOhSj8m
         PA8F2q4XiLyQWx9Yhov61BeZXMt2Dkpy3lcK9Bvw6Uo5MNELIFEBZRKrFFCt+7MaRc
         BmlcLSapwch7g==
Date:   Thu, 5 May 2022 12:25:37 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
Message-ID: <20220505162537.byiwfe2ghomxhezl@notapiano>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
 <20220429203039.2207848-2-nfraprado@collabora.com>
 <4826c824-40ce-5726-ed95-5be069233ca7@collabora.com>
 <cbf2fcbae25408b95875278eb37e829bf4671430.camel@mediatek.com>
 <d1c548bb-8a36-79bf-498d-c909bf7e7679@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1c548bb-8a36-79bf-498d-c909bf7e7679@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 10:52:45AM +0200, AngeloGioacchino Del Regno wrote:
> Il 05/05/22 10:48, Jiaxin Yu ha scritto:
> > On Thu, 2022-05-05 at 10:08 +0200, AngeloGioacchino Del Regno wrote:
> > > Il 29/04/22 22:30, Nícolas F. R. A. Prado ha scritto:
> > > > The Mediatek AFE PCM controller for MT8192 allows sharing of an I2S
> > > > bus
> > > > between two busses. Add a pattern for these properties in the
> > > > dt-binding.
> > > > 
> > > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > > ---
> > > > 
> > > >    Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml | 5
> > > > +++++
> > > >    1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-
> > > > pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-
> > > > pcm.yaml
> > > > index 7a25bc9b8060..5b03c8dbf318 100644
> > > > --- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > > > +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > > > @@ -54,6 +54,11 @@ properties:
> > > >          - const: aud_infra_clk
> > > >          - const: aud_infra_26m_clk
> > > > +patternProperties:
> > > > +  "^i2s[0-35-9]-share$":
> > > > +    description: Name of the I2S bus that is shared with this bus
> > > > +    pattern: "^I2S[0-35-9]$"
> > > > +
> > > >    required:
> > > >      - compatible
> > > >      - interrupts
> > > > 
> > > 
> > > The only other way of doing this would be to complicate this in the
> > > driver
> > > so that we can do something like
> > > 
> > > "i2s-share = <0 2>";  instead of  i2s0-share = "I2S2";
> > > 
> > > ...and I don't think that this would be any more straightforward than
> > > the
> > > provided way.
> > > 
> > > There's an improvement that we can do to that pattern description
> > > though,
> > > which would be explaining that declaring 'i2s0-share = "I2S2"' means
> > > that
> > > I2S2's data pin will be used as DATA-OUT, while i2s0 is DATA-IN.
> > > 
> > > Another thing that comes to mind here is that this is a MediaTek
> > > specific
> > > property and *not* a generic one, which means that both the driver
> > > and
> > > this binding should be fixed to get a "mediatek," prefix, so, this
> > > property
> > > should - in reality - be "mediatek,i2s[0-35-9]-share" instead.
> > > 
> > > I think that everyone agrees about that, but let's see what the
> > > others say.
> > > 
> > > Cheers,
> > > Angelo
> > 
> > Hi Angelo,
> > 
> > 'i2s0-share = "I2S2"' means that if we want use I2S0, there need open
> > I2S2 to provide clock. Conversely, if we want to use I2S2, we don't
> > need to open I2S0. However, MediaTek I2S0 and I2S2 hardware are
> > generally designed as input. So usually we use 'i2s0-share = "I2S1"'.
> > Even numbers represent input, odd numbers represent output.
> > 
> > Yes, I think adding the "mediatek," prefix is the right way to define a
> > non-generic property.
> > 

Hi Jiaxin,

thank you for the insights.

> 
> Hello Jiaxin,
> 
> if I get this correctly, i2s0-share = "I2S2" would be *invalid*... as you
> just explained, i2sX, where:
> 
> X = even number -> always DATA IN
> X = odd number  -> always DATA OUT
> 
> ...this means that the dt-binding needs a pattern to specify that only odd
> can be assigned to only even.

So, the situation seems different at least on mt8192-asurada-spherion.
Here, I2S8 is used for the headset microphone and I2S9 for the headset audio.
Even for input and odd for output agree with Jiaxin's description. However, the
input bus seems to be the main one, that is, disabling I2S8:

	amixer cset name='UL2_CH1 I2S8_CH1' 0
	amixer cset name='UL2_CH2 I2S8_CH2' 0

not only disables the microphone but also the audio on the headset. If I add 

	i2s9-share = "I2S8";

on the DT, then everything works, I can disable I2S8 without impacting the
headset audio. So the pattern for the property on this platform is the opposite
that Jiaxin mentioned. This tells me that we should keep the binding more
generic (not assume where odds and evens go). I will still apply the other
suggestions mentioned though.

Thanks,
Nícolas

> 
> Nicolas, take note! :-) :-)
> 
> Thanks,
> Angelo
> 
> -- 
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.
