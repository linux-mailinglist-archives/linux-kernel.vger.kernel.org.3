Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA84AB152
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 19:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbiBFSi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 13:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346721AbiBFSin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 13:38:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6056DC043187
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 10:38:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C962361218
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 18:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F4EFC340F0;
        Sun,  6 Feb 2022 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644172717;
        bh=ejulXTfXMUcS/vOazAj5+r4Ja4PVNFuuOso8TuYWtb4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N8I/VV96WGlGbJzoCJ3oS3IJdkMMlblu2GwtkMOfU0XEld+Iub7BxM8qA8hCpZqrf
         2TGJwmQgE5NRrIAARx9fAB/uQxojmm2XtyWCIswrZ4zgCcU06o7IineXcu1zrulb8O
         L+oQkp0pVN1EJSIjN2DAuHJ/FgmCzE/s9fC8CSI2CtMEnB+WH6wcbZcWUbKMcNP83l
         22bf/8T3AHR2Z7u85xUvdROjHQVwN6urw2svyo3Sk7YSh/3nveriuk8E97JaMYiiSS
         XxA44u7lZ4Duhx8awq65OAuglae8CyRuRqln2qI18XxC1pVfGABO3qRCoD9E20ydiq
         5BXCOHKf4MqTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D3ACC6D4EA;
        Sun,  6 Feb 2022 18:38:37 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for v5.17-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yf+5W4f+kpNuGl+a@zn.tnic>
References: <Yf+5W4f+kpNuGl+a@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yf+5W4f+kpNuGl+a@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.17_rc3
X-PR-Tracked-Commit-Id: 82880283d7fcd0a1d20964a56d6d1a5cc0df0713
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aeabe1e0744d1794246a909d2c042e9129fe22bd
Message-Id: <164417271718.9246.8191818722901903220.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Feb 2022 18:38:37 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Feb 2022 13:04:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.17_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aeabe1e0744d1794246a909d2c042e9129fe22bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
