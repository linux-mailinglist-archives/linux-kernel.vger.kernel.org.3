Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A09532131
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiEXCv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbiEXCvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:51:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5A21C919
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:51:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DD2561245
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2FAEC341C5;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360675;
        bh=Kd4jvXVEW2ixyT8hV7wjNav9YGOkkZ4rP/WhmponpYY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qzDEiO0UCdEZjOGALArrUvF/qVLB0PFpAV7NE9BjgtCLuab+LEN+Kw51BTZ3cFeM8
         SuiTX8WBStvCjeYTdeNSceMSM2/45fIUHl56GDJx5uKr0I7DeOosyD+YxgxfqAoVES
         IFysMZn678cNEagbA/Bd5KIPDtDJEy7d7dfy29KCou+Fvw2W8/TOzY5Hw3hIcDMpJL
         hvhVYnvL6LbiQEMY5v4vLDQmcbU/0+MPPPOdIQXAote8Pk9UDI4NKeOUlSYrWokq+x
         E4dDVAjh+uLE46FWk0PD9RXKUNVixOou+kO0X+SiZ842MOkQpWGWpgch0X8Lg1JQSE
         MrnX5Rif/sfVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C20ABF03947;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
Subject: Re: [GIT PULL] x86/core for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YouoMW6jtD3BRavh@zn.tnic>
References: <YouoMW6jtD3BRavh@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YouoMW6jtD3BRavh@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.19_rc1
X-PR-Tracked-Commit-Id: 69505e3d9a39a988aaed9b58aa6b3482238f6516
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de8ac81747fca15925f3488ead7804560cdea532
Message-Id: <165336067579.14181.8349738739286219638.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 02:51:15 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 17:28:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de8ac81747fca15925f3488ead7804560cdea532

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
