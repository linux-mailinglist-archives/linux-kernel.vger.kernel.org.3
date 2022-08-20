Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DEE59AF9A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiHTSkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHTSkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:40:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007B929828;
        Sat, 20 Aug 2022 11:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF7B6B80AB3;
        Sat, 20 Aug 2022 18:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 754C0C433C1;
        Sat, 20 Aug 2022 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661020837;
        bh=3dRohlvEjVowVvgtVZ/n0aF8iWp9/ZDKrnRxKzH/Vpc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h43jROJiw2RlmQKPSDLKjTLNzmYTF5GhZGXo9Ere3YY1GxODsOyowi8/2r4U0ApQW
         KWYmQllxU0pRtZEydPyF7yJsCXbv44Jk+fVZHsnYfO2zhrP1iVoVZ9YPnVeTw+Gr3M
         6504vjGcX2v1ZAebGfLKIqfeUJOV1t6FWmtC/4hXXlLgvKHx7UsQPrmYGEvVrCAicw
         Bgmbdk6CjcA5V7AGoKU0el+Re/rK38xiiP+mkgdaRJ91HBeNXUUis+rJQNFIpebwHr
         FePVKQ5DE5hayKlVNTlxrTN1lNU1J1sMW/94lRB1rsUYcSkBsN3KaiA5WByd6g76G9
         HGK0pnX8TQkcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 614D8E2A053;
        Sat, 20 Aug 2022 18:40:37 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YwB792JxY0ZO7NBC@tuxmaker.boeblingen.de.ibm.com>
References: <YwB792JxY0ZO7NBC@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YwB792JxY0ZO7NBC@tuxmaker.boeblingen.de.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-1
X-PR-Tracked-Commit-Id: 0fef40be5d1f8e7af3d61e8827a63c5862cd99f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc1807b9158a909ffe829a5e222be756c57c9a90
Message-Id: <166102083739.30631.3053372766246938578.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Aug 2022 18:40:37 +0000
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Aug 2022 08:15:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc1807b9158a909ffe829a5e222be756c57c9a90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
