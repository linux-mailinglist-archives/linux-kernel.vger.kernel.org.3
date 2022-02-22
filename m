Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36B4BFF91
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiBVRBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbiBVRBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:01:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51AA16E7D9;
        Tue, 22 Feb 2022 09:01:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61FE0CE179C;
        Tue, 22 Feb 2022 17:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259EEC340EF;
        Tue, 22 Feb 2022 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645549266;
        bh=mXu+SRd+CioGzEEmfpgeICqupXqfk8N07owEL+iR4xQ=;
        h=From:To:Cc:Subject:Date:From;
        b=VstmbJasrK1er2zAbT+nWkNjj/DWO6dBNfk7a0z86bGO6Wqm1WmnrcIPvmLsrEWmL
         jGxrDVURYxywE/fanqsvpMfZVdZAjnY2to5MO04I/CwCJdV/REwFImhIKHKAOGSwpe
         IWmki5OV3gny6iSFjPlEEGo6Ijlx8/OtrWab7rfXfHBBBUNDrIXwoQYqA97LblsNqF
         2XTMeeAtKMQIPS3+uYU4+WeY51ivXEcHkYlOSKdrMzoh0pqGSASdmkCeUgpuWRsWVO
         9a7hP55cM31oVB2WW6rvpADBgKYFmZ/CzhHqbkqmG/uQKGh/6WZdTzTfDLk/odbI4D
         BcmW+7JBJNrVw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 0/3] Docs/damon: Update documents for better consistency
Date:   Tue, 22 Feb 2022 17:00:57 +0000
Message-Id: <20220222170100.17068-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of DAMON document are not properly updated for latest version.
This patchset updates such parts.

SeongJae Park (3):
  Docs/vm/damon: Call low level monitoring primitives the operations
  Docs/vm/damon/design: Update DAMON-Idle Page Tracking interference
    handling
  Docs/damon: Update outdated term 'regions update interval'

 Documentation/admin-guide/mm/damon/usage.rst |  6 +--
 Documentation/vm/damon/design.rst            | 43 +++++++++++---------
 Documentation/vm/damon/faq.rst               |  2 +-
 3 files changed, 27 insertions(+), 24 deletions(-)

-- 
2.17.1

