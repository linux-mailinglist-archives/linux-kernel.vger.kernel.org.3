Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A932848CFC8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 01:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiAMApz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 19:45:55 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36390 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiAMApg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 19:45:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A09A1B82013
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 00:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A134C36AEC;
        Thu, 13 Jan 2022 00:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642034734;
        bh=gcOMIMsgsdc6MwbbSlMEvn4G7eGCnxFCe8qfPqtn09A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qk6UhsMGbyNydOKXXl5uoOueBvjr+72DX3C8K5NCcXFswfqMb6e+epEwsdshy++eX
         uqucIAyW3jb63YbaY3KzrjqiaVJ4UjqWaxou8RuVYZMcBC/Hwb47faeAgEeKWZ1jtT
         /Hnf1dF4diit/2X8rP9J36a/vQ/BR2VC4e3ZjMiNZzzkQwb/O1u3PBZeyxpFbj20zA
         u2N4RwUW+tREge0EPwzsr3pWQBpsxJR93SNjwk1EU7+oMOvnsaAlClUwotTCGKf3GW
         crOvAiNGwikzeuUSn587JZBjV7e4SHJ0D2r3bP3JSkumHLMhByMYn5GRl57G/jSC8w
         42AChGS21+heg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4561FF60794;
        Thu, 13 Jan 2022 00:45:34 +0000 (UTC)
Subject: Re: [GIT PULL] perf/core for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd2+Wqrl0ax2JQjg@zn.tnic>
References: <Yd2+Wqrl0ax2JQjg@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd2+Wqrl0ax2JQjg@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_core_for_v5.17_rc1
X-PR-Tracked-Commit-Id: a9f4a6e92b3b319296fb078da2615f618f6cd80c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e5b0adeea19309c8ce0e3c9119061554973efa9
Message-Id: <164203473427.19726.7152501825175488504.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jan 2022 00:45:34 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 18:28:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_core_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e5b0adeea19309c8ce0e3c9119061554973efa9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
