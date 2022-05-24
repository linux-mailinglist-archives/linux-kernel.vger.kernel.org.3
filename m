Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2008533203
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241422AbiEXTxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241376AbiEXTxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:53:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3083793B1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79217616F1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC5BBC34117;
        Tue, 24 May 2022 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653422006;
        bh=BSwXR3DeZqlsKenkl80sOfMbBXoL4AQn2M5K1h65dS4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Cn/8NDVp7MvsecQ3jrQSZ16K3W3kx+IM42tLzWVvxhocfCKWGdhmMSjkO0wComAvP
         SD/o9rvgH8nfzuqu4cKb48lbCk4pgCJBqNFbIpz8SfXAsjAu2jiEqv9W+XhSysbFG7
         DPpZdibVoDRy7hR4ilRzfVc2jR+Mt+A7MtMU7fVkaL2arK67+KBGOqWHJgyPhrLarX
         nTUdL5wdkMocAK3pivhYBmo+g64BtcocRCgzku+6jaavyEBdwBxun9B2T6R6kAG5mS
         A65Sid/I9cECw8LV90e5ZtRD28stvsypVFp90lMi+vN8irvRj6gcfdoPB1Z6bOE038
         l3gUuuEUWjX5g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8FF9F03943;
        Tue, 24 May 2022 19:53:26 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202205231218.4D24FEDCF@keescook>
References: <202205231218.4D24FEDCF@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202205231218.4D24FEDCF@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v5.19-rc1
X-PR-Tracked-Commit-Id: 70578ff3367dd4ad8f212a9b5c05cffadabf39a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6b450573b912316ad36262bfc70e7c3870c56d1
Message-Id: <165342200681.18932.13314480320585374719.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 19:53:26 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 12:18:55 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6b450573b912316ad36262bfc70e7c3870c56d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
