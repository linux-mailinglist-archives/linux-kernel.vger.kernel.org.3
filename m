Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA4351141B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbiD0JND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiD0JMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:12:55 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D802465E3;
        Wed, 27 Apr 2022 02:09:37 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R98rxS096516;
        Wed, 27 Apr 2022 04:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651050533;
        bh=ZyUx3wo0iYiilxqnF8laPtxpLJ1kPF6fVUWaFEOr0NI=;
        h=From:To:CC:Subject:Date;
        b=aZLQB4doOr/qwI3yUeKSooy5I1jr9UWDnYJSLeY7tuYOyL69oqEz/vxMyEo0fiUaT
         xhWFgJvBD8oE5XNvCcAbPzAi7Fl+YaMQRdjpjGFxxuX7okRVMwuXjd/hhHBhKfRRgp
         buK8CZz7RDLnftfDOt7sxg6k5vUI5mEl8ri0RDBw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R98rC8085122
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 04:08:53 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 04:08:52 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 04:08:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R98poL039899;
        Wed, 27 Apr 2022 04:08:52 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH 0/4] arm64: ti: k3-am62: Add DT nodes to enable display
Date:   Wed, 27 Apr 2022 14:38:46 +0530
Message-ID: <20220427090850.32280-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series adds DT nodes for Display SubSystem and other
peripherals required to enable the display on the AM625-SK board. An
HDMI monitor can be connected to the board to view the image/video
outputs.

This series should be applied on top of Vignesh Raghavendra's patch
series that introduces the basic soc and board peripherals for AM62x.

Link for Vignesh's Patch series:
https://lore.kernel.org/linux-arm-kernel/20220427072954.8821-1-vigneshr@ti.com/


Aradhya Bhatia (4):
  arm64: dts: ti: k3-am62-main: Add node for Display SubSystem
  arm64: dts: ti: k3-am625-sk: Add DSS pinmux info
  arm64: dts: ti: k3-am625-sk: Update main-i2c1 frequency
  arm64: dts: ti: k3-am625-sk: Add DSS ports, HDMI tx & peripherals

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi |  30 +++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 103 ++++++++++++++++++++++-
 2 files changed, 132 insertions(+), 1 deletion(-)

-- 
2.36.0

