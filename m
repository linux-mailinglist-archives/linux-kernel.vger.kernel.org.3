Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCFF4F5790
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiDFH5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377821AbiDFHoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 03:44:38 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D981F635C;
        Tue,  5 Apr 2022 22:47:40 -0700 (PDT)
X-UUID: 4f93afbe5bbf4477864d2213634df7ae-20220406
X-UUID: 4f93afbe5bbf4477864d2213634df7ae-20220406
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 726767342; Wed, 06 Apr 2022 13:47:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Apr 2022 13:47:35 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Apr 2022 13:47:34 +0800
Message-ID: <06c9f2f8236f8dab6b27da9db0332b4ca45a1039.camel@mediatek.com>
Subject: Re: [PATCH v5 0/2] phy: mediatek: Add PCIe PHY driver
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
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
Date:   Wed, 6 Apr 2022 13:47:34 +0800
In-Reply-To: <20220326022728.2969-1-jianjun.wang@mediatek.com>
References: <20220326022728.2969-1-jianjun.wang@mediatek.com>
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

Hello Maintainers,

Is there anything I can do to get these patches merged?

Thanks.

On Sat, 2022-03-26 at 10:27 +0800, Jianjun Wang wrote:
> These series patches add support for PCIe PHY driver on MediaTek
> chipsets.
> 
> Changes in v5:
> 1. Fix typo in kerneldoc: "eFues" => "eFuse".
> 
> Changes in v4:
> 1. Fix no return when calling dev_err_probe.
> 
> Changes in v3:
> 1. Add introductions for structure members;
> 2. Add SoC dependent data;
> 3. Dynamically allocate efuse data;
> 4. Check return value if it's an -EPROBE_DEFER.
> 
> Changes in v2:
> 1. Add specific compatible name;
> 2. Read NVMEM data at probe time;
> 3. Fix typos.
> 
> Jianjun Wang (2):
>   dt-bindings: phy: mediatek: Add YAML schema for PCIe PHY
>   phy: mediatek: Add PCIe PHY driver
> 
>  .../bindings/phy/mediatek,pcie-phy.yaml       |  75 +++++
>  drivers/phy/mediatek/Kconfig                  |  11 +
>  drivers/phy/mediatek/Makefile                 |   1 +
>  drivers/phy/mediatek/phy-mtk-pcie.c           | 272
> ++++++++++++++++++
>  4 files changed, 359 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
>  create mode 100644 drivers/phy/mediatek/phy-mtk-pcie.c
> 

