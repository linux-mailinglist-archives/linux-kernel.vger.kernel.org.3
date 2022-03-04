Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9F34CD6BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiCDOsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237160AbiCDOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:48:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6CA74DFB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646405272; x=1677941272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E3j7SQpok6Ea6NdstnR4CWXDU6IjMCFuF1+JSKHNG38=;
  b=mk9BVvdG7Xp1INELktlwtdFRA/UL4e9zDVNKQ+i68mLlimePl2VMUyMO
   h55M8xt5j9yKJzB3t9vIPe1E22s191DAOddZQNgtvakIQ9LZaRsztUn0I
   RXkfOap1OkJeUALsMHhDdVM3cIu84te1pZgzRFVteSiqSGsmQR4mcl5Zy
   Y/HuUP/Nunr4/jBknDZ3/8O6mYLDjBE864+McRiIZOxHW0fP1d0Lllfqh
   BA5bIIavGKVP/Nj7m/cE5820rr8f7fzsigOcOf+4tyYwQAoMqql1fdE05
   AMgf25EVlOG3y9Ad79KjAylCztfx0ceK/0VNuiINzm4/MLTfs/VS5ThAY
   g==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="150870895"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 07:47:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 07:47:51 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 4 Mar 2022 07:47:49 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [GIT PULL] ARM: at91: defconfig for 5.18 #2
Date:   Fri, 4 Mar 2022 15:47:46 +0100
Message-ID: <20220304144746.23779-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

A little more defconfig changes for 5.18. Please pull.

Thanks, best regards,
  Nicolas

The following changes since commit 2884f2dda70ac8659b2e15b8ba8b85fe7184b9f4:

  ARM: configs: at91: sama7: add config for cpufreq (2022-02-25 12:20:43 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-defconfig-5.18-2

for you to fetch changes up to 5f5399843c0ec3bd562dfd533f32e4074ca90314:

  ARM: configs: at91: sama7: Unselect CONFIG_DMATEST (2022-03-04 12:53:15 +0100)

----------------------------------------------------------------
AT91: defconfig #2 for 5.18:

- Add EIC, remove DMATEST to sama7_defconfig

----------------------------------------------------------------
Claudiu Beznea (1):
      ARM: configs: at91: add eic

Tudor Ambarus (1):
      ARM: configs: at91: sama7: Unselect CONFIG_DMATEST

 arch/arm/configs/sama7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Nicolas Ferre
