Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79523575675
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbiGNUmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiGNUma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:42:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3894B4A8;
        Thu, 14 Jul 2022 13:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C1C260C17;
        Thu, 14 Jul 2022 20:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04DEAC34115;
        Thu, 14 Jul 2022 20:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657831348;
        bh=fJ4eyjvO0Um+pJyYKG5uq/R/N+F7V14YpFEuWB5+yu4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LBL00c2iin6GSLn8zJVmBqIEAwo5OQFKtU2qeKDYcVN6wn0G2kfz3AgRFdoEMmemW
         7Ozt69PztxYMnoV1y97HsSosn5UFBAQjmkisHmKi0UyBpkJLCVpFf2fnWiwFJflZpc
         b2F5sXTJ/fdTK2ZOxs8meOg7adPQ7/+IYJ9zYXSgVB4zrLG+9ba0ERoB/p5crnoRzT
         i+gFCbw/NVEpPhX4n5xlaTtM3fndYel2uMrfezPgfIQuWPk376pXRXUXhKsiyNJqKJ
         Lkexsii8bVojocr3AGmwFxQTUWb+/D1YS3WWWj1uLGHRBNpQAQHxrbjjr7zcu7UztP
         ATjOu85woEKQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8B0EE45225;
        Thu, 14 Jul 2022 20:42:27 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtdGBeQK+nVg_9QS5CXWoKM=f=9vbau8Cv6+vcN6DMikA@mail.gmail.com>
References: <CAH2r5mtdGBeQK+nVg_9QS5CXWoKM=f=9vbau8Cv6+vcN6DMikA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtdGBeQK+nVg_9QS5CXWoKM=f=9vbau8Cv6+vcN6DMikA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc6-smb3-client-fixes
X-PR-Tracked-Commit-Id: 32f319183c439b239294cb2d70ada3564c4c7c39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f41d5df5f146d606df02ec8fafd080a5ee6e6e81
Message-Id: <165783134794.13350.4114993759826135745.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Jul 2022 20:42:27 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Jul 2022 13:41:54 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.19-rc6-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f41d5df5f146d606df02ec8fafd080a5ee6e6e81

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
