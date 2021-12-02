Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542F746644F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358203AbhLBNN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:13:57 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50698 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358178AbhLBNNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:13:50 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B2DA8Vk024561;
        Thu, 2 Dec 2021 07:10:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638450608;
        bh=f6sAaoaJOz1208IHW4aLleeoCN8L+qtJVwhz1Pk2fiI=;
        h=From:To:CC:Subject:Date;
        b=dPTEQfPSVyldlt8CiVQrKdzQhIUT5oy9IzFVh3eZR7WPVGxk7AtxLib4/+cL+Z+cO
         wWnYvbzm+X9cJPv31TpyB6Mr2KsFJeJf1mptiZHjogSvwwh27nm+OflxOPg+GjQ7he
         SEgzAMnxipzqGcGM0wrTMc97IZgfW1VqD8KrQ6Tw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B2DA8gt110535
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Dec 2021 07:10:08 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Dec 2021 07:10:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Dec 2021 07:10:08 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B2DA4Ki031324;
        Thu, 2 Dec 2021 07:10:05 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-can@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] CAN: Add support for setting mux
Date:   Thu, 2 Dec 2021 18:40:00 +0530
Message-ID: <20211202131002.12217-1-a-govindraju@ti.com>
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

Aswath Govindraju (2):
  dt-bindings: phy: ti,tcan104x-can: Document mux-states property
  phy: phy-can-transceiver: Add support for setting mux

 .../bindings/phy/ti,tcan104x-can.yaml         | 13 +++++++++++
 drivers/phy/Kconfig                           |  1 +
 drivers/phy/phy-can-transceiver.c             | 22 +++++++++++++++++++
 3 files changed, 36 insertions(+)

-- 
2.17.1

