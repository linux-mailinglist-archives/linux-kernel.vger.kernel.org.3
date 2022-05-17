Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EEC52A710
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350258AbiEQPji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiEQPjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:39:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B10227
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652801974; x=1684337974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vjEkaJTkjDDJBA3jZlCF4IOQPC13hVXrVqeqKghrK44=;
  b=ZnLrhydA9V3mKwa+bMjBJ5iEzYi6vaDi76t+XMO6DuZuIJszyLCwdxQ1
   yGkWoJlBDOlqzNU+mW+Ran7N0wfeaxaCBnSkiDxuSWtKWZQvwIO/84RMK
   xXuSOyOto+BwOH/yqEHAOPRAdWmzEk3daxLJgePRandz7SXM138yF6SOr
   qXykrljHQbVA2eeU80Bm76unwjEHIps2Q04H54vguTKAJja6X08f/AjHM
   GEUs0w9rcmK739xfqFXgbXHuYqlATeK7MRO5H7iC5ZQSkrSYA9Wwy5H1T
   3WHDJwEVSeV6adh0zNIU7mXifWYFQHk24VRystFwbSMrJR7x3xD7yfgbZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="156418168"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2022 08:37:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 17 May 2022 08:37:56 -0700
Received: from ROU-LT-M43238L.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 17 May 2022 08:37:54 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [GIT PULL] ARM: at91: dt for 5.19 #2
Date:   Tue, 17 May 2022 17:32:52 +0200
Message-ID: <20220517153252.92393-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here is the (late) second batch of dt changes for 5.19. It's not crucial code,
so you can just postopone its inclusion without any problem.

Thanks, best regards,
  Nicolas

The following changes since commit 46a9556d977e290a18890fb4cf07d19b0da16f31:

  ARM: dts: kswitch-d10: enable networking (2022-05-13 16:42:43 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-dt-5.19-2

for you to fetch changes up to 821cb05f6b4b024847624de0d0e5765c7b09b947:

  ARM: dts: at91: sama7g5ek: add node for PDMC0 (2022-05-17 17:14:42 +0200)

----------------------------------------------------------------
AT91 DT #2 for 5.19:

- at91: more DT compliance updates for RTC and RTT nodes
- at91: sama7g5: add microphone support

----------------------------------------------------------------
Codrin Ciubotariu (2):
      ARM: dts: at91: sama7g5: add nodes for PDMC
      ARM: dts: at91: sama7g5ek: add node for PDMC0

Sergiu Moga (2):
      ARM: dts: at91: Add the required 'atmel, rtt-rtc-time-reg' property
      ARM: dts: at91: Use the generic "rtc" node name for the rtt IPs

 arch/arm/boot/dts/at91-sama7g5ek.dts | 21 ++++++++++++++++++++-
 arch/arm/boot/dts/at91sam9261ek.dts  |  4 ++++
 arch/arm/boot/dts/at91sam9263ek.dts  |  4 ++++
 arch/arm/boot/dts/at91sam9rlek.dts   |  4 ++++
 arch/arm/boot/dts/sam9x60.dtsi       |  2 +-
 arch/arm/boot/dts/sama7g5.dtsi       | 26 +++++++++++++++++++++++++-
 6 files changed, 58 insertions(+), 3 deletions(-)

-- 
Nicolas Ferre
