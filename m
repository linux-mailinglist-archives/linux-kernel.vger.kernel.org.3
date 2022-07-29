Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF445855F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbiG2UOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiG2UOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:14:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3D789EB3;
        Fri, 29 Jul 2022 13:14:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BD6F9CE2BD9;
        Fri, 29 Jul 2022 20:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB5CBC433D6;
        Fri, 29 Jul 2022 20:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659125687;
        bh=ykpusgUN+Wy7D2gUWSGzrQjY86z8OOUvZz9K3vERSG8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PbeTP0J4vMdUfNFm5jFFGs6Hwfo5UWChfBkHaVaNfUTgjL6WLUTmmMRqqZeP+D9Tz
         HPWMYtBQJG5NCBYzwG4420L7vWvTboYHfEPV/usm1RLGwhevlQzMJivEcXrBEW2jNz
         xZNYTXeVxhGChbtig1G1mJR4pcFaffrT2+7wq+EAdxothmiRwbo34WiGFLXaCiPh6F
         VdNw3kr4beLFU4bvsTUK1x6nHoQjlUMEqHFhvwmPgVxZs+lBMnRUkUSHk83Nc79s9y
         2q0wWk03VQP11H1z7PlQR5H1NBFwpDn4DrNxs/Ue9q8wPXO76HMfxlBpQ6xVojjO36
         kAw+3L0inxaXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C72A1C43142;
        Fri, 29 Jul 2022 20:14:47 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.19-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d3a4b15f5eab509f9830f858a82f0db394d201db.camel@HansenPartnership.com>
References: <d3a4b15f5eab509f9830f858a82f0db394d201db.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d3a4b15f5eab509f9830f858a82f0db394d201db.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: f5c2976e0cb0f6236013bfb479868531b04f61d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c8ac1c4af178ebcdf6fd4a0ba11716e2c814593
Message-Id: <165912568780.21424.9938780429617910310.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jul 2022 20:14:47 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Jul 2022 15:42:21 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c8ac1c4af178ebcdf6fd4a0ba11716e2c814593

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
