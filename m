Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1684B4C43B0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 12:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbiBYLdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 06:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbiBYLc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 06:32:59 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F5215D3BC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 03:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645788748; x=1677324748;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5UwFmzbyIUta6CR16913XuPjSW+SetjjS6+IwteKVXY=;
  b=fKq+uIMbuiKqaVLoFy/fwkahIv2iC86wUxNj+9VYr1wclfxL8YmKwuxp
   +zRzA7DjErvkuUs/LOQBGaZcK3ZlcJO343XJjcPJ7cMMjw0YMtvh+fYf4
   fiCsjr1FXjllXU1g+bWRztQb4ISYjxy3klUxm2JZLh5fwcSQugSv3Gn5e
   6t2DcaCQGq5WHgyBkU3qh8s/3V8R342+sbcwWwUeHzVaEC/lCqMUL6BFG
   vbFSYLHLdlYBPXMzIhPbHykwY4BoKA86l+IdKWhzgrwIPFfd04/JDkEwL
   9TwHakQOBvpAO/iJIlO1dnYm3SiO4XEQ3C5ji4fifE5crJuufA1XsKmPy
   A==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="147275429"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 04:32:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 04:32:26 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 04:32:24 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [GIT PULL] ARM: at91: defconfig for 5.18
Date:   Fri, 25 Feb 2022 12:32:20 +0100
Message-ID: <20220225113220.51401-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are the defconfig changes for 5.18. Please pull.

Thanks, best regards,
  Nicolas

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-defconfig-5.18

for you to fetch changes up to 2884f2dda70ac8659b2e15b8ba8b85fe7184b9f4:

  ARM: configs: at91: sama7: add config for cpufreq (2022-02-25 12:20:43 +0100)

----------------------------------------------------------------
AT91 defconfig #1 for 5.18:

- sama7 additions for NAND flash, crypto, cpuidle and cpufreq

----------------------------------------------------------------
Claudiu Beznea (2):
      ARM: configs: at91: sama7: enable cpu idle
      ARM: configs: at91: sama7: add config for cpufreq

Tudor Ambarus (3):
      ARM: configs: at91: sama7: Enable NAND / SMC
      ARM: configs: at91: sama7: Enable UBIFS_FS
      ARM: configs: at91: sama7: Enable crypto IPs and software algs

 arch/arm/configs/sama7_defconfig | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

-- 
Nicolas Ferre
