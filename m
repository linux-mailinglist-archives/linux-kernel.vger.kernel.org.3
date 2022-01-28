Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6B49FFA7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350711AbiA1Rg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350499AbiA1RgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:36:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B546C061751;
        Fri, 28 Jan 2022 09:36:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D80DDB82656;
        Fri, 28 Jan 2022 17:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F503C340E6;
        Fri, 28 Jan 2022 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643391360;
        bh=WQZ/mWm2lpWMiUPo+FywdX/Py8CIb0JBXrJutwPyRdc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nDD6nHiZr6bBSDWbKtUaJi2TncYHmrMYlYP0JHxyfXPPTSRyiQHRuO3KtkTrKyWJq
         TtlrDTOZ14njaharm4snitjZbsdSR13GknmZmJNi7w264VHJTtA0RkFrUzYxpPbY7m
         ApOAdhPKbHRhuDdJZvn/Niko+uoog7ya05CuKfdOZsJOQBRc0GUw9TiCUjKNgg/59o
         o6pWukCiIDf4XFV+2YtzN6lTt0L0fLgIzFbCSGsfnxGPMhqpA6P5ss2mZ9O4oraxbT
         lasDLzwhiTjhQAKl1zVC8BOLqkkanMuIzKXXO7B/N6F209qdQ7UUoIhkHOfvE/2dKU
         a7K2l3UvSgjGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C74DF6079F;
        Fri, 28 Jan 2022 17:36:00 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220128133345.GA10829@alpha.franken.de>
References: <20220128133345.GA10829@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220128133345.GA10829@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes-5.17_1
X-PR-Tracked-Commit-Id: fa62f39dc7e25fc16371b958ac59b9a6fd260bea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0152705e4630b4a6ae8eb716aa44ed5a90054ea
Message-Id: <164339136024.16649.5575093232445715999.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 17:36:00 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 14:33:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes-5.17_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0152705e4630b4a6ae8eb716aa44ed5a90054ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
