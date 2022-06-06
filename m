Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7041553EDD1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiFFSX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiFFSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:23:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27D410634C;
        Mon,  6 Jun 2022 11:23:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65A6AB81AE6;
        Mon,  6 Jun 2022 18:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893D2C3411E;
        Mon,  6 Jun 2022 18:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654539797;
        bh=r7qsMO+KaTvKmkx5mx/GJ+zu6Ys/r3ohlnLftZkA8x0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j8JnNnOJIAvqeARo2dlT4UcQMZ8rJ//iqmHsfN9M4cIEZNdeAnbFB8CmnMAfD9pFX
         UiNfXHQmu7cthP9LIT7NVUgYTjwxh/t1hCj4FGG40mXLXdsEZKL/tG0IDH3DTABqP9
         CShyDuo9w395PBZ9kKneAsphx18R3r5xsL7Hz3jYc/+c3HPRj/ZDn4Qwz2F1SGZdmJ
         gXzn9ShGWt/0FcDEfnrA+8yjck9sc+THOzP/B3pPNFpv6TjA2w2poz0JKvp/zbN4ma
         hiDHiL0i65m5+wH4OQR1HgiqbAYaMe2pVD5/GLouer+Z4FjGo3NJNAhsc5AEAY1nRT
         M1uHWvuJ1/n6g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/6] Docs/admin-guide/damon/reclaim: remove a paragraph that been obsolete due to online tuning support
Date:   Mon,  6 Jun 2022 18:23:05 +0000
Message-Id: <20220606182310.48781-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606182310.48781-1-sj@kernel.org>
References: <20220606182310.48781-1-sj@kernel.org>
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

Commit 81a84182c343 ("Docs/admin-guide/mm/damon/reclaim: document
'commit_inputs' parameter") has documented the 'commit_inputs' parameter
which allows online parameter update, but it didn't remove a paragraph
saying the online parameter update is impossible.  This commit removes
the obsolete paragraph.

Fixes: 81a84182c343 ("Docs/admin-guide/mm/damon/reclaim: document 'commit_inputs' parameter")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/reclaim.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 46306f1f34b1..6510baa91109 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -48,12 +48,6 @@ DAMON_RECLAIM utilizes module parameters.  That is, you can put
 ``damon_reclaim.<parameter>=<value>`` on the kernel boot command line or write
 proper values to ``/sys/modules/damon_reclaim/parameters/<parameter>`` files.
 
-Note that the parameter values except ``enabled`` are applied only when
-DAMON_RECLAIM starts.  Therefore, if you want to apply new parameter values in
-runtime and DAMON_RECLAIM is already enabled, you should disable and re-enable
-it via ``enabled`` parameter file.  Writing of the new values to proper
-parameter values should be done before the re-enablement.
-
 Below are the description of each parameter.
 
 enabled
-- 
2.25.1

