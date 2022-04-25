Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AAC50DB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbiDYIv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbiDYIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:51:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BB490CDA;
        Mon, 25 Apr 2022 01:48:09 -0700 (PDT)
X-UUID: 9977d4578d784542855a3e2eb8e0e80c-20220425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:acad9432-eca5-445b-b422-d72f81efe975,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:75
X-CID-INFO: VERSION:1.1.4,REQID:acad9432-eca5-445b-b422-d72f81efe975,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:75
X-CID-META: VersionHash:faefae9,CLOUDID:7f0cd9f0-da02-41b4-b6df-58f4ccd36682,C
        OID:213dbefdc4fc,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:-3,Fi
        le:nil,QS:0,BEC:nil
X-UUID: 9977d4578d784542855a3e2eb8e0e80c-20220425
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1389865509; Mon, 25 Apr 2022 16:48:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 Apr 2022 16:48:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Apr 2022 16:48:02 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Lala Lin <lala.lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v2 0/1] dt-bindings: nvmem: mediatek: Convert mtk-efuse binding to YAML
Date:   Mon, 25 Apr 2022 16:47:59 +0800
Message-ID: <20220425084800.2021-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert MediaTek eFuse devicetree binding to YAML.

Based on tag: next-20220422, linux-next/master

make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/nvmem/mtk,efuse.yaml

make ARCH=arm64
dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/nvmem/mtk,efuse.yaml

changes since v1:
- change file name from mtk,efuse-yaml to mtk,efuse.yaml
- add mtk-efuse in commit title
- change compatible entries from const to enum

Allen-KH Cheng (1):
  dt-bindings: nvmem: mediatek: Convert mtk-efuse binding to YAML

 .../devicetree/bindings/nvmem/mtk,efuse.yaml  | 70 +++++++++++++++++++
 .../devicetree/bindings/nvmem/mtk-efuse.txt   | 43 ------------
 2 files changed, 70 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mtk,efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt

-- 
2.18.0

