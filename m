Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB00C4EE4B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243049AbiCaXYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243036AbiCaXYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:24:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0E724D9B2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C08EBB82299
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 888FAC34117;
        Thu, 31 Mar 2022 23:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648768976;
        bh=Ws92oaqTTWvY8mi+41InfhScz80iG1C2A5sr4IPCd90=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FCqu7CR8kD2l/knIFKpiv+MtaxLZM3GOAn+Qy6hCruSqslehijRwlHa6ZvklT625W
         2GcShInzrUaV2OhnznbNKrGILcZtNut4IlXI1vBGOcrSVQtHSTXKcozd3mQL1HHqm3
         qZ+VQJpsgc4HS+BL6TPJayRrmnTwvOtL3l5qDKYpmGptugKOrLPU10N4vJ3qtl00LJ
         p9viiM3StwDLP/YenSCEUFTxO+KmeTvqynfnNhXMRqLmTml3LHaMvSGcasr1rDYECs
         cg0yIQmmvbZHgSCygX9c8YdSsOSQu32fdEqjSlw4HU94ApmZomQwu5FfO0KRRp/w4A
         wykQ9tlFFe1Ag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75937E7BB0B;
        Thu, 31 Mar 2022 23:22:56 +0000 (UTC)
Subject: Re: [GIT PULL] UML updates for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <738009331.204323.1648760650240.JavaMail.zimbra@nod.at>
References: <738009331.204323.1648760650240.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <738009331.204323.1648760650240.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.18-rc1
X-PR-Tracked-Commit-Id: 82017457957a550d7d00dde419435dd74a890887
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8b767f5e04097aaedcd6e06e2270f9fe5282696
Message-Id: <164876897647.28012.10192085287132293994.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Mar 2022 23:22:56 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Mar 2022 23:04:10 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8b767f5e04097aaedcd6e06e2270f9fe5282696

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
