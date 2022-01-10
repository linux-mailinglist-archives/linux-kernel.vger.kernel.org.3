Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5456848A0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343646AbiAJUWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:22:43 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33258 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343660AbiAJUWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:22:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A6BEB817DD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 20:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB65DC36AE3;
        Mon, 10 Jan 2022 20:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641846158;
        bh=ropD2mwf54OV0yD8/ZeMyJB4RFBxPieFWxq8zmXiVbU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XDIWX37Kg4k89AyMzfPwGx0v5k6OtflOT/PnCsZZ0OaXaYjEOM1JVPPADtuT+hWCe
         okvaD62FB8xWJT1Aqk8+DSMDw15hfo7JDJE+OkDUcj7ep+PEWbq2iP2S8EUFYbGO7d
         SJTmVOoWaDF+DELV7PdhgnNAA8pW/hK3ohfbAKJoDHBC5bG0AEqa9mz19DMN1BWr5G
         mnLfUb+MrmSszpGcFOOv/F+DES15OewEHlRQGh+2EesEdHKnFH+F812fy1s/Hp4kf6
         3MO7icE+C0w5s9ZSnlrAfzkL90Vwwzd8eKOxY/nk5EpXqShrLQVYpGZ3GJ5dEgf6P8
         e7oonMU7sYRfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCA55F6078B;
        Mon, 10 Jan 2022 20:22:38 +0000 (UTC)
Subject: Re: [GIT PULL] pstore update for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202201050912.9C8AA2AD6@keescook>
References: <202201050912.9C8AA2AD6@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202201050912.9C8AA2AD6@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.17-rc1
X-PR-Tracked-Commit-Id: a5d05b07961a2df47d3b4aae3bdae61ac095a43c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 404dbad38248fc07b721f4201318418ce94fcb02
Message-Id: <164184615876.11936.6644921407621221537.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jan 2022 20:22:38 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 Jan 2022 09:12:52 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/404dbad38248fc07b721f4201318418ce94fcb02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
