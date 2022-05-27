Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE2A53582F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 06:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbiE0EGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 00:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbiE0EGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 00:06:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FC72611C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 21:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54FE1B82280
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15B88C34118;
        Fri, 27 May 2022 04:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653624398;
        bh=FjabYU9xf54BvZzldhLVqvIrDFn8VrLlqiTt2V0JY9k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jTIsrJQWUqIK0I8eAj2awcNrHbzWpCRmHzBJn6ug0jD3ijecUpyXEd4C1W0wdeNk2
         LI5QJ4IPeWOE0lF3pSVIqmmlBBoI1PCf/KuJ3pSgAbSY8fsFluegO01HzSNQnYKEcu
         rf2rzHrx+n2rttUMgJVwD3uIwMy5ZjBKx6AkTwxBhzV/76bkKCtenggTGRblXwqNcB
         ETeZYQGTf2zgH+PalGu4uMuPf62CP4T/xOg9DL2fa0yIa2eRgvE7TlzSdKlJOtdIXi
         xYmA1VNkcZPb4WplPXEdFabKSGY93nVJOC4X1mJROYtC2z/1XMcZQZmeXk3wsf2R/K
         sqMXQvEFp5ZUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6F65F0394C;
        Fri, 27 May 2022 04:06:37 +0000 (UTC)
Subject: Re: [GIT PULL] kernel hardening fix for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202205260827.CADD61804@keescook>
References: <202205260827.CADD61804@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202205260827.CADD61804@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.19-rc1-fix1
X-PR-Tracked-Commit-Id: d37aa2efc89b387cda93bf15317883519683d435
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 090b39af591cdde897664dfa5d3d5b0c78a197fb
Message-Id: <165362439794.3780.481017997790326144.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 04:06:37 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 26 May 2022 08:30:50 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.19-rc1-fix1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/090b39af591cdde897664dfa5d3d5b0c78a197fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
