Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CA45B122C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiIHBjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiIHBjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:39:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C39DED4;
        Wed,  7 Sep 2022 18:39:29 -0700 (PDT)
X-UUID: 5fc9852ee2f74a639168bc78f4a9f338-20220908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/RTSQNPPLI/qYLfJwsavfRsg22Jon9x2KTHWb9ohw8I=;
        b=GtdW4CffqRbxg5U7Nfv9mcBUHLxZJk3KmTayNak0uNe8nT1P7jBvlvQ0/cs+8/eTsZ9HVXs4pM0Om+wEfqvURzmXbaS055d9Gi1V7TltK92UO33VQYdLysHunu0hdtrKelaDmTKxIct+X43h3Li7ldBuCtLDUJxLcgFCld44iAc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:857188ad-0f37-4156-aefd-0452a020c6ad,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:7c519121-1c20-48a5-82a0-25f9c331906d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5fc9852ee2f74a639168bc78f4a9f338-20220908
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1994137104; Thu, 08 Sep 2022 09:39:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 8 Sep 2022 09:39:23 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 8 Sep 2022 09:39:22 +0800
Message-ID: <a4e5f9e360a3fc6d094bc719aa4523a4886cae93.camel@mediatek.com>
Subject: Re: [PATCH v2 3/7] phy: phy-mtk-tphy: add property to set
 pre-emphasis
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Thu, 8 Sep 2022 09:39:22 +0800
In-Reply-To: <219aef5a-af2a-6873-f682-cb6aef862425@collabora.com>
References: <20220829080830.5378-1-chunfeng.yun@mediatek.com>
         <20220829080830.5378-3-chunfeng.yun@mediatek.com>
         <219aef5a-af2a-6873-f682-cb6aef862425@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-31 at 10:14 +0200, AngeloGioacchino Del Regno wrote:
> Il 29/08/22 10:08, Chunfeng Yun ha scritto:
> > Add a property to set usb2 phy's pre-emphasis, it's disabled by
> > default
> > on some SoCs.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v2: no changes
> > ---
> >   drivers/phy/mediatek/phy-mtk-tphy.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c
> > b/drivers/phy/mediatek/phy-mtk-tphy.c
> > index 8ee7682b8e93..986fde0f63a0 100644
> > --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> > +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> > @@ -72,6 +72,8 @@
> >   #define PA5_RG_U2_HS_100U_U3_EN	BIT(11)
> >   
> >   #define U3P_USBPHYACR6		0x018
> > +#define PA6_RG_U2_PRE_EMP		GENMASK(31, 30)
> > +#define PA6_RG_U2_PRE_EMP_VAL(x)	((0x3 & (x)) << 30)
> 
> Hello Chunfeng,
> 
> can you please clarify which SoC is this change referred to?
These bits are reserved before using 12nm process.

> 
> If I'm not missing anything, there may be a register layout conflict 
As I know these reserved bits are not used before, but now used to tune
pre-emphasis after supporting 12nm or 5nm process.

> between
> one version and the other for T-PHYs, for which, it may be a good
> idea to add
> a PHY version check before allowing to write settings that are
> supported only
> on a specific IP...
Do you know which SoC used bits, I can confirm it with our DE.

Thanks a lot

> 
> Regards,
> Angelo
> 

