Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164B451089B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354161AbiDZTLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353059AbiDZTKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:10:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33B135AAA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:07:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64520B82253
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 19:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 31259C385AD;
        Tue, 26 Apr 2022 19:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651000020;
        bh=kObyFg5hqvKcgEp4TNR0jQenTsKW9rpFViwem5oqKAE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GhmcsUCJJSmNnJIJ1yODCliU2n6u3d7BloDpb9+5q8g+dh/3i2CRj/O2urYrOKAa3
         pJf9ofUKYJvryZ1T4Q+9dyKBpOKwKETzX6tkqzFqF6lVLIkZbvZft5sKx8fp0p8t57
         cWl000E4npIDDJbeUaqot6v1ckw7vA1w9ds4cLAc6+KOXAORf5rlcRct3iOasKkaHZ
         ZAhpvZ8LXl0+tL2XZ+HYEcy4fE4/Mu7gg/zp8BHD+nryFxLT4jcBWxYsnmYWSC1rEx
         XXRf3WZlvs7uhucCLJ9mvTXa28g//ILsQksDdP8DXz/5vcjHNeSZOh+l0wIsLbs1ga
         WxPQbz6y38uJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C661F67CA0;
        Tue, 26 Apr 2022 19:07:00 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220426145445.2282274-1-agruenba@redhat.com>
References: <20220426145445.2282274-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220426145445.2282274-1-agruenba@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.18-rc4-fix
X-PR-Tracked-Commit-Id: e57f9af73d6b0ffb5f1aeaf6cec9a751dd8535c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fad37d595b9d9a2996467d780cb2e7a1b08b2c0
Message-Id: <165100002011.21339.8081509732129826179.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Apr 2022 19:07:00 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Apr 2022 16:54:45 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.18-rc4-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fad37d595b9d9a2996467d780cb2e7a1b08b2c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
