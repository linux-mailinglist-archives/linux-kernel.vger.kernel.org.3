Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE1C468F39
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhLFCjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:39:43 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:34053 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbhLFCjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:39:42 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 1B62Zi2C027181;
        Mon, 6 Dec 2021 11:35:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 1B62Zi2C027181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1638758147;
        bh=gdf4J4kW/6Nhp/Ib/U/zW8GhsWDyMhh+OVXKeeV5ZGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3hIXzQxf/JWj2Xk8vBPGDauX+0z9kJhJgizIM5AOrQHRdCQn3uY6ZoRlqgahYx9a
         GW0hxvZfcEwVDwcWAGP2ilqsyafdVGtjyGQJsrWEUQiiuJiHGWLL2Q632QF4E9PAaU
         23OyR21nOIZfayu5NeA1V9r8arfBtjO53w/OcuDz3zYZr3MMfMRhc4XUxuoYSHJIBz
         r9PhTAEQg81h8zfdfcZHJQWGPTT+mBocvYcqvE+5TbJ+F2w+5bVae1pU7NLEcBtalR
         dYAXt8r+iA5/yEDSQTK3WelcoHqEt6m97GrkLTkUwbJQED31xYPkVR8z0ChWWZMFzF
         udIX/auRJFgZA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] kbuild: remove headers_check stub
Date:   Mon,  6 Dec 2021 11:35:07 +0900
Message-Id: <20211206023507.447574-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206023507.447574-1-masahiroy@kernel.org>
References: <20211206023507.447574-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 5.15 is out. Remove this stub now.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 Makefile | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Makefile b/Makefile
index 0a6ecc8bb2d2..8d58f65e226b 100644
--- a/Makefile
+++ b/Makefile
@@ -1284,15 +1284,6 @@ headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archscripts
 	$(Q)$(MAKE) $(hdr-inst)=include/uapi
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(SRCARCH)/include/uapi
 
-# Deprecated. It is no-op now.
-PHONY += headers_check
-headers_check:
-	@echo >&2 "=================== WARNING ==================="
-	@echo >&2 "Since Linux 5.5, 'make headers_check' is no-op,"
-	@echo >&2 "and will be removed after Linux 5.15 release."
-	@echo >&2 "Please remove headers_check from your scripts."
-	@echo >&2 "==============================================="
-
 ifdef CONFIG_HEADERS_INSTALL
 prepare: headers
 endif
-- 
2.32.0

