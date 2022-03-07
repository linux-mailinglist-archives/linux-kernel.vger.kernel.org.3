Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7921B4CFE1B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiCGMXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbiCGMW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:22:56 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B22680214;
        Mon,  7 Mar 2022 04:21:57 -0800 (PST)
X-UUID: 923b65cf9fa54cf2b826851fd7005e5e-20220307
X-UUID: 923b65cf9fa54cf2b826851fd7005e5e-20220307
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jia-wei.chang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1360615509; Mon, 07 Mar 2022 20:21:52 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Mar 2022 20:21:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 7 Mar
 2022 20:21:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 20:21:51 +0800
From:   Tim Chang <jia-wei.chang@mediatek.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jia-Wei Chang <jia-wei.chang@mediatek.com>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <fan.chen@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        <Allen-yy.Lin@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hsinyi@google.com>
Subject: [PATCH 0/4] cpufreq: mediatek: introduce mtk cpufreq
Date:   Mon, 7 Mar 2022 20:21:47 +0800
Message-ID: <20220307122151.11666-1-jia-wei.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPUFREQ is DVFS driver used for power saving by scaling clock frequency
and supply voltage of CPUs. This module cooperates with CCI DEVFREQ for
certain Mediatek SoCs.

Jia-Wei Chang (4):
  dt-bindings: cpufreq: mediatek: transform cpufreq-mediatek into yaml
  dt-bindings: cpufreq: mediatek: add mt8186 cpufreq dt-bindings
  cpufreq: mediatek: clean up cpufreq driver
  cpufreq: mediatek: add platform data and clean up voltage tracking
    logic

 .../bindings/cpufreq/cpufreq-mediatek.yaml    | 172 +++++
 drivers/cpufreq/mediatek-cpufreq.c            | 717 +++++++++---------
 2 files changed, 521 insertions(+), 368 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.yaml

-- 
2.18.0

