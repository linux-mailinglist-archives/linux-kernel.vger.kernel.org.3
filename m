Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047A2501F06
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347576AbiDNX21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347581AbiDNX2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:28:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263513BFB8;
        Thu, 14 Apr 2022 16:25:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B82EE62111;
        Thu, 14 Apr 2022 23:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C4A4C385A1;
        Thu, 14 Apr 2022 23:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649978754;
        bh=1UY0hndw1UA8iWKqDXrfG2Q6v29J8M3pg+nYSbPGY+E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n30reCYyeNu0OQO38On40193HTkQ0T59sHUisuxZkr3eAxPSkgkle4l+29ucybmts
         VPXqyIt9Wj8dPTZYa2wcOY2kBUBtn3cBUHQpGRIJ70YhyUQ6f9IVu4q/Ud03zQAdQG
         X4mrTgODg/KFMVTEq5/+xfCG2jravikca5tVEq8aYWFyHQUTg46yfcz0rVZJ4dp6FA
         gbGNQ787A21GWWtk9oDEofvZ2xMLdH5dHoyshMgU7R8jLyy1pW1cAiQmlz6MKUDUfw
         tO//pVgPvVkrwEmp1ESQ1eb0FfOaNmKU8QjX0LDed5H7zAlFKu3liuu/BlYggMXojt
         CsupLcyjNVTpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19029E85D15;
        Thu, 14 Apr 2022 23:25:54 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvdJYtYrBuQWoqvBH+YadJE5iv3C3Es0HjRRBY5vospyA@mail.gmail.com>
References: <CAH2r5mvdJYtYrBuQWoqvBH+YadJE5iv3C3Es0HjRRBY5vospyA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvdJYtYrBuQWoqvBH+YadJE5iv3C3Es0HjRRBY5vospyA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-rc2-smb3-fixes
X-PR-Tracked-Commit-Id: 8b6c58458ee3206dde345fce327a4cb83e69caf9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62345e482899185a247b126f32a96e4665018f45
Message-Id: <164997875409.7927.11662115355784116263.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Apr 2022 23:25:54 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Apr 2022 15:42:58 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.18-rc2-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62345e482899185a247b126f32a96e4665018f45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
