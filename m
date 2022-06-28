Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288C155D935
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244449AbiF1IVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbiF1ITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:19:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2402CDE4;
        Tue, 28 Jun 2022 01:19:36 -0700 (PDT)
X-UUID: da3e0083ec9f4979817c868145524137-20220628
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:711f6eca-5a82-4152-bd26-5be3e71a82bc,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:87442a2,CLOUDID:3e11d762-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: da3e0083ec9f4979817c868145524137-20220628
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1255498605; Tue, 28 Jun 2022 16:19:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 28 Jun 2022 16:19:32 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jun 2022 16:19:31 +0800
Message-ID: <4dbbdd1f5886f72d5603ea45fd24602087ac01fc.camel@mediatek.com>
Subject: Re: [PATCH v10 2/2] phy: mediatek: Add PCIe PHY driver
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Chen-Yu Tsai" <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     Wei-Shun Chang <weishunc@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rex-bc.chen@mediatek.com>,
        <randy.wu@mediatek.com>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Date:   Tue, 28 Jun 2022 16:19:31 +0800
In-Reply-To: <20220617070246.20142-3-jianjun.wang@mediatek.com>
References: <20220617070246.20142-1-jianjun.wang@mediatek.com>
         <20220617070246.20142-3-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-17 at 15:02 +0800, Jianjun Wang wrote:
> Add PCIe GEN3 PHY driver support on MediaTek chipsets.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/phy/mediatek/Kconfig        |  11 ++
>  drivers/phy/mediatek/Makefile       |   1 +
>  drivers/phy/mediatek/phy-mtk-pcie.c | 267
> ++++++++++++++++++++++++++++
>  3 files changed, 279 insertions(+)
>  create mode 100644 drivers/phy/mediatek/phy-mtk-pcie.c
> 
Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks

