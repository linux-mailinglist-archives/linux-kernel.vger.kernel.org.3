Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFD3485045
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiAEJmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:42:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41558 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbiAEJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:42:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A601721129;
        Wed,  5 Jan 2022 09:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641375742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zn+G7JoiKFPeGVyH3XyCkTZU2JgwOeZvNWRLBNyD8Dg=;
        b=rOo1A0ZzPWe+8sAyQFj2cHhTYbtW16EUSGlg1wgkxIGlvKxwe9bkuiXA3SpJ/eYMmw99Bz
        v0ex+Ca0x25My4fp/KK7A4Fw9EYHNH+oEIe3LJdeWeO273W1aQ0sN7H3CnN+bE9/lB4OfA
        sv2ZXBGAWom82YBycMoo4LvMaADioqU=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id 6FD8CA3B83;
        Wed,  5 Jan 2022 09:42:22 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 2/2] MAINTAIERS/printk: Add link to printk git
Date:   Wed,  5 Jan 2022 10:41:57 +0100
Message-Id: <20220105094157.26216-3-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220105094157.26216-1-pmladek@suse.com>
References: <20220105094157.26216-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It might also help to avoid confusion with the historic
pmladek/printk.git that has got obsoleted by printk/linux.git
in February 2020.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9547ccda7d0..653415ed050b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15339,6 +15339,7 @@ M:	Sergey Senozhatsky <senozhatsky@chromium.org>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	John Ogness <john.ogness@linutronix.de>
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
 F:	include/linux/printk.h
 F:	kernel/printk/
 
-- 
2.26.2

