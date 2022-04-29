Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F5A514543
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356455AbiD2JZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbiD2JZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:25:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080B5B6D3D;
        Fri, 29 Apr 2022 02:21:46 -0700 (PDT)
X-UUID: a683860e2ba94204b1542030cbdf980d-20220429
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:57cf52b3-97af-4ecd-bf7d-6369f6dfdad6,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:57cf52b3-97af-4ecd-bf7d-6369f6dfdad6,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:11a1f4c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: a683860e2ba94204b1542030cbdf980d-20220429
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 830141353; Fri, 29 Apr 2022 17:21:40 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 29 Apr 2022 17:21:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 Apr 2022 17:21:39 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Apr 2022 17:21:38 +0800
Message-ID: <990e0f5b27203d99c502d3cb2fcacc0b9767b848.camel@mediatek.com>
Subject: Re: [v4 00/18] ASoC: mediatek: Add support for MT8186 SoC
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <angelogioacchino.delregno@collabora.com>,
        <aaronyu@google.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <julianbraha@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 29 Apr 2022 17:21:38 +0800
In-Reply-To: <YmqGXCg97X6Vqvs+@sirena.org.uk>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
         <YmqGXCg97X6Vqvs+@sirena.org.uk>
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

On Thu, 2022-04-28 at 13:19 +0100, Mark Brown wrote:
> On Thu, Apr 28, 2022 at 05:33:37PM +0800, Jiaxin Yu wrote:
> > This series of patches adds support for Mediatek AFE of MT8186 Soc.
> > Patches are based on broonie tree "for-next" branch.
> 
> This looks mostly good from a framework point of view - I did notice
> a
> few minor issues which I commented on (some of the control things are
> repeated in other patches) but the overwhelming bulk of the code
> looks
> good.
Hi Mark,

Thank you very much for your review. I will check the codes with your
comments carefully.

Best Regards
Jiaxin.Yu

