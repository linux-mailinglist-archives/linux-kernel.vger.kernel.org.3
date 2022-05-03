Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B377F5182BF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiECLAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbiECK7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:59:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3088289A3;
        Tue,  3 May 2022 03:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651575367; x=1683111367;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=0PUJoXw0gUXYhcx8VbGlgka6mzwXGjiMPFzKkCRtCqw=;
  b=cp8pxKjs8fVb7W32/k4RG51qsxmt2Jl4WR4La+W467xXc5bKJ4LZ+AGQ
   QYTK6RSRHD9N418G3h/PCRWYSMcwTmTUz6sHUQ9BES4XfmHE6DKm0KyNU
   uC7kpWm/au0JCqIWrl8cL76BjkBrMOpvOXkPmPpRVlpVTvBJtUqFSfpKR
   7dr0QIYxrDYAkYdxopobGrcN/q3gFaISCm97UL83IZXX+W0GGPV+mdHxJ
   mlZvC518L9nwXnBC2/iJjRdEXt4PkD2c6hkKN4dwgDsRzfvT/dnMeGuZg
   scBU0tGiCG52yZsdm0aLGq+1paUA3ixoXy+nOMzXsv4ri9ULjMqFy+MEc
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="162127842"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 03:56:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 03:56:06 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 03:56:01 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <peda@axentia.se>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux@armlinux.org.uk>, <Manohar.Puri@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH 0/4] Add support for lan966 flexcom multiplexer
Date:   Tue, 3 May 2022 16:25:24 +0530
Message-ID: <20220503105528.12824-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements driver for lan966 flexcom multiplexer.
Converts atmel-flexcom.txt bindings to yaml format and add new
compatible string for lan966 flexcom.

This patch also adds dt bindings for lan966 flexcom multiplexer.

Kavyasree Kotagiri (4):
  dt-bindings: mfd: atmel,flexcom: Convert to json-schema
  dt-bindings: mfd: atmel,flexcom: Add lan966 compatible string and mux
    properties
  dt-bindings: mux: Add lan966 flexcom mux controller
  mux: lan966: Add support for flexcom mux controller

 .../bindings/mfd/atmel,flexcom.yaml           |  84 +++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 ----------
 .../mux/microchip,lan966-flx-mux.yaml         |  55 +++++++++
 arch/arm/mach-at91/Kconfig                    |   2 +
 drivers/mfd/atmel-flexcom.c                   |  55 ++++++++-
 drivers/mux/Kconfig                           |  12 ++
 drivers/mux/Makefile                          |   2 +
 drivers/mux/lan966-flx.c                      | 116 ++++++++++++++++++
 8 files changed, 325 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
 create mode 100644 Documentation/devicetree/bindings/mux/microchip,lan966-flx-mux.yaml
 create mode 100644 drivers/mux/lan966-flx.c

-- 
2.17.1

