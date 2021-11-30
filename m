Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B12463DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245519AbhK3SrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhK3Sqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:46:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD1DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 10:43:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0A498CE1AEF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF119C53FCC;
        Tue, 30 Nov 2021 18:43:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KWaYShPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638297808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=n5Q+5Vl7cCP5ENHyhupMWmu3T68HhvIIdI4C4OHDNrU=;
        b=KWaYShPSLF9V6QWiMeMSOnoZxdmKV4yVe7JRZecx2dfMxEPP71bJ/bRpe186BIiAkqXa5M
        YVlzJxXCoXkikMniFaCztAq4D2oOaOWHXvSeGMfwfwnXcb9ascL8f12/zYsjOGQ6zb2na3
        Dm9IBbZk85A4r4F8n5ajnS6OR394b/g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a4e184de (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 30 Nov 2021 18:43:28 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] MAINTAINERS: co-maintain random.c
Date:   Tue, 30 Nov 2021 13:43:15 -0500
Message-Id: <20211130184315.258150-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

random.c is a bit understaffed, and folks want more prompt reviews. I've
got the crypto background and the interest to do these reviews, and have
authored parts of the file already.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 360e9aa0205d..913856599623 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15979,6 +15979,7 @@ F:	arch/mips/generic/board-ranchu.c
 
 RANDOM NUMBER DRIVER
 M:	"Theodore Ts'o" <tytso@mit.edu>
+M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
 F:	drivers/char/random.c
 
-- 
2.34.1

