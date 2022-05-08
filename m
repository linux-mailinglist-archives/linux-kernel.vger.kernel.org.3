Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A43451EF48
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbiEHTH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379975AbiEHSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:44:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D39BBE04
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98174612AB
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 18:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 049F7C385B1;
        Sun,  8 May 2022 18:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652035260;
        bh=tD/Da+t5Y2v4PFqm2+dfJQeXB5CoZm2hrbkJsc99IsQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qe7tM50gj7L/cmGsw6S0h+1RdfTYKRrE1ZZHZ4+e+tDkpbn0VTIzwUDQ/Vfz4nzGR
         jGadjqeA2119Ox+ZlUmPylu+Hj325f4wmGSpSam/wSkPu5hSxJLejSA15VuSgaQ9EU
         No8R1YdB7+CgC2QDqBsL4tjATl4eTpXcD2nWFCVfJq64GOv+sCBFiS4QurFzY4DRUy
         Ilt11qdbwYPgRvwJNvR1awpfT/eCPPStcQhpKrwiQmMhpDvg5ESp7KO5PFUdgae3vu
         L7hKJ2Si1AUKjemNobdjfY8ydJpFvDVvHJg/mU5JYRogG2yZCS1IRrRpdobdl2zy64
         B091DwEA+b3Hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E23B8E5D087;
        Sun,  8 May 2022 18:40:59 +0000 (UTC)
Subject: Re: [GIT pull] timers/urgent for v5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165201148510.536527.10163841261763309889.tglx@xen13>
References: <165201148069.536527.1960632033331546251.tglx@xen13> <165201148510.536527.10163841261763309889.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165201148510.536527.10163841261763309889.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2022-05-08
X-PR-Tracked-Commit-Id: 2c33d775ef4c25c0e1e1cc0fd5496d02f76bfa20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea82593bad9a77f6f14c9701c13ff7368b22f027
Message-Id: <165203525992.974.17660962951273192852.pr-tracker-bot@kernel.org>
Date:   Sun, 08 May 2022 18:40:59 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  8 May 2022 14:05:24 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2022-05-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea82593bad9a77f6f14c9701c13ff7368b22f027

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
