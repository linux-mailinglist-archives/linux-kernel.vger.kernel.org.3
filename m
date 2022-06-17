Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A249654F9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383008AbiFQPAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382496AbiFQPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:00:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41E53B2B8;
        Fri, 17 Jun 2022 08:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EB8CB82AD6;
        Fri, 17 Jun 2022 15:00:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20BDFC3411F;
        Fri, 17 Jun 2022 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655478008;
        bh=3pQwhwyI6zl/coQSK+xeVJzTkchUvTT4bvZNKDUptbM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BzCwH5EEa7ch6HGklcjY+CLvTSefM0OEjeXKPMb98hp75TbZBTAO3DiMDzynhGhMp
         SqpHQJaaFrrVkfe84Cs8vOgwdGLwT19TDrhkuKXifak07vwscTuPLdhItF+EdtGCsE
         Ld7hzx/0FqRhNWapHz9GRrLye1BE6id3xclsOGNuXNdviGNJiYWgef3rIMei5+Alw4
         rL+5Mtde2Wja29cP4EECOWPQ9F3W9uq9QO7Ue4v84yD+nLICId1+deOJcpmysIsFAj
         frS8ZIgzPkSjwnMDz76pq6GgdB1AlsMmFn1rLJYUS3lFxR2F2pyML+8kFyqGnkxSzp
         EuqlRW6DqqJ6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09EB8E56ADF;
        Fri, 17 Jun 2022 15:00:08 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yqw4AJGmhTSfzc97@kroah.com>
References: <Yqw4AJGmhTSfzc97@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yqw4AJGmhTSfzc97@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.19-rc3
X-PR-Tracked-Commit-Id: be03b0651ffd8bab69dfd574c6818b446c0753ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62dcd5e198af3b511f3abfd0380a4d71b21b5f6b
Message-Id: <165547800803.17120.8460288992791908391.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 15:00:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 10:14:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62dcd5e198af3b511f3abfd0380a4d71b21b5f6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
