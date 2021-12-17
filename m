Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989274791A1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbhLQQlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:41:46 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:6334 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239188AbhLQQlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:41:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639759305; x=1671295305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D2h8E/Ug1gRKBcu/bGtG10Pcx4s2TUetykAr0Pgo++w=;
  b=o+twgqqDGY63bT08hOC5DCyA3m+DrubzE9ieaJw8mG+P+eiQeY/iu5c/
   iNHULNKatzIo03V9XdJV3vycz83xgW4J+PHdFOyBC62+Ey+rces49uQm4
   lEzNAITfnf/zGL/GqhpLER01/XibTOAr6Vld/Wl27S237gT6UavotDrU9
   eYG8CT5qymWcfuyZMCtFfVvCOHItEe2lVgU3uSOps2fw98qzTkscBKQ0Q
   NtOj3mlCD09u/7adp3JStfnJvu/HSEPYAbOnu3vT450jTgz8Q7kzBb7kH
   TESYEcFhU351qgQF/z5Dg+Ngem+UXa03xaY2C05O2ITRzEOPTQUEa4Ppn
   Q==;
IronPort-SDR: cIn372YCiFTEjINntpTiI0AT9FNkrHZPoaswS1n8+XBkH7Ck3X9/W39bkHU2gNOsNaAKWpgOIb
 HPqWk7tZeAfohlmI2tTV56pL4uIG8cISgKykBaFT7zFz2ExQn7t5MS5vpLiFSXkMi5ERWTudv8
 YMgt6aveBkG6BI5xAC1cElQXgaG2Ldb7J+UmaOHalCcbHyF1GFgVP5O/3zLYZ1IgDh+kZKFZMf
 n3kbHfdsWPhEK/cKukYIXqk+GCC6tFmOO5bpu14DDrPcNcu8/AnZ7hP/m5lNJTFRBIgal1Ua3q
 JdCo2vwct0gWTx0uW7sD22by
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="155902638"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Dec 2021 09:41:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 09:41:44 -0700
Received: from ness.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Dec 2021 09:41:42 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [GIT PULL] ARM: at91: soc for 5.17
Date:   Fri, 17 Dec 2021 17:41:34 +0100
Message-ID: <20211217164134.28566-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here is one soc change for 5.17.

Thanks, best regards,
  Nicolas

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-soc-5.17

for you to fetch changes up to bb29e4091079dd7ef5bd488bd7625965cdfd2c12:

  ARM: at91: pm: Add of_node_put() before goto (2021-12-08 14:01:16 +0100)

----------------------------------------------------------------
AT91 SoC #1 for 5.17:

- one low priority fix about of_node_put() missing in PM code

----------------------------------------------------------------
Wan Jiabing (1):
      ARM: at91: pm: Add of_node_put() before goto

 arch/arm/mach-at91/pm.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
Nicolas Ferre
