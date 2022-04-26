Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6390B5108A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354078AbiDZTLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354006AbiDZTKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:10:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440113584F;
        Tue, 26 Apr 2022 12:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF6BAB82252;
        Tue, 26 Apr 2022 19:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC0C4C385AA;
        Tue, 26 Apr 2022 19:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651000019;
        bh=oB0PfXfFNyYYN59yI+8k+hxgU+ymNaYK85FvevEPleU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c8+hQmuDBqba9roo9nMVxo1NRDvaMZRSuO5pgX33I1+QQBnB0eK/gulCpV0AOWeFH
         XapDFiJa8ErKUjurLspATxV3WBJ/udblaWkLaXdFjevkfIsRNOMQG5t2lv5FRUiLr5
         KsokaWPbIvct/yj6sYiGatpshUd4O50BdTXkT0APXFoaoBAec2uRiXqPlRZXLFkPsd
         HJ0gp4Fo1ZSipUKj6wonapEaZG8ajj3dDecq1H+QguZRt1ZLaKnqm4dM2vqS2JFOu1
         vRXtyhtO6Jt/ojZADq5vy31uE+ga3neJF9tRoOYSKLneMIxXerBzveJN/ZYCHAt89g
         lXOlnKbVHS2lA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97714E8DD85;
        Tue, 26 Apr 2022 19:06:59 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev updates & fixes for v5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YmgNUgK/FeNcX0MG@ls3530>
References: <YmgNUgK/FeNcX0MG@ls3530>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <YmgNUgK/FeNcX0MG@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/for-5.18/fbdev-2
X-PR-Tracked-Commit-Id: 6fbe0cc53a1b5f7abe2c44399c18e943adbebe2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf424ef014ac30b0da27125dd1fbdf10b0d3a520
Message-Id: <165100001961.21339.1776716463797926143.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Apr 2022 19:06:59 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Apr 2022 17:18:42 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/for-5.18/fbdev-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf424ef014ac30b0da27125dd1fbdf10b0d3a520

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
