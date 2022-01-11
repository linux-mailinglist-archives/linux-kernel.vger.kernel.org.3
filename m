Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C92048B8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiAKUx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235783AbiAKUxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B25C034001
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:53:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 556FB61729
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B955BC36AF2;
        Tue, 11 Jan 2022 20:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934387;
        bh=9ymIWOuQP+fFbzoeTLgy6vS7hAhBdRD1ciLl9JhWO/U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c6Gx8xNJ6LoCJbDpN5Y4ycLOhGa+aq+JU4+40Qamkt9eZWLyuRgjjekfupUg3M6MD
         72iTIFNELF6KJN7+THdAC38TNohwwm5X925lENR/OGCQF9VA4huKa8eZv8phy4DSky
         2Km7ztVP2n9foKvZ/9pWXlbgVxvdydHTiEYedbHISjPPWl5cj7HBLssbFhhItIWcaL
         r4hfyOFbc+raKQX3RDV6lSrRS8M1tGqOWw2Dsxare2OeNuUPSd4fQ6tqRbdtC9MRKT
         44BUVBvwMJj3J14ejGDdkpqLIylXR/iAcvDZ0VAFfFAymDc2UdQksxmD7Te0DGkHHE
         2xMDwTtz98TjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A396CF6078A;
        Tue, 11 Jan 2022 20:53:07 +0000 (UTC)
Subject: Re: [GIT PULL] HID subsystem for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2201101000520.28059@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2201101000520.28059@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2201101000520.28059@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: cd598d21294e088c3c9e518a7e9098f94ae8cf6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26b88fba2ad9b573b8433926294fe48fbf815deb
Message-Id: <164193438766.11435.3625371980178907741.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:07 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 10:09:59 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26b88fba2ad9b573b8433926294fe48fbf815deb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
