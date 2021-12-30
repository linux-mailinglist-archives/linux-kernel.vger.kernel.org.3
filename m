Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B47481BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238964AbhL3LsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:48:23 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:54326 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235195AbhL3LsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:48:22 -0500
X-UUID: c05e241c8f6642609edd9378a9b4bbad-20211230
X-UUID: c05e241c8f6642609edd9378a9b4bbad-20211230
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1884782077; Thu, 30 Dec 2021 19:48:18 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 30 Dec 2021 19:48:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Dec 2021 19:48:17 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH 0/2] Add PMIC wrapper support for Mediatek MT8186 SoC IC
Date:   Thu, 30 Dec 2021 19:48:13 +0800
Message-ID: <20211230114815.9268-1-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add PMIC wrapper support for Mediatek MT8186 SoC IC

Johnson Wang (2):
  soc: mediatek: pwrap: add pwrap driver for MT8186 SoC
  dt-bindings: mediatek: add compatible for MT8186 pwrap

 .../bindings/soc/mediatek/pwrap.txt           |  1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c          | 86 +++++++++++++++++--
 2 files changed, 81 insertions(+), 6 deletions(-)

-- 
2.18.0

