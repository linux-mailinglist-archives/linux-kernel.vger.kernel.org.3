Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2042749F04D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344672AbiA1BDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:03:13 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:39452 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344935AbiA1BCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:02:50 -0500
X-UUID: 68524e6b2b4248f895d7be7c8c74098d-20220128
X-UUID: 68524e6b2b4248f895d7be7c8c74098d-20220128
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <guochun.mao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 684498575; Fri, 28 Jan 2022 09:02:47 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 28 Jan 2022 09:02:45 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 Jan 2022 09:02:44 +0800
Message-ID: <c847fc0055557ac362305b2689caf14cd96a4fe0.camel@mediatek.com>
Subject: Re: [PATCH] spi: spi-mtk-nor: make some internal variables static
From:   Guochun Mao <guochun.mao@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Bin Zhang <bin.zhang@mediatek.com>,
        <project_global_chrome_upstream_group@mediatek.com>,
        kernel test robot <lkp@intel.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>
Date:   Fri, 28 Jan 2022 09:02:44 +0800
In-Reply-To: <164321141754.490431.3020669404541003433.b4-ty@kernel.org>
References: <20220126091159.27513-1-guochun.mao@mediatek.com>
         <164321141754.490431.3020669404541003433.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you very much.

BR,
Guochun


On Wed, 2022-01-26 at 15:36 +0000, Mark Brown wrote:
> On Wed, 26 Jan 2022 17:11:59 +0800, guochun.mao@mediatek.com wrote:
> > From: Guochun Mao <guochun.mao@mediatek.com>
> > 
> > Variables mtk_nor_caps_mt8173, mtk_nor_caps_mt8186 and
> > mtk_nor_caps_mt8192 are not declared.
> > Make them static.
> > 
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> for-next
> 
> Thanks!
> 
> [1/1] spi: spi-mtk-nor: make some internal variables static
>       commit: 474fc2e6395d62758e80b9ea65f61339296355fc
> 
> All being well this means that it will be integrated into the linux-
> next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual
> testing
> and review of the tree, please engage with people reporting problems
> and
> send followup patches addressing any issues that are reported if
> needed.
> 
> If any updates are required or you are submitting further changes
> they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when
> replying
> to this mail.
> 
> Thanks,
> Mark

