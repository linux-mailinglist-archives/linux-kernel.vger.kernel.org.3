Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDC1507EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358899AbiDTCTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiDTCTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:19:46 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EE815A39;
        Tue, 19 Apr 2022 19:16:57 -0700 (PDT)
X-UUID: 8409fd70d4b3458cb584da2a769e1a0c-20220420
X-UUID: 8409fd70d4b3458cb584da2a769e1a0c-20220420
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 870627283; Wed, 20 Apr 2022 10:16:51 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 20 Apr 2022 10:16:50 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Apr 2022 10:16:50 +0800
Message-ID: <dd069ad818e13ab30847d5da93ca4a9ef7c13bf9.camel@mediatek.com>
Subject: Re: [PATCH 4/7] clk: mediatek: reset: Add reset.h
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <yong.liang@mediatek.com>, <runyang.chen@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <allen-kh.cheng@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 20 Apr 2022 10:16:50 +0800
In-Reply-To: <20eaaba7-19cb-8f1d-ecf4-bfac14d50f67@collabora.com>
References: <20220418132154.7401-1-rex-bc.chen@mediatek.com>
         <20220418132154.7401-5-rex-bc.chen@mediatek.com>
         <20eaaba7-19cb-8f1d-ecf4-bfac14d50f67@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-19 at 12:46 +0200, AngeloGioacchino Del Regno wrote:
> Il 18/04/22 15:21, Rex-BC Chen ha scritto:
> > Add a new file "reset.h" to place some definitions for clock reset.
> > 
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >   drivers/clk/mediatek/clk-mtk.h | 10 +---------
> >   drivers/clk/mediatek/reset.h   | 20 ++++++++++++++++++++
> >   2 files changed, 21 insertions(+), 9 deletions(-)
> >   create mode 100644 drivers/clk/mediatek/reset.h
> > 
> > diff --git a/drivers/clk/mediatek/clk-mtk.h
> > b/drivers/clk/mediatek/clk-mtk.h
> > index dafdf30fe94e..dfb0549ceb6c 100644
> > --- a/drivers/clk/mediatek/clk-mtk.h
> > +++ b/drivers/clk/mediatek/clk-mtk.h
> > @@ -12,6 +12,7 @@
> >   #include <linux/kernel.h>
> >   #include <linux/spinlock.h>
> >   #include <linux/types.h>
> > +#include <reset.h>
> 
> This should be
> 
> #include "reset.h"
> 
> ...since the header is in the same directory.
> 
> 
Hello Angelo,

I will fix this in next version.
Thanks!

BRs,
Rex

