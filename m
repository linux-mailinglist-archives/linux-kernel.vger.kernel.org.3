Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328A0588444
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 00:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236855AbiHBW3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 18:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbiHBW3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 18:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C15A54C83;
        Tue,  2 Aug 2022 15:29:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD2C46023A;
        Tue,  2 Aug 2022 22:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3968EC43470;
        Tue,  2 Aug 2022 22:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659479364;
        bh=V8v5YfF9cjKUyc/paNim78DqaLjGUb+4q+GRiKvwPdE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=upIdhB1cxs3kappcGHsQ3cBSfHR8dbUBkHmauqbuU+uMti8e83OWkBi0Chc20GnYz
         a5kMbx3JSaXdNDpO0nmFdDoZmnlfKN3WpFgDf1u109daQMTCu+VgR4c86Y8wwTIeOX
         lqrHCGyqn/ziUAcAJzib0nLL2CODE6gCCpmluaHUd3NjNfiNRwL6/zQoL+4GZQYCXd
         /xMj1WFygj5MX5W16M6A1zroptPL7F4e15Mbygukk39W4Atg0oUNxAWn5PVgD4jnHZ
         NgwFmem4ePgn0+Sg3Uynj4vWXZAWb212Qt/3jYaOBQKHFTCsFc7IAEV1z2r4XRpeEp
         HYl1Yp3e2bLJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 267B0C43140;
        Tue,  2 Aug 2022 22:29:24 +0000 (UTC)
Subject: Re: [GIT PULL] SafeSetID changes for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJ-EccPH46FGKQj8gYEg5HGpmmRiqzrZouTZauwpvX-+2j4GNA@mail.gmail.com>
References: <CAJ-EccPH46FGKQj8gYEg5HGpmmRiqzrZouTZauwpvX-+2j4GNA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJ-EccPH46FGKQj8gYEg5HGpmmRiqzrZouTZauwpvX-+2j4GNA@mail.gmail.com>
X-PR-Tracked-Remote: https://github.com/micah-morton/linux.git tags/safesetid-6.0
X-PR-Tracked-Commit-Id: 64b634830c919979de4b18163e15d30df66e64a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87fe1adb66a514fa3abbe8bdb4278a5b2f421d8b
Message-Id: <165947936415.5634.11166825579004727713.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 22:29:24 +0000
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 19:42:26 -0700:

> https://github.com/micah-morton/linux.git tags/safesetid-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87fe1adb66a514fa3abbe8bdb4278a5b2f421d8b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
