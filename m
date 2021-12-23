Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B776B47E9B0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 00:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbhLWXqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 18:46:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48376 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbhLWXqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 18:46:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77B07B82243
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 23:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19E59C36AE5;
        Thu, 23 Dec 2021 23:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640303175;
        bh=fB0baz0hhdnMOqq6AXayvb9xQM6n4Uz1f8iPUUexEcQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XTT5A66IEHVXyuclY4To7Iv+h93OjyHCnG9MD3CwsBgZe6tPbR2dLxcfPSyzz87AF
         JdOQgghTtzdolFk58TiXwSdxasS9qcdkj2wF5P9lmRqOlpPZHmFTNBNUKKa6sHZuyw
         msJ/fhogmDH3B+h9xBEsHSRHoNdT9XuZ34Vbm76IFj0rpT4d43VWF6tTRE+dam5MeJ
         hb5dD5zKN4t5be5Y92e0wEgUCEz4RY9QLPPTPFtBsZtCBeZ2DX6/YZVs7/zf+ZgFHW
         iVbcMWxYBHVZf29Qi8DUp7oHEIEa3yAADO0/2oV7W8ftjyNgRzedwHW+28exA3Klga
         uQM8f9ORcBeXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0790DEAC06C;
        Thu, 23 Dec 2021 23:46:15 +0000 (UTC)
Subject: Re: [GIT PULL] ucount fix for v5.16-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o857t7m2.fsf@email.froward.int.ebiederm.org>
References: <87o857t7m2.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <containers.lists.linux.dev>
X-PR-Tracked-Message-Id: <87o857t7m2.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-fixes-for-v5.16
X-PR-Tracked-Commit-Id: 59ec71575ab440cd5ca0aa53b2a2985b3639fad4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fe2bc1b64650fa6e3a7088786a983766676fd84
Message-Id: <164030317502.13743.5040365301434724454.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Dec 2021 23:46:15 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Dec 2021 13:59:49 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-rlimit-fixes-for-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fe2bc1b64650fa6e3a7088786a983766676fd84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
