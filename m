Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE764617B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377623AbhK2OQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:16:36 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37272 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231462AbhK2OO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:14:29 -0500
X-UUID: 4aaf70748b254020abaf5ee72c134a93-20211129
X-UUID: 4aaf70748b254020abaf5ee72c134a93-20211129
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2061602169; Mon, 29 Nov 2021 22:11:08 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 29 Nov 2021 22:11:07 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 29 Nov
 2021 22:11:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Nov 2021 22:11:05 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <yc.hung@mediatek.com>, <daniel.baluta@nxp.com>,
        <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/4] ASoC: mediatek: Update MT8195 machine driver
Date:   Mon, 29 Nov 2021 22:10:53 +0800
Message-ID: <20211129141057.12422-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds support for RT5682s headset codec in mt8195
machine drivers, and SOF support on card mt8195-mt6359-rt1019-rt5682 is
also included.
Patches are based on broonie tree "for-next" branch.

Changes since v1:
  - remove patch3 and patch4 in v1
  - add SOF support on card mt8195-mt6359-rt1012-rt5682
  - add new propertes to dt-bindings for mt8195-mt6359-rt1019-rt5682

Trevor Wu (4):
  ASoC: mediatek: mt8195: add headset codec rt5682s support
  dt-bindings: mediatek: mt8195: add model property
  ASoC: mediatek: mt8195: add sof support on mt8195-mt6359-rt1019-rt5682
  dt-bindings: mediatek: mt8195: add adsp and dai-link property

 .../sound/mt8195-mt6359-rt1011-rt5682.yaml    |   4 +
 .../sound/mt8195-mt6359-rt1019-rt5682.yaml    |  14 +
 sound/soc/mediatek/Kconfig                    |   2 +
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      |  29 +-
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      | 347 +++++++++++++++++-
 5 files changed, 370 insertions(+), 26 deletions(-)

-- 
2.18.0

