Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C06A481AD4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhL3Irk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:47:40 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34670 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237529AbhL3Irk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:47:40 -0500
X-UUID: 1f78bb900dfc4a70958dc36edc81acf2-20211230
X-UUID: 1f78bb900dfc4a70958dc36edc81acf2-20211230
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1311688746; Thu, 30 Dec 2021 16:47:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Dec 2021 16:47:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Dec 2021 16:47:34 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ASoC: mediatek: mt8195: repair pcmif BE dai
Date:   Thu, 30 Dec 2021 16:47:29 +0800
Message-ID: <20211230084731.31372-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches repairs some problems for pcmif BE dai.
The unexpected control flow is corrected, and the missing playback
support of DPCM is added.

Patches are based on broonie tree "for-next" branch.

Trevor Wu (2):
  ASoC: mediatek: mt8195: correct pcmif BE dai control flow
  ASoC: mediatek: mt8195: add playback support to PCM1_BE dai_link

 sound/soc/mediatek/mt8195/mt8195-dai-pcm.c    | 73 ++++++-------------
 .../mt8195/mt8195-mt6359-rt1011-rt5682.c      |  1 +
 .../mt8195/mt8195-mt6359-rt1019-rt5682.c      |  1 +
 sound/soc/mediatek/mt8195/mt8195-reg.h        |  1 +
 4 files changed, 24 insertions(+), 52 deletions(-)

-- 
2.18.0

