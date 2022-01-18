Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B78E491EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 05:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239013AbiARExO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 23:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbiARExC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 23:53:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F21C061401
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 20:53:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6321A6133C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 04:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0DADC36AE3;
        Tue, 18 Jan 2022 04:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642481581;
        bh=vMzlZ44a5QjCWkrfuftcTqchvsKjrJ7JAZct+aW8Vlo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LEB9CjbVaGCATH86QJrLL7Z7hkbwXcFhW8v9hVtSBXB5XM/ir6bFP9biqTLCQMAOT
         wEWeO/zyH8morN/kPuSPITkMQul+NRhWRsupZQHuNQYRjUMUfgzQ1cKxQTkF/nm++v
         kCyLr8Dvj0bULK2MSaF7GYqJu3Ch/imgHwJiPnT9lmiPGDRB+cKmvVDaHhjxCrCkA3
         DIQ+5qzYBonFr/WJlu8OJ+wyzMFOYrB6HtbHnAvO2HTg3aE0QmOAC4XcGQo/acNt7N
         UmqdaxSVWT2J2EYrmbbFftHRpS3ZcyB8uJ3SblFKKB46cTaJOnjP8+ROFUBNkdtvZD
         Gjnjk15CDZeMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1D8BF60794;
        Tue, 18 Jan 2022 04:53:01 +0000 (UTC)
Subject: Re: [GIT PULL] slab for 5.17 - part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <06e9cd6c-320c-af1a-ef12-55e2e8c13f17@suse.cz>
References: <06e9cd6c-320c-af1a-ef12-55e2e8c13f17@suse.cz>
X-PR-Tracked-List-Id: <patches.lists.linux.dev>
X-PR-Tracked-Message-Id: <06e9cd6c-320c-af1a-ef12-55e2e8c13f17@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.17-part2
X-PR-Tracked-Commit-Id: 07f910f9b7295b6a28b337fedb56e612684c5659
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3a8b6a1e70c37702054ae3c7c07ed828435d8ee
Message-Id: <164248158171.2547.15960320680018270653.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jan 2022 04:53:01 +0000
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Jan 2022 16:33:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.17-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3a8b6a1e70c37702054ae3c7c07ed828435d8ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
