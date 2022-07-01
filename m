Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED17563A86
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiGAUJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 16:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiGAUJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 16:09:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108294F1B5;
        Fri,  1 Jul 2022 13:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1EDD62207;
        Fri,  1 Jul 2022 20:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E3C3C3411E;
        Fri,  1 Jul 2022 20:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656706188;
        bh=82xqiQI+o/sJkbEL9KmeHtcAseVsUSnXXfI6jjJ4CZE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RXTzo9c2ppPDT0sq0HFu8MyZtu3TrFFIybOMx/n/9yuOPyrjOSDHbiTWaSrwMPmES
         +UAUDpWjTgRhQrCsnJCdnJP6oezIy+m2hnJErvCFuYhHIt4O5Dj+i/9hrcox62qHa/
         i1n8TG8knCh11IEZP7z1JduVkLwhjHjyFprM/K/lmZ8YeGNFCLKjZSMDGdu7uILmsr
         ewKVBT+g+Ob8taLrMgbgBkbd3j1YPxYUH22eIJG/04vqDNduFNaWcIiavM6Ty3a+F6
         /Dxl0pHeen6t30j1Q6lcN5T8n++G8EcICf5CnLz39k3UaRiHbdaVb7Jj+Zf7zIQ8Ia
         1OI6hVZ3+zeng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E307FE49BB8;
        Fri,  1 Jul 2022 20:09:47 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0i25SEq5cNqC3hxkSJwcpstdJ36_xBVs=wPZ1Dz=TiC5Q@mail.gmail.com>
References: <CAJZ5v0i25SEq5cNqC3hxkSJwcpstdJ36_xBVs=wPZ1Dz=TiC5Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0i25SEq5cNqC3hxkSJwcpstdJ36_xBVs=wPZ1Dz=TiC5Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc5
X-PR-Tracked-Commit-Id: bc621588ff591564ea01ad107e7bae869c1c0285
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ee7827668c7c30f587b0101c4e6240672a4f429
Message-Id: <165670618792.9587.11045852122705336585.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jul 2022 20:09:47 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Jul 2022 21:54:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.19-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ee7827668c7c30f587b0101c4e6240672a4f429

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
