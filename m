Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24B348BBB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiALAOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:14:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36388 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347332AbiALANr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:13:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36D1461637;
        Wed, 12 Jan 2022 00:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0DCCC36AF6;
        Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641946426;
        bh=idPmRD3vDDYJQLa+CtrngNkb7v8wUZgsDGQVv7fun7k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aneDntADCU5oIm9Jz1ER/J6n1xyBRq1rCQONjwpg2Q5+B8yvhb1ubo9bJXYXsSlef
         cGAj0W8ph3ESxJsNGnplfDptD32eoiK++DPW5yRZ+iMg4nkQMuQjUX6X0AMr4Kk8UZ
         XtE780HVPAQImoG+25JitnPUCi2aM24YU3mT/2v6PsP3VWWaPlqpkq923zbYwEb2Rp
         Vn/njv2VtP44VTcYnGj8zMzSvrgR2bDfe0bm2REC2luGQxkCGvrtXZPCtkKp7JULTe
         P22/0/KH4Y2TgD1kS9XQQlG41AruydSoQ1l0nroh6sJyAw6/HlLdr9EQMQ1etLpbmA
         vPLXyq9s1aXkw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C76BF60793;
        Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture updates v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd1up5g3mSzj7eHL@ls3530>
References: <Yd1up5g3mSzj7eHL@ls3530>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd1up5g3mSzj7eHL@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.17/parisc-1
X-PR-Tracked-Commit-Id: 68d247ad38b1ef46bd945a5220fa6d28c901c2f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1eb8f6cff3442b0b7eff5b801c9745ea9abcb14
Message-Id: <164194642657.21161.3159844271949198469.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 00:13:46 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 12:48:55 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.17/parisc-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1eb8f6cff3442b0b7eff5b801c9745ea9abcb14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
