Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD42485044
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbiAEJma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:42:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41538 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238995AbiAEJmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:42:20 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7992B210FB;
        Wed,  5 Jan 2022 09:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641375739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JD8ncBxtJHRyNFNC3lfOZ5TQAbXenPQEwe/+VK+o2IQ=;
        b=XRVb0S31Js/ipeQfrcXwqVha9NHiOSkm8+ZWX23PAM/SmfEU2f+NtEjeFL+AhvvNBmy2kn
        dG3zqvW7QNNmAf2bdXTqVCWzDd9a8mNxaJfAPDpgVZtv2Gwc/naM+ebBI5RTx+3cgG2Ky+
        w8S8BuL5crGfCLmssRWHAKYwjMxX6OE=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id 40C8EA3B81;
        Wed,  5 Jan 2022 09:42:19 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 1/2] MAINTAINERS/vsprintf: Update link to printk git tree
Date:   Wed,  5 Jan 2022 10:41:56 +0100
Message-Id: <20220105094157.26216-2-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220105094157.26216-1-pmladek@suse.com>
References: <20220105094157.26216-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

printk git tree has moved to printk/linux.git in February 2020.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fb18ce7168aa..e9547ccda7d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20428,7 +20428,7 @@ M:	Sergey Senozhatsky <senozhatsky@chromium.org>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
 F:	Documentation/core-api/printk-formats.rst
 F:	lib/test_printf.c
 F:	lib/test_scanf.c
-- 
2.26.2

