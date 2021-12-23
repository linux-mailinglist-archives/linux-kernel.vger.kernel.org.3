Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1F047E315
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348186AbhLWMRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:17:33 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36574 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbhLWMRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:17:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BNCHQmt018198;
        Thu, 23 Dec 2021 06:17:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640261846;
        bh=tRH4EuorSdryfqX3zogUzAkJHn5H2PXs2AZBXRzWybg=;
        h=From:To:CC:Subject:Date;
        b=yPZwBCc+BufVPKrYglQn07t4BeyUvSQtdmZzlvOkcuI5yvxU+2mVEZ2xluxy58bP1
         bdXBmROlUfpnBXwVQ7luTZB3DkvpSB9OWXaxbkcAUEcs2Jw5dAyWM8bpzDd4zW0a3Y
         +5eMQOD54R0TUVJ4Hg++aLm+9DOxykADRLGJ84lA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BNCHQ8O014797
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 06:17:26 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 06:17:25 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 06:17:25 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BNCHN6B047704;
        Thu, 23 Dec 2021 06:17:23 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH-next 0/2] arm64: dts: ti: Cleanup aliases
Date:   Thu, 23 Dec 2021 17:46:48 +0530
Message-ID: <20211223121650.26868-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Dat:    Thu, 23 Dec 2021 17:41:24 +0530
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move aliases to board dts and trim the list to interfaces that are
enabled.
Alias main_uart8 to serial2 so as to use ttyS2 as console on all K3 SoCs

Aswath Govindraju (2):
  arm64: dts: ti: k3-j721s2: Move aliases to board dts
  arm64: dts: ti: k3-j721s2-common-proc-board: Alias console uart to
    serial2

 .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 ++++++++++--
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi         | 22 -------------------
 2 files changed, 12 insertions(+), 24 deletions(-)

-- 
2.34.1

