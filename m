Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA54ED9D1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiCaMuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiCaMt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:49:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7088A211EE1;
        Thu, 31 Mar 2022 05:48:11 -0700 (PDT)
X-UUID: 7f17dc530e79479e9a02a0189fc8c2de-20220331
X-UUID: 7f17dc530e79479e9a02a0189fc8c2de-20220331
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 569259805; Thu, 31 Mar 2022 20:48:07 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 31 Mar 2022 20:48:05 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 31 Mar
 2022 20:48:04 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 31 Mar 2022 20:47:57 +0800
From:   <xinlei.lee@mediatek.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <rex-bc.chen@mediatek.com>, <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v5,0/4] Convert pwm-mtk-disp.txt to mediatek, pwm-disp.yaml format
Date:   Thu, 31 Mar 2022 20:47:49 +0800
Message-ID: <1648730873-18505-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
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

From: Xinlei Lee <xinlei.lee@mediatek.com>

Changes since v4:
1.Base on Linux-next.
2.Cancel removal of mt8167 compatiable patch.

Changes since v3:
1. Combine multiplexed socs into one entry

Changes since v2:
1. Modify the PWM name to DISP_PWM.
2. Include pwm.yaml.
3. Separate conversion files and add/remove operations.

Changes since v1:
1. Fixed formatting issues mentioned in the v1.
2. Delete pwm-mtk-disp.txt.
3. Add mtk_pwm dt_maintainers.
4. Add "#pwm-cells" & power-domains properties.
5. Make dt_checking successful.

Xinlei Lee (4):
  dt-bindings: pwm: Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml
    format
  dt-bindings: pwm: Add compatible for MediaTek MT8192
  dt-bindings: pwm: Add compatible for MediaTek MT8195
  dt-bindings: pwm: Add compatible for MediaTek MT8186

 .../bindings/pwm/mediatek,pwm-disp.yaml       | 72 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt  | 45 ------------
 2 files changed, 72 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt

-- 
2.18.0

