Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F454549F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiFMUdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiFMUdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:33:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C4B25E8D;
        Mon, 13 Jun 2022 12:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8F18B81260;
        Mon, 13 Jun 2022 19:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8645C341C6;
        Mon, 13 Jun 2022 19:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655148191;
        bh=VBsgQVJb305tu+x5Ezk9xdnNcUiCg8aWk5S50W2VGCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nwkY5iB/FBsFoMBVuUTRoDxNVkViDcsprfVa78XaY+e7pn0E6ofcJAjKfa3FiTuYV
         ZAvtKRakoy2Pw1Ka4WbCimxUtoupKTxE20bGydUF+qaBNqxK/oP1M6tGBim0b2riWz
         cGhqciMQKJiHntWylNAwhcH/oNXNkvpcJEaUyQdEvtpD+RWTJqwYRFItCqj5M5Tkvp
         UWOf5ZuGcGnRJtioModUaO7SA5r/B+//cRZaUe9JKD4P2fu9GTWgjb33Em7uXhzCx5
         PkFPWPiOXYDWYA9uKF8XmQkIwVCXFXHp9VlLNw5VW9Szz+j2t5rCRuHGQuxZ3vIWGo
         32ujOHqyEAA1A==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] Docs/admin-guide/damon/sysfs: document 'LRU_PRIO' scheme action
Date:   Mon, 13 Jun 2022 19:22:57 +0000
Message-Id: <20220613192301.8817-6-sj@kernel.org>
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

This commit documents the 'lru_prio' scheme action for DAMON sysfs
interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 1bb7b72414b2..af4e15ee81cd 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -264,6 +264,7 @@ that can be written to and read from the file and their meaning are as below.
  - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT``
  - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``
  - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``
+ - ``lru_prio``: Prioritize the region on its LRU lists.
  - ``stat``: Do nothing but count the statistics
 
 schemes/<N>/access_pattern/
-- 
2.25.1

