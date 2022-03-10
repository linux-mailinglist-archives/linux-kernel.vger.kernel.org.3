Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5B4D4D74
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbiCJPj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236683AbiCJPj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:39:27 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C21DE3893;
        Thu, 10 Mar 2022 07:38:21 -0800 (PST)
X-UUID: b670a9956308466f8165fd64401c260f-20220310
X-UUID: b670a9956308466f8165fd64401c260f-20220310
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1827591408; Thu, 10 Mar 2022 23:38:15 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 10 Mar 2022 23:38:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Mar
 2022 23:38:14 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Mar 2022 23:38:13 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <aaronyu@google.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <linmq006@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [v2 0/2] ASoC: mediatek: mt8192: support rt1015p_rt5682s
Date:   Thu, 10 Mar 2022 23:37:05 +0800
Message-ID: <20220310153707.29722-1-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series reuses mt8192-mt6359-rt10150rt5682.c for supporting machine
driver with rt1015p speaker amplifier and rt5682s headset codec.

Changes from v1:
  - uses the snd_soc_of_get_dai_link_codecs to complete the
  configuration of dai_link's codecs
  - uses definitions to simplifies card name and compatible name

Jiaxin Yu (2):
  ASoC: dt-bindings: mt8192-mt6359: add new compatible for using rt1015p
    and rt5682
  ASoC: mediatek: mt8192: support rt1015p_rt5682s

 .../sound/mt8192-mt6359-rt1015-rt5682.yaml    |   1 +
 sound/soc/mediatek/Kconfig                    |   1 +
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 204 +++++++++++-------
 3 files changed, 129 insertions(+), 77 deletions(-)

-- 
2.18.0

