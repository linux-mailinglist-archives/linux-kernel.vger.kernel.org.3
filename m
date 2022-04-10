Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5071B4FB007
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243906AbiDJUOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242784AbiDJUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:14:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D794B1D0;
        Sun, 10 Apr 2022 13:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59140B80E7A;
        Sun, 10 Apr 2022 20:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21E25C385A1;
        Sun, 10 Apr 2022 20:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649621541;
        bh=8paowOEL0F6ps9/ZTGBg7dqxv6sITcl+JySDoAnKdeQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C7izLsmvxOs43h8tyFfmCu1hbECZ4TBUjSjMxoy8nlWZyGW8MJzi+3yKa6COtMGfk
         mbOKbi/8PI72HorPIj+oGBekMqkdCRAglAS5r8Z7t7gSyGWDl41iPlQaL+AvhmqRRZ
         Xr3Nnex4z8ZRGGZRJTfyTFbvsFUu3sY8FRoCwyXCbLNscxgjxd4GkXYEFhPv3cwsgo
         aIs74nEpOuZnMxYiP/sw6jVxjZ3Rsk/6pbERKVnTjTi5lJRsQTDz9UYKkSjp2yJw/g
         LuGHh3NYVAwa8k9wRqCxsJYGk9vc77atjkpmk/IiXXfcLai8vdmL2sgJ+oIT0bubQf
         OPQBiCqXtee2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C71FE8DD5D;
        Sun, 10 Apr 2022 20:12:20 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fix for 5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YlLSyUv83naZO3Lz@kroah.com>
References: <YlLSyUv83naZO3Lz@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <YlLSyUv83naZO3Lz@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.18-rc2
X-PR-Tracked-Commit-Id: dbf3f09322141b6f04a33949453b7626f62d9e0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b57b3046107b50ebecb65537a172ef3d6cec673
Message-Id: <164962154004.385.10080255578914154729.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Apr 2022 20:12:20 +0000
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

The pull request you sent on Sun, 10 Apr 2022 14:51:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b57b3046107b50ebecb65537a172ef3d6cec673

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
