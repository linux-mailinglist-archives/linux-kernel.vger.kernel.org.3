Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB062575958
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 04:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbiGOCAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 22:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbiGOCAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 22:00:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70B072EF4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 19:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nF2OQIFTAhYqopzX2rikIHROeUELSnKaHB+f1DDtUH8=; b=um1tzbUEJZsbB8nkD6Tq7ZmdRW
        7Yv07NvuqHB8z5Ml5z8UOyuaTh0ql81l3MZnjQzRzaU9YdEH3wd1MPZCvPNOTKSCcbeC5Bvi3CxEJ
        6SGV719xRKCMTgQYje0UShUTyTtSZUJq7BQA2lO6OjCu9w7kiMtryybr0B7j0FOp3qXJBKtPsvLmm
        ORryC1Ltt8Ik9WAbz4mg+8VWzjva6HlVemh7t/8SeruT/MUjcP313NeU1ZRtVqy4wBpYh3DyAsuKY
        v9PXQAGrWo+Uo7GkX3tO+LJvJXqok/0n5ExpxvGFMpTVHLvUa/q1TccH3IBg7Qwz4IRgc3Xrd8zad
        ASNsexlA==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCAce-009sdH-ES; Fri, 15 Jul 2022 02:00:05 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] kobject: fix Kconfig.debug "its" grammar
Date:   Thu, 14 Jul 2022 18:59:59 -0700
Message-Id: <20220715015959.12657-1-rdunlap@infradead.org>
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
Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1568,7 +1568,7 @@ config DEBUG_KOBJECT_RELEASE
 	help
 	  kobjects are reference counted objects.  This means that their
 	  last reference count put is not predictable, and the kobject can
-	  live on past the point at which a driver decides to drop it's
+	  live on past the point at which a driver decides to drop its
 	  initial reference to the kobject gained on allocation.  An
 	  example of this would be a struct device which has just been
 	  unregistered.
