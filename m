Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8BD5045CC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 02:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiDQAOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 20:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiDQAOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 20:14:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C13553E21
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 17:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC8A661046
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 00:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4792BC385A3;
        Sun, 17 Apr 2022 00:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650154323;
        bh=Xs1FUV2SeNB/pwiT2MC0qOCGySDQHFM0g3iHtg3NBt4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BTevM3SSDrlpmInZIu0geb1ALwW76hq+aYMODyfazk5SZ9XK9GU9QqL9Sg7MkBNbb
         M2s1+/cDGn1v5IOzEuq5xqw955T2eFhaJsrwpbPQDph/zVj53AX4CKFZHwT+MT0uaO
         kNiDZn3JM/Suy3ZvHqO+0K9mYA5mp7CbhX4qFcZ9DsAJvJ3pq1HSxDpzpKNAmYb+e6
         PJMs6g/n006ITVsffcN53q4HNSaVYYhHpQGcWySeZJUQ0L+anb3yFfTUpA6T35uAUP
         MGHY4HjDG6zrof1I0UXv/xYIjbKA8153iTyDGjby+O8ERadafKxIqCB/SRqSsJuTw9
         ji/FHBR+qflOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3401CE8DD67;
        Sun, 17 Apr 2022 00:12:03 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220416131318.80278-1-Jason@zx2c4.com>
References: <20220416131318.80278-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220416131318.80278-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc3-for-linus
X-PR-Tracked-Commit-Id: 35a33ff3807d3adb9daaf937f5bca002ffa9f84e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92edbe32e3822f7b66e471c7e0bd5ee5d63bf4b8
Message-Id: <165015432320.20129.10453685302413958110.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Apr 2022 00:12:03 +0000
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

The pull request you sent on Sat, 16 Apr 2022 15:13:18 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc3-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92edbe32e3822f7b66e471c7e0bd5ee5d63bf4b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
