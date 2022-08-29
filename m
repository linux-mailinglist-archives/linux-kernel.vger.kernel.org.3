Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B915A4343
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiH2Gad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2Gaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:30:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CE9B7EB;
        Sun, 28 Aug 2022 23:30:24 -0700 (PDT)
X-UUID: 3a3aa4abc84344a6b7f14173da6060f3-20220829
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JhK6lBBOqVRT4kKbaoyybEn8XZO56uWakDHEHA5gZEY=;
        b=tlvp4EdRygJ8nib9eAkt+X7PZnGMMb5FHXot/ZrrnCVtTvWGLR/sdt7TOR3hb1I5zk+5BRV3KtK1g8QOTeIwciohXiQ/6dJk1R+E8foIYsBhRxw33d6mWlAG6yDvz25dCLLZXc1BM6aJgKAz84ApROT8Fu+p2Kbf/YDWiGp0HpM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:38d6fdd4-f7f0-4e18-b8b0-35cefbb3889f,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:05f0e5cf-20bd-4e5e-ace8-00692b7ab380,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3a3aa4abc84344a6b7f14173da6060f3-20220829
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1212872841; Mon, 29 Aug 2022 14:30:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 29 Aug 2022 14:30:13 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 29 Aug 2022 14:30:12 +0800
Message-ID: <a95c06a3f40683cd6a645d7a064de6d4e53c9182.camel@mediatek.com>
Subject: Re: [PATCH 1/7] dt-bindings: phy: mediatek,tphy: add support type
 of SGMII
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Mon, 29 Aug 2022 14:30:12 +0800
In-Reply-To: <20220823204432.ugfs7k3dn4ibbcky@notapiano>
References: <20220819091344.2274-1-chunfeng.yun@mediatek.com>
         <20220823204432.ugfs7k3dn4ibbcky@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-23 at 16:44 -0400, Nícolas F. R. A. Prado wrote:
> On Fri, Aug 19, 2022 at 05:13:38PM +0800, Chunfeng Yun wrote:
> > Add support ethernet SGMII, forgot to update type supported.
> > 
> > Fixes: c01608b3b46b ("dt-bindings: phy: mediatek: tphy: support
> > type switch by pericfg")
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> 
> Hi Chunfeng,
> 
> when sending a patch series of more than 1 patch, please add a cover
> letter
> describing a higher level overview of the changes done in the
> patches. Example:
> [1]
For these small and independent changes, it's difficult to give a brief
description on a higher level overview, I prefer to add a cover letter
when the series are associated or dependent.

Thanks a lot

> 
> Thanks,
> Nícolas
> 
> [1] 
> https://lore.kernel.org/all/20220629155956.1138955-1-nfraprado@collabora.com/

