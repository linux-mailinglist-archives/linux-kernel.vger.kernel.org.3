Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479B64937B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353364AbiASJsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243624AbiASJsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:48:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 01:48:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CA49B81910
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA590C340E5;
        Wed, 19 Jan 2022 09:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642585692;
        bh=iWKKx5io6KUyHwyzoYOZlJXeJdppkve6no+RNsA9mds=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e+qeB7uSEawCukvb1YiIGVIXeRWNeViK7avaVhgRhGNUF4qvPKRa34ayzvYX+fV7I
         1+dK5T+iq/SlPRNI9tBgY0+jjvs3Ri1N4TVegS83bC+1not5Kb9jLGeLXQX57qhyaS
         837M+sQlYKJPKnCtyBlMbh0fWfn4bmdAJf83LIy5ptwDI0OzzSzL9PijvmfHLsQHJM
         yZbbLTxTvvXfaU6UxjpYamOOrT1NYcNxsh4VdL4AReLw5Q/ghsQJCMl0ovQNMhjwLj
         1ZeRleQLbEHYzQkFXWEo35jf1EFYsIpz03qWZB40+zmRJy1wuKV4z3iir0Z8EWILb8
         Z7A68k6Y29ptQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8A85F60795;
        Wed, 19 Jan 2022 09:48:12 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 5.17 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-d9275aee-84cd-428e-8732-adfa59900a9d@palmer-ri-x1c9>
References: <mhng-d9275aee-84cd-428e-8732-adfa59900a9d@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-d9275aee-84cd-428e-8732-adfa59900a9d@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-mw0
X-PR-Tracked-Commit-Id: b579dfe71a6a5c3967ca9ad648673b6ca10ab0d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1b744f65e2f9682347c5faf6377e61e2ab19a67
Message-Id: <164258569281.19279.8075866123840125296.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Jan 2022 09:48:12 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Jan 2022 11:04:09 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-mw0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1b744f65e2f9682347c5faf6377e61e2ab19a67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
