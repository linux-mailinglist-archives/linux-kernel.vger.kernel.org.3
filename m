Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE94050C1B5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiDVWEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiDVWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:04:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE6341A281;
        Fri, 22 Apr 2022 13:46:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C44EB83260;
        Fri, 22 Apr 2022 20:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15B76C385A4;
        Fri, 22 Apr 2022 20:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650660404;
        bh=lAIpsA8GwlDp91+/3Nl/q7BJTfG0dlG2sKdtR4AeAqg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AJqNmlYygWXwZEVMiilBNTxQdo5aWr2Wb5lbq9M9XHy2U0FchXcPLnXKHjQJYjZ3f
         zRjRZPuNJ3YQL0Ox0F4k0+tkczKbQZz1b536eSHyCzLHo4o2DW+U0ocJS6r50T3ZRT
         hQPsgs1CdtCf3AtezxjiDjeqjk/KCwpv96xTl6yIxOhPt+ZYv9al449HZ3IltTvWxb
         u7Cjw5877G3zwP3l++5S5PpVzeEaZdh0zqJmvV1lUpxaMu9jIbLrM9skdS8dbPKHtl
         3hCPw9zueWGx2srn9QO0wO1I7PbHOnXawWEgdcEnb545/4luo+HGi0PkA/uPrOAQfF
         +Y9ExMsqJoLYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02723E8DBDA;
        Fri, 22 Apr 2022 20:46:44 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtNyRzY2zxrS9Qgoj-NxAEyOEHjrWc1a6bingt61=xWHA@mail.gmail.com>
References: <CAH2r5mtNyRzY2zxrS9Qgoj-NxAEyOEHjrWc1a6bingt61=xWHA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtNyRzY2zxrS9Qgoj-NxAEyOEHjrWc1a6bingt61=xWHA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-rc3-smb3-fixes
X-PR-Tracked-Commit-Id: f5d0f921ea362636e4a2efb7c38d1ead373a8700
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88c5060d56d8f756653bbee89fa45a752e241c9c
Message-Id: <165066040400.3510.2984080535215544463.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Apr 2022 20:46:44 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Apr 2022 12:00:06 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-rc3-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88c5060d56d8f756653bbee89fa45a752e241c9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
