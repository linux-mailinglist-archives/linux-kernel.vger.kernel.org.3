Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11771470365
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242621AbhLJPEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:04:15 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60280 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242508AbhLJPEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:04:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 210A7B8287D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C03C341C5;
        Fri, 10 Dec 2021 15:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639148435;
        bh=4d4SLklUxQ2JQcAHxAn5MLm1T/njPSHJ9DpKaw+ZmvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f0SDocJ2hOpYjfmxziuXYpl0FwZsFru7efEfq6frz/DfpYtFEj2pfi6ymZ4l0CHie
         4Ou9chp6LFdmTP+NcgeQ+0taSYepL8rjWIhKvCEQGbv3iG0Oqn/m4znSv+cdLm1kxe
         y8VbHqcEZr2dF1j2WLZImzOXA/OgkDWR2eGeNiFjr18gZGk44t55nOPlcpg294wwkH
         IzozUj8iVerleJBiFH+jFU9LnqU2mjU1txIzuHO1/u29NQAy0WB+6oTFO1a2gbOfrl
         HZX0PTI8nEr17fVXeDzrvuTsS4UtG0u6rdQK0ML71HRX1R5whpu+XRZcWi9NWJjCAb
         lTenzDOsqG3oA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 6/6] Docs/admin-guide/mm/damon/usage: Update for schemes statistics
Date:   Fri, 10 Dec 2021 15:00:16 +0000
Message-Id: <20211210150016.35349-7-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211210150016.35349-1-sj@kernel.org>
References: <20211210150016.35349-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates DAMON debugfs interface for statistics of schemes
successfully applied regions and time/space quota limit exceeds counts.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index cb614c84ba9e..59b84904a854 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -223,12 +223,13 @@ is activated.
 Statistics
 ~~~~~~~~~~
 
-It also counts the total number and bytes of regions that each scheme is
-applied.  This statistics can be used for online analysis or tuning of the
-schemes.
+It also counts the total number and bytes of regions that each scheme is tried
+to be applied, the two numbers for the regions that each scheme is successfully
+applied, and the total number of the quota limit exceeds.  This statistics can
+be used for online analysis or tuning of the schemes.
 
 The statistics can be shown by reading the ``schemes`` file.  Reading the file
-will show each scheme you entered in each line, and the two numbers for the
+will show each scheme you entered in each line, and the five numbers for the
 statistics will be added at the end of each line.
 
 Example
-- 
2.17.1

