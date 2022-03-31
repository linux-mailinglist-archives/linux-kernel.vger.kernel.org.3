Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C104D4EE387
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbiCaV5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242029AbiCaV5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:57:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A233192343
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0249760B61
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B6AEC340ED;
        Thu, 31 Mar 2022 21:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648763727;
        bh=Mj3bVRE/teSyMVdvsyFkwisnLjTi4d+JgRKP+l5l7Io=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CRJrDQyKRatvb1pJkwD3IXbZvmzT6qeQRO/SE7KoEdwHhhTNxyx2QQFVp05OfOZok
         hIC+vi5GTV2uyUQ6w1Tg2Es2IKd+zENXRGQe1sbLtXIvwfLok1jNCSkezTVBnSBq0B
         KpuXCHpsxHn8xq9r5oX8NPKgrYbuxNx1ujyAuB2jpUsVL0dvHaLooKV+V3eRVnUDzn
         mJH15Oa4CHId2q3lKKplMlVZy58KkXsM9zVFI8e7LtaUXmlmUwaYhcPn9+E1biNzM8
         s9/w025X6PQeDO3adbOa+25tMWKyVSoJWXeoiL47xPC5x5QYz1pEHK6NH5iG58mZ6w
         KfKgmQIP6kHBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56E05EAC09B;
        Thu, 31 Mar 2022 21:55:27 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220331212352.182168-1-Jason@zx2c4.com>
References: <20220331212352.182168-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220331212352.182168-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc1-for-linus
X-PR-Tracked-Commit-Id: 1754abb3e7583c570666fa1e1ee5b317e88c89a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 478f74a3d8085076dfcb481aa9361b808a6aae94
Message-Id: <164876372734.13969.12200971032270189655.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Mar 2022 21:55:27 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Mar 2022 17:23:52 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/478f74a3d8085076dfcb481aa9361b808a6aae94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
