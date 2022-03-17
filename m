Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF54DCF80
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiCQUmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiCQUmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:42:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B523F2AEA;
        Thu, 17 Mar 2022 13:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D9B1B82007;
        Thu, 17 Mar 2022 20:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F23EC340EC;
        Thu, 17 Mar 2022 20:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647549658;
        bh=bSCKPhgw1emJ6pzl0laqjPJuiBh+rDuGgXhhIH9MpEQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FBCrC3E6Rcers3DJe59uuzDbcFNEWEP+lUsCJ4wP10+rbdwlCSTdNtnp5ojJC5zX0
         Y8GSXsDF947ivRtT/q4VveCzNO3mbcecot1ilbfhUwfJNEqf9SDIq6bhunQ9k77aY6
         eNO7EFH9/WqUM7g1KI4QtDFFCyeMmr72cStlxoddewEPbbN7aIY6LIk7xvPvQCRmoo
         lniVXimI1PWYXd8s0eRfQyvqeANCdb2LCfB6mjM0R/5A//U7q/viox3bAO4csu/Epf
         WwfvjCDn+9M4xFe54RVMn3TodwW7gkt6EAWPhmu+p/2UrERDKNKkLpb/Li22DhYBuh
         HqNUTuF0+eS4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA808E8DD5B;
        Thu, 17 Mar 2022 20:40:57 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for final v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gcZb9mq4WfHuGC-3zMx215u_cYMzwTkx1jxgZmu_EUbw@mail.gmail.com>
References: <CAJZ5v0gcZb9mq4WfHuGC-3zMx215u_cYMzwTkx1jxgZmu_EUbw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gcZb9mq4WfHuGC-3zMx215u_cYMzwTkx1jxgZmu_EUbw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc9
X-PR-Tracked-Commit-Id: 462ccc35a750f335c8456cde9120b8b593fff60f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c81801eb7f2476a25d8fb27449e01b0bef46908a
Message-Id: <164754965795.20112.7421154161369091909.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Mar 2022 20:40:57 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 17 Mar 2022 14:02:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c81801eb7f2476a25d8fb27449e01b0bef46908a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
