Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E64479226
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbhLQQ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:59:03 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:32063 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbhLQQ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639760342; x=1671296342;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XjAbaeCyYnGkhfNDEqSOCJEj/QZGtp6vPVcYYe4dPY4=;
  b=A3MboVte3pg8zts/VXRpjGB3q4S0SdDCjKvgpOMbHTnf/6/nkSs9VvY+
   2prRqGfRwH2gz0n3Wx22Juk4ol7eS4SwP4Imsvq+S5NGDhPW4PohYsgQZ
   qKdD8tf0QM2FG0cRwCrz/KVNSinoRI244uo9xi9wiKBW3/6sionN6wH9/
   zY3B4ON/abIt0qTS+bez/f/V0PhIMd6064QtrkYVAceQl2u6AqoF4lne3
   v7452Jyz+OzyrHUACJfi6fe/XfcwA/di4qOulyeAaqg04rXg030JYJIuz
   jnkXdtFTqjy3Ap4lSsq7ZBVRrAsl0o11QLtAvvDWLbRN+tLxhtC7YXGZ5
   Q==;
IronPort-SDR: xzuxQW5TBDcMlRuhOKooiRHEV0AciTsO1IyHvD476Ue4XHCX0rGX1UnULDJVXOxu3aQ5aFA57m
 CdToHFtFQRY7onhEf3FJOGf4eANgaXPgL3hhy00vTV93AY/EKZYJVv4WPBb63eKEDP37tBg/Sc
 7mCZEp0mNmr7vUtdHoJCGpk7diawWukh0zy0HcVOpH1KT/lZSLDU80eBjC05cW//7CmIZn4H1m
 Fn7RLAVCUbZmPjZ0U0JZXNnjq2FFWuZgjbHws95zN6FMPpv2410wxfNoQDt8SRhhmmYdQS4Nh9
 JEYhfFwWaSgXOgdlvWYwODQz
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="147046955"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Dec 2021 09:59:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 09:59:01 -0700
Received: from ness.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Dec 2021 09:58:59 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [GIT PULL] ARM: at91: defconfig for 5.17
Date:   Fri, 17 Dec 2021 17:58:50 +0100
Message-ID: <20211217165850.29694-1-nicolas.ferre@microchip.com>
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

Here are the defconfig changes for 5.17. Please pull.

Thanks, best regards,
  Nicolas

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-defconfig-5.17

for you to fetch changes up to e1137bcefa025ec4c583e85d6c86c9ba11133224:

  ARM: configs: at91: Enable crypto software implementations (2021-12-17 17:51:36 +0100)

----------------------------------------------------------------
AT91 defconfig #1 for 5.17:

- Sama7: addition of QSPI SPI-NOR and the QSPI controller for this
  product
- Addition of the crypto algorithms that are fallbacks for HW engines

----------------------------------------------------------------
Tudor Ambarus (2):
      ARM: configs: at91: sama7: Enable SPI NOR and QSPI controller
      ARM: configs: at91: Enable crypto software implementations

 arch/arm/configs/at91_dt_defconfig | 9 ++++++++-
 arch/arm/configs/sama5_defconfig   | 8 ++++++++
 arch/arm/configs/sama7_defconfig   | 5 +++--
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
Nicolas Ferre
