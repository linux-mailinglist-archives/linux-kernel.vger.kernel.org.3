Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BABE4ACD28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345260AbiBHBEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343570AbiBGXep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:34:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A91C061355;
        Mon,  7 Feb 2022 15:34:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7132A60EBF;
        Mon,  7 Feb 2022 23:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D46B1C004E1;
        Mon,  7 Feb 2022 23:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644276883;
        bh=z9XBnkjnVxejrYG6vrIgoihNXxApi9gB+qXfpQ9IrUw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R6+3jVCwRXOE1bthQitgwE1zDemhk8xrg+zBYVFfKEi8pJny4TMbqqVpePx4/qlcL
         JmVbjUEbv9So/c5CAtqVOsl94tgIUV61QMim1UpNKdlT6ZWRaBTkHlAap/ZzuA50gc
         wMzHDpXY8LtixE0qt6rkFfO+JUlG2CuRwwkfGmAX+BfYcF3qu/Fu2IgXfiEgl2ciFQ
         MSJ0M09RQjlCOGhVA6nR1U80/MosO/WbugYNdnnu1a/AD3yObYabmf0eyUuFp0fprj
         QO9fDSZ8wmYhMpLVk5spbcq21kgckiBtZ+ZDV595CTf/5H1dEq9JD++qV2AMDzAMPu
         /EZuktQViBNuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4E06E5CF96;
        Mon,  7 Feb 2022 23:34:43 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms7nZOL5jiGO2+AY8WO_hVXuEK9WsA9jE8utZgyHMoxZA@mail.gmail.com>
References: <CAH2r5ms7nZOL5jiGO2+AY8WO_hVXuEK9WsA9jE8utZgyHMoxZA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms7nZOL5jiGO2+AY8WO_hVXuEK9WsA9jE8utZgyHMoxZA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/5.17-rc3-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: f9929ef6a2a55f03aac61248c6a3a987b8546f2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 555f3d7be91a873114c9656069f1a9fa476ec41a
Message-Id: <164427688379.10399.6355470902649968520.pr-tracker-bot@kernel.org>
Date:   Mon, 07 Feb 2022 23:34:43 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 7 Feb 2022 15:04:06 -0600:

> git://git.samba.org/ksmbd.git tags/5.17-rc3-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/555f3d7be91a873114c9656069f1a9fa476ec41a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
