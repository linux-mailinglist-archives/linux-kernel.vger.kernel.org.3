Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035F4532141
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiEXCvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiEXCvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:51:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE79DF07
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 19:51:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAC68B8172C
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 02:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A6D3C3411C;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653360675;
        bh=mD9vbJNuDKehAWCht46jxlAIsSP2JFAW3U2pX9iI0wQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lIQ5WKgz16S//WH48TLcuMbH+Sm294Vzdq4TcqQu6h5naOmSltoPh4FK5LBxlZ1YC
         xHgVlx0Sce/u8ykVx2HDrJ6xskZ1Y6zWHNhIsj3NoTNezWj6xg+btp0FgQaM3jjUbz
         bGI+Zf5KwU/JTzcY8ngei2H9056HZLJDJQOvoVeDtL18pE2qOsGJQX+jAJfYjqGTnD
         kYftjKyfBfMmZTk562Niocdj+ThEAgqM9MQNAgcsG/EDbf9PP8POiU7ZpOzBvubaPQ
         F47cmhDEQeX3jnORbO/zTiHvAjeLKY3zB0xFhknRypWS/1mPN56+zczkAcADWk/yta
         NfLIpF4Q9uasA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AE66F03948;
        Tue, 24 May 2022 02:51:15 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cpu for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yot44Yl5/6VFQtHI@zn.tnic>
References: <Yot44Yl5/6VFQtHI@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yot44Yl5/6VFQtHI@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.19_rc1
X-PR-Tracked-Commit-Id: 2147c438fde135d6c145a96e373d9348e7076f7f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5a3d3c01e90e74166f95eec9db6fcc3ba72a9d6
Message-Id: <165336067536.14181.778673140122390577.pr-tracker-bot@kernel.org>
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

The pull request you sent on Mon, 23 May 2022 14:06:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.19_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5a3d3c01e90e74166f95eec9db6fcc3ba72a9d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
