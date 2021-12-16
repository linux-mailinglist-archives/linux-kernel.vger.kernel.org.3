Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96E6477F84
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbhLPVpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242246AbhLPVoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:44:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F6DC061B38
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 13:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cw4xTspNzk37jZto/nd6zWgK67TtjV1uKtv91TG1+gg=; b=qQ9mC0ZF2w3cc3B2vjjeCGT3cC
        CdBjjxhZaIGd/sajCsQRMu8ordDXZB8xfv43n1pyyL1FOfJP/le2wy5UtYDDuGo/+TsJCvQrLUnJ5
        OEiPO5cots/k3x6XcFXrVi+AAlhjD1JWbxHR5cCxQvGc5g3/jcsuQORu+nfeXiEl5LRkZqyJieKdQ
        q+IVXabNKzZiDx2SwLXu8ovD9nmOfU5+v0ogxQ8N+lEB+mhvxLOiYk/upPE/DDsUBZ4UJLbMMWPlF
        KdUAc4/ZhvorBEKBHyA00/DevpCHTE/h/tE0fQBAyhMzhrdOzgvdGSJtqcfGL4TOaSrBlDn1I8PPi
        GvKMGXMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxyX5-00Fz5o-Aj; Thu, 16 Dec 2021 21:43:23 +0000
Date:   Thu, 16 Dec 2021 21:43:23 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC] Add a 'tag' field to MAINTAINERS
Message-ID: <Ybuy++k9sitvrem3@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

People find it hard to use the right tag when sending patches which
affect a maintainer that they don't interact with often.  If we add
a field to MAINTAINERS, perhaps a tool will be written some day that
automatically adds it to patches.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a1410d5a621..c6358fa58fed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -81,6 +81,7 @@ Descriptions of section entries:
 	R: Designated reviewer: FullName <address@domain>
 	   These reviewers should be CCed on patches.
 	L: Mailing list that is relevant to this area
+	J: Prefix to use when sending a patch
 	W: Web-page with status/info
 	B: URI for where to file bugs. A web-page with detailed bug
 	   filing info, a direct bug tracker link, or a mailto: URI.
@@ -2667,6 +2668,7 @@ F:	drivers/leds/leds-blinkm.c
 BLOCK LAYER
 M:	Jens Axboe <axboe@kernel.dk>
 L:	linux-block@vger.kernel.org
+J:	block
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
 S:	Maintained
 F:	block/
@@ -14927,6 +14929,7 @@ M:	Pawel Osciak <pawel@osciak.com>
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
 M:	Kyungmin Park <kyungmin.park@samsung.com>
 L:	linux-media@vger.kernel.org
+J:	videobuf
 S:	Maintained
 F:	drivers/media/v4l2-core/videobuf2-*
 F:	include/media/videobuf2-*

