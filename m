Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A68471F64
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 03:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhLMClb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 21:41:31 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:20865 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhLMCla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:41:30 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 1BD2eoHb020453;
        Mon, 13 Dec 2021 11:40:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 1BD2eoHb020453
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639363251;
        bh=BGvWo/oPAxYlFoDIQbSSfIDTMxZajeGi986Rtte0N/o=;
        h=From:To:Cc:Subject:Date:From;
        b=F7hLtCPVvITSMSy+wekJ40CgApnDdza1bh4nbGWl1dNVyalT1slEsmWjODX0PMBpi
         +HRloHD5AJVRsgr/IBHC7eYPfW3j2R+BwZnl4RzePy27mjdbQyGj7zZLBux/tyEj8V
         /oVlcTRhxWnC0m87/ART2Q24UTXlR8NO9IExD1lZ/WRUrScAbyLJZuwJBCdSHTmf2A
         CzrXRk6WLmQtHCgfrtYVLqEocQ/+AKvlMs2U3Fzt8b8CVYe//a8r5LI5CwNDweEZWZ
         FM9zfiBd63aua9jDyQUToofEaqH4TrnFOY5x1ut9jmBmYwSA2GQdsfIKOdVkt8clmw
         o9noO0kVj/SzA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-parisc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH] parisc: remove ARCH_DEFCONFIG
Date:   Mon, 13 Dec 2021 11:40:44 +0900
Message-Id: <20211213024044.1165969-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2a86f6612164 ("kbuild: use KBUILD_DEFCONFIG as the fallback for
DEFCONFIG_LIST") removed ARCH_DEFCONFIG because it does not make much
sense.

In the same development cycle, Commit ededa081ed20 ("parisc: Fix
defconfig selection") added ARCH_DEFCONFIG for parisc.

Please use KBUILD_DEFCONFIG in arch/*/Makefile for defconfig selection.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index b2188da09c73..011dc32fdb4d 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -85,11 +85,6 @@ config MMU
 config STACK_GROWSUP
 	def_bool y
 
-config ARCH_DEFCONFIG
-	string
-	default "arch/parisc/configs/generic-32bit_defconfig" if !64BIT
-	default "arch/parisc/configs/generic-64bit_defconfig" if 64BIT
-
 config GENERIC_LOCKBREAK
 	bool
 	default y
-- 
2.32.0

