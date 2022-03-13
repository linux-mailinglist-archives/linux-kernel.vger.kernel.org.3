Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FEF4D71A5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 01:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiCMACg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 19:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiCMACc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 19:02:32 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CE41F1603;
        Sat, 12 Mar 2022 16:01:21 -0800 (PST)
X-UUID: 7da47bb1aa4e4a15a61988cc10ddf0dc-20220313
X-UUID: 7da47bb1aa4e4a15a61988cc10ddf0dc-20220313
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 49272585; Sun, 13 Mar 2022 08:01:16 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 13 Mar 2022 08:01:15 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 13 Mar
 2022 08:01:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 13 Mar 2022 08:01:10 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <lkp@intel.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <bjorn.andersson@linaro.org>, <kbuild-all@lists.01.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <matthias.bgg@gmail.com>, <tinghan.shen@mediatek.com>
Subject: Re: [PATCH v2] remoteproc: mediatek: fix side effect of mt8195 sram power on
Date:   Sun, 13 Mar 2022 08:01:10 +0800
Message-ID: <20220313000110.3869-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <202203120056.qtDEVoye-lkp@intel.com>
References: <202203120056.qtDEVoye-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tinghan,

>      418 |                           MT8195_L1TCM_SRAM_PDN_RESERVED_BITS);
>          |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                           MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS
>    drivers/remoteproc/mtk_scp.c:418:27: note: each undeclared identifier is reported only once for each function it appears in
>    drivers/remoteproc/mtk_scp.c: In function 'mt8195_scp_stop':
>    drivers/remoteproc/mtk_scp.c:592:28: error: 'MT8195_L1TCM_SRAM_PDN_RESERVED_BITS' undeclared (first use in this function); did you mean 'MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS'?
>      592 |                            MT8195_L1TCM_SRAM_PDN_RESERVED_BITS);
>          |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          |                            MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS

I tested this patch and it can should be caught by the
internal build test.

Could you do the test before submitting patches out?


Thanks,
Miles
