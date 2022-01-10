Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80751489F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242237AbiAJS2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240150AbiAJS16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:27:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC8BC061757
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:27:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E21AB61336
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50EBDC36AFC;
        Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839277;
        bh=X0ichf7pdUdJ7WqJcAuVLsh3Y0VZD9wwYePdNIYtjc4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IPCjqAdQwMJ3OxVepWdvu5JItlwCUsoyrRgvUT3z/3KNVR2zoBkoF7MtcN70DaMyc
         VCYYeXK0vl7Qd22t78H3irS6jU2BOlxj46bD1HN3Uw9FtFuFYq/qw/f+GWakR6PVVO
         2rTcN7zAjTSgX5ZxtwZXHnv/CyNgLtjvO6kGpF+KUs0uqm5vFBoaDHnj26EIJZvFZb
         j9JE+cf5bOwsEmeV31tGKPL9ec1x3YKAjv8YNVaa57ffS+pRZAfcIglNP3D7RLdbSr
         o9O44UjgEuyu3z1q8JAgxzNFFlMiI7B+9MvUHD9hSyvllD6QCjeJYI9y4tNw/AFHmM
         e0i05I+0L0D8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CD26F60791;
        Mon, 10 Jan 2022 18:27:57 +0000 (UTC)
Subject: Re: [GIT PULL] x86/vdso for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwZStOiA4hwQsLg@zn.tnic>
References: <YdwZStOiA4hwQsLg@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwZStOiA4hwQsLg@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vdso_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 9102fa34604159642625f42d7f801f1e04d9ca12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 133d9c53c9dcbb1b8f317e402e79c44d9eb725c9
Message-Id: <164183927724.9673.6815516458427423791.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:57 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 12:32:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vdso_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/133d9c53c9dcbb1b8f317e402e79c44d9eb725c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
