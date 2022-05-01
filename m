Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A97516684
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352411AbiEARNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 13:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352390AbiEARNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 13:13:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAB34D9FC
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 10:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 610B9B80E91
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 17:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A22CC385A9;
        Sun,  1 May 2022 17:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651424979;
        bh=adMC0ncZGNZHQfDPU8ZPn4agz5kcRIOP3FVROqIAQ7E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ggA91tkCdt/wHMdKUPvkYpbz+LEMuJqeHtl4Jjlyf5JJ0vzQ0v/M05RGkDs17+0FX
         mg5cGdmR0KkH2lZTNZubPyaazDrVjiS6CWLy+Vef++4dyY/eq3pijAeIJJlDxndbK9
         /1jd0pbEgtJ06PMXXzIoNur8jPhginS0SFRlyIfh2ic7cv50lq8+brLmm+aN/o2rMU
         JnYoKP4acbp6SUQzESS5aOX1kuFDpADWsfxGyt3Kii9ojhHrFG4nPC+W8//DvZRAy2
         sY5X5rcxtYe98+n/6IlIo5xEYbbsRiL4hccU2xeBLEL/H7CuWvoWvI+QRqqp5xPpu5
         jnepf3Q4tRkcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D3CDE6D402;
        Sun,  1 May 2022 17:09:39 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ym5ysk8Eo4p+0YnU@zn.tnic>
References: <Ym5ysk8Eo4p+0YnU@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ym5ysk8Eo4p+0YnU@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.18_rc5
X-PR-Tracked-Commit-Id: 4abff6d48dbcea8200c7ea35ba70c242d128ebf3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b70ed23c238af025153cb0f5b3c1d0ae5bc30f73
Message-Id: <165142497905.30448.15024701702529230788.pr-tracker-bot@kernel.org>
Date:   Sun, 01 May 2022 17:09:39 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 May 2022 13:44:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.18_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b70ed23c238af025153cb0f5b3c1d0ae5bc30f73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
