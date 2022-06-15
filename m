Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F7B54D3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349784AbiFOV2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241445AbiFOV2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:28:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0952ED69
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 128BECE22ED
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50494C3411A;
        Wed, 15 Jun 2022 21:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655328492;
        bh=02H0A+ywWsEUJTAC7/gPVQ+RtKoLgJyzpLUpWA0JEUA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jawRz6zhJbopxRPCLITm3quvhm37QGN9kKq4WIBL99c8ii5TZgmDvDT9jkbbKCP/5
         caa69aUroL1IVlFtmzVOd64gi/Xl9r5TowoOPe3KFheusNSIl9klYecKwGl442MVan
         IAMHj3dJIZp6XsOhv4DBxG2t/vebXw02bIYrapO6K2iMNBf0hn62QgLHVBIu3IEnpp
         PfA2fWPxaW+/XkLaaENkPLRF5abzOsY035+jLhuMtGX4DXhTgA6mNcgfTljVbl3yob
         fQMbbXcKp7e88gjbuATLnhOBZqTBHn5KCV5jVcYfkrgFz7s8F0SX5GYxmFAvdYcr3R
         h8IfOZaxNLkYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C98BE6D466;
        Wed, 15 Jun 2022 21:28:12 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202206151405.D8EDB70EA@keescook>
References: <202206151405.D8EDB70EA@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202206151405.D8EDB70EA@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.19-rc3
X-PR-Tracked-Commit-Id: 1dfbe9fcda4afc957f0e371e207ae3cb7e8f3b0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 30306f6194cadcc29c77f6ddcd416a75bf5c0232
Message-Id: <165532849223.18693.3759785082100551644.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Jun 2022 21:28:12 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Zorro Lang <zlang@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 Jun 2022 14:07:05 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/30306f6194cadcc29c77f6ddcd416a75bf5c0232

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
