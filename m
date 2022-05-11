Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FBB5229A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241415AbiEKC1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbiEKC1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:27:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25EF252B9;
        Tue, 10 May 2022 19:27:03 -0700 (PDT)
X-UUID: c336104a6f984458885a7a98b3ed924b-20220511
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:f812588a-7128-4be8-87d9-57df20bc8858,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:d6df58b3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: c336104a6f984458885a7a98b3ed924b-20220511
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 199278061; Wed, 11 May 2022 10:26:58 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 11 May 2022 10:26:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 May 2022 10:26:56 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 11 May 2022 10:26:56 +0800
Message-ID: <4d2b1c2c4ab27ba96d59b9a0e3adcdab311ec897.camel@mediatek.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: add vdosys1 RDMA
 definition for mt8195
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Jason-JH Lin =?UTF-8?Q?=28=E6=9E=97=E7=9D=BF=E7=A5=A5=29?=" 
        <Jason-JH.Lin@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Nancy Lin =?UTF-8?Q?=28=E6=9E=97=E6=AC=A3=E8=9E=A2=29?= 
        <Nancy.Lin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Date:   Wed, 11 May 2022 10:26:56 +0800
In-Reply-To: <0686125d-4984-5dcd-32ca-4eeece09d7c3@linaro.org>
References: <20220509044302.27878-1-rex-bc.chen@mediatek.com>
         <20220509044302.27878-2-rex-bc.chen@mediatek.com>
         <a5c9e7ad-c4b5-e757-cd6d-f79de47d1ff3@linaro.org>
         <fbbbc7e6a951bdde648ddd896f1fa163dafa16f1.camel@mediatek.com>
         <1c3fd336-1450-9b68-df81-2f01cc2ba32f@linaro.org>
         <CAGXv+5EHFjqiVQbXgcJWCo+TmaTU_z4e0g85beMLCNjyx5qJcw@mail.gmail.com>
         <0686125d-4984-5dcd-32ca-4eeece09d7c3@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-10 at 18:57 +0800, Krzysztof Kozlowski wrote:
> On 10/05/2022 12:37, Chen-Yu Tsai wrote:
> > > Use a generic node name, as Devicetree spec asks:
> > > "The name of a node should be somewhat generic, reflecting the
> > > function
> > > of the device and not its precise programming
> > > 
> > > model. If appropriate, the name should be one of the following
> > > choices:"
> > > 
> > > I proposed dma-controller, but feel free to find better generic
> > > node name.
> > 
> > dma-controller is covered by dma-controller.yaml, which references
> > dma-common.yaml in its entirety, so I don't think that would work.
> > 
> > What about "blitter"? I think that is a generic term that is/was
> > commonly
> > used with display hardware and sort of describes the function of
> > the RDMA
> > & WDMA blocks, and if only one side is memory and the other is the
> > display
> > pipeline.
> 
> Sure, sounds fine!
> 
> 
> Best regards,
> Krzysztof

Hello Krzysztof and Chen-Yu,

Nancy thinks our IP is more like rdma.
Blitter may be somthing for reading memory and writing to another
memory, but we don't have the function of writing memory.
If we use rdma, is it ok?

BRs,
Rex

