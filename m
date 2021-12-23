Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B8D47E0EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347502AbhLWJk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:40:59 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33476 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347485AbhLWJk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:40:58 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BN9elLJ018543;
        Thu, 23 Dec 2021 03:40:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1640252447;
        bh=k2J4pHrADTRM46UX00geaOvMmN7yPdJDltRf2UYr9rQ=;
        h=From:To:CC:Subject:Date;
        b=dWJW6ABiZSPlOrFnm4W7Yk+mdrrhrodrVDqQTuEiZzMwCVfRXv9SjgXwVZPXLRaDJ
         ujoFvsY5AUtqEWfEo2mvA133T9aRTdG5sFMvpB1zhX224fbLvfVqFhOF3/ISpYGp9V
         o3bebRWso45K/9eisbfGoD4TyuaxSiYagesMMGl0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BN9elRD004039
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Dec 2021 03:40:47 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Dec 2021 03:40:47 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Dec 2021 03:40:47 -0600
Received: from uda0132425.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BN9eiJD088529;
        Thu, 23 Dec 2021 03:40:44 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC <soc@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <kristo@kernel.org>,
        <arm@kernel.org>
Subject: [GIT PULL v2 1/2] arm64: TI K3 SoC configs changes for v5.17
Date:   Thu, 23 Dec 2021 15:10:39 +0530
Message-ID: <20211223094040.15349-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ARM SoC maintainers,

Reroll of defconfig changes for TI K3 SoCs due for v5.17. Addressed
Arnd's comments on v1 by dropping commit touching CONFIG_SERIAL_8250_NR_UARTS
and removing PCIe related configs which cannot be built as modules.

v1: https://lore.kernel.org/linux-arm-kernel/20211217172806.10023-1-vigneshr@ti.com/

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-config-for-v5.17-v2

for you to fetch changes up to 414174b6bb6569c07d8557c4475e43b1e18b4fea:

  arm64: defconfig: Enable USB controller drivers for TI K3 SoC (2021-12-22 13:13:26 +0530)

----------------------------------------------------------------
ARM64 defconfig changes for TI K3 platforms for v5.17 merge window:

- Enable drivers for USB and SERDES IPs on TI K3 SoC

----------------------------------------------------------------
Vignesh Raghavendra (1):
      arm64: defconfig: Enable USB controller drivers for TI K3 SoC

 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)
