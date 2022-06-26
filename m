Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4327E55AEF1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 06:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiFZEkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 00:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiFZEkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 00:40:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B8612D04;
        Sat, 25 Jun 2022 21:40:07 -0700 (PDT)
X-UUID: 64becf58045f403a8382ece9878e720a-20220626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:cf81427b-976e-485d-9895-273afb68efef,OB:10,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:95
X-CID-INFO: VERSION:1.1.6,REQID:cf81427b-976e-485d-9895-273afb68efef,OB:10,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:95
X-CID-META: VersionHash:b14ad71,CLOUDID:1b8b91d8-850a-491d-a127-60d9309b2b3e,C
        OID:b107df16dc8b,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 64becf58045f403a8382ece9878e720a-20220626
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2147397096; Sun, 26 Jun 2022 12:40:00 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 26 Jun 2022 12:39:59 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 26 Jun 2022 12:39:58 +0800
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?N=EDcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH v3 0/5] pinctrl: mediatek: add driver support driving and resistance property  on mt8192
Date:   Sun, 26 Jun 2022 12:39:50 +0800
Message-ID: <20220626043955.32756-1-guodong.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v2:

- Patch 1 Optimize commit message description.

- Patch 3 Fix careless character missing the closing '/'.

- Patch 4 Optimize commit message description.

changes since v1:

- Patch 1 Add commit only, add "mediatek:" on the commit title for this
patch, describe the patch modification in detail.

- Patch 2  Add commit only, add "mediatek:" on the commit title for this
patch, use space instead of tab before the =, Dropping E1, E0, and EN
arrays in this patch, which were used by the original advanced
drive configuration.

- Patch 3 Add commit describe the patch modification in detail,
add the missing pull type array for mt8192 to document the pull type of
each pin and prevent invalid pull type settings. use space instead of
tab after the ,.

- Patch 4 Remove the original advanced drive configuration.

- Patch 5 Remove pin definitions that do not support the R0 & R1
pinconfig property.

v1:

Patch 1 make driver consistent with "drive-strength" properties
  description of  pinctrl-mt8192.yaml

Patch 2 make driver consistent with "mediatek,drive-strength-adv"
  description pinctrl-mt8192.yaml, however, "mediatek,drive-strength-adv"
  description of pinctrl-mt8192.yaml needs to be synchronize a little bit.

Patch 3 Since the bias-pull-{up,down} is generic properties, make
  driver to be used for setting type {PUPD/R1/R0 , PU/PD, PU/PD/RSEL}.

Patch 4 Remove some pins definitions not support PUPD/R1/R0.

Please see the following for detailed  description 

Patch 1 provides generic driving setup, which support 2/4/6/8/10/12/14/16mA
  driving.

Patch 2 provides I2C pins specific driving setup property, can support
  0.125/0.25/0.5/1mA adjustment, and also support driving setup with
  unit microamp.

Patch 3 provides I2C pins pull up/down type which is RSEL. It can support
  RSEL define or si unit value(ohm) to set different resistance

Patch 4 Remove pin definitions that do not support the R0 & R1 pinconfig
  property

Guodong Liu (5):
  pinctrl: mediatek: add generic driving setup property on mt8192
  pinctrl: mediatek: add drive for I2C related pins on mt8192
  pinctrl: mediatek: add rsel setting on mt8192
  pinctrl: mediatek: dropping original advanced drive configuration
    function
  pinctrl: mediatek: fix the pinconf definition of some GPIO pins

 drivers/pinctrl/mediatek/pinctrl-mt8192.c | 296 ++++++++++++----------
 1 file changed, 163 insertions(+), 133 deletions(-)

-- 
2.25.5

