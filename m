Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111854E8A32
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 23:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiC0V0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 17:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiC0V0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 17:26:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88791DEAD
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 14:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41BA7B80D5D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 21:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE875C340ED;
        Sun, 27 Mar 2022 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648416298;
        bh=wn/jD9zvUyw+gJHNl86O+7anNb6OChPyJZokEnNULFY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JVLTuPrjpxkNNEN93AJpJ6TX/A9hIn0rx+B9zl/4bn0+Vl4iOSU0Tu7V38DNCKlSy
         Oipw8whPBBCgs49mRp1+HsIA3FI8DZdxVfweFYuCGnWk9a3xkDWbdydzQrdEjHwQBM
         aBs7ExBu9yigIb7jHWqawSFPnnLanCSW0KIZ9HQBuOyrUEHsHHf4BxdHcLTNU1Lz8s
         YprJhaua8sNHgKjYsyuENK285bT9lDb9qfgTajXpPBRcj8h7WwjypJV74layXPHq3t
         UYg4Id0WM7dwnfvXa6J61XeMNfZLyuOAUbHE6FrmT3tDbTwQf07Fnq/maRat2ONYWn
         cBq/2i/wCIP+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA94CE6BBCA;
        Sun, 27 Mar 2022 21:24:58 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY3JSArf0Tnp3RWN=D9J11KvBpkds6W4tWd8=zq3cj5+5w@mail.gmail.com>
References: <CABb+yY3JSArf0Tnp3RWN=D9J11KvBpkds6W4tWd8=zq3cj5+5w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY3JSArf0Tnp3RWN=D9J11KvBpkds6W4tWd8=zq3cj5+5w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.18
X-PR-Tracked-Commit-Id: 1b0d0f7c12d57763fe27200d0569c863f11d2b8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50d602d81f35621042fa0cdae25808662caffda8
Message-Id: <164841629882.27961.17040701057830374042.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Mar 2022 21:24:58 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Mar 2022 14:07:31 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50d602d81f35621042fa0cdae25808662caffda8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
