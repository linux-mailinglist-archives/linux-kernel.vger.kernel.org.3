Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE49F4CFF78
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbiCGNEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbiCGNEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:04:48 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222B770F75;
        Mon,  7 Mar 2022 05:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646658234; x=1678194234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YS1Q5Iq+4wBzXHt/JGOV5it1q6BB1K1SeUenRcQi0Fk=;
  b=GUCTH1YHboq6mIcDEdxoaWOlegtNdSNCGvFfkJW+2zdyRPOUFnp2MmW6
   mXrLGnl1BS6tOZOn1GoUhR7BZenY1F+FHevxzJvSgWIxht4lOj1G4aSvs
   DuwYpEobDR8j63DiofIcdhRBr0KEzvowNsdZYVbTNJdRWyU52hriO82Kr
   NK4/YqhIRboMezi2/eCwTaf2s1fAfWfZFvq3st0xs+JqAi/PzDThVkAwG
   4AGGdp1ZrAqcHsSzTw5rGWdOku/O72f7YVRSGH/M3r4c6yqGE1K8hi0pL
   JBX0VMrIqL3zz49TylPjs1J3Bjn9dk36yFgCoQT3kkd7yRRD8n4kHGap+
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="164771398"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 06:03:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 06:03:53 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 7 Mar 2022 06:03:46 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <claudiu.beznea@microchip.com>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH 0/2] dt-bindings: pwm: convert atmel pwm to json-schema
Date:   Mon, 7 Mar 2022 15:03:05 +0200
Message-ID: <20220307130307.106102-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series addresses the conversion of the Atmel PWM DT
binding to the DT Schema format and adds the SAMA7G5 compatible to
the respective converted binding.

Sergiu Moga (2):
  dt-bindings: pwm: convert atmel pwm to json-schema
  dt-bindings: pwm: at91: Add SAMA7G5 compatible strings list

 .../devicetree/bindings/pwm/atmel-pwm.txt     | 35 ----------
 .../devicetree/bindings/pwm/atmel-pwm.yaml    | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 35 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.yaml

-- 
2.25.1

