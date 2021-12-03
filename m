Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F1746768C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380550AbhLCLhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380495AbhLCLhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:37:13 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D3CC06175B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 03:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=9PiIRhhbspoxDUE8bG8fxHHdfBdzP4dXsKjVXuyx/Y0=; b=PG0Ha8H2V0KjVnjLFfNr9cwcCZ
        9f41dKvgIM0k/5THYwVkOFaMKHFaCMojqfq8ksL82byZcxat/vnPWgWUPArXJnD+CzTJDmY1Pd+Ye
        yP3sFXWhl1+XmM+PgxeWPnVASAW9+86OCYDYrfULNnACTeVfZerumzcXwgU3lXnL+L0c=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mt6or-0004Ez-NB; Fri, 03 Dec 2021 12:33:37 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Cc:     john@phrozen.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/14] ARM: Add basic support for Airoha EN7523 SoC
Date:   Fri,  3 Dec 2021 12:33:21 +0100
Message-Id: <20211203113331.20510-5-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211203113331.20510-1-nbd@nbd.name>
References: <20211203113331.20510-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

EN7523 is an armv8 based silicon used inside broadband access type devices
such as xPON and xDSL. It shares various silicon blocks with MediaTek
silicon such as the MT7622.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 arch/arm/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f0f9e8bec83a..8dcd05ef31cc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -573,6 +573,18 @@ config ARCH_VIRT
 	select HAVE_ARM_ARCH_TIMER
 	select ARCH_SUPPORTS_BIG_ENDIAN
 
+config ARCH_AIROHA
+	bool "Airoha SoC Support"
+	depends on ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_GIC_V3
+	select ARM_PSCI
+	select HAVE_ARM_ARCH_TIMER
+	select COMMON_CLK
+	help
+	  Support for Airoha EN7523 SoCs
+
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
 # Kconfigs may be included either alphabetically (according to the
-- 
2.30.1

