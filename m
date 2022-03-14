Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D65B4D806E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbiCNLN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbiCNLNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:13:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7468917A85;
        Mon, 14 Mar 2022 04:12:09 -0700 (PDT)
X-UUID: 33b3eaef36e64793a9345f9570c4cf03-20220314
X-UUID: 33b3eaef36e64793a9345f9570c4cf03-20220314
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 211809994; Mon, 14 Mar 2022 19:12:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 14 Mar 2022 19:12:03 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Mar 2022 19:12:02 +0800
Message-ID: <588cb791c2fe3e1db8e0dd9ad66aa6d1bb95b348.camel@mediatek.com>
Subject: Re: [PATCH v2] remoteproc: mediatek: fix side effect of mt8195 sram
 power on
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Miles Chen <miles.chen@mediatek.com>, <lkp@intel.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <bjorn.andersson@linaro.org>, <kbuild-all@lists.01.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <matthias.bgg@gmail.com>
Date:   Mon, 14 Mar 2022 19:12:03 +0800
In-Reply-To: <20220313000110.3869-1-miles.chen@mediatek.com>
References: <202203120056.qtDEVoye-lkp@intel.com>
         <20220313000110.3869-1-miles.chen@mediatek.com>
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

Hi Miles,

On Sun, 2022-03-13 at 08:01 +0800, Miles Chen wrote:
> Hi Tinghan,
> 
> >      418 |                           MT8195_L1TCM_SRAM_PDN_RESERVED_BITS);
> >          |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >          |                           MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS
> >    drivers/remoteproc/mtk_scp.c:418:27: note: each undeclared identifier is reported only once
> > for each function it appears in
> >    drivers/remoteproc/mtk_scp.c: In function 'mt8195_scp_stop':
> >    drivers/remoteproc/mtk_scp.c:592:28: error: 'MT8195_L1TCM_SRAM_PDN_RESERVED_BITS' undeclared
> > (first use in this function); did you mean 'MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS'?
> >      592 |                            MT8195_L1TCM_SRAM_PDN_RESERVED_BITS);
> >          |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >          |                            MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS
> 
> I tested this patch and it can should be caught by the
> internal build test.
> 
> Could you do the test before submitting patches out?
> 
> 
> Thanks,
> Miles

I'm Sorry. I was too confident for this change.
I'll do the test at next time.
Thank you.


Best regards,
TingHan

