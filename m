Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F335C531BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiEWTeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiEWTeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:34:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4F1EBEB7;
        Mon, 23 May 2022 12:19:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 732FFB81263;
        Mon, 23 May 2022 19:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30FF1C385A9;
        Mon, 23 May 2022 19:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653333597;
        bh=jRdiJIJJbnDBO2xiOQaCd5Ux9s+qVhU25aEUC79GVTU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GWRM6DHCnXGoZbZi8mFv9bNhAmCkAp4r/hn7nYfs8jtOjMv9NEXsE8VONJQaxGpR6
         H7Kz5lLyIk3Lsti1g0vpEcZEGg/oIWGMBTJz5Aha0Y/HomJWGUvKJpHnmV1dj7dgtn
         1qaS+6W23zcUDyhkQHb3AS+lxgFZutqLUBloU9qpxVN2VdfmKPBZMGzHFQ+hIyO43t
         K6IDA7VcWbbQ9bjjbA3KC6ER1mqxKg7Qu6WRdKs17Dk1t3xMmcKxj7DKkpeSUVnlgl
         JbR56gKlQMtIKy4aIs7Pie6DiWMeCMrJK6ecRqAkxuvmshK8F8XsTi24qkM0i+Kicv
         aMi186tYDJDuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FCBDF03935;
        Mon, 23 May 2022 19:19:57 +0000 (UTC)
Subject: Re: [GIT PULL] RCU changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220520180634.GA3788910@paulmck-ThinkPad-P17-Gen-1>
References: <20220520180634.GA3788910@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <rcu.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220520180634.GA3788910@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2022.05.19a
X-PR-Tracked-Commit-Id: ce13389053a347aa9f8ffbfda2238352536e15c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e57930e9f4083ad5854ab6eadffe790a8167fb4
Message-Id: <165333359712.1924.7650600521502516459.pr-tracker-bot@kernel.org>
Date:   Mon, 23 May 2022 19:19:57 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 May 2022 11:06:34 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2022.05.19a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e57930e9f4083ad5854ab6eadffe790a8167fb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
