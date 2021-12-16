Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E8D4768FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 05:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhLPEKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 23:10:30 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34764 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhLPEKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 23:10:30 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BG4AJD4068197;
        Wed, 15 Dec 2021 22:10:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639627819;
        bh=bqNJ7doLGaZDzl+Yqf7PFn8b5z/KOgogWZZb9M1PXJc=;
        h=From:To:CC:Subject:Date;
        b=vyFl1XzTzuafX0TqLUh50bydivJSpQoN9JPyI8RGH/MY5r5tgzPoaA/BN880wMMUf
         dLVTrfdLfSnMKKREYmp+uiCaboziXjGKKkSFRrMRqXlHGzThJA2Y50RNas2oSL2DdL
         w/0KfdlL/SKOUTXn1tL1MX02++7QZjivwSHTXHPE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BG4AJYO079702
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Dec 2021 22:10:19 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 15
 Dec 2021 22:10:19 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 15 Dec 2021 22:10:19 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BG4AEOJ093350;
        Wed, 15 Dec 2021 22:10:15 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] CAN: Add support for setting mux
Date:   Thu, 16 Dec 2021 09:40:10 +0530
Message-ID: <20211216041012.16892-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches add support for setting
muxes to route signals from CAN controller to transceiver
by reading the property mux-states from the device tree
node

The following series of patches are dependent on,
- https://lkml.org/lkml/2021/12/2/423

Changes since v2:
- Fixed the bindings removing the description about
  the arguments in mux-states property

Changes since v1:
- Fixed the description for mux-states property in bindings
  file
- appended declaration of variable ret in the end

Aswath Govindraju (2):
  dt-bindings: phy: ti,tcan104x-can: Document mux-states property
  phy: phy-can-transceiver: Add support for setting mux

 .../bindings/phy/ti,tcan104x-can.yaml         |  7 ++++++
 drivers/phy/Kconfig                           |  1 +
 drivers/phy/phy-can-transceiver.c             | 24 ++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.17.1

