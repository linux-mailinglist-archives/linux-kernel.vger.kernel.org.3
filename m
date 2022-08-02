Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0813B5883C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 23:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiHBVsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 17:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiHBVs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 17:48:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A7F25C79
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 14:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 481B561560
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DEEFC433D6;
        Tue,  2 Aug 2022 21:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659476905;
        bh=H+0dgZW5UUcFJRLPAdSEbZWbuzLTtKbqaYxD89kGpgw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UZOinFvxM01BoCZI/lCuHgT06jCq4spwtO6eItwjzxoEaKnEJLV3j9Dco1YvESg6o
         tPJBKF+C+cgipaLPISdKqmDPm4yfN8Erttgm6qAscffvEJt29zmDP4lkvikpe2VhfX
         cPRSxdH4gfdHdm1TzbAEzj1RJna64yRTTz6wk57FZ12t2XHGfV1XRI0O+cNxAagEvk
         Q2tJa8oivvle2CFYP+mFYOXOpHX2b/kp/BWHfO7tN2ccc9urh0v0v+9s+DRe2MjEjv
         wHb9XY3rmfpNJc++bCLf7WvDr/ItKK4brkegyzecIhvEHLtXwYQ3Vcy6opsAhtc2xl
         aRduZLmjcB28w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89BCDC43142;
        Tue,  2 Aug 2022 21:48:25 +0000 (UTC)
Subject: Re: [GIT PULL] pstore updates for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202208011029.A1E7EE281@keescook>
References: <202208011029.A1E7EE281@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202208011029.A1E7EE281@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.20-rc1
X-PR-Tracked-Commit-Id: 2c09d1443b9b8b6e25bfb2acf51ad442cf9b314e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ddd1949f585ef98138754033c9b1251ca2d32951
Message-Id: <165947690555.15647.13723994452378563640.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 21:48:25 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 10:32:00 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ddd1949f585ef98138754033c9b1251ca2d32951

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
