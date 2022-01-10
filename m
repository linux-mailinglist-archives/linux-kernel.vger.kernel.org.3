Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB02848A0E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbiAJUWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:22:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33184 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343562AbiAJUWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:22:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6A99B817DD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 20:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6063C36AE9;
        Mon, 10 Jan 2022 20:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641846149;
        bh=fALGNxxBhjgR34mTTNMNbka+hOTECxX3NedWW6ZWeI0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RaeP+wB+zwQB89GzPDzsnGrbGVBQlIxkyNYyuGneVXQ0Eb/SHbz4duhoO+9kyVm+x
         +67F5atxXsJ/6Qs+KIQxfKFRYxhsBezFzpDD28EU9AwzMGmMFH2O1z0cMZLC4n+yfa
         ws7QW5m46rJWCC/vRlOdxS7oVVdVMXFbBSv9S4VMwE7J/A4mtimFRmYdJdcy3UCEK4
         YUkttFxpj8MdD1K89ZMesgitvxqUqdIjmeGoV6pEWujLxY5TjV9Iu09A2mePfyRQ3R
         ftagZLOgji1BV6IMHSu4bJwBDwm+OzWhSGgm3Zb6w7JqSjkrjGTvxpz/UWHGXk6KqT
         gZJUVLNVwmuwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 962DCF6078D;
        Mon, 10 Jan 2022 20:22:29 +0000 (UTC)
Subject: Re: [GIT PULL] slab for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fa6573eb-9d5c-ef49-06b1-157c16efb868@suse.cz>
References: <fa6573eb-9d5c-ef49-06b1-157c16efb868@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <fa6573eb-9d5c-ef49-06b1-157c16efb868@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.17
X-PR-Tracked-Commit-Id: 9d6c59c1c0d62a314a2b46839699b200cccd2d08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca1a46d6f5064c129f7ca6bcfd8f035d69da175c
Message-Id: <164184614960.11936.9494844537308334809.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 20:22:29 +0000
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

The pull request you sent on Fri, 7 Jan 2022 12:08:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca1a46d6f5064c129f7ca6bcfd8f035d69da175c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
