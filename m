Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750E64F7D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244645AbiDGLBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244652AbiDGLA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:00:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED29812C6EE;
        Thu,  7 Apr 2022 03:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649329137; x=1680865137;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=EzmSGWlsWjkeqCQgsHDdF/k8eR0xW55Lf0E785X6ELU=;
  b=NIQBqT7lI0EYL1D0P4xN6kCx6GMOqHDeH60q9MJF7b73JwsXAYunKHHf
   PWAHhDmQb/XMdU3RWqlEDh2Zl++xOW24LzHQisUIGkrzmGkFpLsXvOWOz
   rFeg7eEC6Dd6lUOorkmrli956+kQwQ8is/IhiSenTWPjXER85lwk54DxX
   as4lO2HNBTx6/cImcCS31AFhAVx8zLN52vTZeFFk44mTVP94+Na6LvPIx
   cOnJLOMgcr8RX88aTGA1wuRk74+JacFNcB3Pq20GKUcQ7Ux92nJrkBX2j
   g8ZGlS/M7U7s1xz/Flh/0Y+sLq41uDphHIxkziHOHhnUrRuGaa7imgtXz
   g==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="154758581"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2022 03:58:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Apr 2022 03:58:55 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 7 Apr 2022 03:58:50 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <arnd@arndb.de>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <olof@lixom.net>,
        <soc@kernel.org>, <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <tudor.ambarus@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Manohar.Puri@microchip.com>
Subject: [PATCH 0/2] ARM: dts: Add LAN966x QSPI nodes
Date:   Thu, 7 Apr 2022 16:28:33 +0530
Message-ID: <20220407105835.10962-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds QSPI nodes of LAN966x Soc.
Also enables qspi0 controller and SST SPI-NOR flash
for pcb8291 board.

Kavyasree Kotagiri (2):
  ARM: dts: lan966x: Add QSPI nodes
  ARM: dts: lan966x-pcb8291: Add QSPI0 and SPI NOR memory nodes

 arch/arm/boot/dts/lan966x-pcb8291.dts | 15 +++++++++
 arch/arm/boot/dts/lan966x.dtsi        | 48 +++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

-- 
2.17.1

