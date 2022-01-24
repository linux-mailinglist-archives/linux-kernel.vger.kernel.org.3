Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733C64978D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 07:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbiAXGMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 01:12:47 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:35162 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232076AbiAXGMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 01:12:46 -0500
X-UUID: 7eb0e3daa3854ae69017cc537cb36162-20220124
X-UUID: 7eb0e3daa3854ae69017cc537cb36162-20220124
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 780973454; Mon, 24 Jan 2022 14:12:42 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Jan 2022 14:12:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 Jan
 2022 14:12:40 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Jan 2022 14:12:40 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH V3 0/3] Add compatible for Mediatek MT8186 
Date:   Mon, 24 Jan 2022 14:12:36 +0800
Message-ID: <20220124061238.7854-1-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH V3 0/3] Add compatible for Mediatek MT8186

v3:
1. Fix Rob review comment in v2.

v2:
1. Fix Rob review comment.
2. split spi-mt65xx & spi-slave-mt27xx to 2 patches.

Leilk Liu (3):
  dt-bindings: spi: Convert spi-slave-mt27xx to json-schema
  dt-bindings: spi: Convert spi-mt65xx to json-schema
  dt-bindings: spi: Add compatible for Mediatek MT8186

 .../bindings/spi/mediatek,spi-mt65xx.yaml     | 102 ++++++++++++++++++
 .../spi/mediatek,spi-slave-mt27xx.yaml        |  58 ++++++++++
 .../devicetree/bindings/spi/spi-mt65xx.txt    |  68 ------------
 .../bindings/spi/spi-slave-mt27xx.txt         |  33 ------
 4 files changed, 160 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt

--
2.18.0


