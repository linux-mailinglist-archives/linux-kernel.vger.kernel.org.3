Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4485229B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241208AbiEKC3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiEKC3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:29:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D730C219C01;
        Tue, 10 May 2022 19:29:20 -0700 (PDT)
X-UUID: fd0a9a853dde486aae5d21a9929b5353-20220511
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:34c66137-9e53-4614-af2a-79dd9aecb23c,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:34c66137-9e53-4614-af2a-79dd9aecb23c,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:87f958b3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:008f62d8b7ee,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: fd0a9a853dde486aae5d21a9929b5353-20220511
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 140623551; Wed, 11 May 2022 10:29:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 11 May 2022 10:29:13 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 11 May 2022 10:29:13 +0800
Message-ID: <c0db4e1a720fe66d0c3ac4699cb4f5d34a3e6802.camel@mediatek.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: mediatek: add ethdr definition for
 mt8195
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     "airlied@linux.ie" <airlied@linux.ie>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        Jason-JH Lin =?UTF-8?Q?=28=E6=9E=97=E7=9D=BF=E7=A5=A5=29?= 
        <Jason-JH.Lin@mediatek.com>,
        Nancy Lin =?UTF-8?Q?=28=E6=9E=97=E6=AC=A3=E8=9E=A2=29?= 
        <Nancy.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 11 May 2022 10:29:13 +0800
In-Reply-To: <f1d477d2-13c4-2914-e520-4b2778e52e35@linaro.org>
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com>
         <20220509044302.27878-4-rex-bc.chen@mediatek.com>
         <46bc32df-e4e8-ac47-426d-8056714f0d5c@linaro.org>
         <5462209c5afb0a638ed777ec1829bb2717c8d76e.camel@mediatek.com>
         <98505974-afad-9639-d4f2-814097b0523b@linaro.org>
         <85fcdcd0-e7c5-5192-9113-c69f9c3a6385@collabora.com>
         <2a480ca0cf640e59a12d55435d02cb3892035a35.camel@mediatek.com>
         <f1d477d2-13c4-2914-e520-4b2778e52e35@linaro.org>
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

On Tue, 2022-05-10 at 19:19 +0800, Krzysztof Kozlowski wrote:
> On 10/05/2022 03:46, Rex-BC Chen wrote:
> > > 
> > > 
> > > That's mediatek-drm, and this refers to the HDR block in the
> > > display
> > > IP...
> > > 
> > > Though, I have no idea of what "ET" stands for in "ETHDR", so, it
> > > would be
> > > definitely nice if MediaTek can write the meaning in the
> > > description,
> > > like
> > > 
> > > description:
> > >    ETHDR (E??? T??? High Dynamic Range) is designed for HDR video
> > > and
> > > ...blah
> > > 
> > > Cheers,
> > > Angelo
> > 
> > Hello Krzysztof and Angelo,
> > 
> > "ET" is actually meaningless.
> > ET is one of mediatek departments and it's where the engine from.
> > Therefore, I think we will add description like this:
> > > ETHDR (ET High Dynamic Range) is a MediaTek internal HDR engine
> > > and
> > > designed for HDR video...
> 
> Sure, sounds good, but then the node name should not have it. Please
> try
> to find some more generic name (DT spec gives examples). Could be
> display-controller, "hdr-engine", "isp".
> 
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

Thanks for your suggestion.
We will use hdr-engine to name this node.
Thanks!

BRs,
Rex

