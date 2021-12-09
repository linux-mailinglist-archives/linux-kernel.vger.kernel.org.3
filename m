Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E227446E8F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhLINVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:21:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56490 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhLINVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:21:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9709BB82458;
        Thu,  9 Dec 2021 13:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26B3C004DD;
        Thu,  9 Dec 2021 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055893;
        bh=LRQianhMtj+CS/sd4j3ID6DenT16Lli/4LE8T+VXtOE=;
        h=From:To:Cc:Subject:Date:From;
        b=aMiIDoLE/kxfE6F+3gei3enRkoZJ+9RuuxSzCOmPEPScyF5ckaDq0jHaeFbOPlW61
         XsPzH3dMTqbS9rkmzX4xL8r1ibVNfhg2duc/Q1Rl9cnLS49re3Jx/cl/m4wvQXEmNs
         Av1cglimLHbDncmd6VpXLqyv2EzMNNQeqNsH41LdpahF+OF29XLYcjPEG8GulNmccS
         J/U8vlF0JCWdhPS+SPq//QVTDKWqixXr9irnNX9iU923G2lPwblCfY38N2y6JJqwIR
         3iPENAEe1wT2/8XMeFJrNwSbmLhWVCLc3NUNZNTFolH+O2T6W6rKf01ChERwu2Kj4/
         oN0Ka1Nko/r1A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/6] mm/damon: Misc cleanups
Date:   Thu,  9 Dec 2021 13:18:00 +0000
Message-Id: <20211209131806.19317-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains miscellaneous cleanups for DAMON's macro
functions and documentations.

SeongJae Park (6):
  mm/damon: Convert macro functions to static inline functions
  Docs/admin-guide/mm/damon/usage: Update for scheme quotas and
    watermarks
  Docs/admin-guide/mm/damon/usage: Remove redundant information
  Docs/admin-guide/mm/damon/usage: Mention tracepoint at the beginning
  Docs/admin-guide/mm/damon/usage: Update for kdamond_pid and
    (mk|rm)_contexts
  mm/damon: Remove a mistakenly added comment for a future feature

 Documentation/admin-guide/mm/damon/usage.rst | 224 +++++++++++++++----
 include/linux/damon.h                        |  20 +-
 mm/damon/core.c                              |   5 +-
 mm/damon/vaddr.c                             |   6 +-
 4 files changed, 196 insertions(+), 59 deletions(-)

-- 
2.17.1

