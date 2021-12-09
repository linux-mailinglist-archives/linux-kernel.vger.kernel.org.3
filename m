Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB70D46F404
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 20:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhLITjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 14:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhLITjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 14:39:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3FFC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 11:35:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4818B82619
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 19:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9989DC004DD;
        Thu,  9 Dec 2021 19:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639078543;
        bh=UHAQ3KkVNyQ7zaXP9uTLH+2qSQDot4VYNHx/rSmDt1s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tBZOoj3Hn49RZuZ0WfOtiZZQsFqa6D6gVLe1tNJ9dH5yToYj8Mxv0G392PokIARIp
         KjoDwNooVnnpdjlZ2MZbAAGk/Uqf4e7YCad1IUUg5dv3IgPln4DdAm8700cmmboS6x
         94Mg5k0DQqYPtoRLRnXNQdQK55Hf6hVkDql2S4vIYgrkeA92LfMBRHFMJDA/nt4cXX
         dWb9mvbuEFen2R8qiUPOeGddkeIlcEcjgGvcCQlh6kX3LTA5eBHCELNRAJ81x0SlCW
         S1uFGrQaF+W0leDWAZHqeU5f9IuvhklyHRTUdDyzsUAXurQcjzh49M68tvJoSZqJqa
         4yWXBLmsk8HaQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7521660A37;
        Thu,  9 Dec 2021 19:35:43 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Fixes for 5.16-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211209180424.689b70db@xps13>
References: <20211209180424.689b70db@xps13>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <20211209180424.689b70db@xps13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.16-rc5
X-PR-Tracked-Commit-Id: 27a030e8729255b2068f35c1cd609b532b263311
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27698cd2a3c07d124fad6bfc8dd93fd1c5d46879
Message-Id: <163907854342.11961.13203077453860158990.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Dec 2021 19:35:43 +0000
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 Dec 2021 18:04:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27698cd2a3c07d124fad6bfc8dd93fd1c5d46879

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
