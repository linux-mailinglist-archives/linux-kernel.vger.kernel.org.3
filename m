Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848F950AF4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444037AbiDVFFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiDVFFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:05:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6947049250;
        Thu, 21 Apr 2022 22:02:55 -0700 (PDT)
X-UUID: 7de3b95034484cb09e09d6cc8fa855b3-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:8293eb62-05c2-4ced-8b3b-8a67204fed2d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:2,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:47
X-CID-INFO: VERSION:1.1.4,REQID:8293eb62-05c2-4ced-8b3b-8a67204fed2d,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:2,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:47
X-CID-META: VersionHash:faefae9,CLOUDID:7a9790f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:4,EDM:-3,File:ni
        l,QS:0,BEC:nil
X-UUID: 7de3b95034484cb09e09d6cc8fa855b3-20220422
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 830653771; Fri, 22 Apr 2022 13:02:48 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 13:02:47 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Apr
 2022 13:02:45 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 13:02:45 +0800
Message-ID: <f1ce2b0f1215548da3b1b1d2fc6f1ad67d7b1e48.camel@mediatek.com>
Subject: Re: [PATCH V2 05/12] clk: mediatek: reset: Add reset.h
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <allen-kh.cheng@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 22 Apr 2022 13:02:45 +0800
In-Reply-To: <90ad46a5-8b67-e9ca-25df-2a7cc6110bff@collabora.com>
References: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
         <20220420130527.23200-6-rex-bc.chen@mediatek.com>
         <90ad46a5-8b67-e9ca-25df-2a7cc6110bff@collabora.com>
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

On Thu, 2022-04-21 at 11:07 +0200, AngeloGioacchino Del Regno wrote:
> Il 20/04/22 15:05, Rex-BC Chen ha scritto:
> > Add a new file "reset.h" to place some definitions for clock reset.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> 
> Right now, you're adding the enum mtk_reset_version and *then* you're
> moving it to the new reset.h header, but does that really make sense?
> 
> I think that this series would be cleaner if you add this header from
> the start, so that you place the aforementioned enumeration directly
> in here...
> 
> ...so we would have a commit that moves the
> mtk_clk_register_rst_ctrl()
> function from clk-mtk.h to a newly created reset.h, mentioning in the
> commit description that it's all about preparing for a coming
> cleanup,
> then the addition of enum mtk_reset_version would be in
> `clk: mediatek: reset: Merge and revise reset register function`
> directly
> into reset.h.
> 
> Does that sound right to you?
> 
> Cheers,
> Angelo
> 

Hello Angelo,

yes, I think it's more reasonable to move this modification to the
first order of this series.
I will do this in next version.

BRs,
Rex

