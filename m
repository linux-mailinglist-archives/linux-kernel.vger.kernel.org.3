Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B52B57A809
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239488AbiGSUIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbiGSUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:08:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEAB2E9E9;
        Tue, 19 Jul 2022 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658261312; x=1689797312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H4Em/iwwd25hKva9PCNGk5oU/inwRkCYwVBNUE0lh9A=;
  b=uy3pG49f6vt7iHq5PUNIVD0LgEt+LhbyC1+B37S74OsaeAVy1AJi47dc
   681dKygv6Gt3Mv9un5e6ST5i4UVOhq3LRORLKoPJxA91PKQK4Dl0kabg1
   zfcmprJ79xaDNHRZlxzb03oatHNpdt5betfKO5jYqjUIvwML4Wi8Xiq/T
   OAOyuK+8FDKcYvIIbgl3v1+aJhZg8X5uXbO4IvRfXv8X9/Z8iVcSJLB4r
   c4zxVQ6Q26mF2uV+CJ3E9rYcOf9IC137QbIu9zzD4YZqr5pMqNDwaZYK+
   yyUcFOV36MnL27m5ZgMcUJjKIHRLD9zshl/OYwZBaBvyM5P1mCCEVBl3f
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="165488397"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 13:08:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 13:08:29 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 19 Jul 2022 13:08:27 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH v2 0/3] ARM: dts: lan966x: Extend pcb8291
Date:   Tue, 19 Jul 2022 22:11:55 +0200
Message-ID: <20220719201158.1696168-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend pcb8291 with different features like, add support to reset the board
using GPIO and add network support.

v1->v2:
- instead of removing the can0 node, just disable and add a comment
- reorder the nodes to be alphabetical

Horatiu Vultur (3):
  ARM: dts: lan966x: Add gpio-restart
  ARM: dts: lan966x: Disable can0 on pcb8291
  ARM: dts: lan966x: Enable network driver on pcb8291

 arch/arm/boot/dts/lan966x-pcb8291.dts | 43 ++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

-- 
2.33.0

