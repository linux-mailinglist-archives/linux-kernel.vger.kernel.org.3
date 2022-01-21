Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBDC4959B0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 07:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378612AbiAUGBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 01:01:35 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59356 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237848AbiAUGB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 01:01:29 -0500
X-UUID: f7d46c83d52a401b8aadf0e4e7f7ad4f-20220121
X-UUID: f7d46c83d52a401b8aadf0e4e7f7ad4f-20220121
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1606192875; Fri, 21 Jan 2022 14:01:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 21 Jan 2022 14:01:23 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 21 Jan 2022 14:01:22 +0800
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH v2 0/2] pinctrl: mediatek: Support pinctrl driver on mt8186
Date:   Fri, 21 Jan 2022 14:01:18 +0800
Message-ID: <20220121060120.10683-1-guodong.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v1:
- add default pinctrl config to consistent with other MTK pinctrl drivers

Patch 1 add pinctrl file and binding document.

Patch 2 add pinctrl chip driver on mt8186.

Guodong Liu (2):
  dt-bindings: pinctrl: mt8186: add pinctrl file and binding document
  pinctrl: add pinctrl driver on mt8186

 .../bindings/pinctrl/pinctrl-mt8186.yaml      |  303 +++
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8186.c     | 1313 ++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8186.h | 2186 +++++++++++++++++
 include/dt-bindings/pinctrl/mt8186-pinfunc.h  | 1174 +++++++++
 6 files changed, 4984 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8186.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8186.h
 create mode 100644 include/dt-bindings/pinctrl/mt8186-pinfunc.h

-- 
2.25.5

