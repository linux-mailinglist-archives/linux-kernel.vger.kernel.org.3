Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE52D588605
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 05:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiHCDXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 23:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiHCDXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 23:23:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1A34F65E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 20:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8103AB8217D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 03:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 192F1C433D6;
        Wed,  3 Aug 2022 03:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659497001;
        bh=aBxz+mPwEvkI5IYUK5AkYJAlEP2h3X0pWxjugwUQFUM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NQULG0c/HxSPcRhXdWTM41f25JUcaZ3Za5xY26KrsTFPcOoPER4lNrDS23yO9zHha
         5LL466m/Gz/AVk0uhb+Sb2WUCWUuL+DNBrP8EqHFYpO3yBRpfxudA/xgzRwJq87jEn
         3AM3SnsT9CCxOatGjXxI1Y1ntemEZeYwdIFf8z2/NolLWF8s+Z0Xt/svxwLH9buvSA
         N3jjrdwPjK9rlesGPqaj9FZquXIgRKACo3v3YQBPDAD+yVUQEINtR5VHb+oa5U/ZK5
         YSVXcFp6E6vDuU8lQAWszi5lmG0ZsTJ8TIohWimtKuDtFMsBujh42iEQWJDlRctUQ+
         WmZfstMQUBfkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07B30C43142;
        Wed,  3 Aug 2022 03:23:21 +0000 (UTC)
Subject: Re: [GIT PULL] nolibc changes for v5.20 (or whatever)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220731165756.GA3034113@paulmck-ThinkPad-P17-Gen-1>
References: <20220731165756.GA3034113@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220731165756.GA3034113@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2022.07.27a
X-PR-Tracked-Commit-Id: 4f8126f3a665456b68ae923cd7a7e9b9eb98547d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b069122256e45216b5c49d9441f9713991a4c645
Message-Id: <165949700101.31205.5698342320316700317.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 03:23:21 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, w@1wt.eu, alviro.iskandar@gnuweeb.org,
        ammarfaizi2@gnuweeb.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Jul 2022 09:57:56 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2022.07.27a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b069122256e45216b5c49d9441f9713991a4c645

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
