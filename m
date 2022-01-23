Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD1649707D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 08:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiAWHfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 02:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiAWHfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 02:35:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD43C06173B;
        Sat, 22 Jan 2022 23:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fWhD0rdHJXmk3jjCBeJIpRI447YxEAOUTk85sPXaUQ0=; b=cH8MxFIPcrPOCb/9fp/EApg0Wx
        TOHqkGeoDdLoSwFpQJnesBnAzyLJWQojlOms8SN4jeNlZpMWrA7c77ZmMH5o2zx8WK4gepBErEOCM
        kuEbOe/tTmTlslti6HvfbeumM5mUZDdVpeSS6mTrgWZ9bLukFOcO4NDLAKjVkn1Rm4TINL0XcngX9
        kebny8iOxsCDcaMBpMyebP5JBqO7I6XvrkJp1axysnIkVk4j3J4kDoD6tj7qSm362URaqvoJ393CO
        EokX0tk2p/BHUg+FQLLXHD0yXk8hnGidFX99BC1r9Kud7qz7f21iRRdW5Efi94CzIu7HVqevTVqZN
        3nK4WOwg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBXPV-000QNL-0k; Sun, 23 Jan 2022 07:35:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-gpio@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH ?next?] gpio: sim: add doc file to index file
Date:   Sat, 22 Jan 2022 23:35:36 -0800
Message-Id: <20220123073536.12193-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the gpio-sim.rst file in the GPIO index (toc/table of contents).

Quietens this doc build warning:

Documentation/admin-guide/gpio/gpio-sim.rst: WARNING: document isn't included in any toctree

Fixes: b48f6b466e44 ("gpio: sim: new testing module")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/admin-guide/gpio/index.rst |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20220121.orig/Documentation/admin-guide/gpio/index.rst
+++ linux-next-20220121/Documentation/admin-guide/gpio/index.rst
@@ -10,6 +10,7 @@ gpio
     gpio-aggregator
     sysfs
     gpio-mockup
+    gpio-sim
 
 .. only::  subproject and html
 
