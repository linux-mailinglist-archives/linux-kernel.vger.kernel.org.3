Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DF449F87F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244353AbiA1Lmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:42:51 -0500
Received: from mail.loongson.cn ([114.242.206.163]:40646 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236888AbiA1Lml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:42:41 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb+Kh1vNhREgFAA--.17556S3;
        Fri, 28 Jan 2022 19:42:26 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] docs: kdump: update description about sysfs file system support
Date:   Fri, 28 Jan 2022 19:42:21 +0800
Message-Id: <1643370145-26831-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1643370145-26831-1-git-send-email-yangtiezhu@loongson.cn>
References: <1643370145-26831-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9Dxb+Kh1vNhREgFAA--.17556S3
X-Coremail-Antispam: 1UD129KBjvJXoWrKrW8Jry8Zw43Aw4rAr47Arb_yoW8JF18pa
        nYyry29FW7AF1kC3yUAF1IgFy5A3WIkayrGa4kAr18Xr1kur97ZrsI9w47JF1DXr1kGayr
        XFWSgFyF9a42k3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPIb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY
        1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
        xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCa
        FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkIec
        xEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
        F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
        ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jI
        zuXUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to
CONFIG_EXPERT"), "Configure standard kernel features (for small
systems)" is not exist, we should use "Configure standard kernel
features (expert users)" now.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Documentation/admin-guide/kdump/kdump.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index cb30ca3d..d187df2 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -146,9 +146,9 @@ System kernel config options
 	CONFIG_SYSFS=y
 
    Note that "sysfs file system support" might not appear in the "Pseudo
-   filesystems" menu if "Configure standard kernel features (for small
-   systems)" is not enabled in "General Setup." In this case, check the
-   .config file itself to ensure that sysfs is turned on, as follows::
+   filesystems" menu if "Configure standard kernel features (expert users)"
+   is not enabled in "General Setup." In this case, check the .config file
+   itself to ensure that sysfs is turned on, as follows::
 
 	grep 'CONFIG_SYSFS' .config
 
-- 
2.1.0

