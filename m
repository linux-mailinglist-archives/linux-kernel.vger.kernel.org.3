Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE1C50D4DC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbiDXTi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239339AbiDXTio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:38:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA16E12A90
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0CF0B80EEC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 748FCC385A7;
        Sun, 24 Apr 2022 19:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650828939;
        bh=2Ll1tqmcYI4QkLXrtWM37r72tue3SU9WD1qqAFaFMJU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bZAu3t8z3dMFijDs8dv2+0BTEJsrAL7JA1sxz9QRak6NCv/RLN5s9zWC+WNDrN8Zj
         9caMal40OtKzVXDMPN88O0UcZfa1lr1tjyNpLGtAOmtnaHj1sQWbV1Tg4hV7qwBNI8
         7z91Ih41CgF+mIQAfDg5txpCJaK6msRnd3WzZRVYaHQg87YKjdHNvAIeSc1zQIC1oO
         7Gg6IlK7G0j9k4hJIn6rt8t6uorIOr6iw/KA7qiv9mAlExlBgTl5dDVRZLlLdE21sN
         x5GBB43qLbOck6Q31pxNOeEY5R3qXAOYg4eUwRyxV6RIKkwNNLuKC+iJHmVsuVIM8J
         YnSHkNFf86hDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 508A7E8DD85;
        Sun, 24 Apr 2022 19:35:39 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.18-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ilqy8w7z.fsf@mpe.ellerman.id.au>
References: <87ilqy8w7z.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ilqy8w7z.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.18-3
X-PR-Tracked-Commit-Id: bb82c574691daf8f7fa9a160264d15c5804cb769
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5206548f6e6741fccbce8d95cff8faeba0738c99
Message-Id: <165082893932.1098.12774524804963596528.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Apr 2022 19:35:39 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, aik@ozlabs.ru,
        atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Apr 2022 23:08:48 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.18-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5206548f6e6741fccbce8d95cff8faeba0738c99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
