Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD7457C592
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiGUHyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiGUHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:54:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134F37CB6D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658390081; x=1689926081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UOHHQZrAvuoH0wwF3Sv9euWGBdLrmtfd5KyYatOB2q0=;
  b=dBeW4utQ4Y1S8HPKrhSxf4+XQYJFIFMMVq8m41B4G9qY7WzGQTR6TkCg
   RUsoznUVLjUpNIFh0AARHu5OGZyZoCfofBJ2ffrWEYOePCx6iCzxLYmge
   aJKNtP9RowED0LN1ez8uvpH5umo/ISulccbuIeM2RqvMZfP39Qnzetwhu
   wH+rV6nvbplDyCWrOpSZT91FV+RsZ88/6EEV4inCw2wV+K1C3dgMofA3F
   ndEyPtpuxF+6T2PZSO3IV492e4qv+iSo8uj4OkWeQRFWCBi2VPRN8Sh7n
   Sp8U440BXTIZhq+x7RVBe0wlG4+fHp6K0N9SdnFdyZqRCpireu50tgmvS
   g==;
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="105475920"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jul 2022 00:54:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Jul 2022 00:54:40 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 21 Jul 2022 00:54:38 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <arnd@arndb.de>, <olof@lixom.net>, <arm@kernel.org>,
        <soc@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] AT91 fixes for 5.19 #3
Date:   Thu, 21 Jul 2022 10:57:05 +0300
Message-ID: <20220721075705.1739915-1-claudiu.beznea@microchip.com>
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

The following changes since commit 2fdf15b50a46e366740df4cccbe2343269b4ff55:

  ARM: dts: at91: sama5d2: Fix typo in i2s1 node (2022-07-08 17:44:33 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-fixes-5.19-3

for you to fetch changes up to ef0324b6415db6742bd632dc0dfbb8fbc111473b:

  ARM: dts: lan966x: fix sys_clk frequency (2022-07-18 09:31:22 +0300)

----------------------------------------------------------------
AT91 fixes for 5.19 #3

It contains one fix for LAN966 based SoCs fixing the frequency of
sys_clk. sys_clk is feeding different IPs so having proper frequency
for it in DT is necessary for proper working of different drivers.

----------------------------------------------------------------
Michael Walle (1):
      ARM: dts: lan966x: fix sys_clk frequency

 arch/arm/boot/dts/lan966x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
