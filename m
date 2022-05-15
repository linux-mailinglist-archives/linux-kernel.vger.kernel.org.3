Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEA35277E4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 15:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbiEONtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 09:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiEONtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 09:49:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AD913D5B
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 06:49:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 560EEB80B3B
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 13:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB8D3C36AE5;
        Sun, 15 May 2022 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652622539;
        bh=fG9BeCFoNbwLqE+fQhNYaL+vGmIzTk05Fb75VIOqjuo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n94SvtOdtuGhs/6Q/LyIQRusJ6tqNo94AIHwDjHdPLxCqQeQbx4mwiKG1r7KKg/Am
         IX8Ab5xwEWuCWOuaXHa52oFYp3sbfVIOcuM8wM/J7lddVykvAbK8XaBWIvMnhW7ef2
         90X//tVj33PdSsQ/nU7+M7JD38VMPTs1elFI9sSd7Z9D/rXnrkhiNv4UCQ47fIwIVo
         vZSby0hcI4KFvvTpz5WrDfPx2P5avD7f72h+/3QiWcx57Ys8pa98ZgNvYtVn5iFjU1
         hL8gMCC+WHap8Zj8uz2Z2c/q65+nk/IjLukBjEPTMbK37yEdM0EZdED/b0R+QVZZqz
         iNoS1/kxvab8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3A2CF03938;
        Sun, 15 May 2022 13:48:58 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.18-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ee0v6map.fsf@mpe.ellerman.id.au>
References: <87ee0v6map.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ee0v6map.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.18-5
X-PR-Tracked-Commit-Id: ee8348496c77e3737d0a6cda307a521f2cff954f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc403203d65a874df2f3156046468052e4109cb0
Message-Id: <165262253886.32598.10680090511280783938.pr-tracker-bot@kernel.org>
Date:   Sun, 15 May 2022 13:48:58 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, graf@amazon.com,
        matt@ozlabs.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 May 2022 21:57:18 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.18-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc403203d65a874df2f3156046468052e4109cb0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
