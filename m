Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326304C4FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbiBYUpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiBYUpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:45:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDF51AAFFE;
        Fri, 25 Feb 2022 12:44:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93C15B83377;
        Fri, 25 Feb 2022 20:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3686EC340E7;
        Fri, 25 Feb 2022 20:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645821870;
        bh=RBSGcynFsGOIZ0yZcF9ccn83g+TvOmmfcfeka8M1WcI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RX51k/dg+b8Un/g7CXEfyaq1m+Vimh3zfelUllngReKFdeCNDySX0JCyP/bPccFni
         WXviRD1IrsFWdHBBhLrg4Dh+UCGBBHZYjNq/QId2uVUktPHLC8ptZUmee1MSkCZxRc
         7R2jjwmY5JhCBIG3m02yXVrYvnvBBPN6tyx9xzO8wD9RirMMiwCl52nvlAql3s31Fw
         VcJyA9F8OJznJvjaoAkRY/G49XWgXcd/upjOj9GVMGphBQEnBmJ6upZKXlp3FLivzU
         ul0InH0eJhBZVMpUWGnCRNFUyAyPBKOeaBdoINED6kwoJmHGvhh7In9KECOhs1UNgd
         TanUsDbNKp4YQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16701E6D4BB;
        Fri, 25 Feb 2022 20:44:30 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control fix for v5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hhiuXu=rKp8=gfMh6Xm5cT4-EK2QduofM2bUgY7jMqCw@mail.gmail.com>
References: <CAJZ5v0hhiuXu=rKp8=gfMh6Xm5cT4-EK2QduofM2bUgY7jMqCw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hhiuXu=rKp8=gfMh6Xm5cT4-EK2QduofM2bUgY7jMqCw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.17-rc6
X-PR-Tracked-Commit-Id: 3abea10e6a8f0e7804ed4c124bea2d15aca977c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e48cb5c2c65db87cf1269ca004e111764da6cc74
Message-Id: <164582187008.27616.5119390862849636582.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 20:44:30 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Feb 2022 16:33:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e48cb5c2c65db87cf1269ca004e111764da6cc74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
