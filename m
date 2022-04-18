Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEFB50511C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbiDRMb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbiDRM1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:27:40 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31CD1E3E9;
        Mon, 18 Apr 2022 05:21:09 -0700 (PDT)
X-UUID: 4b3d5665d53a412db09326e58bfadaff-20220418
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:88ef193e-4d84-413b-be80-a49c2ab6f040,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:e0f616f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 4b3d5665d53a412db09326e58bfadaff-20220418
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2145015939; Mon, 18 Apr 2022 20:21:03 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 18 Apr 2022 20:21:02 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 Apr
 2022 20:20:59 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 18 Apr 2022 20:20:58 +0800
From:   <xinlei.lee@mediatek.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rex-bc.chen@mediatek.com>,
        <jitao.shi@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH v6,0/5] Convert pwm-mtk-disp.txt to mediatek, pwm-disp.yaml format
Date:   Mon, 18 Apr 2022 20:20:51 +0800
Message-ID: <1650284456-16407-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
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

From: Xinlei Lee <xinlei.lee@mediatek.com>

Change since v5:
1.Add interrupts property.

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

Xinlei Lee (5):
  dt-bindings: pwm: Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml
    format
  dt-bindings: pwm: Add compatible for MediaTek MT8192
  dt-bindings: pwm: Add compatible for MediaTek MT8195
  dt-bindings: pwm: Add compatible for MediaTek MT8186
  dt-bindings: pwm: Add interrupts property for MediaTek MT8192

 .../bindings/pwm/mediatek,pwm-disp.yaml       | 75 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt  | 45 -----------
 2 files changed, 75 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt

-- 
2.18.0

