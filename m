Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EAE58860A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 05:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbiHCDX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 23:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiHCDXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 23:23:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA69D4F64A;
        Tue,  2 Aug 2022 20:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 236BDCE2247;
        Wed,  3 Aug 2022 03:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48AB7C43470;
        Wed,  3 Aug 2022 03:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659497001;
        bh=CUNI89lAeAQoJCZajdL5MGmpqNAYwd7ijWvtuFK5FTs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=etNGEk8zu3pfDxC2ane///9R4d7Cxikt71htwpovVxeZLDX21Fj1aDYzAblNFOqyy
         rmVZuU0ImIzv2p3IIlkPpywMAGlEAjkOooVbZL2zACKwJMSp1LxhbAZJaf8DhUnjY8
         83vAiFD3EW2eBWz5KTd+zoqbsZn+w/KPuyNZiV52cYFJ3/cu7883GYDRgALPLNBeWe
         gn772Tt2lbiKgEZnD40cHHHrylCQ4ocsKQG4D5HwfWWdiUQaHwSETOgGPh3YaR7hiE
         57sRum6pE4jCAjZY57wu1jDGb0fJ811svLEermyo01v0T04k91um8Mt1GDxAGDFLI8
         x0Luw32ijnBUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 316C7C43140;
        Wed,  3 Aug 2022 03:23:21 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ilnc6k0c.fsf@meer.lwn.net>
References: <87ilnc6k0c.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ilnc6k0c.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-6.0
X-PR-Tracked-Commit-Id: 339170d8d3da5685762619080263abb78700ab4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aad26f55f47a33d6de3df65f0b18e2886059ed6d
Message-Id: <165949700119.31205.13928420544677879499.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 03:23:21 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 01 Aug 2022 09:50:11 -0600:

> git://git.lwn.net/linux.git tags/docs-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aad26f55f47a33d6de3df65f0b18e2886059ed6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
