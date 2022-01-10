Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1511D489F38
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbiAJS2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39298 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241563AbiAJS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:27:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C57361366
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41294C36AF8;
        Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839277;
        bh=aqvUW5VqtUzdYz6mbpc6bmJcH56TsmhG9AfQG1n//9g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t3/FLkgjdNqT1Xby+ENltjAiLb3l2oOV+q4hbvy8Dt7NcvkdYrvrvkbq/IbRXk49W
         k+Hn4dmNRYUbpag2ZTR3avqV7xuL3eGXxY+wphR787o5KMzCXkFpJQJykTLr3ZA+A7
         Wensjm9Hlfdy01pDOmfEVgxcPZk3cd3JmfBCcofjBrb52RZNmhx3ZTOdtf/RySpHrO
         MhPlQX/ktoNOZqeSwjNVXu0QgyNyn5QFNFfpmG3eQXwkSCEX4bMIc2tS6Uf6AcORJR
         XfuN3hLbbi9YIxDnLTf8eGBcTiSK2JQcFzEFOFZhFXVJUh/I5t1C6RFIqSYRUu9A4g
         /VP3LDcuX3wjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DCF4F6078F;
        Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwWZeajNhOasI3U@zn.tnic>
References: <YdwWZeajNhOasI3U@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwWZeajNhOasI3U@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 5fe392ff9d1f7254a1fbb3f72d9893088e4d23eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c6d4056663dad0ea0b87b21fe98415b9dbcdd5b
Message-Id: <164183927718.9673.168102402154451981.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:57 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 12:20:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c6d4056663dad0ea0b87b21fe98415b9dbcdd5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
