Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB82A521313
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240596AbiEJLHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiEJLHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:07:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD0527D01D;
        Tue, 10 May 2022 04:03:45 -0700 (PDT)
X-UUID: b16d705e0cfb4bbf9ee5326839ccc407-20220510
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:3a8bfec3-3cdf-472a-a8bb-e60bedfe4936,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:470f47b3-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: b16d705e0cfb4bbf9ee5326839ccc407-20220510
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1213444592; Tue, 10 May 2022 19:03:39 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 10 May 2022 19:03:37 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 May 2022 19:03:34 +0800
Message-ID: <b1dc5dbd2f84b068bde5c49b25026b5756841fd2.camel@mediatek.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: mediatek: mt8195: enable usb remote
 wakeup
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>
Date:   Tue, 10 May 2022 19:03:34 +0800
In-Reply-To: <1f2ed3a2054c4ab707beb48aca4f3d6e7c601218.camel@mediatek.com>
References: <20220128062902.26273-1-chunfeng.yun@mediatek.com>
         <20220128062902.26273-4-chunfeng.yun@mediatek.com>
         <6707a581-b42c-de13-c8d6-0528955d0218@collabora.com>
         <1f2ed3a2054c4ab707beb48aca4f3d6e7c601218.camel@mediatek.com>
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

On Tue, 2022-05-10 at 11:47 +0800, Macpaul Lin wrote:
> On Mon, 2022-01-31 at 10:59 +0100, AngeloGioacchino Del Regno wrote:
> > Il 28/01/22 07:29, Chunfeng Yun ha scritto:
> > > Enable USB remote wakeup of all four xHCI controllers
> > > 
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > 
> > Reviewed-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > 
> 
> This patch doesn't apply to 'for-next' branch to MediaTek's repo.
> 
> 
https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
> 
> Dear Chunfeng, could
>  you please update a new version?
Ok, I'll send it out this week.

> 
> Thanks
> Macpaul Lin
> 

