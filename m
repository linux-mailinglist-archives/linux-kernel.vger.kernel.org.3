Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC63859EDCA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiHWUuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbiHWUuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79435B7C6;
        Tue, 23 Aug 2022 13:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15FE661367;
        Tue, 23 Aug 2022 20:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F75FC433C1;
        Tue, 23 Aug 2022 20:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661287615;
        bh=n5lGmHZUYCv1fhCs4j0Wp3FfE6pNWgHeIYjKIYnalJc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R4nTMEm7D5/75eSQvZECfFyMe9xi9Zfw8dyBu1MGFunyxTbHZYRrCnB9MXTGZexkb
         Tr+UEFnoThNHreTzY8i2Lu3EFrE8/0gtHHQvtmu330yOV2grD1hzjkljoZEB/87Z3w
         beA3K3+Mi8Q8pAGeKAbxc00KLSN+XQAql805GXift47Jw8Ws9uv9b6Vuqz+Ag2o9CZ
         ZE6bWfZ/gnYaJEkhhC0BlKDy+JJy+4JhdOyZQ3og9CFJxdcPPWZ83HWFtpm1lWmQ7G
         RsHgxCLjubbDEicM7FRv7NjGfLPRBq5/GGvaqjz5RFlzMiCEExVBHOpLEg1A7I1fBw
         XjHHhbrx4RGBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55854C004EF;
        Tue, 23 Aug 2022 20:46:55 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes and updates for v6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YwTsX8zR7x09qWP5@p100>
References: <YwTsX8zR7x09qWP5@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YwTsX8zR7x09qWP5@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.0-2
X-PR-Tracked-Commit-Id: 591d2108f3abc4db9f9073cae37cf3591fd250d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df0219d11b6f04251d38e345db4f9780cb32e2e2
Message-Id: <166128761533.16096.13588636352366104779.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Aug 2022 20:46:55 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 23 Aug 2022 17:03:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df0219d11b6f04251d38e345db4f9780cb32e2e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
