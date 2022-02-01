Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620374A6649
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242467AbiBAUqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242436AbiBAUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:46:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EDBC061714;
        Tue,  1 Feb 2022 12:46:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5984E6171A;
        Tue,  1 Feb 2022 20:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0FB6C340EC;
        Tue,  1 Feb 2022 20:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643748367;
        bh=d694+S+zU8Ju8hGyDp0AnAAskyS+mgJFrkFrml9f3YQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M6DFTye46tP+3Y4A7UW8+Tqe5308ssaL7weZp91A4ttk7Ah+nVo/p8kc4dfa3vI29
         J9doBIfVpH3/+oPTdtQO1CP0n9C14z5NjbCPwSs0f9o0f6BY7IprCyRahTHKe4hicv
         A4SG4hdLwn5F/Wqn3I0Q3qzbD0S3p454b7zqyL8j/D5bZA5RUKNhzPfiP9eqCS6zi6
         Ql7N4i3VNqeS43IU00EDHyPYvD2OqU2T6QlJqIDxeEdbv1GHOpe5FTwzFPgtPVWjGr
         o88u2ddX8P0tTCtHb5I4A0Hq43sKaa9Gscg/KNBFBQ3P7F8MY6YRnrkMahRT4WHnf0
         jGtiXpsKQWuzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACCB6E5D07D;
        Tue,  1 Feb 2022 20:46:07 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.17-2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <37770642-bdab-bf37-c5c5-5c3edf9ad4a4@redhat.com>
References: <37770642-bdab-bf37-c5c5-5c3edf9ad4a4@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <37770642-bdab-bf37-c5c5-5c3edf9ad4a4@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.17-2
X-PR-Tracked-Commit-Id: 836f35f79153ce09d813c83f341dba4481996966
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83c2713a6754815c4f533097914a8d4fbe85dcf1
Message-Id: <164374836770.6282.945237551428224373.pr-tracker-bot@kernel.org>
Date:   Tue, 01 Feb 2022 20:46:07 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 1 Feb 2022 16:45:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83c2713a6754815c4f533097914a8d4fbe85dcf1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
