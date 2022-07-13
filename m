Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EDD572EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiGMHDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiGMHDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:03:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7ACF597
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657695818; x=1689231818;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9qt8csHkgYNrS5Oi1qBJfWGmXxYwaOhVFbXfJFXRZm8=;
  b=uOQKJg+MXSJVGPLIivAyRZe4hekTnXKnyMP4pgDoasEkJiKxr7tvUXU+
   bR+/bzsTZx0rveeEs9+a8DUyLc6SkaVFUudI1eAxRQNWDANrIPwKMLEYn
   nx0WVDe+43KlaJiub0OkGEjxrL5jtrrLdtvoG+E3WN1f5kOh+W9UbQ2qw
   p0tYhD/UtuqWtBjB1MKAN/i4TWdzuoo65lZms8FhxvowHEijs8t+DfzGc
   AHm8bDE2bzAWliF4ITlLoaPLJb2NlvIN9GIerdSSvpPDBLi11D9pQtneX
   zWZImwPuqabgsWt2Dayjo5VGI1+Gh+4hZlMrRKPhrHfvTXOg5rKY25u2J
   A==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="104226152"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 00:03:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 00:03:37 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 13 Jul 2022 00:03:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <arnd@arndb.de>, <olof@lixom.net>, <arm@kernel.org>,
        <soc@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] AT91 device tree updates for v5.20 #2
Date:   Wed, 13 Jul 2022 10:06:02 +0300
Message-ID: <20220713070602.1652118-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The following changes since commit 4dd1a613e464e9036d5163fc8ec5f7dc6e394b53:

  ARM: dts: lan966x: Add UDPHS support (2022-07-05 10:42:18 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-dt-5.20-2

for you to fetch changes up to be16285265868aa371378132fe37df2bc14ceb78:

  ARM: dts: kswitch-d10: enable the USB device port (2022-07-12 10:12:30 +0300)

----------------------------------------------------------------
AT91 DT for v5.20 #2

It contains only the enablement of USB device port.

----------------------------------------------------------------
Michael Walle (1):
      ARM: dts: kswitch-d10: enable the USB device port

 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)
