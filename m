Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82928513B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350862AbiD1STu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245277AbiD1STj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:19:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441FC3F8B6;
        Thu, 28 Apr 2022 11:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8B9CB82F58;
        Thu, 28 Apr 2022 18:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91180C385A9;
        Thu, 28 Apr 2022 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651169781;
        bh=8GYl2v23R4RNOKsXXcr4bQ+Kjv3eMYrQMwKAlxHBVTQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PHZTHpy9l9NGFPupuf8T5hOCsNeB645hXPINYIpLiweeuzILFVnk9Ovw7rIMADYMh
         /WZtCLwVv9fPU/fX7XDvtzHX5JsSYbK1pr+0BUaFG3cCYBIdNc/o31VFbSQCqsFRtz
         f1MGqWNWeHbLWcOiMv0W/xx/sMLBd6kBpXDoVWegtJsMun9UpWKriQVBofO1zi/YNb
         +1N06UMC/OlBHp8WGWsAloU4o8pL7r20mdKB6HNoomzjzO3/aWEZtcUW5fGLD7nXW4
         Ab5opqIHDJvm0kBmCuJMoH9FDrIJmVrDNQ97sVMivBdeLQzJk8HD+m24HnjQlbonsl
         uMH+R7E6Nn9kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74386E8DD67;
        Thu, 28 Apr 2022 18:16:21 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.18-3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d6954974-3ee8-9573-f906-c141165cd4b7@redhat.com>
References: <d6954974-3ee8-9573-f906-c141165cd4b7@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d6954974-3ee8-9573-f906-c141165cd4b7@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.18-3
X-PR-Tracked-Commit-Id: eb2fd9b43fae0c51982ac4229535b6cfd77380db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 259b897e5a7958e06d1ac30ddd28dc8419e8f328
Message-Id: <165116978147.27414.3199673467686070742.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Apr 2022 18:16:21 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Apr 2022 14:32:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.18-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/259b897e5a7958e06d1ac30ddd28dc8419e8f328

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
