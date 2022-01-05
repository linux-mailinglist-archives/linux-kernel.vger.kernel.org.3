Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03D3485043
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbiAEJmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:42:22 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42060 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiAEJmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:42:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8A5F61F37B;
        Wed,  5 Jan 2022 09:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641375736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0wbZCxsdWmx4dTqRXixE1C/lWD1GIULVfJO3PjGzP+E=;
        b=L/Dz3DtZn/wQ4nPfITefAt8Fmqj26qBim+8jxrq2kwYp8Y5H9M/15K9c0EvPXvRE3Uh5dz
        htfSEEgtECGgDk5YNPznapMx4/oxDlAWNHcsdH6TV1LD2NwEOhZn0IKPjeQREvvjUtUG/T
        L5yG/NiGaOotEjnXp2Gpxe8+LI7WLsI=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id 14789A3B83;
        Wed,  5 Jan 2022 09:42:16 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/2] MAINTAINERS: Update information about printk git tree
Date:   Wed,  5 Jan 2022 10:41:55 +0100
Message-Id: <20220105094157.26216-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have noticed one outdated and one missing link to the printk git tree.
I am not sure if it is worth sending for review and having two patches.
I just want to avoid possible complains ;-)

Petr Mladek (2):
  MAINTAINERS/vsprintf: Update link to printk git tree
  MAINTAIERS/printk: Add link to printk git

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.26.2

