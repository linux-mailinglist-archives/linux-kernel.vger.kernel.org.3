Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4F146768B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380549AbhLCLhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245434AbhLCLhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:37:12 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3938C06175A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 03:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=A7INkRKyeSGoWGaGf1MYn5atjdsKEWuXQlXgfPh4qb4=; b=FdhgMemmwHsiSYJRXbDeagzV9r
        9jM2UmxFiSL3rXgL6PmQlx5BNMmYwi+ONfrG+z8s50culirAYrQCl7Ae7Jc6AwTYXOJ0iuZbpuwW1
        SwIz76uTAbs5jfxmGsjT24GOAmG28c06e5w7FbAduYqjxMN8EXemg6bSLXYd1h2lslgQ=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mt6os-0004Ez-Bf; Fri, 03 Dec 2021 12:33:38 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Cc:     john@phrozen.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/14] ARM: multi_v7_defconfig: Add support for Airoha EN7523 SoC
Date:   Fri,  3 Dec 2021 12:33:22 +0100
Message-Id: <20211203113331.20510-6-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20211203113331.20510-1-nbd@nbd.name>
References: <20211203113331.20510-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

This enables basic bootup support for the Airoha EN7523 SoC.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c951aeed2138..912b3d60325b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -32,6 +32,7 @@ CONFIG_MACH_BERLIN_BG2=y
 CONFIG_MACH_BERLIN_BG2CD=y
 CONFIG_MACH_BERLIN_BG2Q=y
 CONFIG_ARCH_DIGICOLOR=y
+CONFIG_ARCH_AIROHA=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_HISI=y
-- 
2.30.1

