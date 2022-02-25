Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA6A4C4F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiBYUS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbiBYUSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:18:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525C763BC6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:17:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9395EB8334B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 512A1C340F2;
        Fri, 25 Feb 2022 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645820258;
        bh=FPlr2NSBb0kCxb7sdM6Z/++RU6QZ2LML7PzfWFR6K2s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q0aeH0q7ADuk/38NEwvc880MjHYBCFYG86RFQFVrBydhhk9PJVFpZ2SdmUV3yZsGX
         x3q2iyfaOiR77k846hYmHbzE6VH0RARamFU9nlie3v+YiQxXrwfvipLrYj6shDwhMR
         zAqPqT+3YFWkcwNtv5NYIiBMqEASCpO+c5x4B/fHtTK9CDvAKNErrV2xX2tGmMLCvC
         1x6kD+mZ9z2JmHFSNg0r7Mcjux9QOupsCgfsTeZ1O1zVxOFkAo61lrG1elIQUDTXDj
         msxYlPBmImFxB9VABB/PZWDxn/jNpJSVhSPOSNQUuygY0gV80UuHwUW4B/C7IGXljn
         qfvj3iF3VI0ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DF10E6D453;
        Fri, 25 Feb 2022 20:17:38 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhjYbrtdhbp4HE+B@kroah.com>
References: <YhjYbrtdhbp4HE+B@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhjYbrtdhbp4HE+B@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-rc6
X-PR-Tracked-Commit-Id: 6c7621890995d089a56a06d11580d185ede7c2f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c47658311d60be064b839f329c0e4d34f5f0735b
Message-Id: <164582025825.12222.17020788771125148583.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 20:17:38 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Feb 2022 14:23:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c47658311d60be064b839f329c0e4d34f5f0735b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
