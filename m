Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2548746340C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbhK3MWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:22:34 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55258 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhK3MWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:22:23 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AUCIpbM008365;
        Tue, 30 Nov 2021 06:18:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638274731;
        bh=nmi1IlZcNk9nS1cOKiptvQbp5I9DiELHf08aJ2+lkF4=;
        h=From:To:CC:Subject:Date;
        b=d6aoaQXCEEdLyHotUjIObm3MUnt1zdDa53+hwJnv9x4Me21xPxrYRdqqnEJCWDzJ7
         eLnGWbFyzVgRpnWXmAcbMfMIkbek9BlrM0yB8+/Ib5KKTH/yVRBm00CeR7ikHS/SH7
         XX1J3KAmNV7dNQjSKJN5E2gCuN24pCch7jU4Rw3c=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AUCIpsx103242
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Nov 2021 06:18:51 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 30
 Nov 2021 06:18:50 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 30 Nov 2021 06:18:50 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AUCIliP058207;
        Tue, 30 Nov 2021 06:18:48 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH 0/2] MUX: Add support for mux-states
Date:   Tue, 30 Nov 2021 17:48:45 +0530
Message-ID: <20211130121847.11112-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches add support for reading mux
state from the device tree.

Aswath Govindraju (2):
  dt-bindings: mux: Document mux-states property
  mux: Add support for reading mux state from consumer DT node

 .../devicetree/bindings/mux/gpio-mux.yaml     |  11 +-
 .../devicetree/bindings/mux/mux-consumer.yaml |  14 ++
 .../bindings/mux/mux-controller.yaml          |  26 ++-
 drivers/mux/core.c                            | 213 ++++++++++++++++--
 include/linux/mux/consumer.h                  |  19 +-
 5 files changed, 260 insertions(+), 23 deletions(-)

-- 
2.17.1

