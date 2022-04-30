Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4361F515F8C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 19:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383237AbiD3RbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 13:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243748AbiD3RbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 13:31:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEB928E34;
        Sat, 30 Apr 2022 10:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C212B8077F;
        Sat, 30 Apr 2022 17:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D711AC385AA;
        Sat, 30 Apr 2022 17:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651339663;
        bh=bGwSKDTOvceR4fmtlvcP/la8/7OZjJm+V8h3ZJYixgk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hKfDTIZ24FBGnVEpe5piws7si5ThflKR2Rmpd4LHUbpxWztf2eZanStBHwFkiFeR8
         lll9LK0KQlkiTKX6wPg/vHrpifrryPoWCzytsqZNsbDInXu0gf5jcofk6Ow3Kyr9fm
         cIoYAE0C1sZJlwXCaQImAHQq1Hp+CtIGbldBRIZL/9SsZBoqGe8YZrI3/HOXnT2dlj
         JK06I6AZKdh5Y/yvMuGBJjCuTE71XqHw8USO3d7WtgDNhK3MAlqGVoyBIQJeJtLEC5
         6IF7lV+AvyXy3aE6avhkIptp58UNZm+2qgbfeMq/fCOq3KR4u+uNGFKvr9iE8gILlm
         XtlCfyQS/UKTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C521DE8DBDA;
        Sat, 30 Apr 2022 17:27:43 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c0cce549e81dd3b773bc30bda30212d94ae0759e.camel@HansenPartnership.com>
References: <c0cce549e81dd3b773bc30bda30212d94ae0759e.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <c0cce549e81dd3b773bc30bda30212d94ae0759e.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 8be70a842f70c0fe8e00fd488b1966344fa10ff4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9512f3668b7090be7a149fc38026729d96e944a
Message-Id: <165133966380.20469.5776116866631255344.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Apr 2022 17:27:43 +0000
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

The pull request you sent on Fri, 29 Apr 2022 23:23:36 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9512f3668b7090be7a149fc38026729d96e944a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
