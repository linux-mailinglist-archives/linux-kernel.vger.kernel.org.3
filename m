Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5651F49A83B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381246AbiAYDAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:00:37 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:48258 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S3415292AbiAYBir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 20:38:47 -0500
X-UUID: 06c2020a51114bff8dafbf7cad950c5b-20220125
X-UUID: 06c2020a51114bff8dafbf7cad950c5b-20220125
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <leilk.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1842569060; Tue, 25 Jan 2022 09:23:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 25 Jan 2022 09:23:32 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 09:23:31 +0800
From:   Leilk Liu <leilk.liu@mediatek.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH V4 0/3] Add compatible for Mediatek MT8186 
Date:   Tue, 25 Jan 2022 09:23:27 +0800
Message-ID: <20220125012330.13449-1-leilk.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH V4 0/3] Add compatible for Mediatek MT8186

V4:
1. add "dt-bindings: spi: Convert spi-slave-mt27xx to json-schema" to
this series again.

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


