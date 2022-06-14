Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B31554A71F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 04:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354848AbiFNCzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiFNCzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:55:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EAB2EE;
        Mon, 13 Jun 2022 19:39:07 -0700 (PDT)
X-UUID: 8ad4d25951214249a2f90ce7a65301cb-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:449a824b-3c8a-486b-984d-8e362b0aa023,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:40
X-CID-INFO: VERSION:1.1.6,REQID:449a824b-3c8a-486b-984d-8e362b0aa023,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:40
X-CID-META: VersionHash:b14ad71,CLOUDID:306453c5-c67b-4a73-9b18-726dd8f2eb58,C
        OID:c6a8985aa87f,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 8ad4d25951214249a2f90ce7a65301cb-20220614
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 411665334; Tue, 14 Jun 2022 10:39:01 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 14 Jun 2022 10:39:00 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 14 Jun 2022 10:38:59 +0800
Message-ID: <bcc98dbbf737e4d98c25c839a390a0d9782cde3e.camel@mediatek.com>
Subject: Re: [PATCH v9 0/2] phy: mediatek: Add PCIe PHY driver
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wei-Shun Chang <weishunc@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rex-bc.chen@mediatek.com>,
        <randy.wu@mediatek.com>, <jieyy.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <jian.yang@mediatek.com>
Date:   Tue, 14 Jun 2022 10:38:59 +0800
In-Reply-To: <Ypb6AS6oj2en/Roi@matsya>
References: <20220520064920.27313-1-jianjun.wang@mediatek.com>
         <96f7cc90171bb6e088ce0ed88e10ad14f06a98bb.camel@mediatek.com>
         <Ypb6AS6oj2en/Roi@matsya>
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

Hi Vinod,

Sorry to disturb you, would you mind taking a look at this patch?

Thanks.

On Wed, 2022-06-01 at 11:02 +0530, Vinod Koul wrote:
> On 01-06-22, 10:21, Jianjun Wang wrote:
> > Hello Maintainers,
> > 
> > Gentle ping for this patch series, if there is anything I can do to
> > get
> > these patches merged, please let me know.
> 
> Patience my friend patience. This was received very late in cycle and
> I
> will review after merge window closes..
> 
> 
> > 
> > Thanks.
> > 
> > On Fri, 2022-05-20 at 14:49 +0800, Jianjun Wang wrote:
> > > These series patches add support for PCIe PHY driver on MediaTek
> > > chipsets.
> > > 
> > > Changes in v9:
> > > 1. Check if the return value is -ENOMEM when reading efuse data
> > > fails.
> > > 
> > > Changes in v8:
> > > 1. Use "device_property_present()" to increase human readability;
> > > 2. Use "GPL" as recommended in commit bf7fbeeae6db ("module: Cure
> > >    the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity").
> > > 
> > > Changes in v7:
> > > 1. Add bitfield.h header to fix the build error on non-arm64
> > > platforms.
> > > 
> > > Changes in v6:
> > > 1. Remove unnecessary header files;
> > > 2. Use FILELD_PREP in bitfield.h to set value.
> > > 
> > > Changes in v5:
> > > 1. Fix typo in kerneldoc: "eFues" => "eFuse".
> > > 
> > > Changes in v4:
> > > 1. Fix no return when calling dev_err_probe.
> > > 
> > > Changes in v3:
> > > 1. Add introductions for structure members;
> > > 2. Add SoC dependent data;
> > > 3. Dynamically allocate efuse data;
> > > 4. Check return value if it's an -EPROBE_DEFER.
> > > 
> > > Changes in v2:
> > > 1. Add specific compatible name;
> > > 2. Read NVMEM data at probe time;
> > > 3. Fix typos.
> > > 
> > > Jianjun Wang (2):
> > >   dt-bindings: phy: mediatek: Add YAML schema for PCIe PHY
> > >   phy: mediatek: Add PCIe PHY driver
> > > 
> > >  .../bindings/phy/mediatek,pcie-phy.yaml       |  75 +++++
> > >  drivers/phy/mediatek/Kconfig                  |  11 +
> > >  drivers/phy/mediatek/Makefile                 |   1 +
> > >  drivers/phy/mediatek/phy-mtk-pcie.c           | 267
> > > ++++++++++++++++++
> > >  4 files changed, 354 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/phy/mediatek,pcie-phy.yaml
> > >  create mode 100644 drivers/phy/mediatek/phy-mtk-pcie.c
> > > 
> 
> 

