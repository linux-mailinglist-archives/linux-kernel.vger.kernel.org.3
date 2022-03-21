Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0278D4E3186
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351639AbiCUUOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354033AbiCUUOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D44CE0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:12:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E49FC61158
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 527C6C340F4;
        Mon, 21 Mar 2022 20:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647893557;
        bh=N4kodCJokqKDxywzWJv+T+N57aWwlbs/tiDhDuugea4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ai2PwIxh3FAd6yM1aGlfi4VyXpgLjuXFbETwVuN0xjfoNqL075e0x576IeqhrGpU2
         b2gcXWC6hsImAyjpSKrqCznncQeWz7FJF/a7YrCbw1qAFtp6t33KgFIIloz5xj9LSo
         ce0o3cAVZvWK/0lZ29at9Q6zhtdkxHH1AMhOreeC+3dMZdL3TQbKWnEZVWxAU6gh35
         JFaguC+OfSPYOn4tB53liwC2iCJOiMRn/v/BZPjGxk2VIqIhxKi05dxlbWlhlRyCX7
         D8dcRijSauwCipHuFpwLU7cWWdpRNJYzhvCDA2s8s2kZaNUVJRNzk5RK0aX86Eac9O
         k0VMkpDpw00gA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C76CF03845;
        Mon, 21 Mar 2022 20:12:37 +0000 (UTC)
Subject: Re: [GIT pull] x86/pasid for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <164786043190.122591.9314646033947786445.tglx@xen13>
References: <164786042536.122591.4459156564791679956.tglx@xen13> <164786043190.122591.9314646033947786445.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <164786043190.122591.9314646033947786445.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pasid-2022-03-21
X-PR-Tracked-Commit-Id: 83aa52ffed5d35a08e24452d0471e1684075cdf8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fd33273a4675e819544ccbbf8d769e14672666b
Message-Id: <164789355724.19380.17458626397346846096.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 20:12:37 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 12:02:29 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pasid-2022-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fd33273a4675e819544ccbbf8d769e14672666b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
