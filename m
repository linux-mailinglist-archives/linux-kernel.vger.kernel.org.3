Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831FA500C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbiDNL4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiDNL4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:56:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB5B887AF;
        Thu, 14 Apr 2022 04:53:49 -0700 (PDT)
X-UUID: 2a3feb5c5ba6403a8358d36008dc8a07-20220414
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:10da4593-4ebc-457d-a26d-8552cbbea70d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:25,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.4,REQID:10da4593-4ebc-457d-a26d-8552cbbea70d,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:25,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:100
X-CID-META: VersionHash:faefae9,CLOUDID:dade25a9-d103-4e36-82b9-b0e86991b3df,C
        OID:7a0f8d2109bd,Recheck:0,SF:13|15|28|17|19|48,TC:nil,Content:0,EDM:5,Fil
        e:nil,QS:0,BEC:nil
X-UUID: 2a3feb5c5ba6403a8358d36008dc8a07-20220414
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1247441206; Thu, 14 Apr 2022 19:53:42 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 14 Apr 2022 19:53:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Apr
 2022 19:53:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Apr 2022 19:53:41 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH 0/2] remoteproc: mediatek: allow different SCP firmware names
Date:   Thu, 14 Apr 2022 19:53:37 +0800
Message-ID: <20220414115339.5536-1-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCP needs firmware which differs between platforms and SoCs. Add a new
property "firmware-name" to allow the DT to specify the platform/board specific
path to this firmware file.

The firmware-name property is optional and the code falls back to the
old filename if the property isn't present.

Base on tag: next-20220412, linux-next/master

Allen-KH Cheng (2):
  dt-bindings: remoteproc: mediatek: dd firmware-name property
  remoteproc: mediatek: allow reading firmware-name from DT

 Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml | 7 +++++++
 drivers/remoteproc/mtk_scp.c                              | 7 ++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.18.0

