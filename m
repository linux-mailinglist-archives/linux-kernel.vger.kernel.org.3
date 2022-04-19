Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4F9506254
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345392AbiDSC5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiDSC5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:57:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F1524BF6;
        Mon, 18 Apr 2022 19:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WzX7TzG1xIdHxDY2BZ0Xm745acZi7pqaZxLEvJnxMaU=; b=D9QU5UEqO3Wr2E82Zk1zzLKNab
        gmMBefBTbOEdSN8l/A+V29z1cFT5VZJL64bJhjAdpLd0p09KQMjf/w2Y2cLTf11uHIDHNElHBOsVN
        QywYiuzvgpUm5NYGXNpAsa89xgO4FvBNmOMrjZO9ILOYg/T93M07ISqFfu17tZxgh5CVIDRJ97Ud4
        LfCbKO5YocrU2plEaRUAzHoszdJM7QhELYD8eHX/C5Gtu0JDTloqE5+ibtbgEldXupiVpl9hJCd3/
        5fgXBHlJBkz0Tjhjd6veeCwSfauwKpGQPe5B82mdLGqxAgIOBHs3T1//Dlry9loLvVZZu6KXnmUbn
        7Fy5VUdg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nge0P-001Cr7-Fu; Tue, 19 Apr 2022 02:54:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: move watch_queue to core-api
Date:   Mon, 18 Apr 2022 19:54:16 -0700
Message-Id: <20220419025416.19434-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move watch_queue documentation to the core-api index and
subdirectory.

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---

 Documentation/core-api/index.rst             | 1 +
 Documentation/{ => core-api}/watch_queue.rst | 0
 Documentation/index.rst                      | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{ => core-api}/watch_queue.rst (100%)

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 972d46a5ddf6..2bfbf7093338 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -18,6 +18,7 @@ it.
 
    kernel-api
    workqueue
+   watch_queue
    printk-basics
    printk-formats
    symbol-namespaces
diff --git a/Documentation/watch_queue.rst b/Documentation/core-api/watch_queue.rst
similarity index 100%
rename from Documentation/watch_queue.rst
rename to Documentation/core-api/watch_queue.rst
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 1988c19d9daf..617503a39200 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -169,7 +169,6 @@ to ReStructured Text format, or are simply too old.
 
    tools/index
    staging/index
-   watch_queue
 
 
 Translations
-- 
2.34.1

