Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10474578CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiGRV0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiGRV0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:26:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F972AE1D;
        Mon, 18 Jul 2022 14:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658179568; x=1689715568;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=980PssNBkKl6pJGSdycVps/zbWeYrW5Q24GPyZNMFtw=;
  b=gEwEy7jaNHkiB52QS2QnRFSuRzrm4FVA177I0R6Hf0NFuKJS/flAasNo
   9+Me766uL1k/gfJhwWebHZdm4jRU5GfVwCC4GOoe3E3EoZeS+QzuOKuB7
   1tsQsxr1mFErqKTthjIVLgtkLyfU+BQt7l7ba/y3ijt3q2LMFg+JBzk91
   jNSKN1TfXkOORUSVaqXM3r6MKiphA/eVWOxmVw89/fh9eujnTpAcABVVt
   T2MdEumEfKW5FMaUJ8OAP192Y9B7XyGYafPK15baERgW1JGpNzVOfV2SJ
   nY2xRUbiUmm+fYdlOKGnrI3GT878JyO8CgMIQZucyZqbWha9GwNwP1HE5
   g==;
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="182715239"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jul 2022 14:26:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 18 Jul 2022 14:26:07 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 18 Jul 2022 14:26:05 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH 0/3] ARM: dts: lan966x: Extend pcb8291.
Date:   Mon, 18 Jul 2022 23:29:18 +0200
Message-ID: <20220718212921.1506984-1-horatiu.vultur@microchip.com>
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

Horatiu Vultur (3):
  ARM: dts: lan966x: Add gpio-restart
  ARM: dts: lan966x: Disable can0 on pcb8291
  ARM: dts: lan966x: Enable network driver on pcb8291

 arch/arm/boot/dts/lan966x-pcb8291.dts | 45 ++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 8 deletions(-)

-- 
2.33.0

