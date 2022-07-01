Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16F75638DE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiGASCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiGASCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:02:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F2240903;
        Fri,  1 Jul 2022 11:02:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF745B83119;
        Fri,  1 Jul 2022 18:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90960C341CA;
        Fri,  1 Jul 2022 18:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656698560;
        bh=mUewwZomQFXBvUrwaM5ucAhhLviRGfFQHrA6TKl1zH8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IxNflo1c0ATiK8LHt5q514eS6J3w02MZ8ivDZmu34vycExHXicyNQXXVDh8ZmBNm2
         9JD5iGnIy9nKbgvkTOlnOv+6THmohwAq7BV690rJMOABVoOY30zW58p+35eSJwdIxq
         O+2QCx34XlijBwO5H4UclpI8voBFk0gvEoClyux4cs7t6h8LSC+3R33MNRdOwyR2Zj
         4I2IDl4Jx6MtgKhn9lGOWQSElhz1lzmw6cOhZ6b2QC6XOyVvpkHQBhaXhgdyT2f4+D
         lvK/U2vk0TIpCdSq9qQVBGnPlUm0ZjmqpBd5EqtSnPHETYLl2aCXQ7jbsmQHcUofqI
         iWO66LlY67j5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DCEEE49BB8;
        Fri,  1 Jul 2022 18:02:40 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ace8c857f48306f2c63169d85baf1f539f3a4fbd.camel@HansenPartnership.com>
References: <ace8c857f48306f2c63169d85baf1f539f3a4fbd.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ace8c857f48306f2c63169d85baf1f539f3a4fbd.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: fce54ed027577517df1e74b7d54dc2b1bd536887
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 067c227379c0ec96cb19ed9aacea6b1281982368
Message-Id: <165669856051.14842.15855873832405559486.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jul 2022 18:02:40 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 01 Jul 2022 11:26:39 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/067c227379c0ec96cb19ed9aacea6b1281982368

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
