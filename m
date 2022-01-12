Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0829448CBB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344921AbiALTPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357039AbiALTOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:14:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFE5C0254AF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:12:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78429B8208F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 19:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C7D9C36AEA;
        Wed, 12 Jan 2022 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642014728;
        bh=CDo7uly22Fc1kgATpN7dPjU3sEevu035m4wPXRN1K7M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UpUQATtvFF4gJeXe/RJbuFo2Ych1qwN0JZtTYiKAObF5p5CVsCrG96Fxk91rg6xo5
         HqVQk6TIvVYQwg5jPA+a6RD1fr7h5ur068zSG5cIqHHxtb7oeV15uace9KO3j18uzL
         grySlBUxmDPMra8C/hGSpV0jAW4RN53UPCJj9nWFed4C8rh1GZ8E7JS5CO506NDaAI
         iu8ZlnoEM7eKsexqBu31+1yb4UFectdG9haOr7z9Ywf7qqdafHWlLgjLsB9e7YItYR
         1wJH1RnRBfl8oUZW6iCufnNayf7u4RIO5Syz+RqPtD4/jrI2yVIy5H1CLc2dQ6QY6E
         VnTodxnM6p0ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35DE1F6078C;
        Wed, 12 Jan 2022 19:12:08 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ydx+6rmjq2giOC/b@infradead.org>
References: <Ydx+6rmjq2giOC/b@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ydx+6rmjq2giOC/b@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.17
X-PR-Tracked-Commit-Id: f857acfc457ea63fa5b862d77f055665d863acfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e7b69654724c72bd3219b71f58937845dca0b2b
Message-Id: <164201472820.2601.1205408391529229477.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 19:12:08 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 19:46:02 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e7b69654724c72bd3219b71f58937845dca0b2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
