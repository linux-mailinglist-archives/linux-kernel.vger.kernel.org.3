Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC973560665
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiF2Qop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiF2Qom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:44:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B5FDF;
        Wed, 29 Jun 2022 09:44:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C222ECE2859;
        Wed, 29 Jun 2022 16:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E02DEC385A2;
        Wed, 29 Jun 2022 16:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656521077;
        bh=145iEFNr+1wndFzy/YO7HeoszVr7V6xV125JMJOC2BA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iTEEWW7gkf0KXLxUKPsSkMp6AA0JyrCS+u9apqlc0be5x/QEJBJ0x2rmDbttPF9lA
         I0xoNNZgvJota+PI7lJMYufnee2Y5goxdo5cSBl1inOUJu2KLWIZBG4K9IAihuOdpP
         jQsMOP4LBAxOZoelnUxYW8V4yfKDfrDoAbSNvVo4kONpF6EZs/2zvL52CRamdSGIRE
         TrEQ0v1hpMs8GuMsMRDrtxQg7+8/JClFH8btuu82kH8djFZX1PqyQ/lxOG4OmJ626F
         H1bwUvhNB6l9nycj2QqynbyweE6TDJc7juaxQkGjutp/HFT87sFyY79yx6yMSk0U3R
         4EPk0iPQCOTNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C9A9AE49BB8;
        Wed, 29 Jun 2022 16:44:37 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.19-3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <42646771-d1ea-0b05-7cb8-233d6e42ac1d@redhat.com>
References: <42646771-d1ea-0b05-7cb8-233d6e42ac1d@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <42646771-d1ea-0b05-7cb8-233d6e42ac1d@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-3
X-PR-Tracked-Commit-Id: 9ab762a84b8094540c18a170e5ddd6488632c456
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9b2ba67917c18822c6a09af41c32fa161f1606b
Message-Id: <165652107782.8432.17451658153338765951.pr-tracker-bot@kernel.org>
Date:   Wed, 29 Jun 2022 16:44:37 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 29 Jun 2022 13:01:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9b2ba67917c18822c6a09af41c32fa161f1606b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
