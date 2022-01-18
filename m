Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA278491EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 05:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239811AbiAREx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 23:53:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53202 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239823AbiARExJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 23:53:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 769BA61348
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 04:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9D3AC340E0;
        Tue, 18 Jan 2022 04:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642481587;
        bh=iPxqe1UrOl4JJ+LY+BBuqN5nQ+hF4YAmA2A3UxxbtyE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u8sc1nXiiHXguSIDXtgunAQBhntuTEgZ0wxgphSiZmAaFT4DPflIGl0bC1u5g7JZf
         eMPTkqs5nS1YhBfLo/EauLaWJJF9qWn7wmSTR4cS/6xAyPbVvksHAPTjq7mBMxsESC
         7GIhtuNavbHVmT6GtekJjqHw4KV781qoi55B48Sgf8ukkDUGbXFBkQqahCYHEHKWom
         sNwO+wlbm0hDyG7lNb69owwWoHId7uLRnP58NHcsHD1/9BkE/IhuBWxEwArnr8EN4j
         2nQxKLUdEN8V9cig2u6P3jrAutGBxTKFYkvKrKxKZs3gZIXBw8gQBfEB/QVE4r4Fec
         j7NGI6n4JhsAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE373F60794;
        Tue, 18 Jan 2022 04:53:07 +0000 (UTC)
Subject: Re: [GIT PULL] ARC updates for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4af6c0e7-03a3-702c-f364-b0ebe0f8923a@kernel.org>
References: <4af6c0e7-03a3-702c-f364-b0ebe0f8923a@kernel.org>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <4af6c0e7-03a3-702c-f364-b0ebe0f8923a@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.17-rc1
X-PR-Tracked-Commit-Id: 8f67f65d121cc3bbb4ffaae80e880aeb307d49f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62b488875c0551822ac3b961d04800d4c7a655d9
Message-Id: <164248158783.2547.2561234904707871792.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jan 2022 04:53:07 +0000
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        abrodkin@synopsys.com, Yihao Han <hanyihao@vivo.com>,
        Kees Cook <keescook@chromium.org>, colin.i.king@googlemail.com,
        Colin Ian King <colin.i.king@gmail.com>,
        Vladimir Isaev <isaev@synopsys.com>,
        Randy Dunlap <rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jan 2022 19:27:35 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62b488875c0551822ac3b961d04800d4c7a655d9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
