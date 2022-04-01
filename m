Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553BC4EFC4F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353093AbiDAVrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347353AbiDAVrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:47:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BC410F6C2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:45:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 903B8619FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 21:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0145EC2BBE4;
        Fri,  1 Apr 2022 21:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648849515;
        bh=3vqyyWlbH+Fr/9V6j6Bk7EtgRXAUrFky3OTgXIvZOoo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VpBKMHJqDUPRTDgPJHi4oLVFPix+3A438vUJs3MjayOTpSJS1oAUgThp7wM1NP5k8
         dtgoxBLeaq8DHqhWFYqyzsgBSxnQ3++vxdHNC9bpi2/gQwVs7R43Ol4Bm43+JmZQmV
         gv8+ymhquWE52scLxsj+9YFA6ZW09xM78yR17iVbLpkhvxHbtap76QIRIGOaAb85oO
         WNHGYKlVC2IxBEL34PbMNQESUZyR72xrvJ6FoWuJH/J1MKaA4SZbX8IMu1+/NWWTCO
         wPYx0ROicHJFfviS6gAMJN7tCuMWZBy31Yevq5eio5a9Cs7Y/TXlyP1YgaDwKidcvy
         oCyPoCPJ3DO2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7DC8E6BBCA;
        Fri,  1 Apr 2022 21:45:14 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd8ZoLh9tAaoXjhRk=8o4Q=-S=puQG04Wsr9p=hg9r9x6Q@mail.gmail.com>
References: <CAKYAXd8ZoLh9tAaoXjhRk=8o4Q=-S=puQG04Wsr9p=hg9r9x6Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd8ZoLh9tAaoXjhRk=8o4Q=-S=puQG04Wsr9p=hg9r9x6Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.18-rc1
X-PR-Tracked-Commit-Id: a4a3d8c52d952ab1f5c8b8b67b57f2e01936628d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec251f3e1851380f3e177e1559fc497843947e35
Message-Id: <164884951487.9554.9682810802831933134.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 21:45:14 +0000
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Apr 2022 22:10:19 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec251f3e1851380f3e177e1559fc497843947e35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
