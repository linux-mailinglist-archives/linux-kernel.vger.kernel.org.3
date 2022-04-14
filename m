Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9559D500617
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 08:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbiDNG2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 02:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiDNG2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 02:28:07 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE0822288;
        Wed, 13 Apr 2022 23:25:43 -0700 (PDT)
X-UUID: 0671cb57c3d94dae9c7d71dbde9fb4db-20220414
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:0b3c4655-9a90-43fd-aabb-d10c699e7197,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:2
X-CID-META: VersionHash:faefae9,CLOUDID:7b4d5978-0afa-4dca-bdec-ca54c998425a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:4,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 0671cb57c3d94dae9c7d71dbde9fb4db-20220414
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 685369214; Thu, 14 Apr 2022 14:25:36 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 14 Apr 2022 14:25:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Apr
 2022 14:25:35 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 14:25:35 +0800
Message-ID: <5fa51ff6aab0d54e4edd8fc6fed00d4718ceb9dc.camel@mediatek.com>
Subject: Re: [PATCH 2/2] soc: mediatek: svs: add support for mt8186
From:   Jia-Wei Chang <jia-wei.chang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>
Date:   Thu, 14 Apr 2022 14:25:35 +0800
In-Reply-To: <138aad1c-63d7-371a-ff41-4fd7022d365d@collabora.com>
References: <20220412112127.21570-1-jia-wei.chang@mediatek.com>
         <20220412112127.21570-3-jia-wei.chang@mediatek.com>
         <138aad1c-63d7-371a-ff41-4fd7022d365d@collabora.com>
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

On Tue, 2022-04-12 at 17:30 +0200, AngeloGioacchino Del Regno wrote:
> Il 12/04/22 13:21, Tim Chang ha scritto:
> > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > 
> > MT8186 svs has a number of banks which used as optimization of opp
> > voltage table for corresponding dvfs drivers.
> > MT8186 svs big core uses 2-line high bank and low bank to optimize
> > the
> > voltage of opp table for higher and lower frequency respectively.
> > 
> > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> For the code only, as I am unable to test:
> 

Hi AngeloGioacchino,

I provided the svs content in mt8186.dtsi on chromebook prototype as an
example in previous response.  You can refer to it for urgent usage.
I will update it in my series in the future version.

Thanks.

> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> 

