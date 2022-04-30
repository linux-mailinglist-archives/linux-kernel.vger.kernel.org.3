Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677BA515F8F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 19:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383263AbiD3RbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 13:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383230AbiD3RbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:31:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE33229C88
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 10:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DBC361028
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 17:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E795DC385AF;
        Sat, 30 Apr 2022 17:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651339665;
        bh=QVj+ZyIg2OCwyZlnYKHy19CLDR7MS0k5UOEqjiV5I7I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pby8Fclf/Tfx1ITvMifc5nU3xw+s+W+7Uo0CCgaGf4+bJQDys69p8LqPWY9baBBe4
         bV6kguw9taKtYnvXqM9ry58Y7aexS8VODJy9KIB7TtWyGwaxdR4jvCJ9Hla/G2UhFy
         xxEDMyR1bBULI6whBkDFqEFQr2VVDfNNGdYQV/u+dDlXUPPbN/dMUaNSqzSMGZeKBi
         c23kjWuF9OitJhTHRGV7GkSnlsMZQagqE4Id+mbR71sJCDNFQCo7qsj0iNLW5w/6M2
         KoNT4zVCm7FY2EsI1lMmpemC1ajEEYAGEw22xOmbKinN7J+6OEbdPyP2RTphwb8neP
         0Jn9GJVsFyiHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1537F03841;
        Sat, 30 Apr 2022 17:27:45 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes 5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ym1bjfINnY89BvKQ@kroah.com>
References: <Ym1bjfINnY89BvKQ@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ym1bjfINnY89BvKQ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.18-rc5
X-PR-Tracked-Commit-Id: fda05730f62b9a53e7d415f5c607942afbdc1fd9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2e5ebecca69a5a692cbd0728cb7f4abd25f48ac
Message-Id: <165133966585.20469.14709356848940339685.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Apr 2022 17:27:45 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Apr 2022 17:53:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2e5ebecca69a5a692cbd0728cb7f4abd25f48ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
