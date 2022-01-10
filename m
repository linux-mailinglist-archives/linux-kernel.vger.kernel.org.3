Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E367488F24
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbiAJEHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:07:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49662 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiAJEHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:07:12 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20A46uWk010823;
        Sun, 9 Jan 2022 22:06:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641787616;
        bh=DWhaHKR9RAeqJgfcht9+xY75xinhLO6EFG4nlneJ1oo=;
        h=From:To:CC:Subject:Date;
        b=JuuLsTWJ1WxLNNb3F7Dwavb1lQPuXrSnvE8YOdRt4C8aGfIgOjPNbty012mPddbfd
         NwA1CImaeSTD9lK7Ew4YTJdXvF+H7qO9P/hSZZmriDgd3uYNXR/5KQGDcV76gJGuDk
         NUL3BtWbA0OQ3iOuagrjmpor9Czs/T6ShDIdt1HI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20A46t1h083689
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 9 Jan 2022 22:06:55 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 9
 Jan 2022 22:06:55 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 9 Jan 2022 22:06:55 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20A46tvG106340;
        Sun, 9 Jan 2022 22:06:55 -0600
From:   Hari Nagalla <hnagalla@ti.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <hnagalla@ti.com>
Subject: [PATCH 0/2] TI K3 M4F support on AM64x SoC
Date:   Sun, 9 Jan 2022 22:06:48 -0600
Message-ID: <20220110040650.18186-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following series introduces K3 M4F remoteproc driver support for AM64x 
SoC family. The AM64X SoCs has a ARM Cortex M4F core in MCU voltage
domain. For safety oriented applications, this core is operated
independently with out any IPC to other cores on the SoC. However,
for non safety applications, some customers use it as a remote processor
and so linux remote proc support is extended to the M4F core.

See AM64x Technical Reference Manual (SPRUIM2C – SEPTEMBER 2021)
for further details: https://www.ti.com/lit/pdf/SPRUIM2

Regards
Hari

Hari Nagalla (2):
  dt-bindings: remoteproc: k3-m4f: Add bindings for K3 AM64x SoCs
  remoteproc: k4-m4: Add a remoteproc driver for M4F subsystem

 .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 121 +++
 drivers/remoteproc/Kconfig                    |  13 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/ti_k3_m4_remoteproc.c      | 899 ++++++++++++++++++
 4 files changed, 1034 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
 create mode 100644 drivers/remoteproc/ti_k3_m4_remoteproc.c

-- 
2.17.1

