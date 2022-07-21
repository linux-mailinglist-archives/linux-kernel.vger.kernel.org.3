Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C294857C254
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiGUCfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiGUCfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:35:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D7DB846;
        Wed, 20 Jul 2022 19:35:18 -0700 (PDT)
X-UUID: a87ce954c5df4c359b7262e0bc1b48bc-20220721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:fcf65bc8-e657-4b99-8b3a-bfd6bc1b7cea,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:6574d964-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: a87ce954c5df4c359b7262e0bc1b48bc-20220721
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1845675534; Thu, 21 Jul 2022 10:35:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 21 Jul 2022 10:35:13 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 21 Jul 2022 10:35:13 +0800
Message-ID: <c79b0f441bc4d7dce6c8d35f189783e69144413f.camel@mediatek.com>
Subject: Re: [PATCH v3 06/21] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
CC:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 21 Jul 2022 10:35:13 +0800
In-Reply-To: <68a30bbd-5f9d-17d2-59fa-7b0da06ee877@linaro.org>
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
         <20220720123023.13500-7-tinghan.shen@mediatek.com>
         <YtgDu70Lpl/uPOkf@google.com>
         <68a30bbd-5f9d-17d2-59fa-7b0da06ee877@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-20 at 19:37 +0200, Krzysztof Kozlowski wrote:
> On 20/07/2022 15:31, Lee Jones wrote:
> > On Wed, 20 Jul 2022, Tinghan Shen wrote:
> > 
> > > The System Control Processor System (SCPSYS) has several power
> > > management related tasks in the system. Add the bindings for it.
> > > 
> > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > 
> > Why have you ignored my review comments from v2?
> 
> If you refer whether the binding is needed at all, then the answer is
> yes, because this is not simple syscons but a device with children,
> which we want to parse/match.
> 
> Anyway Tinghan should respond to you about way how he proceeds...
> 
> Best regards,
> Krzysztof

Hi Lee,

I'm so sorry for not answering your feedback. I misunderstood it
that you're waiting the review result of DT maintainers.

This binding is added because of the discussion of the scpsys node[1].
I first looked at mfd/syscon.yaml to see if I could use it.
I found that it doesn't have the 'simple-mfd' compatible, so I decide to add a new one.
It's because I need the 'simple-mfd' compatible to parse child nodes.


[1] https://lore.kernel.org/all/f7eee4e8-05fa-4c83-9168-64e5ea4c510f@linaro.org/



Best regards,
TingHan

