Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D8D489F37
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240166AbiAJS2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbiAJS15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:27:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100EEC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:27:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A488F6133A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19DF6C36AF5;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839276;
        bh=/SfxSYSdcLyDlZVJQ9qzUmlp0ZiEwwUBK/ldZZmXow4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VAwG80JttPQr0oOFHfH1M4kKYKokAQjuQmh8x6TvsG5+fXdld7oxOAgJpxizOjEpN
         FQ4idl/NeWIKQIGA6qaIyPW9oE9Oje+m+wOq1O9PHaouCnuIws7pYyBbOlzDa92F3v
         boTZHJkneAkBmB6UIszmkR/vZpng0q04nh7zjtUSLu5OzazI/uLWskPMMx+TQI6zsj
         Ie62K/ANvgaMUDQPuCa9fbShNVbQXWZ/fJXnMWP8kW7t+hUuPAuIePyJiS8RYYwMhM
         yZ6dFjtN0YFbZFEJHSzRDnUBtExf6dxRGZT5J9iJtZwPBA/BuG+pj6gMWWKTdMIXoM
         4ikB0PsBmDZTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 054CFF6078F;
        Mon, 10 Jan 2022 18:27:56 +0000 (UTC)
Subject: Re: [GIT PULL] x86/paravirt for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YdwIQXX4xbfkeOT7@zn.tnic>
References: <YdwIQXX4xbfkeOT7@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YdwIQXX4xbfkeOT7@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v5.17_rc1
X-PR-Tracked-Commit-Id: 6da5175dbe1c2f02f1301b6d987e3ce24742bfd4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e59451fd3bfa263c775c7dffb7c3df9a787c97bb
Message-Id: <164183927601.9673.6625210413062118779.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 18:27:56 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 11:19:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v5.17_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e59451fd3bfa263c775c7dffb7c3df9a787c97bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
