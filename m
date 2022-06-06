Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8053E67E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbiFFP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240601AbiFFPZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080A91CD361;
        Mon,  6 Jun 2022 08:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB7CF6150D;
        Mon,  6 Jun 2022 15:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27B1C36B03;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529149;
        bh=bv86DwGzWLqhD5P8CP9tPQuLZL3y15Vz58qOWkDLoP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ty+L57VM4KWcjIrZISVlYpRyN9HEBnpxop3nlhO+wrblXzYVl4wK05aYr+6x7Srks
         cWQj9Ecu56XfLyQN9vGV1ilinSnqXsTTd9cw4vxpkyBi8SdDxMt4YzBXBKJx7WJeDd
         8eiYWjWf0vSsb47EDcazZCOb7piXV85uTY0fHgFJUsk69Jwc7zX1NHjNgmov5uYkOp
         Ycm1l0CAxmA4D+mazHVKdb3Ac4pi6DOxphJP+8pGf6T338Aa4ssh7KMt5zq1P5cCUW
         xMi3cWeYcxwTplBrDuzF38s3kOoOPAC2g7VdHCLor50VRvg3ZVsjxBGfHC6D6mRHNl
         n6b3XN75qJmbA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012PC-6I;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/23] docs: filesystems: update netfs-api.rst reference
Date:   Mon,  6 Jun 2022 16:25:30 +0100
Message-Id: <e76a5b3977cb566ecd6d1a8fd55f6c7c1cbafb72.1654529011.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654529011.git.mchehab@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

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

