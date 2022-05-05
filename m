Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213D051B5B2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbiEECRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiEECRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:17:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D99F473AA;
        Wed,  4 May 2022 19:13:50 -0700 (PDT)
X-UUID: eaa920a7b9914c7fa8bde4e0efc6f109-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:6cfe91a2-dde4-4508-8ff0-da5df5c84a55,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:0dbc9ab2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: eaa920a7b9914c7fa8bde4e0efc6f109-20220505
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1533016179; Thu, 05 May 2022 10:13:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 5 May 2022 10:13:43 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 5 May 2022 10:13:41 +0800
Message-ID: <97d295bf950ea3dbccbcaa7f5a60ccc7bc0b1cab.camel@mediatek.com>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Rob Herring <robh@kernel.org>,
        "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     Mark Brown <broonie@kernel.org>, <kernel@collabora.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shane Chien <shane.chien@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 5 May 2022 10:13:42 +0800
In-Reply-To: <YnLkYKmJ0TJ8uyjC@robh.at.kernel.org>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
         <20220429203039.2207848-2-nfraprado@collabora.com>
         <YnLkYKmJ0TJ8uyjC@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-04 at 15:38 -0500, Rob Herring wrote:
> On Fri, Apr 29, 2022 at 04:30:37PM -0400, Nícolas F. R. A. Prado
> wrote:
> > The Mediatek AFE PCM controller for MT8192 allows sharing of an I2S
> > bus
> > between two busses. Add a pattern for these properties in the
> > dt-binding.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > 
> >  Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml | 5
> > +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-
> > pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-
> > pcm.yaml
> > index 7a25bc9b8060..5b03c8dbf318 100644
> > --- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> > @@ -54,6 +54,11 @@ properties:
> >        - const: aud_infra_clk
> >        - const: aud_infra_26m_clk
> >  
> > +patternProperties:
> > +  "^i2s[0-35-9]-share$":
> > +    description: Name of the I2S bus that is shared with this bus
> > +    pattern: "^I2S[0-35-9]$"
> 
> Why not a phandle to the the other bus? That would be the DT way to
> do 
> it. But I'm not sure I really understand who is sharing what here.
> 
I can explain the usage of this property. The I2S interface of MT8192
only have 3 pins [bit clock/ frame clock/ data in(or out)]. So if we
want use them as normal I2S that has 4 pins [bit clock/ frame clock/
data in/ data out], we need to combine two MT8192 I2S interface to use.
But we need to specify whose clock they use. E.g. "i2s9-share =
"I2S8"".

> > +
> >  required:
> >    - compatible
> >    - interrupts
> > -- 
> > 2.36.0
> > 
> > 

