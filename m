Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D8851BEE8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359765AbiEEMPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244504AbiEEMPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:15:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C166411;
        Thu,  5 May 2022 05:12:05 -0700 (PDT)
X-UUID: 85c1ab05184f4bf5b38b80821f60b2ec-20220505
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:a9a785a5-7a76-42bf-98a6-8a23df82c485,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:144d5216-2e53-443e-b81a-655c13977218,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 85c1ab05184f4bf5b38b80821f60b2ec-20220505
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1724677628; Thu, 05 May 2022 20:12:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 5 May 2022 20:11:59 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 5 May 2022 20:11:58 +0800
Message-ID: <d017583a2472e7d4bf4684b1aabeebd93c80c68b.camel@mediatek.com>
Subject: Re: [PATCH v7 2/2] phy: mediatek: Add PCIe PHY driver
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     Wei-Shun Chang <weishunc@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rex-bc.chen@mediatek.com>,
        <randy.wu@mediatek.com>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Date:   Thu, 5 May 2022 20:11:58 +0800
In-Reply-To: <bad44be8-abc7-169f-bc7a-cef3692c9a71@collabora.com>
References: <20220422142331.17173-1-jianjun.wang@mediatek.com>
         <20220422142331.17173-3-jianjun.wang@mediatek.com>
         <bad44be8-abc7-169f-bc7a-cef3692c9a71@collabora.com>
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

Hi Angelo,

On Tue, 2022-04-26 at 18:06 +0200, AngeloGioacchino Del Regno wrote:
> Il 22/04/22 16:23, Jianjun Wang ha scritto:
> > Add PCIe GEN3 PHY driver support on MediaTek chipsets.
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> 
> Hello Jianjun,
> there's only one last bit to fix, check below:
> 
> > ---
> >   drivers/phy/mediatek/Kconfig        |  11 ++
> >   drivers/phy/mediatek/Makefile       |   1 +
> >   drivers/phy/mediatek/phy-mtk-pcie.c | 267
> > ++++++++++++++++++++++++++++
> >   3 files changed, 279 insertions(+)
> >   create mode 100644 drivers/phy/mediatek/phy-mtk-pcie.c
> > 
> 
> ..snip..
> 
> > +static int mtk_pcie_read_efuse(struct mtk_pcie_phy *pcie_phy)
> > +{
> > +	struct device *dev = pcie_phy->dev;
> > +	bool nvmem_enabled;
> > +	int ret, i;
> > +
> > +	/* nvmem data is optional */
> > +	nvmem_enabled = device_property_read_bool(dev, "nvmem-cells");
> 
> device_property_read_bool() returns device_property_present().
> 
> I would prefer that, instead, you call the latter:
> 
> 	nvmem_enabled = device_property_present(dev, "nvmem-cells");
> 
> It's the same, yes, but this will increase human readability, as the
> function
> name clearly states the intention here.

Thanks for your review and sorry for the late response, I'll replace it
with 'device_property_present' in the next version.

Thanks.

> 
> Thanks,
> Angelo
> 

