Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C254F8E7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiDHFCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiDHFBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:01:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA9A19C818;
        Thu,  7 Apr 2022 21:59:18 -0700 (PDT)
X-UUID: 1978a92f3ac64dc199fbb11de284364f-20220408
X-UUID: 1978a92f3ac64dc199fbb11de284364f-20220408
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1832130323; Fri, 08 Apr 2022 12:59:12 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Apr 2022 12:59:11 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 8 Apr
 2022 12:59:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 12:59:11 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH V2 04/15] cpufreq: mediatek: Remove unused headers
Date:   Fri, 8 Apr 2022 12:58:57 +0800
Message-ID: <20220408045908.21671-5-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
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

From: Jia-Wei Chang <jia-wei.chang@mediatek.com>

Remove unused headers.

Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index e0545aca7e41..2a2859dbc5e0 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -13,8 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
-#include <linux/thermal.h>
 
 #define MIN_VOLT_SHIFT		(100000)
 #define MAX_VOLT_SHIFT		(200000)
-- 
2.18.0

