Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019EB53E0D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiFFF3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiFFF2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:28:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0086913FD47;
        Sun,  5 Jun 2022 22:11:37 -0700 (PDT)
X-UUID: b90dc76aab8445e0975b15471b83c89f-20220606
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:646d8357-28e2-4d69-8057-c6a9539acc69,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:47,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:42
X-CID-INFO: VERSION:1.1.5,REQID:646d8357-28e2-4d69-8057-c6a9539acc69,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:47,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:42
X-CID-META: VersionHash:2a19b09,CLOUDID:ecca447e-c8dc-403a-96e8-6237210dceee,C
        OID:d1a002376914,Recheck:0,SF:28|100|17|19|48|101,TC:nil,Content:0,EDM:-3,
        IP:nil,URL:1,File:nil,QS:0,BEC:nil
X-UUID: b90dc76aab8445e0975b15471b83c89f-20220606
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1777165115; Mon, 06 Jun 2022 13:11:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 6 Jun 2022 13:11:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 6 Jun 2022 13:11:32 +0800
From:   Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <matthias.bgg@gmail.com>, <airlied@linux.ie>,
        <angelogioacchino.delregno@collabora.com>, <pavel@ucw.cz>,
        <nancy.lin@mediatek.com>, <ck.hu@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Subject: [RESEND v4 0/3] MediaTek MT8195 display binding
Date:   Mon, 6 Jun 2022 13:11:28 +0800
Message-ID: <20220606051131.14182-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this series to present MediaTek display binding for MT8195.
The reason I send this series is Jason and Nancy's binding patches are
never received by devicetree mail server.
Therefore, I help them to resend binding patches.

Changes for resend v4:
1. Rebase to v5.19-rc1 which iommu series is included.
2. Add my signed-off.
3. v4 is not received by devicetree mail server, add more cc and resend.
4. This patch is from Nancy's v22 series:[2].

[2]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=645240

Changes for v3:
1. Fix rdma and ethdr binding doc.
2. Nancy's series: [1].
3. This series is based on linux-next: next-20220511.

Changes for v2:
1. This patch is based on linux next-20220506.
2. Jason's patches are accepted and I drop them.

[1]: https://lore.kernel.org/all/20220512053128.31415-1-nancy.lin@mediatek.com/

Nancy.Lin (3):
  dt-bindings: mediatek: add vdosys1 RDMA definition for mt8195
  dt-bindings: reset: mt8195: add vdosys1 reset control bit
  dt-bindings: mediatek: add ethdr definition for mt8195

 .../display/mediatek/mediatek,ethdr.yaml      | 188 ++++++++++++++++++
 .../display/mediatek/mediatek,mdp-rdma.yaml   |  88 ++++++++
 include/dt-bindings/reset/mt8195-resets.h     |  45 +++++
 3 files changed, 321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-rdma.yaml

-- 
2.18.0

