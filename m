Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7424B474508
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 15:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhLNO3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 09:29:50 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38024 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhLNO3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 09:29:50 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BEETZh6116420;
        Tue, 14 Dec 2021 08:29:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639492175;
        bh=pkfW5fFxKZWfnkpyQc7roh64li4gkF8aBNTVNrZ5tOI=;
        h=From:To:CC:Subject:Date;
        b=Hln6uVax/PCoEL/CqvEzOY+V/ZRjxI2nlTqsm1QQe8YdPdkMp3084sO5Jhwp+qSL7
         bG4l0VKUoHdHuYlUwT1Frcb+px940E9lzKEOVPsw8GsViPJBz89NQpJMbS03XYr2tT
         7MRwvLbGxtIzqTXdtIeTf7vjt6iz4Rpn4cea+M8A=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BEETZIe024914
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Dec 2021 08:29:35 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 14
 Dec 2021 08:29:35 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 14 Dec 2021 08:29:35 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BEETVkN038465;
        Tue, 14 Dec 2021 08:29:32 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] CAN: Add support for setting mux
Date:   Tue, 14 Dec 2021 19:59:06 +0530
Message-ID: <20211214142908.27940-1-a-govindraju@ti.com>
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

Changes since v1:
- Fixed the description for mux-states property in bindings
  file
- appended declaration of variable ret in the end

Aswath Govindraju (2):
  dt-bindings: phy: ti,tcan104x-can: Document mux-states property
  phy: phy-can-transceiver: Add support for setting mux

 .../bindings/phy/ti,tcan104x-can.yaml         | 10 ++++++++
 drivers/phy/Kconfig                           |  1 +
 drivers/phy/phy-can-transceiver.c             | 24 ++++++++++++++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.17.1

