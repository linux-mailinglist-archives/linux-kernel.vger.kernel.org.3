Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE2355E084
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbiF1Jqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344303AbiF1Jqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:46:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF79625C55;
        Tue, 28 Jun 2022 02:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64596B81D79;
        Tue, 28 Jun 2022 09:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE31C341CA;
        Tue, 28 Jun 2022 09:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656409590;
        bh=qHIYwC0MUE7l/qkHy6SpVtjLMVFmnu5rrRpz/lQTjrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCcb/wcS2buWfSiU6z7jcNlYGTLIogyO4E35JoCwqlOwgd2m9sbjwul9VIqMhghh2
         oKhfXGAq5Do+8VZMHRnVtb2rR2kfNO42LpLTlBry1atuNqYvqkEe8goxMZbIkU0qci
         8fAMAh9GxD+xMT1ra421ngp4O2ib4wph58kyGL3EjfubQy9DMScoFNFi4oTlnQ28xX
         x1uiSFler+c7b842gN2r7lTVnYSJwMMrnUWbGTxq+dNAPFmlgqa+sL5ptfHAtEEKx+
         Pm1qZNaSOXQWT6Ug7VD1JbWtrtpM7oX4G1KDDSPI29sYQSfmj/p4Pbml4Q1QfDftUS
         uAEXAWxMge7Yw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o67nf-005HEy-NJ;
        Tue, 28 Jun 2022 10:46:27 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/22] fscache: fix kernel-doc documentation
Date:   Tue, 28 Jun 2022 10:46:09 +0100
Message-Id: <9fb5c8a99752e1f01adfa32ed7ddeda2a9f75d71.1656409369.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656409369.git.mchehab@kernel.org>
References: <cover.1656409369.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/

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

