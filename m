Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A734A2F8A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 13:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350313AbiA2Mvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 07:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347857AbiA2Mvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 07:51:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF2DC061714;
        Sat, 29 Jan 2022 04:51:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F295060BA0;
        Sat, 29 Jan 2022 12:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65F5DC340E5;
        Sat, 29 Jan 2022 12:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643460708;
        bh=8K2PUV+b/ZheJiq0fuRjAuScA4CRH1TI4jWAi+4Pb9Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=h6cc+36At3Q4JS0gBoF48deL8kW7BXHjgGuLLZw1D9Fkff6NWsxCwOhxIB3G9x0A6
         lvUPmrHvpoCE1IBJmxhR7nUr7JP4SFqaIt9WGHimrZnvGtl+41iiObx6VgFQW2QTCX
         hjfctSGrok/bUq9pK8V3l0ibubXxvnT0pNXW51uVcOZbBtTmf6JdjFDAwoCjZZZ1NK
         YaczZy/vUITGlBA1LmoFOLIPN5laWe/YqcEETRrFtLSrGJaKctP7fZt9Xp4VlXEzQr
         RgCDoE3bgsuNVT8aZQUR2oee5dMZC6FpzH2pwPl1qaQ4W7HzJaiPPIcQ0wHku0Zn+R
         bY7nPhPwsVQVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55DD2E5D07E;
        Sat, 29 Jan 2022 12:51:48 +0000 (UTC)
Subject: Re: [GIT PULL] security, lsm: dentry_init_security() Handle multi LSM
 registration
From:   pr-tracker-bot@kernel.org
In-Reply-To: <88413260-5f31-7fbf-7127-715051ca5ead@namei.org>
References: <88413260-5f31-7fbf-7127-715051ca5ead@namei.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <88413260-5f31-7fbf-7127-715051ca5ead@namei.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.17-lsm-ceph-null
X-PR-Tracked-Commit-Id: 7f5056b9e7b71149bf11073f00a57fa1ac2921a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1e7f0919ea84911e2ab965418cd502ba6a906e1
Message-Id: <164346070834.2828.2030565672191430601.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jan 2022 12:51:48 +0000
To:     James Morris <jmorris@namei.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Jan 2022 05:57:37 +1100 (AEDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git tags/fixes-v5.17-lsm-ceph-null

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1e7f0919ea84911e2ab965418cd502ba6a906e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
