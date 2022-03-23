Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292B74E5962
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 20:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbiCWTwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 15:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344396AbiCWTwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:52:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA0558827
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0D2F61604
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A04CC340E8;
        Wed, 23 Mar 2022 19:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648065050;
        bh=O3iYQzZDFKFaYEai80v14IX9o5YoNsm8i6KJUIkzXZU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cKtC4SvyRdUtveHA/I6PWwd6iDz3wOe7FTBAw/i1wxB6pDfi/918Py0VLKJOlNVsr
         EY7GiF48x3SXsZnnniAQqpgF3YlXwQ3ZBULHq5UZU8JEpBSvTjEbYW+0aq088QY7xx
         bIXFywyiG30HEVnRr6EnAZK0rQheAIyZPvI/4diTMJCsvwXnFZG1BZ6dHm77feLVhs
         oYAfTMbVyLvQbEYlfTOsj7Z67whHTf+UoT/i+5QZCNSw7gQ2dfQ7FkagD8VMEAexDp
         5sR0FBkDJRxCotcGjkoKpXKnOOc3p0c+i9eNRmicNCPczlmtydek9Pcorfg8Crm48H
         jG2lACOqOadDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0490CE6D402;
        Wed, 23 Mar 2022 19:50:50 +0000 (UTC)
Subject: Re: [GIT PULL] slab for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ee1fe9ee-c560-9f7c-c8d1-bd48c608ba90@suse.cz>
References: <ee1fe9ee-c560-9f7c-c8d1-bd48c608ba90@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <ee1fe9ee-c560-9f7c-c8d1-bd48c608ba90@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.18
X-PR-Tracked-Commit-Id: 94fa31e99b57ce4a56e93815421566d483186cb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5c009e2503d4c027591c65b49a98f420cb4fa56
Message-Id: <164806505001.21505.5331298391907150342.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 19:50:50 +0000
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 20:02:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5c009e2503d4c027591c65b49a98f420cb4fa56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
