Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5291E5182A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiECK50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiECK5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:57:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E605338A4;
        Tue,  3 May 2022 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651575217; x=1683111217;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=0PUJoXw0gUXYhcx8VbGlgka6mzwXGjiMPFzKkCRtCqw=;
  b=MKzOL8HpjvPo2bFj79pTstGdSDCxVORuuRY9AVa7pgB56LirvK7UPRfm
   BvIOOaqfp4a8mZQlzvFapP9BkjdNWkjSH2E1yUrLJkZ3gsEvyxWsmS8aj
   6jANRTuoqrWKKXpMJBkgdUulAnJvFyyJoTtW/7WoMn6SWOtuWOHkYf8Dw
   JRSdUK4Qe9q2Zbc2mqnr4qHAKhc2jSOtZHzAVeCQUtqjx5WF8PlMYIx4E
   Q10tgUX9sWI3iZK5JKVIFI6CmTNyn76hOTLnYgSl8C09TND6ZTfQ7Xx6V
   LXgTBve4blYeidRvjhFOEJw07xn1bFpsEpwbUDCkrSd0CVWbGMWODQHjy
   g==;
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="171750931"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 May 2022 03:53:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 3 May 2022 03:53:36 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 3 May 2022 03:53:32 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <peda@axentia.se>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lee.jones@linaro.org>,
        <linux@armlinux.org.uk>, <Manohar.Puri@microchip.com>,
        <Kavyasree.Kotagiri@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: [Internal PATCH 0/4] Add support for lan966 flexcom multiplexer
Date:   Tue, 3 May 2022 16:23:16 +0530
Message-ID: <20220503105320.12727-1-kavyasree.kotagiri@microchip.com>
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

