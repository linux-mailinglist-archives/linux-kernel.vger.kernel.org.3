Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2C6569A75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbiGGGZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiGGGZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:25:18 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1620910B0;
        Wed,  6 Jul 2022 23:25:15 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2676P8dY043709;
        Thu, 7 Jul 2022 01:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657175108;
        bh=ZJ8DyvmgmgZoto0z0hfg2LDK7ZTaw+3l27p2FMAjOiM=;
        h=From:To:Subject:Date;
        b=OTkmVyPsxeupcIjzbthvKAk17Qp6GOStppW8EfC+b9DbbNodUbPpzi/+FZL1F/djL
         iNCDyLSoBh0tHGtQiLhgDR+WSq1AvJe/ESLthYDGv4HikA2nT6OvKeg3UqIuUd2HTV
         K/UGWE3qnW5W4iXkXlo10VsZJnRR/uDtKwBBeb6I=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2676P8xG058650
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jul 2022 01:25:08 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 7
 Jul 2022 01:25:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 7 Jul 2022 01:25:08 -0500
Received: from ubuntu.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2676P51R106842;
        Thu, 7 Jul 2022 01:25:06 -0500
From:   Matt Ranostay <mranostay@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH RESEND 0/6] J721S2: Add support for additional IPs
Date:   Wed, 6 Jul 2022 23:24:57 -0700
Message-ID: <20220707062503.295663-1-mranostay@ti.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches add support for the following
on J721S2 common processor board,

- USB
- SerDes
- OSPI

Aswath Govindraju (6):
  arm64: dts: ti: k3-j721s2-main: Add support for USB
  arm64: dts: ti: k3-j721s2-main: Add SERDES and WIZ device tree node
  arm64: dts: ti: k3-j721s2-mcu-wakeup: Add support of OSPI
  arm64: dts: ti: k3-j721s2-common-proc-board: Enable SERDES0
  arm64: dts: ti: k3-j721s2-common-proc-board: Add USB support
  arm64: dts: k3-j721s2: Add support for OSPI Flashes

 .../dts/ti/k3-j721s2-common-proc-board.dts    |  78 ++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 112 ++++++++++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  40 +++++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  42 +++++++
 4 files changed, 272 insertions(+)

-- 
2.36.1

