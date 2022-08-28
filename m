Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA05A5A3AA0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 02:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiH1A26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 20:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1A24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 20:28:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC31C33E0E;
        Sat, 27 Aug 2022 17:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=23ph2otCZCX5I5yCccntprO67HKi3ey2WowmynKONxM=; b=bgCRJmiDBBwSAPbvtovMYFC557
        wYA4hWSZJbs7tVfOEAUOa8T5Hez4T8u6ZymwZzDt29FxtRl22ljnrU/qzzidp0E57Z3ofJJPdPZ+X
        gOUgtJLcOe/1mwSJ/cidnEMdS1iI6wa4QtGCpicSNewYIqzQrZe9ZnNJKpjbxU6FEoPtjNrstG4ek
        CKdExst2zmm7y6NZ6ADM1FPgH375bAO8KUBinzcU14yOw+7jpoS/yEd3bf+k57e7iNIrnzfclxKqS
        MixqwTPRoE1QGdkmOvxRKzHvriOwfOlLfWQpK/xsMr+U/dvljwMDKlkOOTuJmDJ9lv9OuvDhxjvtV
        i2skl9tQ==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oS6AV-001p4v-KE; Sun, 28 Aug 2022 00:28:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Evgeniy Polyakov <zbr@ioremap.net>
Subject: [PATCH] Documentation: W1: minor typo corrections
Date:   Sat, 27 Aug 2022 17:28:45 -0700
Message-Id: <20220828002845.7022-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.2
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

Correct one typo/spello and remove one duplicated word in the
W1 documentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Evgeniy Polyakov <zbr@ioremap.net>
---
@Evegniy-
I notice that ioremap.net web site is not working for me.
Can you do something about that or modify the URL in
Documentation/w1/w1-netlink.rst (2. http://www.ioremap.net/archive/w1)
for source code examples?

 Documentation/w1/masters/ds2490.rst |    2 +-
 Documentation/w1/w1-generic.rst     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/Documentation/w1/masters/ds2490.rst
+++ b/Documentation/w1/masters/ds2490.rst
@@ -52,7 +52,7 @@ Notes and limitations.
   clear the entire bulk in buffer.  It would be possible to read the
   maximum buffer size to not run into this error condition, only extra
   bytes in the buffer is a logic error in the driver.  The code should
-  should match reads and writes as well as data sizes.  Reads and
+  match reads and writes as well as data sizes.  Reads and
   writes are serialized and the status verifies that the chip is idle
   (and data is available) before the read is executed, so it should
   not happen.
--- a/Documentation/w1/w1-generic.rst
+++ b/Documentation/w1/w1-generic.rst
@@ -113,7 +113,7 @@ generally only make sense when searching
 redetect manually removed devices that are present and timeout manually
 added devices that aren't on the bus.
 
-Bus searches occur at an interval, specified as a summ of timeout and
+Bus searches occur at an interval, specified as a sum of timeout and
 timeout_us module parameters (either of which may be 0) for as long as
 w1_master_search remains greater than 0 or is -1.  Each search attempt
 decrements w1_master_search by 1 (down to 0) and increments
