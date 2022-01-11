Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C8A48A60C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiAKDG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:06:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37374 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243417AbiAKDGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:06:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55B46B8180E;
        Tue, 11 Jan 2022 03:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06282C36AE5;
        Tue, 11 Jan 2022 03:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641870380;
        bh=Et5aazlokOGYri0UZ0VH3BjwcXHJDDaN0GuoXE1ouEc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XD2rRjsLKG3b4CzkUMZFfA1c2lotptHSVbXaAQDKCIKaxUtii538tN2muAq7vpOVe
         jDtv7PN8fkus9yP5QctcNrpmKTrTcaVVSbIL6VGxGzG+IwP7esEviYjy9dlITWZiUp
         +z5AJzjPj0cgV01LQbPdOp2UcYE2o4d3EMBaCqRk7WsEogaPKfybTgW4dny5+Ct5Fz
         iE/cnpbQVUZW/RLe1RttXy6vfwgYriJ0um3Z/8PZ8EQ6MtSrkbMiIAGiGT/GYlehqd
         stD/lT3WCbHkqkHWmftPXMZ/16Qg9Ouif7FPD1pC9/YzD7sUgzbBs/tww9qxi4OAHA
         vYFN/KRcCQPiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6C5EF6078C;
        Tue, 11 Jan 2022 03:06:19 +0000 (UTC)
Subject: Re: [GIT PULL for v5.17-rc1] New year's media updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220101022920.62f31d16@coco.lan>
References: <20220101022920.62f31d16@coco.lan>
X-PR-Tracked-List-Id: <linux-media.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220101022920.62f31d16@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.17-1
X-PR-Tracked-Commit-Id: 68b9bcc8a534cd11fe55f8bc82f948aae7d81b3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bcbf894b6872216ef61faf17248ec234e3db6bc
Message-Id: <164187037993.10909.9606250087478653304.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 03:06:19 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Jan 2022 02:29:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v5.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bcbf894b6872216ef61faf17248ec234e3db6bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
