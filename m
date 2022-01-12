Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F385D48C25A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352556AbiALKgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:36:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37818 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239182AbiALKgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:36:17 -0500
X-UUID: b554ec6ef6404c5795770831d7ffbe03-20220112
X-UUID: b554ec6ef6404c5795770831d7ffbe03-20220112
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1435407271; Wed, 12 Jan 2022 18:36:15 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Jan 2022 18:36:14 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Jan 2022 18:36:13 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH V2 0/3] Add compatible for Mediatek MT8186
Date:   Wed, 12 Jan 2022 18:36:06 +0800
Message-ID: <20220112103609.17421-1-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH V2 0/3] Add compatible for Mediatek MT8186

v2:
1. Fix Rob review comment.
2. split spi-mt65xx & spi-slave-mt27xx to 2 patches.

Leilk Liu (3):
  dt-bindings: spi: Convert spi-slave-mt27xx to json-schema
  dt-bindings: spi: Convert spi-mt65xx to json-schema
  dt-bindings: spi: Add compatible for Mediatek MT8186

 .../bindings/spi/mediatek,spi-mt65xx.yaml     | 100 ++++++++++++++++++
 .../spi/mediatek,spi-slave-mt27xx.yaml        |  73 +++++++++++++
 .../devicetree/bindings/spi/spi-mt65xx.txt    |  68 ------------
 .../bindings/spi/spi-slave-mt27xx.txt         |  33 ------
 4 files changed, 173 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt

--
2.25.1



