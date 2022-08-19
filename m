Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3259559A79B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352324AbiHSVOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352290AbiHSVOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD7D3E61;
        Fri, 19 Aug 2022 14:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D67B61743;
        Fri, 19 Aug 2022 21:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3A2EC4347C;
        Fri, 19 Aug 2022 21:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660943681;
        bh=qu6aAAPzSJD0m9IB2GWnn+KR2DDD5QFXginlbe3F9Ng=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Rpxp3ZNL5DLzOoC3wU8AS0eaxXDKx9wc5x/eOXjomd1ukfwJ7hZeJsSziSzCrSTI5
         3t1TqBfBPIhCN/MFeicWDJMFk9hnlmmuN4gfLvkI0vlXPK7q+UppkvBrWFqklf8f7O
         HPdxFlSWwJhiRqAIEIJ2/qbJvdy3KwVxjXIZOYi2oY9y30PCk7Yuk7C8OudQ14X/oj
         zkLCbFCB1Y7EzMKpP9+f4rNysRlIQG8Xd1Eb22zUc6brqmtc6aUrP0nfBZPvI80BO6
         mezUfR24/tX0TKb4hiG18Of6l2/kT0VV7rmsseFDnToE1xvKWMBv+VzwAeAFGMuqF5
         4pRi/YdgHf+Ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1972C43142;
        Fri, 19 Aug 2022 21:14:41 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202208191200.C8B461644@keescook>
References: <202208191200.C8B461644@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202208191200.C8B461644@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.0-rc2
X-PR-Tracked-Commit-Id: 012e8d2034f1bda8863435cd589636e618d6a659
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e45c890140c8c2c9f3dd475c14bdf084c4cd2296
Message-Id: <166094368178.15089.14236020797669823610.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Aug 2022 21:14:41 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Erhard Furtner <erhard_f@mailbox.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        linux-security-module@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Yury Norov <yury.norov@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Aug 2022 12:01:15 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e45c890140c8c2c9f3dd475c14bdf084c4cd2296

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
