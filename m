Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962D55776E4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiGQPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiGQPGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:06:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C129713DCE;
        Sun, 17 Jul 2022 08:06:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F1036123A;
        Sun, 17 Jul 2022 15:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1D3AC341C0;
        Sun, 17 Jul 2022 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658070376;
        bh=uHz6l4fPCB3bfzUuiROJnNUABy8HWalz/vuxbRJmINE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MoozFb0rQXjJya/3X+YiM/khVQVfb7UP1oiJHF2giLcUveobq6vsjbCHWoc0POqCn
         6Ep/g9JX2QsYFQbt9ZRIj80OhEI/c46CG3vYyGEGqwJx3MUiJHKEjECSSxhKcxRLyc
         pQBgY/afwC3DcFkHn+OtQVQMiifa0ZGQOV7ipnUKLpjdrcS0xnt4uFEqLp/Nj5QIvK
         wGUlbk5YQPXaB0AZcDg3ncYjh42aoQ/iejCW9oQXnO2bsbX9Cz6zA+7DeBXY6xhbJ3
         4BWUr464/FATbrmd7OvZK0VK6eTAyHj6rPqc8gWkDXM+zyCgytfJIW3pKk7HnRDPIu
         a2NwIOVExiLcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF068E45225;
        Sun, 17 Jul 2022 15:06:16 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YtOW6KABn6sd9ZDZ@google.com>
References: <YtOW6KABn6sd9ZDZ@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <YtOW6KABn6sd9ZDZ@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.19-rc6
X-PR-Tracked-Commit-Id: 2a96271fb66c499e4a89d76a89d3d01170c10bef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ad4b6fa0f874ec8ec6e92a90116e3ab43cded6c
Message-Id: <165807037670.25191.2550981057682198131.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Jul 2022 15:06:16 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Jul 2022 21:58:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ad4b6fa0f874ec8ec6e92a90116e3ab43cded6c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
