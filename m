Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB0F551089
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbiFTGlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbiFTGlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:41:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B80DF3C;
        Sun, 19 Jun 2022 23:41:01 -0700 (PDT)
X-UUID: a81145aad18047b6abe219e63e63243e-20220620
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:2da8612c-23aa-4f9d-98f5-3e4df808eb93,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:2da8612c-23aa-4f9d-98f5-3e4df808eb93,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:5a10832d-1756-4fa3-be7f-474a6e4be921,C
        OID:e6edc2b7deba,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: a81145aad18047b6abe219e63e63243e-20220620
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1860347345; Mon, 20 Jun 2022 14:40:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 20 Jun 2022 14:40:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 20 Jun 2022 14:40:55 +0800
Message-ID: <af32751dd7013a96dac5d165c35e132fda87f2ac.camel@mediatek.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: dsp: mediatek: Use meaningful names
 for mbox
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, YC Hung <yc.hung@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 20 Jun 2022 14:40:55 +0800
In-Reply-To: <629e761b-e3ad-0861-1937-ad660a8a900b@linaro.org>
References: <20220616073042.13229-1-tinghan.shen@mediatek.com>
         <20220616073042.13229-2-tinghan.shen@mediatek.com>
         <629e761b-e3ad-0861-1937-ad660a8a900b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, 2022-06-16 at 06:55 -0700, Krzysztof Kozlowski wrote:
> On 16/06/2022 00:30, Tinghan Shen wrote:
> > Rename mbox according to actions instead of 'mbox0' and 'mbox1'.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >  .../devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml   | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> > b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> > index b7e68b0dfa13..ca8d8661f872 100644
> > --- a/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> > +++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml
> > @@ -50,13 +50,13 @@ properties:
> >  
> >    mboxes:
> >      items:
> > -      - description: ipc reply between host and audio DSP.
> > -      - description: ipc request between host and audio DSP.
> > +      - description: mailbox for receiving audio DSP requests.
> > +      - description: mailbox for transmitting requests to audio DSP.
> >  
> >    mbox-names:
> >      items:
> > -      - const: mbox0
> > -      - const: mbox1
> > +      - const: rx
> > +      - const: tx
> >  
> 
> Commit msg lacks important piece - do you break any users with this? Do
> you have any users of this binding?
> 
> 
> Best regards,
> Krzysztof

The 8195 dsp node, which uses this binding, has not yet been added to the 8195 devicetree.


Thanks,
TingHan

