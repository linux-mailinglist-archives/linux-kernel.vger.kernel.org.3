Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C066547B7F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 20:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiFLSlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 14:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiFLSk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 14:40:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD7059972
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 11:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 507D6B80D03
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 18:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22D0BC34115;
        Sun, 12 Jun 2022 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655059253;
        bh=YB5kkitJEmpHozMcb3IjsekOPFuqxcOD5EB9jpOwy90=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Gh2F6zhlUCdhfzNTrrKqr2LJXOriqKyF3LKj/nntqfwArn0mrKuFEkt1E8jMTglro
         yxLnGjJyA7jyIvmDtaMxp1MgcbkAEE6nxny6IzxmG6MZaiTr+ZFlNX23ncNZI95ELP
         Udi8vC7s5ZlrfT8u5vU5HyjcwMJzOpLNYDBgSgMpWkfbXiYQsjPKEXmN10s516LgcF
         RFGgWx0yUUVvqXftpNghhN+XwzLkygFZPjX8nKEoX7BWilisZ6YNmeCtt2eLlLhMDy
         u9U2gm45G/BxuE7pCv3dBiuWkhZ74ps6LeT2lfYhAzzn/u9gZQWoM98oI3Zpx9/+CW
         ezz8QWjYDiYqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EC6DE737E6;
        Sun, 12 Jun 2022 18:40:53 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220611153611.828415-1-Jason@zx2c4.com>
References: <20220611153611.828415-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220611153611.828415-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.19-rc2-for-linus
X-PR-Tracked-Commit-Id: 17b0128a136d43e5f8f268631f48bc267373ebff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cae0d84756aea1c563f0cf9f668cf13e281e8a5
Message-Id: <165505925305.24195.11927112753989532073.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Jun 2022 18:40:53 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Jun 2022 17:36:11 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.19-rc2-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cae0d84756aea1c563f0cf9f668cf13e281e8a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
