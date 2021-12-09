Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2178546ECB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbhLIQLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:11:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40094 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240918AbhLIQKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:45 -0500
Date:   Thu, 09 Dec 2021 16:07:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4M0ACzm2q97AIqupAzGhLpK4qDK/RFzhvmFjIYN5Ao=;
        b=Ys7PeK1uqFeeTN/XRK8lcMCEhHAAeIuuLG7BqDGGwD1hrvcbz6ZlgsLqh3gwjDi6UcsZfU
        rTrfy/vKvL+kQJNXwf4lUDdJ+8Mffp1hW8S5c+n+AJY+apLORsRk5DMQWW4uHuzwDHt+5E
        hVkZ7OSErgvwn80hfH8UHlQKlEBz7rhzLwyjkxigkfTpquVU+r/dcJl714iB4YMu9WjQJP
        fTuN5WbPhC84klX1s8q4mYXn52GytrPzUlE1pqaAIAWVXjd47POWNt3zWa0XWgkt1Te/PE
        a8YATWTUKNVCeu0MGZDbBKAfddf1HjBcd9kvAOQiNNhmTje58jYuF/e8IDxEug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4M0ACzm2q97AIqupAzGhLpK4qDK/RFzhvmFjIYN5Ao=;
        b=8mQtqAP9FqHxOd0x6fLf3LqRgnmfNT5cL/dP7PEMN1EyCIZx1Y6iousp6F903gtmYmSWBV
        I7w1ZNqwqxoJsgCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Fixup includes
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.103502021@linutronix.de>
References: <20211206210224.103502021@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906603072.11128.1404648433816016200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     3ba1f050c91d5ce3672dbf3a55dc2451c0b342e2
Gitweb:        https://git.kernel.org/tip/3ba1f050c91d5ce3672dbf3a55dc2451c0b342e2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:20 +01:00

genirq/msi: Fixup includes

Remove the kobject.h include from msi.h as it's not required and add a
sysfs.h include to the core code instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20211206210224.103502021@linutronix.de

---
 include/linux/msi.h | 2 +-
 kernel/irq/msi.c    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 4b962f7..5c62775 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -2,7 +2,7 @@
 #ifndef LINUX_MSI_H
 #define LINUX_MSI_H
 
-#include <linux/kobject.h>
+#include <linux/cpumask.h>
 #include <linux/list.h>
 #include <asm/msi.h>
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index cd4fa26..6718bab 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -14,6 +14,7 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/pci.h>
 
 #include "internals.h"
