Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9F65AC014
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiICRhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiICRhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5741652E66;
        Sat,  3 Sep 2022 10:37:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3480860BC8;
        Sat,  3 Sep 2022 17:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99E4EC433B5;
        Sat,  3 Sep 2022 17:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662226627;
        bh=MN1FFiEkkAUlO/7Lg/0+hDQiyYyusdqbEcO+QPGYiTI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XUAXvtyEFMIXi8EzmGZb5j+7svfImmGuBnJ9lwZVEhVINQ7/heAGEQUB97e2MXK7C
         mDTHOuIfvl7fwiwPI7AqmFrKRw70+yelno+xXwEfZ7vbMXplo4WBBSnjheLNv2pte7
         r3fqNnHYVIabkmvDJ+C7eeMJAnL7FUd3ujhpPMMk1z3/JhVbSbaWeJvRSRX8uHcZk1
         rqQJT0fXwpWMTiOADGD3FinR3LlnxVKqkM1XyWpEjFX6A4dkZ2wpUXKKDk04PVPSbv
         TWvVghZLHB7sXHy15ncL4Ge5DDBOWb6G+Ie3M3LT7zR4k39vxw6pHuZK9urU7xbdQm
         vbNKlEOKIJR3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81F47E924D9;
        Sat,  3 Sep 2022 17:37:07 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YxL+77uOsLIXRNfd@kroah.com>
References: <YxL+77uOsLIXRNfd@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YxL+77uOsLIXRNfd@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.0-rc4
X-PR-Tracked-Commit-Id: 902e02ea9385373ce4b142576eef41c642703955
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42cf58c272ee1dae902e8cc1166c246589abd1d8
Message-Id: <166222662752.30432.10893857010878451976.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Sep 2022 17:37:07 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 3 Sep 2022 09:14:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42cf58c272ee1dae902e8cc1166c246589abd1d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
