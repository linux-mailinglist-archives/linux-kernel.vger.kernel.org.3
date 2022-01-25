Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D3B49B4CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575789AbiAYNRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:17:38 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60006 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1575597AbiAYNMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:12:31 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20PDCTes027728;
        Tue, 25 Jan 2022 07:12:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643116349;
        bh=tZfRakDxr6IaVcXNqJg09wazOdGm6s80/dTUcsPL8iY=;
        h=From:To:CC:Subject:Date;
        b=caAShyOdaBhkuinLemgAHclHjRHauWotXgHNvJnqlA7qIKHqiQLz01o7OscVu03U6
         fb04WXz8AG12ydBpI8TfaPKo/bi5LPeeq8NmyQ0c+bUEHmNLjJbffLHdi+jOPksjH9
         WvJBibxMem4JQsdNq7TyGkyA3JO/z/rqbPcLa3pY=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20PDCTHA074017
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jan 2022 07:12:29 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 25
 Jan 2022 07:12:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 25 Jan 2022 07:12:28 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20PDCPWD008001;
        Tue, 25 Jan 2022 07:12:26 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH 0/2] J721S2: Add support for PCIE
Date:   Tue, 25 Jan 2022 18:42:23 +0530
Message-ID: <20220125131225.871-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches add support for single
instance of PCIe brought out on J721S2 common processor
board.

Notes:
- Applying this patch series **breaks the boot** of J721S2.
  This is because of the following commit,
  "19e863828acf PCI: j721e: Drop redundant struct device *"
  Dicussions are currently ongoing regarding the required
  fix.

- This needs to be merged after the following patch
  to avoid dtbs_check errors
  https://lkml.org/lkml/2021/11/29/1752

Aswath Govindraju (2):
  arm64: dts: ti: k3-j721s2-main: Add PCIe device tree node
  arm64: dts: ti: k3-j721s2-common-proc-board: Enable PCIe

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 ++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 48 +++++++++++++++++++
 2 files changed, 62 insertions(+)

-- 
2.17.1

