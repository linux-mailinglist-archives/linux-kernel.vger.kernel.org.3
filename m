Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1459E50AFD5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiDVGAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiDVGAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:00:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C614F9D8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:57:23 -0700 (PDT)
X-UUID: 9da354324c1a4640a505334e2494aed0-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:c12192c6-c32f-403c-a562-33a4f3a8ee32,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.4,REQID:c12192c6-c32f-403c-a562-33a4f3a8ee32,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:faefae9,CLOUDID:79e4bcef-06b0-4305-bfbf-554bfc9d151a,C
        OID:5502ed875025,Recheck:0,SF:13|15|28|16|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 9da354324c1a4640a505334e2494aed0-20220422
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1081602718; Fri, 22 Apr 2022 13:57:16 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 22 Apr 2022 13:57:15 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Apr
 2022 13:57:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 13:57:14 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YC Hung <yc.hung@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
CC:     <linux-kernel@vger.kernel.org>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v1 0/4] Add support of MediaTek mt8186 to SOF
Date:   Fri, 22 Apr 2022 13:56:55 +0800
Message-ID: <20220422055659.8738-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of MediaTek mt8186 SoC DSP to SOF.
This series is taken from thesofproject/linux/tree/topic/sof-dev-rebase.

Tinghan Shen (4):
  ASoC: SOF: mediatek: Add mt8186 hardware support
  ASoC: SOF: mediatek: Add mt8186 sof fw loader and dsp ops
  ASoC: SOF: mediatek: Add mt8186 dsp clock support
  ASoC: SOF: mediatek: Add DSP system PM callback for mt8186

 sound/soc/sof/mediatek/Kconfig                |   9 +
 sound/soc/sof/mediatek/Makefile               |   1 +
 sound/soc/sof/mediatek/adsp_helper.h          |   8 +
 sound/soc/sof/mediatek/mt8186/Makefile        |   4 +
 sound/soc/sof/mediatek/mt8186/mt8186-clk.c    | 101 +++++
 sound/soc/sof/mediatek/mt8186/mt8186-clk.h    |  24 +
 sound/soc/sof/mediatek/mt8186/mt8186-loader.c |  53 +++
 sound/soc/sof/mediatek/mt8186/mt8186.c        | 413 ++++++++++++++++++
 sound/soc/sof/mediatek/mt8186/mt8186.h        |  80 ++++
 9 files changed, 693 insertions(+)
 create mode 100644 sound/soc/sof/mediatek/mt8186/Makefile
 create mode 100644 sound/soc/sof/mediatek/mt8186/mt8186-clk.c
 create mode 100644 sound/soc/sof/mediatek/mt8186/mt8186-clk.h
 create mode 100644 sound/soc/sof/mediatek/mt8186/mt8186-loader.c
 create mode 100644 sound/soc/sof/mediatek/mt8186/mt8186.c
 create mode 100644 sound/soc/sof/mediatek/mt8186/mt8186.h

-- 
2.18.0

