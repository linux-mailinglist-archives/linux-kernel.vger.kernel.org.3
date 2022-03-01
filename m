Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A61B4C8A68
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiCALPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiCALPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:15:00 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2254290FF4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 03:14:15 -0800 (PST)
X-UUID: f46951ea67a04ae8bb150fecb29955f5-20220301
X-UUID: f46951ea67a04ae8bb150fecb29955f5-20220301
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 494944420; Tue, 01 Mar 2022 19:13:29 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 1 Mar 2022 19:13:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Mar
 2022 19:13:29 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 19:13:29 +0800
Message-ID: <31507af7c67640fa8161b13a4f279fea1a050f55.camel@mediatek.com>
Subject: Re: [PATCH v2,0/2] Add mmsys reset control for MT8186
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <chunkuang.hu@kernel.org>, <jitao.shi@mediatek.com>,
        <xinlei.lee@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 1 Mar 2022 19:13:29 +0800
In-Reply-To: <09ce5aab-0cc6-5903-8238-551085abd739@gmail.com>
References: <20220217082626.15728-1-rex-bc.chen@mediatek.com>
         <09ce5aab-0cc6-5903-8238-551085abd739@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthias,

Thanks for accepting my patches, but I didn't see this patch [1]
in v5.17-next/soc.
There will be build error if [1] is not included while [2] is applied.
The sw0_rst_offset is declared in [2].

If I have mistake, please let me know.
Thanks!

[1]:
https://patchwork.kernel.org/project/linux-mediatek/patch/20220217082626.15728-2-rex-bc.chen@mediatek.com/

[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.17-next/soc&id=831785f0e5b919c29e1bc5f9a74e9ebd38289e24

BRs,
Rex
On Tue, 2022-03-01 at 08:35 +0100, Matthias Brugger wrote:
> 
> On 17/02/2022 09:26, Rex-BC Chen wrote:
> > v2:
> > 1. Change variable type from unsigned int to u16.
> > 
> > v1:
> > 1. Add a new variable in mmsys driver data to control different
> > register
> >     offset for different SoCs.
> > 2. Add MT8183 reset register offset.
> > 3. Add mmsys reset control for MT8186.
> > 
> > This series is based on mmsys patch for MT8186 on [1].
> > [1]: 
> > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20220216084831.14883-4-rex-bc.chen@mediatek.com/__;!!CTRNKA9wMg0ARbw!wp2uW6phbST6ySpYRlb7iwmATAVkkCL1JBau9dCwhXj8KRasrAWnLd1EUT9gLE-oF9Yq$
> >  
> > 
> > Rex-BC Chen (2):
> >    soc: mediatek: mmsys: add sw0_rst_offset in mmsys driver data
> >    soc: mediatek: mmsys: add mmsys reset control for MT8186
> > 
> >   drivers/soc/mediatek/mt8183-mmsys.h | 2 ++
> >   drivers/soc/mediatek/mt8186-mmsys.h | 2 ++
> >   drivers/soc/mediatek/mtk-mmsys.c    | 7 +++++--
> >   drivers/soc/mediatek/mtk-mmsys.h    | 3 +--
> >   4 files changed, 10 insertions(+), 4 deletions(-)
> > 
> 
> Series applied, thanks!

