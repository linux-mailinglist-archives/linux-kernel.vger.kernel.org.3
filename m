Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B5C5A3A6E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 01:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiH0XHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 19:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiH0XHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 19:07:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1437631200;
        Sat, 27 Aug 2022 16:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A69B160EAA;
        Sat, 27 Aug 2022 23:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 151C9C43141;
        Sat, 27 Aug 2022 23:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661641644;
        bh=UDOd5qerVk1b8Fve5/UCpO82l/t6OAMVdU+dr8tpc3g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fqkmnTZh1v8+OazF5j9ZsyQCd3+wusLP7PbzRy37jPH+0NtxU6bcEM5nupr2jrJC/
         xofDge2kstOhxUA/CUMBl9B3h+26cQK6OUJEjWdhKZXfrQuh+33uSSVqh4xI6nHW5a
         9pgksjwvgkmeWkHz+CCva85rNPIF01s9xSjCI48tGVRG/VGTkPCwchd04SmkWj7KSk
         zdTX8Sxk2LoLFyHW2ewFwzknzQNSERJdVKQJ0GN8ypChPi48LjbNKhN4BJ1FmgSSld
         EMym1KVZbby3NfZJb0ddUThrGWQ6ls29e5ciqHMbDhsd6oxUlL4Kgy6JlsHlXvAd5Q
         ofXP7PNc0mPsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01CABE2A041;
        Sat, 27 Aug 2022 23:07:24 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fixes for v6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gzTEAf6NGQAsrG=AiWEXgBtD40gvGEp7BDzQxyXhC9BQ@mail.gmail.com>
References: <CAJZ5v0gzTEAf6NGQAsrG=AiWEXgBtD40gvGEp7BDzQxyXhC9BQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gzTEAf6NGQAsrG=AiWEXgBtD40gvGEp7BDzQxyXhC9BQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.0-rc3
X-PR-Tracked-Commit-Id: 3bf1b1571224e713f1a186de21b2204c06f1cb5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 10d4879f9ef01cc6190fafe4257d06f375bab92c
Message-Id: <166164164399.8591.16088265422552698170.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Aug 2022 23:07:23 +0000
To:     =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Aug 2022 15:42:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-6.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/10d4879f9ef01cc6190fafe4257d06f375bab92c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
