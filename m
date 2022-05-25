Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585CD533DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbiEYNTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244505AbiEYNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:19:28 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2100B20BF2;
        Wed, 25 May 2022 06:18:57 -0700 (PDT)
X-UUID: 3a54a674e22a4dc39038fbbbdd31aa0d-20220525
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:bec41655-ae65-4217-8673-b51cb335cc35,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:6dad35b8-3c45-407b-8f66-25095432a27a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 3a54a674e22a4dc39038fbbbdd31aa0d-20220525
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1354993977; Wed, 25 May 2022 21:18:44 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 25 May 2022 21:18:42 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 25 May 2022 21:18:42 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 May 2022 21:18:42 +0800
Message-ID: <478ed2945cdf90f465a7828ab9b235254caab311.camel@mediatek.com>
Subject: Re: [PATCH v20 0/8] Add Mediatek Soc DRM (vdosys0) support for
 mt8195
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     CK Hu <ck.hu@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
        "Singo Chang" <singo.chang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        jason-jhlin <jason-jh.lin@mediatek.corp-partner.google.com>
Date:   Wed, 25 May 2022 21:18:42 +0800
In-Reply-To: <43a102cf-6971-8083-d24f-629d6d39810f@collabora.com>
References: <20220419094143.9561-1-jason-jh.lin@mediatek.com>
         <43a102cf-6971-8083-d24f-629d6d39810f@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Angelo,

OK, I'll rebase on next-20220525 and resend soon.

Regards,
Jason-JH.Lin

On Wed, 2022-05-25 at 11:50 +0200, AngeloGioacchino Del Regno wrote:
> Il 19/04/22 11:41, jason-jh.lin ha scritto:
> > From: jason-jhlin <jason-jh.lin@mediatek.corp-partner.google.com>
> > 
> 
> Hello Jason,
> 
> this series does not apply cleanly anymore on next-20220525, can you
> please
> rebase and resend?
> 
> I hope that with a bit of coordination, we can get the entire display
> stack
> finally upstreamed in v5.19... it's been quite a while... :-)
> 
> Cheers,
> Angelo
> 
> > Change in v20:
> > - split binding patch to another series 'MediaTek MT8195 display
> > binding':
> >    
> > https://patchwork.ozlabs.org/project/devicetree-bindings/list/?series=295669
> > - fix io_start type from u32 to resource_size_t
> > - fix some commit message for DITHER enum
snip...

