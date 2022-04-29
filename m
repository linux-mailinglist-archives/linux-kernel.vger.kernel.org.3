Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDC951437D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355239AbiD2H63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355272AbiD2H6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:58:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5EDB89B9;
        Fri, 29 Apr 2022 00:55:01 -0700 (PDT)
X-UUID: a2d375cbe3214166b7b74d91b654309b-20220429
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:79fb99bc-c078-49c0-84d1-915b7893baa5,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:bf72282f-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: a2d375cbe3214166b7b74d91b654309b-20220429
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1131853425; Fri, 29 Apr 2022 15:54:43 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 29 Apr 2022 15:54:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 Apr 2022 15:54:41 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Apr 2022 15:54:41 +0800
Message-ID: <0a43e9787c8e4886b361268a58e755afbf81be1d.camel@mediatek.com>
Subject: Re: [PATCH] dt-bindings: arm: mediatek: mmsys: refine power and gce
 properties
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Fabien Parent <fparent@baylibre.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 29 Apr 2022 15:54:41 +0800
In-Reply-To: <9779588a-5bda-ea82-64a0-c13d48d89eff@linaro.org>
References: <20220428012715.2619-1-jason-jh.lin@mediatek.com>
         <b7bb228f-751c-e7ad-a695-3dc40d889a72@linaro.org>
         <60338c26047f47c77fdc7d4eff6a7dee43853e1b.camel@mediatek.com>
         <9779588a-5bda-ea82-64a0-c13d48d89eff@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the reviews.

On Fri, 2022-04-29 at 07:55 +0200, Krzysztof Kozlowski wrote:
> On 29/04/2022 06:10, Jason-JH Lin wrote:
> > Yes, we cannot have infinite number for this, but we can use not
> > only
> > one mbox channel for one mmsys.
> > 
> > Its maximum number is equal to GCE HW thread number.
> > The maximum number in mt8195 is 24 and mt8173 is 16.
> > 
> > But we currently using 1.
> > So I'm not sure if I need to set the maxItems for this?
> 
> Yes. 24 for mt8195 and 16 for mt8173.
> 
OK, I'll add maxItems: 24.
> > 
> > > 
> > > >      description:
> > > > -      Using mailbox to communicate with GCE, it should have
> > > > this
> > > > -      property and list of phandle, mailbox specifiers. See
> > > > -      Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> > > > for
> > > > details.
> > > > -    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > +      If using mailbox to communicate with GCE, it should have
> > > > this
> > > > +      property. GCE will help configure the hardware settings
> > > > for
> > > > the
> > > > +      current mmsys data pipeline.
> > > >  
> > > >    mediatek,gce-client-reg:
> > > > -    description:
> > > > -      The register of client driver can be configured by gce
> > > > with
> > > > 4 arguments
> > > > -      defined in this property, such as phandle of gce, subsys
> > > > id,
> > > > -      register offset and size.
> > > > -      Each subsys id is mapping to a base address of display
> > > > function blocks
> > > > -      register which is defined in the gce header
> > > > -      include/dt-bindings/gce/<chip>-gce.h.
> > > > -    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > 
> > > Why removing ref? Does your binding work after such change?
> > 
> > I removed it unexpectedly, I'll add it back.
> 
> Just be sure you test it before submitting...
> 
I'm sorry about this.
I think something wrong in my local scanning environment.
I'll fix this and test it before submitting the next version.

Regards,
Jason-JH.Lin
> 
> Best regards,
> Krzysztof
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> 
https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-mediatek__;!!CTRNKA9wMg0ARbw!3EBAk7zcr3iMc-Todq-efcLmYCZNkxH9gYnUmY1tHbPiVm9yNYhrI-Yj0I16f8jGnA6B$
>  
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

