Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAC4474BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237346AbhLNTOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:14:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42180 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhLNTOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:14:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD3A2616C1;
        Tue, 14 Dec 2021 19:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84990C34604;
        Tue, 14 Dec 2021 19:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639509275;
        bh=lPacvQh2Gvb/22KWNJS7gFse+ojcEIZ+JHI8apcy0Ao=;
        h=Date:From:To:Cc:Subject:From;
        b=tP2Yw9i7oiYLPRoDIE4Btlg2YWhtIDvUFRAcXSE6lQuCie6g7x21O5ycI/TFm0QJO
         ///uWl6t7LZc08wNEZMCIxB4zQjcRViQJCwMr3WPUf47d8x0sX8T48tO+h/Akard3V
         QOjAAIjMxDlw4E/Ch5l2mIf1SlvFSbXbW0t32ahJh2n36ZfKvEch7c1cpvL8RM5Gc2
         /kvOvED8CRln15aZDATuQ7KkElmSJT18LN+k1r5kU4LdmJJUAN24qTm+UYErGWMwp7
         vOPaKy4vmAEo2tT9ZlyJImG5MQESD/Oo5k0IhASqpJy+KTJJzffdXmKMwQoytJ6H5C
         +AjFH/oB3sz1w==
Date:   Tue, 14 Dec 2021 20:14:15 +0100
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jiri Kosina <jikos@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Remove mentions of the Trivial Patch Monkey
Message-ID: <20211214191415.GA19070@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, it was decided that trivial@kernel.org
is no longer used.

Link: https://lore.kernel.org/lkml/fe86efbd-4e03-76c8-55cf-dabd33e85823@infradead.org/
Co-developed-by: Joe Perches <joe@perches.com>
Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Sending this before we forget about it...

We may want to keep the definition of "trivial patch" somewhere else.

 Documentation/process/submitting-patches.rst | 19 -------------------
 MAINTAINERS                                  |  6 ------
 2 files changed, 25 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 6b3aaed66fba..31ea120ce531 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -271,25 +271,6 @@ least a notification of the change, so that some information makes its way
 into the manual pages.  User-space API changes should also be copied to
 linux-api@vger.kernel.org.
 
-For small patches you may want to CC the Trivial Patch Monkey
-trivial@kernel.org which collects "trivial" patches. Have a look
-into the MAINTAINERS file for its current manager.
-
-Trivial patches must qualify for one of the following rules:
-
-- Spelling fixes in documentation
-- Spelling fixes for errors which could break :manpage:`grep(1)`
-- Warning fixes (cluttering with useless warnings is bad)
-- Compilation fixes (only if they are actually correct)
-- Runtime fixes (only if they actually fix things)
-- Removing use of deprecated functions/macros
-- Contact detail and documentation fixes
-- Non-portable code replaced by portable code (even in arch-specific,
-  since people copy, as long as it's trivial)
-- Any fix by the author/maintainer of the file (ie. patch monkey
-  in re-transmission mode)
-
-
 
 No MIME, no links, no compression, no attachments.  Just plain text
 -------------------------------------------------------------------
diff --git a/MAINTAINERS b/MAINTAINERS
index 13f9a84a617e..c88bac733e9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19334,12 +19334,6 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
-TRIVIAL PATCHES
-M:	Jiri Kosina <trivial@kernel.org>
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git
-K:	^Subject:.*(?i)trivial
-
 TTY LAYER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>
-- 
2.34.0

