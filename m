Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5CB4E3731
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiCVDIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbiCVDIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:08:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDB42AC40
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 063DFB81B46
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97BBCC36AE9;
        Tue, 22 Mar 2022 03:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647918398;
        bh=HLb9sxUXVCgQrtM8xNIq/BvrbaR26zPboSX2TA3B9uA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tEUSDChu3u4ZTFYgObaL1yNrZqeD8eKghId+eYEjPq6gPguMwz+B3rluZFYrHYX3S
         mE2CgLGEc5mQHRdtbb4WsEJH+KQ08My0tvdgpq7PdhlZHumC87gwtU5tVLRcbD1/Xu
         EpYETIEH4chgOGdtJc3qf+/3/dU0qBnmBOyLP9DplpUDAQalPWzc7DOZHP/fWpvNVR
         CHO82TdyXHxt1gBwqgrvzPx+JYs2aDPKcOGaWYowuDd02rde46IVC5Z5EVkrRCWCf7
         skVMzRSM/CYe3+IiVfiCdPFcvhLkzZnTqu6/SxZEAW/9568yifXb16/zyswCAnCoCo
         tVPPzzeayPwBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8535DE6D44B;
        Tue, 22 Mar 2022 03:06:38 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202203210755.C56A4CD5@keescook>
References: <202203210755.C56A4CD5@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202203210755.C56A4CD5@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.18-rc1
X-PR-Tracked-Commit-Id: afcf5441b9ff22ac57244cd45ff102ebc2e32d1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2142b7f0c6bbe1f9515ce3383de9f7a32a5a025b
Message-Id: <164791839854.13286.15681917019883541218.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Mar 2022 03:06:38 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Dan Li <ashimida@linux.alibaba.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>, Marc Zyngier <maz@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 08:03:19 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2142b7f0c6bbe1f9515ce3383de9f7a32a5a025b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
