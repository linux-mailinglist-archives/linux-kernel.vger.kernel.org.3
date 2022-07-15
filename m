Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9CC57595B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 04:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241210AbiGOCA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 22:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241189AbiGOCAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 22:00:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3396571BC5;
        Thu, 14 Jul 2022 19:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=NFvWOBhXUaXzNUwiC6fcRrNXIN6zcEqJ/qvmwUudgeQ=; b=PqjhT1DUT7kRNnhWZGodhjYuex
        H80x4lay9X96oyZ8L347saZBWID+mh37brBp0E8XjuGTlbbXhtgLdzkI467irobFTBamd8NuXJN77
        C5sqj5beR4m5ZeYYi7aIIpzziMDusZSMKo+RmL7TpLwfUNnzhwk656YzbHbVaikbLXzCbYaJsYSJ+
        IsOLrQs6B5JNqoNJN4AzIEXoRKnaSik0pDlJ01xi/3Z3qdkm9xznN3XpOh3hRHydwJ6fOTxp/24Aw
        eqUwpGRYzgtXW06HYspqH7V/a7oVWxuwlXQvIcdlYqnLchp9qI0cbMPoLd+vPeMcjJssEnDfEu1s4
        kc13bx1g==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCAcp-009sec-QJ; Fri, 15 Jul 2022 02:00:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390/hmcdrv: fix Kconfig "its" grammar
Date:   Thu, 14 Jul 2022 19:00:10 -0700
Message-Id: <20220715020010.12678-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.0
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

Use the possessive "its" instead of the contraction "it's"
where appropriate.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/char/Kconfig
+++ b/drivers/s390/char/Kconfig
@@ -89,7 +89,7 @@ config HMC_DRV
 	  Management Console (HMC) drive CD/DVD-ROM. It is available as a
 	  module, called 'hmcdrv', and also as kernel built-in. There is one
 	  optional parameter for this module: cachesize=N, which modifies the
-	  transfer cache size from it's default value 0.5MB to N bytes. If N
+	  transfer cache size from its default value 0.5MB to N bytes. If N
 	  is zero, then no caching is performed.
 
 config SCLP_OFB
