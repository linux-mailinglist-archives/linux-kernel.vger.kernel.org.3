Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9338B4663DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357949AbhLBMop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:44:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55680 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347288AbhLBMoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:44:39 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1B2CewSO004521;
        Thu, 2 Dec 2021 06:40:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638448858;
        bh=HQyw/4oQuNRti/XlgxrV5etzs43HTr53XLNYq7hSp/I=;
        h=From:To:CC:Subject:Date;
        b=UZSWD9EGNj4i7uI3KXerNR62Cb7jWBucS9O8YbtvZfDmOjkKbw3Hk80e05obBTiYU
         dBqNR5ZvxC1p7a3FqG+ZlD4Dp6HehRE/QB0+kWKO2gMMAr0EfnUejnCYtwJKhMXxNa
         N8fQNtBOaoHQ782lYHXmruRKQExBalxCHMYiqvmI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1B2Cewt9080830
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Dec 2021 06:40:58 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 2
 Dec 2021 06:40:58 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 2 Dec 2021 06:40:58 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1B2CesQC051666;
        Thu, 2 Dec 2021 06:40:55 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH v2 0/2] MUX: Add support for mux-states
Date:   Thu, 2 Dec 2021 18:10:51 +0530
Message-ID: <20211202124053.2835-1-a-govindraju@ti.com>
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

changes since v1:
- Made grammer corrections and added more information
  on the usage for mux-states and mux-controls

Aswath Govindraju (2):
  dt-bindings: mux: Document mux-states property
  mux: Add support for reading mux state from consumer DT node

 .../devicetree/bindings/mux/gpio-mux.yaml     |  11 +-
 .../devicetree/bindings/mux/mux-consumer.yaml |  21 ++
 .../bindings/mux/mux-controller.yaml          |  26 ++-
 drivers/mux/core.c                            | 219 ++++++++++++++++--
 include/linux/mux/consumer.h                  |  19 +-
 5 files changed, 271 insertions(+), 25 deletions(-)

-- 
2.17.1

