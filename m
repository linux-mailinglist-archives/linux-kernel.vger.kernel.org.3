Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D261534753
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 02:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348098AbiEZAJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 20:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348089AbiEZAJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E42564BD0;
        Wed, 25 May 2022 17:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12DD8615EA;
        Thu, 26 May 2022 00:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70025C34114;
        Thu, 26 May 2022 00:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653523753;
        bh=x+U3JZ5aTgUICVEDS7d0aYdVK38Cl20riw5doycOyeA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tEalbPVCjWmuH8AePIVherqPIXVJ2inb7Gpm1PuRhG2YQ/vyD6tXJr6FgNqGgFL+0
         kccVrRAyIgaV1JWtIy7aXu50VQs7TqhvQHrkGe9U71/AOuHrIZljG0lz8gWy7MKB/+
         6GpHQP+05EEGRNIDFHoi7+K8YB5c0OupPWqdLUbzLztbIGKVVx4uVvwkBt6B+dZT2C
         Qmz9LFNvg8c0aiY8XekVU+Q6Q2eInkWqO+Nnf30ahnfbDKI23sS/6EPOcAliH6jfQW
         /dy2gl8u6cBSbH4whhKAoJk/34a97Tqo2sNG/CrMtkx95KsSojb/LUh5OSV3tKhJbB
         1kHQyVyFtWjjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CE31F03942;
        Thu, 26 May 2022 00:09:13 +0000 (UTC)
Subject: Re: [GIT PULL] -Wstringop-overflow fixes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220524222505.GA7242@embeddedor>
References: <20220524222505.GA7242@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220524222505.GA7242@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wstringop-overflow-fixes-5.19-rc1
X-PR-Tracked-Commit-Id: 336feb502a715909a8136eb6a62a83d7268a353b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3a8b54b4f1a261656eb6c9a517e68e1204cef39
Message-Id: <165352375337.5177.6020372729867356397.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 00:09:13 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 17:25:05 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wstringop-overflow-fixes-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3a8b54b4f1a261656eb6c9a517e68e1204cef39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
