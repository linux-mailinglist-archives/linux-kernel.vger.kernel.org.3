Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB804E3332
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiCUWxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiCUWxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:53:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5683CCCD0;
        Mon, 21 Mar 2022 15:32:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9C97B81A7A;
        Mon, 21 Mar 2022 21:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 795CAC36AE3;
        Mon, 21 Mar 2022 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647899628;
        bh=5+wBPsZpbBVwNV0lj418mnZUaeWICQcbnDvLB3PAOI8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RSdNDYUUqOFu4akpIfAMqOvcHNcRBROPzm4OIG0JKQohSpid7V65U9q4jlTNPWyGR
         9zDsgtX0cFd0ObpiBMNPn0PJDmhS+q2jXKRocCdh/g5Zq/vEs6Bdy84tWdHhryD/GD
         tJMwKj0i3ovNToP7X+daEUtBCW0mEfXIoJIqtB5nD/P43qvUk2USp0LV87N4sSNopl
         R8jtRJgfxEEfs2D6j8fUKgCtBYpaugLmkloRPlYFdbPA+SGk8dwdjilvu4T35uiInv
         VrzXGoie5o7VfnfW4kn7igFhLGQnKelkWiz2pryjiUehONxosex8TDygtD2N2H9otR
         9j4P3+7AVTvyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62B90E6D44B;
        Mon, 21 Mar 2022 21:53:48 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jzzwLCo5=TAntL7_GW_VO=rWJ8Hnbne=n19UNNJzdR2A@mail.gmail.com>
References: <CAJZ5v0jzzwLCo5=TAntL7_GW_VO=rWJ8Hnbne=n19UNNJzdR2A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jzzwLCo5=TAntL7_GW_VO=rWJ8Hnbne=n19UNNJzdR2A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.18-rc1
X-PR-Tracked-Commit-Id: 1bde8bddb5db59e5bcd090b227c74d48965cedef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 242ba6656d604aa8dc87451fc08143cb28d5a587
Message-Id: <164789962839.9856.12794973265477392892.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 21:53:48 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 17:31:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/242ba6656d604aa8dc87451fc08143cb28d5a587

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
