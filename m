Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF6E54F9CA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382998AbiFQPAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382973AbiFQPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:00:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4A13B552
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B640C61957
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 15:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 267F6C3411F;
        Fri, 17 Jun 2022 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655478010;
        bh=pDqenv8VUk/vdDyFDw6l/OhpPIT5yV0/LfCcOlcFws4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gBKiEQ3U0bk84RdBU5Wkyf3KOKx0vVZ7/KYo9C+HCG69poHpNLHB7nG7h8u+Cuy0U
         umLmY2H9+iLJpZ6/kyKBgKmtdHWXpXkEoxVbzCOc9PvOCIG7XIZ5A7qLjCArIWv8tk
         RzNntAWD7tXGux+hrdh8P2hwc40SWdAAYDgmvjTpCjIZsmUc/bRpk8Ojvo8qHunErm
         qF+ZDsKsrauFEpqwS76i9lLh7r9ywyUSYuPB5YZj8JpP4CfUtMPk7sKEAq3n9aiW7E
         LDWRpF8N1cDcIA23PYp6EEa1cqk28nHG+1lPUUcrvaS0bZQdTp+DueOmjdl4IIRsbU
         Tro40h1NR+Mmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E0FFE56ADF;
        Fri, 17 Jun 2022 15:00:10 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yqw4Jujzz5ZzZ2Wg@kroah.com>
References: <Yqw4Jujzz5ZzZ2Wg@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yqw4Jujzz5ZzZ2Wg@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc3
X-PR-Tracked-Commit-Id: 0a35780c755ccec097d15c6b4ff8b246a89f1689
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0ec9c65a8d67e50a16745e62a336355ddf5d03e
Message-Id: <165547801005.17120.16839643499305814924.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 15:00:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 10:15:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0ec9c65a8d67e50a16745e62a336355ddf5d03e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
