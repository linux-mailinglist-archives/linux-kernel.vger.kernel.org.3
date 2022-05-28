Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9EA536EA8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 23:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiE1VjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 17:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiE1VjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 17:39:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2FC5C348;
        Sat, 28 May 2022 14:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2C4AB8091F;
        Sat, 28 May 2022 21:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81AA6C3411A;
        Sat, 28 May 2022 21:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653773936;
        bh=ojcheA925lkBhSyOYSM346VfIjulytLOlELKvDo05eI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vBN7oamGrlNgq4nIjpJIwJ1YfocpWHEfSRG6cdamMZcF7aCoHfx1gHJxjoIuZ+r7e
         KJfJ/nyhjKvtgueE3HW0JLCyXXaLvup5RK2EP3trvyiEANDZu14y0ajfCbbDq5dhZf
         tP0lwn11818lYol7PbT35S1h4sE7XnlaWwk/50f+NxrBBLasClH6X6ZUwAlHYKYeC5
         K6xCS9tzKnVFiarOOEbhVnaSeDYQNuZ2DW8gljQMr0IPnrZbKXKwRfk+743bndeq+A
         xs8bxdCBnlGMip36zRZQdAaizhLlKJO4td5kODEEAFxc03dDMtIE1j+7dAGKVwLAeK
         Wpa9R5naYajxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E3C1F03942;
        Sat, 28 May 2022 21:38:56 +0000 (UTC)
Subject: Re: [git pull] Input updates for v5.19-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpKJXdB/5h7Ee0Ys@google.com>
References: <YpKJXdB/5h7Ee0Ys@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpKJXdB/5h7Ee0Ys@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.19-rc0
X-PR-Tracked-Commit-Id: 1e90e2628cec11c080db3260833f515cc32fc27c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 664a393a2663a0f62fc1b18157ccae33dcdbb8c8
Message-Id: <165377393644.8521.17280818322364392506.pr-tracker-bot@kernel.org>
Date:   Sat, 28 May 2022 21:38:56 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 May 2022 13:43:09 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v5.19-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/664a393a2663a0f62fc1b18157ccae33dcdbb8c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
