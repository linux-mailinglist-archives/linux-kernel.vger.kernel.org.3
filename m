Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FE0466C21
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349184AbhLBWad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:30:33 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:57349 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239809AbhLBWac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:30:32 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Dec 2021 17:30:32 EST
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id suQtmgDlmrmmOsuQtmPeqn; Thu, 02 Dec 2021 23:20:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638483607; bh=btz8KvWc462TUUvIHUh3hD+1jh6D/75biJI96lLyExE=;
        h=From:To:Subject:Date:MIME-Version;
        b=Fd6GnWmCh/coGPsuxcQb3W2yUx0Aqtz+v1G+Ih8T2yi5p+hh0N3e+Qh5QO3EL6EQ5
         f3fW9cEK/sOsUiRuiTZHDwx5C3Z2phLMUK30YX6FCtNGI0NE0XyOiT+Kg8dXh7ccKv
         SeTdTuQWWKzjDThvRE6hTv3gmq8F6SfYNbuI8wLWy/7TKXfAsFk8RDUqT29rEJNAq7
         mwpryyyxTL6PcBZ7GMoyN4AO75VTsriz3IslqJ5ntFdUIA4tbfV5sO5ekQOxyE69xk
         iPtuzAVnMgNgN2Hbs8mzBFTZLlJt/WQsk/oNO3yJa+ulhlQV/rl0jnvtq2yM7c3w9K
         ra6vuYuAHFFfw==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH] ARM: Kconfig: improve ARM_SINGLE_ARMV7M description with Cortex M7
Date:   Thu,  2 Dec 2021 23:20:02 +0100
Message-Id: <20211202222002.33456-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfPvpKufhRjf4A4stLdDIsI6d31RNhGlHnJhYrO886IQFEoHokJzqSfGe3muwrQOm+DEmZ5B5aPP00Vzz1qLF58ghK9T5+tsCvGbcALDtqMcqoAI2HuE5
 hi12wSFUHnACEj1PXOC7DSxXZd2tvm1QQ1ClYZSQ8oyTJ3Y6qJ77BIwdfTawAuFHTFZgBJNcXlGTW3Q4sh/C+PVzmupJYsaFyA5Ec5PztVkhPUD39plvgPe6
 BnfV398sjjzT0rHTephIbIBJANhNVyxedSsAPAqCCW0OLkyUHpBWYgU2Qna/IBR0TRbbdX5tiSJlmRwTJ6/kwPims1cs39clNu//aGKqELKGrVk2thPMPT/y
 x7nGjSgckSxJ/YjeURyDoSF4wCBtmGxiq/1XGaLFrPty53ynBVMCOlnKvZflguzOrWyLFh0UO05Q57s/8OEi8RQg5mI9mv2bw78gH40l0E7zluqracpenhPS
 r5Z9PIPpHxa+4o5YLPvC3t5JLuEZYlb3LLjPFhnnuYK04ZP91GXnyYUdlxXizK+KT0c9CssXCISprBFwBVmjfiGvaJBze8y7nb3UR8EeYLOAWzgojYncP4gu
 E6vqLcNo1Knj4CI2H9PUVMnMu4wEMaEnkNV39PZcisGS8MN6NhKCCAKvFNJZ3y6+KIJ2X7BCj8ufhJAGpfhyOsuuWNyYoPghHtkfZ1ENwhwoiJMQFJzw9lsl
 xisAR/iesP/nQ1Qxcp4c7pOUVZqTZkiu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM_SINGLE_ARMV7M implies Arm Cortex M7 too, so let's add it to
description with M0/M3/M4.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c2724d986fa0..67efbde70e34 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -329,7 +329,7 @@ config ARCH_MULTIPLATFORM
 	select USE_OF
 
 config ARM_SINGLE_ARMV7M
-	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
+	bool "ARMv7-M based platforms (Cortex-M0/M3/M4/M7)"
 	depends on !MMU
 	select ARM_NVIC
 	select AUTO_ZRELADDR
-- 
2.25.1

