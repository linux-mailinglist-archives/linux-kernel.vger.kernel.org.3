Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731B8480CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 21:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhL1ULD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 15:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhL1ULC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 15:11:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F1AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 12:11:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A63EB811E3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 20:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA191C36AE9;
        Tue, 28 Dec 2021 20:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640722259;
        bh=oaNLl9LgH1XIQGV1DN/UwV0AaYorgAiyRQ4eF5Zbto4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jSsDD7Cl2F6fzck324WjyH3W42v6k7A+7opTQylZjml7e8pmZoMaKiDZOwQZ379jc
         M1VL6xp9TCXaKZegKvorDVWPFGVxHV6cFnB9S2gPbWQGSBrlU5kEC4IFbxkQq7jGtY
         mu23/OtelIxZyigP/3WdsKfqDk7Si0DSzyxXir25YHBWHsBFx450tNC5GS21M7c5kH
         YvWvO6C71LenRvkkLmZu7y+iRodgBY23PaNIZ7cK0TEs+AONvY0BCCQnGG59+RXS1+
         HIXG2YHT5wASKBsQns9tLJt9rU0La6B+iLtrWJpq5dGJqYnQeFhkvvBcYBOC5KoRIU
         0bAEi+wHUIoZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B93BBC004F1;
        Tue, 28 Dec 2021 20:10:59 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.16-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87v8z90y7t.fsf@mpe.ellerman.id.au>
References: <87v8z90y7t.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87v8z90y7t.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-5
X-PR-Tracked-Commit-Id: 8d84fca4375e3c35dadc16b8c7eee6821b2a575c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f651faaaba5f41ffac195e64f58483721e60eafc
Message-Id: <164072225974.9016.13251867159989276042.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Dec 2021 20:10:59 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 28 Dec 2021 22:23:50 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f651faaaba5f41ffac195e64f58483721e60eafc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
