Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A91555B08C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiFZJLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiFZJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:11:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EC412A93;
        Sun, 26 Jun 2022 02:11:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F7DD61180;
        Sun, 26 Jun 2022 09:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90DBC341CB;
        Sun, 26 Jun 2022 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656234670;
        bh=cvDUPUUtzJ93M+/T9ebETbcn6ZTwTPOb5ac5fH1CZ78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Py8Or5iBCfo2Dr3X8ilWCsHU4LTknV0s5DZ51vu0G/LjbBhgPaRbhIsPDHIeCjGfZ
         TlngHyAXay4F/5H38vkY7w77Kh0/oj1SXTDI8jklE3Cy31/tGBRURPC67H7BxlCxY1
         AqsNCtxhZP4Y7/nFdkHr9yYgI1fhtZlLFC7QwBxsMNTMBkOQk/v2xZYRtVewCS0osr
         G2f27OpGPZh0dUt4pfJShmbghzEmXpAfrnnflTjpmonMhvmTERfuGaS/vt+1n6NpUk
         89oIgtqf+MLjF1n6ZKCG90HCfZstYBus5DoT2FhBqEMhrFcjmd4qG1noJIUvCTcGpJ
         /qsw78i13cYVw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o5OIN-001coG-S9;
        Sun, 26 Jun 2022 10:11:07 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/20] docs: filesystems: update netfs-api.rst reference
Date:   Sun, 26 Jun 2022 10:10:48 +0100
Message-Id: <5f867f01d42c3e65e111167739ed1a41a26623f9.1656234456.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656234456.git.mchehab@kernel.org>
References: <cover.1656234456.git.mchehab@kernel.org>
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

Changeset efc930fa1d84 ("docs: filesystems: caching/netfs-api.txt: convert it to ReST")
renamed: Documentation/filesystems/caching/netfs-api.txt
to: Documentation/filesystems/caching/netfs-api.rst.

Update its cross-reference accordingly.

Fixes: efc930fa1d84 ("docs: filesystems: caching/netfs-api.txt: convert it to ReST")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/

 include/linux/fscache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 72585c9729a2..2f82ea31d4c1 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -378,7 +378,7 @@ void fscache_update_cookie(struct fscache_cookie *cookie, const void *aux_data,
  *
  * Request that the size of an object be changed.
  *
- * See Documentation/filesystems/caching/netfs-api.txt for a complete
+ * See Documentation/filesystems/caching/netfs-api.rst for a complete
  * description.
  */
 static inline
-- 
2.36.1

