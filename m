Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45BB4EE266
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbiCaUNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241258AbiCaUNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:13:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401FF1B255D;
        Thu, 31 Mar 2022 13:11:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E00D5B82216;
        Thu, 31 Mar 2022 20:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB279C340ED;
        Thu, 31 Mar 2022 20:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648757484;
        bh=E3hwYox9oNuKGRzoM1LoNvV2m84CJxMhK7tx3apicLk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cKc8qWiC3cFFDyv8YrXT+wlLRFDZmQrMJQCyOxTD9BSAQHVPiafvc3HyBjXPYuGo0
         WNlBVx9dPVTX0pw4t5cOupXBggW8OGIIms+XGBHgGCFBAz/cxu/svugoKcwjppvY/F
         hILtGgwsG4hzIJDVVdDH6O5At+QwsY06Snqd2wwoITf/ovPJ7ajEF8Z82aX57cR6if
         OXBOz/58hw1n/MNohwMPQH+tM5t1LIK26cdIY1YRoQv8jfayLoFp5X4/MU2ChiZPpO
         V/6y1LhRcOLnlEAFzpaALED0kBWpZq6vvARJun0tGd9k5r+pSufSp2zXNygJL+Z5DH
         GGno2uNjWQCnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F8D4E7BB0B;
        Thu, 31 Mar 2022 20:11:24 +0000 (UTC)
Subject: Re: [GIT PULL] More ACPI updates for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hGTCBsbrFt7xcS_J+X1hG1qOAL=UecfGyHuhAcHjZ0eQ@mail.gmail.com>
References: <CAJZ5v0hGTCBsbrFt7xcS_J+X1hG1qOAL=UecfGyHuhAcHjZ0eQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hGTCBsbrFt7xcS_J+X1hG1qOAL=UecfGyHuhAcHjZ0eQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.18-rc1-2
X-PR-Tracked-Commit-Id: 4a13e559af0b177eb934c39338f100a9f692a37b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e729dbe8ea1c6145ae7b9efd6a00a5613746d3b0
Message-Id: <164875748458.22963.1822475178150593108.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Mar 2022 20:11:24 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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

The pull request you sent on Thu, 31 Mar 2022 19:16:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.18-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e729dbe8ea1c6145ae7b9efd6a00a5613746d3b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
