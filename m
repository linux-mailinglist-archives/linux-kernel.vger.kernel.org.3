Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C494BD11C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 20:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244733AbiBTTud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 14:50:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244709AbiBTTuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 14:50:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C460CDEDA;
        Sun, 20 Feb 2022 11:50:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B459B80DC1;
        Sun, 20 Feb 2022 19:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FFADC340EB;
        Sun, 20 Feb 2022 19:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645386600;
        bh=RtkN4hEZYUr99jyhCOsuLVZBaK4ovMgpq9Ft7HlRggg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K+QEFY/OTlE3MOPieJxEDtYxaJ1XP1wP4zOca4DXZfLxfcHd3EnR1r6NkTGkEEiSa
         PqJ5iEVn1oXqHL5llqVlhL4DZ5djpErhnjd05EsboVJxjUQSvzYGnOIXuygkZyQ5vV
         oI/9SyvMm7TUnVCq0AqwS02K4tB6KXhrSz4+zFp7ciD4GseTfs3RWUQfcX8IlIWSFh
         PT6Ua/o2jecIsrH4B9inr8Wk+kMHn7jYBj8LQ632yLUA2R7sO0vQACwWpSapa5Mitn
         FMm5JfwwI/N4DtcMW46gQOH6UNusThpe4+1D3zIWau4Re3CkDdCbCuZn8jr4J7OAFD
         wdzQuc9ZQydIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E784E6D447;
        Sun, 20 Feb 2022 19:50:00 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 5.17-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220219015926.nsaz76djtc3d7sfa@mercury.elektranox.org>
References: <20220219015926.nsaz76djtc3d7sfa@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220219015926.nsaz76djtc3d7sfa@mercury.elektranox.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.17-rc
X-PR-Tracked-Commit-Id: f444578d727a0ca4a72b19cd4a1d7da9f1fb99fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 70d2bec7c545e06057c5d963b8623e6e234901e8
Message-Id: <164538660005.12071.9606312258322883456.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Feb 2022 19:50:00 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Feb 2022 02:59:26 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v5.17-rc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/70d2bec7c545e06057c5d963b8623e6e234901e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
