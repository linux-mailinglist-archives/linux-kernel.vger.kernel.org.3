Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3880F533403
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 01:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242937AbiEXXmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 19:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242924AbiEXXma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 19:42:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA3057B35;
        Tue, 24 May 2022 16:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 097E1B81C06;
        Tue, 24 May 2022 23:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8992C34100;
        Tue, 24 May 2022 23:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653435745;
        bh=DC11/NyFE4GYyAa3Hri/Pfis0rqTy/JHVRqA06kRllE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A5qnpJobl0y0xufIADy+g279VZUANvhjYTRoX/47k+bwtUCBcmoAg+IXVWC8vTIEZ
         QzVqiqkckPZK4rbmWnw7TtBI1NmyFSd3IxEv6MEZhUdYqlufbJeHDTPhoRliZLrtmr
         W1OYWjHmQ8+P3gk3lsytiOZpMROQIRGZ3WUriLEDpBhietY81egisHdxY1pxfu+NRz
         ///uSrBIKHtm0no72rbM7KDF+Mhw3aX/VT5bXmBfUakxpuyVb1duL+bhPftA7vma42
         HpBLdEmRxz2v8yQxGX/6OKWhiyTdbpfp72bXzF1czK03BpUptCia4ZoA2IJczSuVKO
         Q2wgjetf7sRsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F392F03938;
        Tue, 24 May 2022 23:42:25 +0000 (UTC)
Subject: Re: [GIT PULL] Device properties framework updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hprw1AQSq+aO9WFz-2Evh6E3-Grn6uB1zQ7ex=Q8N0Rw@mail.gmail.com>
References: <CAJZ5v0hprw1AQSq+aO9WFz-2Evh6E3-Grn6uB1zQ7ex=Q8N0Rw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hprw1AQSq+aO9WFz-2Evh6E3-Grn6uB1zQ7ex=Q8N0Rw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.19-rc1
X-PR-Tracked-Commit-Id: f6e109a0afedec2a9470fec31a567071e2f01e46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 268db333b561c77dee3feb6831806412293b4a7e
Message-Id: <165343574551.8820.3975951065628758581.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 23:42:25 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 21:46:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/268db333b561c77dee3feb6831806412293b4a7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
