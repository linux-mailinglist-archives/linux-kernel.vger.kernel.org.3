Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCEA53691E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiE0XJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 19:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354872AbiE0XI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 19:08:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12EE633B1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 16:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EB16B8264D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 23:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CA4DC385A9;
        Fri, 27 May 2022 23:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653692933;
        bh=hS3PxsKSI36M5qvTyM7ZUhiV2nOcueuiwJVYLdBp1IU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FFV/BwZDm6wTx8oWSJfEMHovPyG6QFbIehAmzQzK9Uqg8GBXMZFMJ+CAM7JMPj0K7
         fxX4weDg8fpqP52vbn8ZHEK+ZQpFlZnoNBYVZsaEuz5YLLcIkFJV+J71kSEHWGt2DL
         SZ0eCXBrOjr0U1lZdvuDI+gtgA6K/DXuAaphAJAcv7YRP9ngYACYGSE+wCiyJr5xFK
         Spj9+bxh8CYM/B8fTHBxj1PXdglH9PZNtw2OjxB0l4JkAtOxKKGvsseSXr11nydCXH
         B6H+mzjT+eQm/NO3EIR/bGJmY2vk3qGL7+Lrr8hEU5BjYXbVS6QwRrb36Kh2/WLVdK
         ZWmJl8N6Xh43g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A091EAC081;
        Fri, 27 May 2022 23:08:53 +0000 (UTC)
Subject: Re: [GIT PULL] jfs updates for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4dc223ba-b0d1-e183-1d83-a03a03c1df97@oracle.com>
References: <4dc223ba-b0d1-e183-1d83-a03a03c1df97@oracle.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4dc223ba-b0d1-e183-1d83-a03a03c1df97@oracle.com>
X-PR-Tracked-Remote: git@github.com:kleikamp/linux-shaggy.git tags/jfs-5.19
X-PR-Tracked-Commit-Id: e471e5942c006532a013eefde239ce1e783ac2d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aef1ff15927421a55312b4b9b2881a89a344bd80
Message-Id: <165369293328.12283.16817743231342476657.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 23:08:53 +0000
To:     Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 May 2022 10:10:36 -0500:

> git@github.com:kleikamp/linux-shaggy.git tags/jfs-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aef1ff15927421a55312b4b9b2881a89a344bd80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
