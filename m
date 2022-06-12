Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A654780E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 02:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiFLAdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 20:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiFLAdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 20:33:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CBB3DDF2;
        Sat, 11 Jun 2022 17:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9165EB80B73;
        Sun, 12 Jun 2022 00:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47B9EC3411C;
        Sun, 12 Jun 2022 00:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654994020;
        bh=buLTWx2Jh9iWTHCfilb1zuCO9rv7g/ztJ2zF9KV26Hw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Sc+aJv2j0PK3025YGnyjCsF7b2ZczdN5/ADvN/9s22lj1v95zS3SrHhwJ1gvMHbZS
         s/Zv49h6oH5boA84mWp/u1dfWWd2zSW9ZMvh1uonG4DB+6RR6jo5eefTgz22x6zXg+
         RFheFxJFQKDV2rrGtzeDQ6srepomz652H3vnf9NATkHRQwDpk+4oNlTtnHCpC/IDTg
         EnZKV61Vc+ZPCM7FPeUSZaUf5PtO6Iyys2GYTlG4/mDmzRlSVvsmgQkVY7lhnfu5cc
         oywwS0zdcuTPaxuYt377qWa6E92aoBfUgR4Ys1iBRSmSMLIoTcUGEL5PWOK1jb+P4M
         D0/HypsCemfTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F392E737F4;
        Sun, 12 Jun 2022 00:33:40 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7373802fc26a9a41b2dd4f5c05f993f574365029.camel@HansenPartnership.com>
References: <7373802fc26a9a41b2dd4f5c05f993f574365029.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7373802fc26a9a41b2dd4f5c05f993f574365029.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: ec1e8adcbdf661c57c395bca342945f4f815add7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cecb3540b89ef2b586d07c1bd69408e251791b76
Message-Id: <165499402018.23172.11406827094090410009.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Jun 2022 00:33:40 +0000
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

The pull request you sent on Sat, 11 Jun 2022 08:22:17 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cecb3540b89ef2b586d07c1bd69408e251791b76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
