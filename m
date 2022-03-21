Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51F14E343B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiCUXZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbiCUXZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2C73EE953
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 16:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E3AE614DD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 23:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBD75C340E8;
        Mon, 21 Mar 2022 23:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647904724;
        bh=m6KXw5cu77fFqjUg3xueUjK3R+aggc9DbsO4Dz7YKb0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q4wV+FLcxwwhxknK0UYjreaH6ViQl1NTjnslX3GCck+FSVyWbSQae/J9/GcH1ac0/
         jvoJFI0dVEN0IGxNv9N/1rKatv3PXFKLn1TWa5MVkbsegy6TeBpwX2nmWkwS4c4hkM
         DtlYz5xDGeXBHf8pNZn1dhW6NaB5cLx7E+5n9GHYyDsw0BEQyTcDakQye+vlidRXx2
         4wvVlSeYUXkZZRtdo2DK3ctQirjbj7JH8WBfHri8NLab3VpyBuX6nYwaO9b+KfQShm
         uvvVG1WYFRZMW8oYMdMXcnxRprB/XzX9ihwK9LgIDHXHXOF6FlEh0Q28XBliYHdPMx
         LmbhokFNP56cA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9BABE7BB0B;
        Mon, 21 Mar 2022 23:18:44 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator updates for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220317232804.931702-1-Jason@zx2c4.com>
References: <20220317232804.931702-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220317232804.931702-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc1-for-linus
X-PR-Tracked-Commit-Id: 3e504d2026eb6c8762cd6040ae57db166516824a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5628b8de1228436d47491c662dc521bc138a3d43
Message-Id: <164790472475.24500.3192057522006290577.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 23:18:44 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Mar 2022 17:28:04 -0600:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5628b8de1228436d47491c662dc521bc138a3d43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
