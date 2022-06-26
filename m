Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D4E55B334
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 19:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiFZRgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 13:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiFZRgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 13:36:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A95EE0A2;
        Sun, 26 Jun 2022 10:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC88FB8018A;
        Sun, 26 Jun 2022 17:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94E44C341C7;
        Sun, 26 Jun 2022 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656264972;
        bh=Sqxv/eGHah0+udl+9WRPbs+su5IX+iDFmjRUAidCBww=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jRPdJf8Zo5LaR+3Sj0XUSpo7UsJhNOwXUALkVTy3iJNyHllvsxMKESMysob/Giogy
         hP/ZCY98N4hLfrScDJi9zHR+7KeRF0x0hFhwr+rSQtYGMmrHKy74A0kDrJJD8DpNiu
         PmuDxZSwnU7xEWyXXF6Y0Enwk4myO398jNp/gzTaWhUCEnmy7yD3RqJOWem9cmXxFm
         P1MnlmAhuH1UuQpBmK7OCKga8373uhaUxy4mBYiLSjhgNE4fnL73Nsdg2ADz7KLURG
         2bwVRoQPTIU/hUlPUQ9SyU9HffO3YNtewXij74V+C3XY5EC3HdRG7iE+2UFpd1P6Ro
         MTj0oo7e0mc4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81E96FD99FF;
        Sun, 26 Jun 2022 17:36:12 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture updates for v5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yrhv/Z0vCzSX/kK3@p100>
References: <Yrhv/Z0vCzSX/kK3@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yrhv/Z0vCzSX/kK3@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.19/parisc-3
X-PR-Tracked-Commit-Id: 0a1355db36718178becd2bfe728a023933d73123
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0c6a7bd4c6f87d6d3621fd58c94110bf2404e12
Message-Id: <165626497252.22456.16889702125998263613.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jun 2022 17:36:12 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jun 2022 16:41:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.19/parisc-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0c6a7bd4c6f87d6d3621fd58c94110bf2404e12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
