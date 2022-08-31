Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A315A7DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiHaMtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiHaMtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:49:04 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4BA8E0DD;
        Wed, 31 Aug 2022 05:48:58 -0700 (PDT)
X-UUID: a9fb2e160df345f9928f9dd6b11c2435-20220831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QHetHRfxF8Jq9zo5zXOQv02C9vAsgfmub91Rvhqsok0=;
        b=Drpit1r3f27Bat0TEnketX90HMZR3YjfOc0vkSNcAHnkVf1fNZE1zyhqC6OQM66MSBQPTATTfxf2vVbm/7Sucs9WduhUY80yrGDEv4GbBx2xsIzwSQza5WqX2seZsjERP732YmWEYdJpLJVNwSWJm82wwCQ/bXgt1SQaMvbbCRk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:038ebf24-4d2b-4747-a480-ba2b4f1d21f4,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:90
X-CID-INFO: VERSION:1.1.10,REQID:038ebf24-4d2b-4747-a480-ba2b4f1d21f4,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:90
X-CID-META: VersionHash:84eae18,CLOUDID:d76832d0-20bd-4e5e-ace8-00692b7ab380,C
        OID:b9bf449cdf21,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a9fb2e160df345f9928f9dd6b11c2435-20220831
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 545670136; Wed, 31 Aug 2022 20:48:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 31 Aug 2022 20:48:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 31 Aug 2022 20:48:51 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <angelogioacchino.delregno@collabora.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH 0/4] Introduce MediaTek frequency hopping driver
Date:   Wed, 31 Aug 2022 20:48:46 +0800
Message-ID: <20220831124850.7748-1-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce MediaTek frequency hopping and spread spectrum clocking control
for MT8186.

Johnson Wang (4):
  clk: mediatek: Export PLL operations symbols
  dt-bindings: arm: mediatek: Add new bindings of MediaTek frequency
    hopping
  clk: mediatek: Add new clock driver to handle FHCTL hardware
  clk: mediatek: Change PLL register API for MT8186

 .../bindings/arm/mediatek/mediatek,fhctl.yaml |  49 ++++
 drivers/clk/mediatek/Makefile                 |   2 +-
 drivers/clk/mediatek/clk-fhctl.c              | 258 +++++++++++++++++
 drivers/clk/mediatek/clk-fhctl.h              |  27 ++
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c  |  65 ++++-
 drivers/clk/mediatek/clk-pll.c                |  84 +++---
 drivers/clk/mediatek/clk-pll.h                |  56 ++++
 drivers/clk/mediatek/clk-pllfh.c              | 271 ++++++++++++++++++
 drivers/clk/mediatek/clk-pllfh.h              |  81 ++++++
 9 files changed, 839 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
 create mode 100644 drivers/clk/mediatek/clk-fhctl.c
 create mode 100644 drivers/clk/mediatek/clk-fhctl.h
 create mode 100644 drivers/clk/mediatek/clk-pllfh.c
 create mode 100644 drivers/clk/mediatek/clk-pllfh.h

-- 
2.18.0

