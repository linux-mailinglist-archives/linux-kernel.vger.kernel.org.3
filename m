Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE8051BAEF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350439AbiEEIw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350432AbiEEIwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:52:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F754AE2D;
        Thu,  5 May 2022 01:48:40 -0700 (PDT)
X-UUID: b6a27cbdd49b4151970748d245fa15a2-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b0e02674-ab0d-40a7-ad44-6868b5f9cd64,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:6a14acb2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: b6a27cbdd49b4151970748d245fa15a2-20220505
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1325095859; Thu, 05 May 2022 16:48:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 5 May 2022 16:48:32 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 5 May 2022 16:48:31 +0800
Message-ID: <cbf2fcbae25408b95875278eb37e829bf4671430.camel@mediatek.com>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>,
        "Mark Brown" <broonie@kernel.org>
CC:     <kernel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 5 May 2022 16:48:31 +0800
In-Reply-To: <4826c824-40ce-5726-ed95-5be069233ca7@collabora.com>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
         <20220429203039.2207848-2-nfraprado@collabora.com>
         <4826c824-40ce-5726-ed95-5be069233ca7@collabora.com>
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

On Thu, 2022-05-05 at 10:08 +0200, AngeloGioacchino Del Regno wrote:
> Il 29/04/22 22:30, Nícolas F. R. A. Prado ha scritto:
> > The Mediatek AFE PCM controller for MT8192 allows sharing of an I2S
> > bus
> > between two busses. Add a pattern for these properties in the
> > dt-binding.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > 
> >   Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml | 5
> > +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-
> > pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-
> > pcm.yaml
> > index 7a25bc9b8060..5b03c8dbf318 100644
> > --- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > @@ -54,6 +54,11 @@ properties:
> >         - const: aud_infra_clk
> >         - const: aud_infra_26m_clk
> >   
> > +patternProperties:
> > +  "^i2s[0-35-9]-share$":
> > +    description: Name of the I2S bus that is shared with this bus
> > +    pattern: "^I2S[0-35-9]$"
> > +
> >   required:
> >     - compatible
> >     - interrupts
> > 
> 
> The only other way of doing this would be to complicate this in the
> driver
> so that we can do something like
> 
> "i2s-share = <0 2>";  instead of  i2s0-share = "I2S2";
> 
> ...and I don't think that this would be any more straightforward than
> the
> provided way.
> 
> There's an improvement that we can do to that pattern description
> though,
> which would be explaining that declaring 'i2s0-share = "I2S2"' means
> that
> I2S2's data pin will be used as DATA-OUT, while i2s0 is DATA-IN.
> 
> Another thing that comes to mind here is that this is a MediaTek
> specific
> property and *not* a generic one, which means that both the driver
> and
> this binding should be fixed to get a "mediatek," prefix, so, this
> property
> should - in reality - be "mediatek,i2s[0-35-9]-share" instead.
> 
> I think that everyone agrees about that, but let's see what the
> others say.
> 
> Cheers,
> Angelo

Hi Angelo,

'i2s0-share = "I2S2"' means that if we want use I2S0, there need open
I2S2 to provide clock. Conversely, if we want to use I2S2, we don't
need to open I2S0. However, MediaTek I2S0 and I2S2 hardware are
generally designed as input. So usually we use 'i2s0-share = "I2S1"'.
Even numbers represent input, odd numbers represent output.

Yes, I think adding the "mediatek," prefix is the right way to define a
non-generic property.

Best Regards,
Jiaxin Yu

