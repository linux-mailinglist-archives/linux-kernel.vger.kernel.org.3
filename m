Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B046DF55
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 01:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbhLIARG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 19:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241413AbhLIARF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 19:17:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9992FC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 16:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=YKaq7u2ZvlBjsqTL7W0J4+7gh5LsbD02rf6n5cT3NHE=; b=aYUGOucC+1mSIQCxeuiQs6k4O3
        uZnNI29VLHIC5gsjn6MphBM4pzwqSDJt2SgobOPe43ICDfh78X9Yl4W7dLYDtZfFg5V0jq1EM2gDX
        uyrdXpp1UHujvzsN10dqs/F08wzhXv4AuK3pDEexq2R9s/n14VS7rFITs1b6rdjQ4TkO7e6dmbRKG
        EZdFgOSGB7HvJnIxmautqAVkfgk4NC8mjfQJbTXpLXiACxPUbGgfnX9IMqUL+91+xVuSYUaEwG92s
        56fedlxBXZoN1VkZd3vfwwtYlDxGtBkpx/4zEOZSENo3zcZWvRLw1mirhEvGmS2hJLa3U1kAmesJI
        Wnjksj0w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv73z-00EZwZ-HT; Thu, 09 Dec 2021 00:13:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Culhane <conor.culhane@silvaco.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] MAINTAINERS: mark more list instances as moderated
Date:   Wed,  8 Dec 2021 16:13:30 -0800
Message-Id: <20211209001330.18558-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some lists that are moderated are not marked as moderated
consistently, so mark them all as moderated.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Conor Culhane <conor.culhane@silvaco.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>

 MAINTAINERS |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20211208.orig/MAINTAINERS
+++ linux-next-20211208/MAINTAINERS
@@ -14929,7 +14929,7 @@ PCIE DRIVER FOR MEDIATEK
 M:	Ryder Lee <ryder.lee@mediatek.com>
 M:	Jianjun Wang <jianjun.wang@mediatek.com>
 L:	linux-pci@vger.kernel.org
-L:	linux-mediatek@lists.infradead.org
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/mediatek*
 F:	drivers/pci/controller/*mediatek*
@@ -17536,7 +17536,7 @@ F:	drivers/video/fbdev/sm712*
 SILVACO I3C DUAL-ROLE MASTER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Conor Culhane <conor.culhane@silvaco.com>
-L:	linux-i3c@lists.infradead.org
+L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
 F:	drivers/i3c/master/svc-i3c-master.c
