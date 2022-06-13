Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10975549F5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiFMUeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiFMUdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:33:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CF93631E;
        Mon, 13 Jun 2022 12:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EBC2614EF;
        Mon, 13 Jun 2022 19:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43251C341C8;
        Mon, 13 Jun 2022 19:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655148192;
        bh=/ZIOfIXjUyDL/E317WytkrmVVIeFLDByyTBTkw3FhHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQbrkfuor7ndKRkLJR3NUU84zVZPei00GRr2otDJiT+VZlwEryFoOHCX1Syn6t9Xe
         8oJZnO+PJBBUrPCdzUv8PWssdHiL3vSPi+rOYH1y/sHRyySHTWhGs4oZjVgKlELfip
         ziKC4IXJ9o+lMKCzodXTrfhm4w38F9ZlbpWSs4rJ32h8Uc5vbUaYWRSQ17NcxjPaQ9
         ARph6Dsherb3IPwUe7Nh+g/K1qPB0pVoMg5BfE7hiuar8OmAy0tFaQx5YNm8UMDP5Q
         j8G/4Md/ii7Ni/TvrE3v22zCWouPhR0BzoRkAjiC+m+1jcjbKWHoGwElUnqYzizREd
         Xd/6ZOkRAY6Vg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] Docs/admin-guide/damon/sysfs: document 'LRU_DEPRIO' scheme action
Date:   Mon, 13 Jun 2022 19:22:59 +0000
Message-Id: <20220613192301.8817-8-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613192301.8817-1-sj@kernel.org>
References: <20220613192301.8817-1-sj@kernel.org>
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

This commit documents the 'LRU_DEPRIO' scheme action for DAMON sysfs
interface.`

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index af4e15ee81cd..d822bf6355ce 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -265,6 +265,7 @@ that can be written to and read from the file and their meaning are as below.
  - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``
  - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``
  - ``lru_prio``: Prioritize the region on its LRU lists.
+ - ``lru_deprio``: Deprioritize the region on its LRU lists.
  - ``stat``: Do nothing but count the statistics
 
 schemes/<N>/access_pattern/
-- 
2.25.1

