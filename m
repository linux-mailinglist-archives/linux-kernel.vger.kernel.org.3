Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0703C467C44
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353351AbhLCRNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:13:19 -0500
Received: from smtpcmd0757.aruba.it ([62.149.156.57]:57511 "EHLO
        smtpcmd0757.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353279AbhLCRNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:13:16 -0500
Received: from localhost.localdomain ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id tC4BmfC7aPZf7tC4Bmc2Jd; Fri, 03 Dec 2021 18:09:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638551391; bh=rV+Iq6YRs34M4uLN+wMSbF56XDF/uO6Fjj0F3sE+VJA=;
        h=From:To:Subject:Date:MIME-Version;
        b=L4tyLZh7s21p5Q/h5+ZJ7e78vG5ynlfvsI5LUClV1wz76Rv552wYCRvQwxHZQapYQ
         JXGcN+atwsdIcuM0McQ5TvmQQmghOzRRA/RjS2jvo4GCwP98XD6/Ykb7H+jtiB3LiQ
         6YJEI5KKKeJKXmc5oFLjVMgx00iRQmxftI4pybGl241mgo+iLmq0bLvvGKbNOTqr9+
         Ir1qbj5hk5gdlEyUEi0jP1Nq7cIqvorTmX8GQsHcwa0AWCzotu2LifEnekKx8SHnKQ
         ug7VOE4QqNumQITNXpIBYPp1n+WkQguhEfcNSm0Rdr3g8Lk8ZhODKzkKkcX/djbnRj
         6VkU3CxTwAUqg==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>
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
Subject: [PATCH] ARM: Kconfig: improve ARM_SINGLE_ARMV7M with ARMv8-M too
Date:   Fri,  3 Dec 2021 18:09:47 +0100
Message-Id: <20211203170947.84283-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ea2679ec-9bfd-6a78-a82d-7b160350ddfb@arm.com>
References: <ea2679ec-9bfd-6a78-a82d-7b160350ddfb@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHqV0aa2Svrg7IW6FCFZ71ormE9RLOZvLaBF5Dp3rAKEu0eiKkBb5M7qNABOwJVw3aiZQg/S541J03+MI/IGrR/j39G3uqW8bzB9nK3FYnIL3Y/i947U
 lZppad2ri6xSH57Sh/BCRtNzM13IWTK4dTRrwxwCvs6DhclPWa+ukEizUAA7lzlEciCMBalaaprvlSmpgJQEn44hxl+VEjXlUhOGII+kWrDqLkCmsUAom/qj
 iFlptpbiBCyrpl055GC9+wTJzF5dK9g1epgNZ/RaOvfUIR2avz9fIARb627Fr7EnzKDl8VGtKbD22kXJmZXOeaQ6h+XYhfI6bf9VYfka6gcINLFVaIlmG9OY
 t+X8j/RwzhnSK74T2KFMAZGAPPXzDmTf3lZQNqfWCIXF+7foZGbJ2LvTBEeJDyLo0i8Df/9Mpdi0Pb60bvbxycP8ZiXe4Cn1vyoHxZJg+B1QntFennUwqQpr
 cdhCZUpbEjyZA2x/ARW7c6+IuRX8KxxsGRtcf2UtgjRZOvwLdeD/XJa6iCXq0xh2O7SgQofRyaKIZTw8yJ+jUuNKrXDebf7eZ1nfnSiZmZWuC2WlzdlP93HQ
 toJjUbcIBuECStdIRypY/tf4QN6JDFt3UAOkjzTls0VbHmSGvXuOrosWVLD17BQK17/LU9S3DxHrTjeEpGwAyupVLhqy65bscwU5c1we02YhKCTyD0j1oE+y
 ippPoAEtxTEmB99sM8d9aQSkElHjco3diGrsCD66+XEDKswuBYXq2chMFIaWdKiMD2kw8kJ/NU8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM_SINGLE_ARMV7M implies ARMv7-M and ARMv8-M, so let's remove
"Cortex-M0/M3/M4" mention and add "/v8-M" after ARMv7-M instead.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c2724d986fa0..4a36a80e57b7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -329,7 +329,7 @@ config ARCH_MULTIPLATFORM
 	select USE_OF
 
 config ARM_SINGLE_ARMV7M
-	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
+	bool "ARMv7-M/v8-M based platforms"
 	depends on !MMU
 	select ARM_NVIC
 	select AUTO_ZRELADDR
-- 
2.25.1

