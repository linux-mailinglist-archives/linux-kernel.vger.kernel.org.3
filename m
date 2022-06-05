Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84FE53DD52
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 19:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351459AbiFERQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 13:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351395AbiFERQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 13:16:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C2F4E3BD;
        Sun,  5 Jun 2022 10:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EA2260F36;
        Sun,  5 Jun 2022 17:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73AF4C385A5;
        Sun,  5 Jun 2022 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654449380;
        bh=1kBlpz/z6UVc0C562hOKllinvxyxzfdB5C6iFR01GcM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lqTBWfYM7icZidaZLG+5m0fe+AxbHUyObjldz7i+ciI/GE7QOu3VKRCFWt68OkoZE
         dRuH/yW2DDgswGqsbmeoFtcGy58r88aUg6aZIwHAE4yvq+2YVVHPINSf/aeWdqfX1F
         8xcOxeSIC9mzDikBsOg1Saz3LsFlpi+QczGIusihkkyhtOlEoEPL1e9YmGsvouFpER
         X0atRR20CkZHWfVLdYiI8E06Hssss178NwfVL7B/ggRIVZAoXgV17YUtKxP3S21Fu3
         Zi34d2W8kr7Q95xpkIoLAGZRKI3m4qJw+YWySEjPvRUSi2opC7OIxgTHG0O3uviJQN
         1IvJuhR3ptO1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6138AF03875;
        Sun,  5 Jun 2022 17:16:20 +0000 (UTC)
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.18+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <29ba89f60e3b9ff457056b79f3b9d86c8a4b1c48.camel@HansenPartnership.com>
References: <29ba89f60e3b9ff457056b79f3b9d86c8a4b1c48.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <29ba89f60e3b9ff457056b79f3b9d86c8a4b1c48.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: aa2a4ded05058f134a4dee1424f829d662e00cda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2c9a83d262a8feb022e24e9f9aadb66cb10a7a8
Message-Id: <165444938039.7539.12094028493865543738.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jun 2022 17:16:20 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 04 Jun 2022 13:13:13 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2c9a83d262a8feb022e24e9f9aadb66cb10a7a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
