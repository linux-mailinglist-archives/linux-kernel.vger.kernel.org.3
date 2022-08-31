Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A8A5A8426
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiHaRUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiHaRUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:20:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360344F655
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9D158CE2221
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFAFFC43470;
        Wed, 31 Aug 2022 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661966408;
        bh=JvVCO7glBEeB9eKpbBpzY82yHD66sHCbptPsT72LqpM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D/bYmCh1Xs6KjeQUKzSZHz0+o+s02e65OQg94hkHNcIi4QoswDCI8gLDa0s57km+V
         07Nydt5TG3MAoAOfIzacGW7PYwKm1Nicq8tO2odY+J8NJlhhFEWqQwbE6D+d0l+Gp0
         3DzEQ7HaDGW4S3oW4wT1DEwD+n1hdm0y7WWuVgxIjUMOD8I9xUZ/BkBXhBn6712PB8
         kmF6wqcdtrypxOUOXSaiFq3YdQG9/N2bNa8XO3a4XviSfIN1RPQBPADT5rdFWrryC+
         CWNvHXLcUu+PP0Y8td5BqarDIgA/s/2ZMpYNHJL1GD0R33pGcCYp5IfdiTDqzfl5e8
         yTCnJlc1R3Isg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4C2DC4166F;
        Wed, 31 Aug 2022 17:20:08 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2208311248520.19850@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2208311248520.19850@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2208311248520.19850@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022083101
X-PR-Tracked-Commit-Id: 1ff89e06c2e5fab30274e4b02360d4241d6e605e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1f764268f3390406f4dcbe3d2f537f2424f22ca
Message-Id: <166196640880.5039.11347104275127539151.pr-tracker-bot@kernel.org>
Date:   Wed, 31 Aug 2022 17:20:08 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
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

The pull request you sent on Wed, 31 Aug 2022 12:54:14 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022083101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1f764268f3390406f4dcbe3d2f537f2424f22ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
