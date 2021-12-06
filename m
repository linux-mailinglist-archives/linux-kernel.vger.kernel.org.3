Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4D7468E79
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhLFBJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:09:54 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:48848 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhLFBJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 20:09:52 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 1B615ljg028855;
        Mon, 6 Dec 2021 10:05:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 1B615ljg028855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1638752748;
        bh=QOyPEuKvb5np0rwpX9TXSpgTv+tj9cVX5wL1TcAKFXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zHHETtrPqX7GQc+mST4sNhRW+PTsbkge83v6HI3OJ8/sXn+MWUo5dnhdV8H+UBEPC
         ffcW7+DGzov52QPAwuibkJojamczIPgi9OZ5/PWf1siIpa36V6UgkIRtqg5shtGK8I
         23HXwXDj4UcdqofO99ncrX33b4ZEY6PSg+SrIMg+dC9xaPlpXhDrMMVht8d0D8wPIC
         g3B5dXoFesM64dTt32gEXRNiDHFobZAGAXtfA6s6CQfSYskxPz8HZHFTPBGhNbX03h
         PnqM01ZOwqzyCJLyqeUJrckRqKqIIY4zcFpcreEd+agsYIZc3iE6bMyTSgiS0ZzQ7j
         B8/Diy/bR1xbw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kbuild: remove headers_check stub
Date:   Mon,  6 Dec 2021 10:05:33 +0900
Message-Id: <20211206010533.439981-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206010533.439981-1-masahiroy@kernel.org>
References: <20211206010533.439981-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux 5.15 is out. Remove this stub now.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

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

