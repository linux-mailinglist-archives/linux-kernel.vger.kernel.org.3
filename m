Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0908E50F416
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbiDZIcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344899AbiDZIbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:31:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AF67DAAF;
        Tue, 26 Apr 2022 01:24:59 -0700 (PDT)
X-UUID: 8e75016a60514b81be909cfb7eeb1e30-20220426
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:3fd02bc8-e753-422f-add6-d674bf6e7ff4,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:cac083c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 8e75016a60514b81be909cfb7eeb1e30-20220426
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1336388002; Tue, 26 Apr 2022 16:24:55 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 26 Apr 2022 16:24:54 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Apr 2022 16:24:54 +0800
Message-ID: <edaf444b9c45e5f36757116fe098749348cb54b7.camel@mediatek.com>
Subject: Re: [PATCH V3 11/17] dt-bindings: arm: mediatek: Add #reset-cells
 property for MT8192-sys-clock
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen =?UTF-8?Q?=28=E9=99=B3=E6=B5=9A=E6=A1=80=29?= 
        <Chun-Jie.Chen@mediatek.com>,
        "wenst@chromium.org" <wenst@chromium.org>,
        Runyang Chen =?UTF-8?Q?=28=E9=99=88=E6=B6=A6=E6=B4=8B=29?= 
        <Runyang.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 26 Apr 2022 16:24:54 +0800
In-Reply-To: <64411bc7-ce4d-9f85-be8f-c93d6b2a0360@linaro.org>
References: <20220422060152.13534-1-rex-bc.chen@mediatek.com>
         <20220422060152.13534-12-rex-bc.chen@mediatek.com>
         <288f55f3-b3ed-32b8-9a44-652f3d53617d@linaro.org>
         <fdedea6f20738bfe2ede7e526aa653af1ac35768.camel@mediatek.com>
         <64411bc7-ce4d-9f85-be8f-c93d6b2a0360@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 15:44 +0800, Krzysztof Kozlowski wrote:
> On 25/04/2022 04:37, Rex-BC Chen wrote:
> > > > +  '#reset-cells':
> > > > +    maximum: 2
> > > 
> > > Why this is a maximum? Usually this is const, so how do you use
> > > it
> > > (with
> > > what values)?
> > > 
> > 
> > We need to let the driver compatible with previous setting in
> > drivers/clk/mediatek/reset.c
> 
> Then it should be enum [1, 2], because '0' is not valid.
> 
> > There are two use cases in our reset driver:
> > (Refer to [1])
> > 
> > 1. #reset-cells = <1>
> >    When we input the argument, the older driver
> > use is to calculate  
> >    bank and bit by different method. From the implementation of
> >    reset_xlate(), we can see if the argument number is 1, it will
> >    return directly.
> 
> I understand this is an old binding with older compatibles, so this
> should be restricted per each variant (allOf:if:then)... but wait,
> old
> binding did not allow any reset-cells! You add an entirely new
> binding
> property and already want to support some older (deprecated?) way.
> 
> > 
> > 2. #reset-cells = <2>
> >    The input arguments is offset and bit. When we input two
> > arguments,
> >    we can use reset_xlate() to calculate the corresponding id to
> > assert
> >    and deassert.
> > 
> > [1]:
> > 
https://urldefense.com/v3/__https://lore.kernel.org/all/20220422060152.13534-10-rex-bc.chen@mediatek.com/__;!!CTRNKA9wMg0ARbw!0U0Yrp6WQxZ0YNMjaLJbAdq6Zyc524B4CY57-TP7QJ5FoSkCM72VI7mHJyWa1SZCnYTK$
> >  
> > 
> > If it's acceptable, I will add this in commit message.
> 
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

I will let #reset-cells = <1> in next version and abandon the
modification of reset_xlate().

Thanks!

BRs,
Rex

