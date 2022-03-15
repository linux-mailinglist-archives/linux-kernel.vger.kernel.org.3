Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD134D9B89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiCOMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348448AbiCOMtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:49:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0531721BF;
        Tue, 15 Mar 2022 05:47:54 -0700 (PDT)
X-UUID: 81e3a45f5d13432db59e9c0e30614be4-20220315
X-UUID: 81e3a45f5d13432db59e9c0e30614be4-20220315
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1334456454; Tue, 15 Mar 2022 20:47:50 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 15 Mar 2022 20:47:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Mar 2022 20:47:49 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Tinghan Shen <tinghan.shen@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v6 0/2] Add SCP support for mt8186
Date:   Tue, 15 Mar 2022 20:47:45 +0800
Message-ID: <20220315124747.30144-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

Based on tag: next-20220310, linux-next/master.

changes since v5:
 - set I-cache and D-cache size before loading SCP FW.
 - remove unused ipi_buf_offset.

changes since v4:
 - use 'Reviewed-by:' for the preferred signature.

changes since v3:
 - base on rproc-next

changes since v2:
 - remove redundant SoB.

changes since v1:
 - use mt8192_power_on_sram() helper
 - add MT8186_SCP_L1_SRAM_PD_P1 in mtk_common.h
 - add MT8186_SCP_L1_SRAM_PD_P2 in mtk_common.h

Allen-KH Cheng (2):
  dt-bindings: remoteproc: mediatek: Add binding for mt8186 scp
  remoteproc: mediatek: Support mt8186 scp

 .../bindings/remoteproc/mtk,scp.yaml          |  1 +
 drivers/remoteproc/mtk_common.h               |  3 ++
 drivers/remoteproc/mtk_scp.c                  | 42 +++++++++++++++++++
 3 files changed, 46 insertions(+)

-- 
2.18.0

