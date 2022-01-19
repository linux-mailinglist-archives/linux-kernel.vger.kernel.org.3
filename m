Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516EF493A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354614AbiASMgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:36:23 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:52324 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1354525AbiASMf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:35:58 -0500
X-UUID: 1e92f186efd941938a47b5979583cae1-20220119
X-UUID: 1e92f186efd941938a47b5979583cae1-20220119
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 541626622; Wed, 19 Jan 2022 20:35:53 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Jan 2022 20:35:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 20:35:52 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     John Crispin <john@phrozen.org>, Ryder Lee <ryder.lee@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH 0/2] Update mt7986 memory node in DT
Date:   Wed, 19 Jan 2022 20:35:35 +0800
Message-ID: <20220119123537.9968-1-sam.shih@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the format of memory node in DT based on
maintainer comments in the following thread:
https://lore.kernel.org/all/bc0a9df0-8ba0-76ed-4522-43a3082f42b4@gmail.com/

Sam Shih (2):
  arm64: dts: mediatek: update mt7986a memory node
  arm64: dts: mediatek: update mt7986b memory node

 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 3 ++-
 arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.29.2

