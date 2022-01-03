Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C90482EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 08:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiACHng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 02:43:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56978 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229793AbiACHne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 02:43:34 -0500
X-UUID: 6a3dbd5d55aa466a9f48df8d76e658b4-20220103
X-UUID: 6a3dbd5d55aa466a9f48df8d76e658b4-20220103
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 891752601; Mon, 03 Jan 2022 15:43:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Jan 2022 15:43:28 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Jan 2022 15:43:28 +0800
Message-ID: <ca8e8e62d4c7d9b714c64fbf9e59ba0ebe42bea4.camel@mediatek.com>
Subject: Re: [PATCH v16 0/7] soc: mediatek: SVS: introduce MTK SVS
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 3 Jan 2022 15:43:28 +0800
In-Reply-To: <abd9332b-dace-f75a-33f5-be88fe516784@gmail.com>
References: <20210428065440.3704-1-roger.lu@mediatek.com>
         <abd9332b-dace-f75a-33f5-be88fe516784@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Thu, 2021-12-30 at 14:18 +0100, Matthias Brugger wrote:
> 
> On 28/04/2021 08:54, Roger Lu wrote:
> > 1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
> > 2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by
> > get_cpu_device().
> > After retrieving subsys device, SVS driver calls device_link_add() to make
> > sure probe/suspend callback priority.
> > 3. SVS dts refers to reset controller [4] to help reset SVS HW.
> > 
> > #mt8183 SVS related patches
> > [1] 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/patch/11193513/__;!!CTRNKA9wMg0ARbw!yy2e7JqE__BQAZF3jwBuR3Fbzbv8LPxwwA3l6SVu7SFAG94dCHyVq9A3MIscKXW-$
> >  
> 
> Already mainline, please either refer to the commit, to make it clear it's 
> maineline or drop it.
> 
> > [2] 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20201013102358.22588-2-michael.kao@mediatek.com/__;!!CTRNKA9wMg0ARbw!yy2e7JqE__BQAZF3jwBuR3Fbzbv8LPxwwA3l6SVu7SFAG94dCHyVq9A3ML35Ale5$
> >  
> 
> Same here.
> 
> > [3] 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20200306041345.259332-3-drinkcat@chromium.org/__;!!CTRNKA9wMg0ARbw!yy2e7JqE__BQAZF3jwBuR3Fbzbv8LPxwwA3l6SVu7SFAG94dCHyVq9A3MMUMr7Oh$
> >  
> 
> Same here,

Thanks for the review. I'll refer to mainline or the latest reviewing patch. 

> 
> > 
> > #mt8192 SVS related patches
> > [1] 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/patch/11193513/__;!!CTRNKA9wMg0ARbw!yy2e7JqE__BQAZF3jwBuR3Fbzbv8LPxwwA3l6SVu7SFAG94dCHyVq9A3MIscKXW-$
> >  
> 
> Same here, it's actually the same link as [1].
> 
> > [2] 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20201223074944.2061-1-michael.kao@mediatek.com/__;!!CTRNKA9wMg0ARbw!yy2e7JqE__BQAZF3jwBuR3Fbzbv8LPxwwA3l6SVu7SFAG94dCHyVq9A3MEUxFEDM$
> >  
> > [3] 
> > https://urldefense.com/v3/__https://lore.kernel.org/patchwork/patch/1360551/__;!!CTRNKA9wMg0ARbw!yy2e7JqE__BQAZF3jwBuR3Fbzbv8LPxwwA3l6SVu7SFAG94dCHyVq9A3MNObUeLt$
> >  
> > [4] 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20200817030324.5690-5-crystal.guo@mediatek.com/__;!!CTRNKA9wMg0ARbw!yy2e7JqE__BQAZF3jwBuR3Fbzbv8LPxwwA3l6SVu7SFAG94dCHyVq9A3MMx-JKoe$
> >  
> 
> There are many dependencies for that. Some patches need resubmit, others seem
> to 
> be stale. I'd advise to concentrate on mt8183 for now and add support for
> mt8192 
> once dependencies have settled.

Sure, let's concentrate on mt8183 patches first. Thanks for sharing the advice.

> 
> Regards,
> Matthias
> 
> > 
> > changes since v15:
> > - Put (*set_freqs_pct) and (*get_vops) in struct svs_bank because they are
> > part of svs bank's operation
> > - Add define "SVSB_INIT02_RM_DVTFIXED" and "SVSB_MON_VOLT_IGNORE" to make
> > control clearly.
> > - Remove unnecessary parenthesis
> > 
> > Roger Lu (7):
> >    [v16,1/7] dt-bindings: soc: mediatek: add mtk svs dt-bindings
> >    [v16,2/7] arm64: dts: mt8183: add svs device information
> >    [v16,3/7] soc: mediatek: SVS: introduce MTK SVS engine
> >    [v16,4/7] soc: mediatek: SVS: add debug commands
> >    [v16,5/7] dt-bindings: soc: mediatek: add mt8192 svs dt-bindings
> >    [v16,6/7] arm64: dts: mt8192: add svs device information
> >    [v16,7/7] soc: mediatek: SVS: add mt8192 SVS GPU driver
> > 
> >   .../bindings/soc/mediatek/mtk-svs.yaml        |   92 +
> >   arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   18 +
> >   arch/arm64/boot/dts/mediatek/mt8192.dtsi      |   34 +
> >   drivers/soc/mediatek/Kconfig                  |   10 +
> >   drivers/soc/mediatek/Makefile                 |    1 +
> >   drivers/soc/mediatek/mtk-svs.c                | 2524 +++++++++++++++++
> >   6 files changed, 2679 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-
> > svs.yaml
> >   create mode 100644 drivers/soc/mediatek/mtk-svs.c
> > 
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > 
https://urldefense.com/v3/__http://lists.infradead.org/mailman/listinfo/linux-mediatek__;!!CTRNKA9wMg0ARbw!yy2e7JqE__BQAZF3jwBuR3Fbzbv8LPxwwA3l6SVu7SFAG94dCHyVq9A3MIj4Pohu$
> >  
> > 

