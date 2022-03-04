Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EC14CD1C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiCDJ6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiCDJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:58:22 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF3D7660;
        Fri,  4 Mar 2022 01:57:28 -0800 (PST)
X-UUID: da42b50672434f5c9d725777bdbb6227-20220304
X-UUID: da42b50672434f5c9d725777bdbb6227-20220304
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 300480696; Fri, 04 Mar 2022 17:57:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 4 Mar 2022 17:57:21 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Mar 2022 17:57:20 +0800
Message-ID: <123cb154ca0e87504c2b663ebdca2ccad967776f.camel@mediatek.com>
Subject: Re: [PATCH v5 00/34] MT8195 IOMMU SUPPORT
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <xueqi.zhang@mediatek.com>,
        <yen-chang.chen@mediatek.com>, <mingyuan.ma@mediatek.com>,
        <yf.wang@mediatek.com>, <libo.kang@mediatek.com>,
        <chengci.xu@mediatek.com>
Date:   Fri, 4 Mar 2022 17:57:19 +0800
In-Reply-To: <YiHZ4lq2QClkdyxS@8bytes.org>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
         <YhzBSsn/zUlGg5JE@8bytes.org>
         <7ba0ee87-c193-9834-d0b4-ff3e06ced82b@collabora.com>
         <5ed9278fa0b72b993512cff2316218ab88cafe50.camel@mediatek.com>
         <YiHZ4lq2QClkdyxS@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-04 at 10:20 +0100, Joerg Roedel wrote:
> On Tue, Mar 01, 2022 at 03:49:18PM +0800, Yong Wu wrote:
> > 
https://patchwork.kernel.org/project/linux-mediatek/list/?series=592275
> 
> Okay, thanks for the clarification. So I can't include linux-next in
> my
> tree, so I think the best option is to wait until v5.18-rc1 (or
> rather
> -rc3, which is where I start merging new stuff) is out and merge it
> then.
> Another option would be if there is a branch which only contains the
> dependencies of this patch-set, which I could pull into my tree, but
> it
> is already pretty late in the cycle.
> So please re-send when the next -rc1 is out and I will pick it up
> then.

Thanks for this info. I will re-send this patchset after the next -rc1.

Could you help apply Dafna's patchset at this time? This patchset
depends on it and it won't conflict with the others.

Thanks.

> 
> Regards,
> 
> 	Joerg

