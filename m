Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC9483A60
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbiADCAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiADCAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5906C061792;
        Mon,  3 Jan 2022 18:00:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id k18so36320295wrg.11;
        Mon, 03 Jan 2022 18:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RvN39auXSxEz3WOh3mbUKrKWbJFq9xjM+ARLeHF7XJA=;
        b=E+iRebTNc1QINxn+tRVV/ejzbCWTHUHCfCHElzh3GPhWgZkETrYle1m1wAOreOL0kz
         4TkUvp2cUQde9Sbt+01uBROw8cA/OmJg8g8a+QPGWeN21EH9P6FDdKMZBRWmpPfYlOtX
         6HKZAhKtLhEd7z95qwuQ4wcOnGMdIWDg64oZxCcVVX/VUxDqWhnWfjAxotSO/bLSnlXB
         6grn/YXQYYfq9bqUXGKteMyliEfmlu2KmQzAivuM1OP12TiA+n6/qb+wjZVb0iMP+vqH
         1YJ4H+6sQxToXVGQWJYHhz2xJb5FlcDSNgBUdPBrp1bv/iYTPDC4c+PXbL7orvO5q/b8
         LNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RvN39auXSxEz3WOh3mbUKrKWbJFq9xjM+ARLeHF7XJA=;
        b=FdiuIbqFLrUJ9xu96Q0RmynT4hpqDbTeqR8hwkfFwRHPRSF9jXHb17p9g8mW/UUlnZ
         Kw+PB3M2VplSiTyUGY+awYcSWDN7O8KM3qRoClrSIPJl5SvyMgC+VIGVmQBY9bXJmuqi
         0l1rHx/gBhtFrmdTrPbyJ3uRwU2ZbooCsOgeOTS7vC4y1eGtlF23bM9a3dk5/r5ROxEH
         Qrp2GcsvkjMhiOzmsgnI5l6oVWORAgDiSyFJis6lOionhUUkg22X4qpfVx4ovpnipUxC
         D+dAuXf3LqjA5GMfqVtkpL5Zx/bjrl/479trGFFys+Fppx56b93k0vb5prEAhhzRqNON
         zVnA==
X-Gm-Message-State: AOAM531s+J+jYx4liRbcVxCFYQHttwcBb7TvwoFSXXZ+3leNkHIhQqj+
        t1iLGa9rY0tNaTluhyJlAXM=
X-Google-Smtp-Source: ABdhPJy7DPvmR/NAUTDj/nYos5SkHQi8UK50RjJ6eh3Z1zOiJCUhBD8fuIlE5x2qyAxsP2Bmx369tw==
X-Received: by 2002:adf:e74c:: with SMTP id c12mr40695181wrn.200.1641261606380;
        Mon, 03 Jan 2022 18:00:06 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:06 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/15] scripts: kernel-doc: Translate the "Output selection modifiers" subsection of OPTIONS
Date:   Tue,  4 Jan 2022 02:59:39 +0100
Message-Id: <20220104015946.529524-9-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A subsection "reStructuredText only" is added for -enable-lineno.

Other notes:
- paragraphing correction

* Transform documentation into POD (8/15)
See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 629ba514db5d..c46d4b9afef2 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -83,14 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Output selection modifiers:
-  -no-doc-sections	Do not output DOC: sections.
-  -enable-lineno        Enable output of #define LINENO lines. Only works with
-                        reStructuredText format.
-  -export-file FILE     Specify an additional FILE in which to look for
-                        EXPORT_SYMBOL() and EXPORT_SYMBOL_GPL(). To be used with
-                        -export or -internal. May be specified multiple times.
-
 Other parameters:
   -v			Verbose output, more warnings and other information.
   -h			Print this help.
@@ -2607,4 +2599,33 @@ May be specified multiple times.
 
 =back
 
+=head2 Output selection modifiers:
+
+=over 8
+
+=item -no-doc-sections
+
+Do not output DOC: sections.
+
+=item -export-file FILE
+
+Specify an additional FILE in which to look for EXPORT_SYMBOL() and
+EXPORT_SYMBOL_GPL().
+
+To be used with -export or -internal.
+
+May be specified multiple times.
+
+=back
+
+=head3 reStructuredText only
+
+=over 8
+
+=item -enable-lineno
+
+Enable output of #define LINENO lines.
+
+=back
+
 =cut
-- 
2.30.2

