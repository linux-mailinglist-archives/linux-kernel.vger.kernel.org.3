Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF856C8A3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 12:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGIKHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 06:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGIKHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 06:07:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9464AD79;
        Sat,  9 Jul 2022 03:07:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 155C960E09;
        Sat,  9 Jul 2022 10:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A013C341CB;
        Sat,  9 Jul 2022 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657361258;
        bh=KZMhqKdJLjrHHTJU133KkxjPp76fXsmKlOwAYjquG7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okoGiyBJ3MHqOlHYCE9BY6Dk3VBbeDVgI8KZn2YHIagcREimM3E2hNXqxrc88o4BD
         pJLBUouTplLaosSaMjBXK3RqhBUr3t2tEEW2xQ2wGFs5KKP9zN8HGRRAeRoWoR7xCI
         rb3oDkLDqhb9F65kD5byEQlmBiui0uqsdY85s1bX1ttuYYM6AQjjG3bUimp4esLzKp
         XuOnoekv+NWCSDaIBtpjjMlazL1XKfTPWeG9a8+brfuGyUe6gP9YKkxh48INBBasZi
         WAwuUU0YOhtnPlmY38waQJKquciZ+t5zECm97zD60cLn01QN687uH/PWw0IWTZMh4F
         +Qs08yLdID6HQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oA7N9-004EGl-Gw;
        Sat, 09 Jul 2022 11:07:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/21] fscache: fix kernel-doc documentation
Date:   Sat,  9 Jul 2022 11:07:20 +0100
Message-Id: <880d7d25753fb326ee17ac08005952112fcf9bdb.1657360984.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657360984.git.mchehab@kernel.org>
References: <cover.1657360984.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prototype of two functions use "cookie" for the object
parameter.

Update kernel-doc tags accordingly, fixing those warnings:

	include/linux/fscache.h:270: warning: Function parameter or member 'cookie' not described in 'fscache_use_cookie'
	include/linux/fscache.h:270: warning: Excess function parameter 'object' description in 'fscache_use_cookie'
	include/linux/fscache.h:287: warning: Function parameter or member 'cookie' not described in 'fscache_unuse_cookie'
	include/linux/fscache.h:287: warning: Excess function parameter 'object' description in 'fscache_unuse_cookie'

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/

 include/linux/fscache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 2f82ea31d4c1..e13184c4b198 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -257,7 +257,7 @@ struct fscache_cookie *fscache_acquire_cookie(struct fscache_volume *volume,
 
 /**
  * fscache_use_cookie - Request usage of cookie attached to an object
- * @object: Object description
+ * @cookie: Object description
  * @will_modify: If cache is expected to be modified locally
  *
  * Request usage of the cookie attached to an object.  The caller should tell
@@ -273,7 +273,7 @@ static inline void fscache_use_cookie(struct fscache_cookie *cookie,
 
 /**
  * fscache_unuse_cookie - Cease usage of cookie attached to an object
- * @object: Object description
+ * @cookie: Object description
  * @aux_data: Updated auxiliary data (or NULL)
  * @object_size: Revised size of the object (or NULL)
  *
-- 
2.36.1

