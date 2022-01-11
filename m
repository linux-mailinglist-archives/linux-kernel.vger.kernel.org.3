Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338C148A6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 05:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbiAKEzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 23:55:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43666 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348117AbiAKEy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 23:54:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73D2EB817D4;
        Tue, 11 Jan 2022 04:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45A25C36AE9;
        Tue, 11 Jan 2022 04:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641876897;
        bh=l3D04WQcgiqYfVqmJu/Rd+fSWi9TCFEshgHuORrEbvM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X1wZ2fxc6bMGG/Y/IXyOh43BrxiabUm2XiOGkMJ8Ew7JtFpyiNx3NHnB+brscRhZo
         wFfUtYxWwi7ul/swWcRutNMpDDSsGFqvqAe6u1OgXJqS3GK0LHHQW4h8VlosbRb5kU
         OLhq7KURas9ZdFvqB1drdrcDiQtShliAkJgrM0fMnlL+bm1WU+iMH5PDl9Gkwuygxb
         iwyvy/bpnOdFMiSKOuiOCjLWRpnI76VhDC7rxGsZpBGMNpMT4GLGS82Nm0ICUmymqz
         1/NRXjFXEn+jlUuduSFF/hsMz45d96tFe68YxdrwpEl8url7KN4czpmUqLdC1ALyuy
         7xDovRo0b2bCg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 318DAF6078D;
        Tue, 11 Jan 2022 04:54:57 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hHd+um2KOmHvLuixMUoTSmD3=OdcGuXz0oLizJ0m3B=g@mail.gmail.com>
References: <CAJZ5v0hHd+um2KOmHvLuixMUoTSmD3=OdcGuXz0oLizJ0m3B=g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hHd+um2KOmHvLuixMUoTSmD3=OdcGuXz0oLizJ0m3B=g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc1
X-PR-Tracked-Commit-Id: 70df8e1bdc941431af2370270f5140291dcbb282
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bca21755b9fc00dbe371994b53389eb5d70b8e72
Message-Id: <164187689719.26750.17995351493606263285.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 04:54:57 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 20:13:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bca21755b9fc00dbe371994b53389eb5d70b8e72

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
