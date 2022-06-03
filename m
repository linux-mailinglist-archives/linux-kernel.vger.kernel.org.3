Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939F253D1C5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 20:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347978AbiFCSu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 14:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349234AbiFCSuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F1E286F2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 11:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3846619C8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34A77C36AE3;
        Fri,  3 Jun 2022 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654282218;
        bh=mFi11WzvRUDrhTxmLoXAsjPwlv4dTuzd1ZnWn6wBUUw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V/YYiWshOhUaoNs4jFxrTTKM08ZS3d6PS8+7R3sx16c+7PRDPpc9lm7KNK5bVY6mS
         dSdi1V/rUGJUrQhV99f/M0E7hZ2hEArax9auH1zT2TkR25Ht3vBvxWdw19UcTYuuFq
         EYfPPBC0IXe5ZSgipCHIYgnpEipsDVl+LMILN35px16tT7gL4IYJq0lzea8YQiHAbE
         UX15nTdWUcuu+4ah325NUPjhhKrHlxxZDxyCUw2RAQB5H1jZvzwO6DgNBZQdTmrLBu
         mk//W40Fq+h5mVFsl2JdMR8csCYZNxj8FrpZr3Ijcx6YQztzDF1ZTVZfbj12W4FM1t
         /ql+URYh6hn/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22545F0394E;
        Fri,  3 Jun 2022 18:50:18 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver updates for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ypng29bf0vGJ20fo@kroah.com>
References: <Ypng29bf0vGJ20fo@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <Ypng29bf0vGJ20fo@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.19-rc1
X-PR-Tracked-Commit-Id: 6a31a95135da0bb2c5349e49e37d76e9909ab7ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ad680f083ec360e0991c453e18a38ed9ae500d7
Message-Id: <165428221813.10974.3090032157881018828.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 18:50:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 12:22:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ad680f083ec360e0991c453e18a38ed9ae500d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
