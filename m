Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A23453EDCB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiFFSXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiFFSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:23:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D1B1059F8;
        Mon,  6 Jun 2022 11:23:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC6D8B81AE8;
        Mon,  6 Jun 2022 18:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15C3C385A9;
        Mon,  6 Jun 2022 18:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654539796;
        bh=+QqAprUxOaQPSOtLP0LgBQYVTXKMbC246G9bHpmyd0Y=;
        h=From:To:Cc:Subject:Date:From;
        b=gs75g9nmBP5Dow05xpuWiCuO/NgJjCt9gShkU29XnHSJeHDrv5fuK7SmlPmJbH/j/
         lhbg7TRElq9liJuX1WAqBxjesskhTNSy+t4VKbFPUB2a0Ixl+SMnjWQIBcIio+OO4v
         S+r4VzUUSY/XXBUy5UKJFRClt0B1DhUqY/Spd0JX3zpGQkRbCPJSldtYrdA6DFNIoO
         gSNHOnBjTaq6TscYJSjr4X56VvtqPc1d8nKSQLqrkQDMYjwKRbWdfFVVkZcArpNm1W
         N9fWhzwDHGlxwc5WKIJybAc0YHTB5t1KjBx995LdfkPqumeo2BOekuVQy0yenf7ICF
         rhWxxTnKAMuTQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/6] mm/damon: trivial cleanups
Date:   Mon,  6 Jun 2022 18:23:04 +0000
Message-Id: <20220606182310.48781-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
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

This patchset contains trivial cleansups for DAMON code.

SeongJae Park (6):
  Docs/admin-guide/damon/reclaim: remove a paragraph that been obsolete
    due to online tuning support
  mm/damon/{dbgfs,sysfs}: move target_has_pid() from dbgfs to damon.h
  mm/damon/reclaim: deduplicate 'commit_inputs' handling
  mm/damon/sysfs: deduplicate inputs applying
  mm/damon/reclaim: make 'enabled' checking timer simpler
  mm/damon/reclaim: add 'damon_reclaim_' prefix to 'enabled_store()'

 .../admin-guide/mm/damon/reclaim.rst          |  6 --
 include/linux/damon.h                         |  6 ++
 mm/damon/dbgfs.c                              | 15 ++---
 mm/damon/reclaim.c                            | 40 +++++------
 mm/damon/sysfs.c                              | 67 ++++++++-----------
 5 files changed, 55 insertions(+), 79 deletions(-)

-- 
2.25.1

