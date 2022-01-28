Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4908C4A00B5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350854AbiA1TOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:14:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40504 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350845AbiA1TOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:14:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4949261BFA;
        Fri, 28 Jan 2022 19:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B06B2C340ED;
        Fri, 28 Jan 2022 19:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643397284;
        bh=cwb1NYuNwOuVpkxTfvvlwZjeROZeQ3h2/Szp0mqINTU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fOHxpdG5ly5nHcXycC87KwHAgmCCLMZsqnlL/hcsYUog7WPvzVxNonKoiaoKPohIQ
         pMBhK0EBTQY3qI5GIrCHrjTU3dcv4zbIuulVmGOoTkLfn3atLbNHu/v6zMqwYFfS3x
         i1orAYFT+6QlBB/JxYZ0yjicFxKgn6P7PYRAry3ZTyXGcTQ+APzWV8UifwNAnVMX25
         CxsieJunfI/lx3l5iuAcXfORvCpjchHjbZEYZSgRdZpAHriREWXENGcGvup2yM4zWR
         AZAWL8sPi8jmK8G0AcPLJXqnsRu51XgquZ4cd95MplUCYQLB3zuGvOE4TzsZKfeFUq
         Ai3a9ElMNQMbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96C56F60799;
        Fri, 28 Jan 2022 19:14:44 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jeB_WPnOJBzTk-VeOtdbwWFE4tLvVQzZH+Bhe3Q1pSdQ@mail.gmail.com>
References: <CAJZ5v0jeB_WPnOJBzTk-VeOtdbwWFE4tLvVQzZH+Bhe3Q1pSdQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jeB_WPnOJBzTk-VeOtdbwWFE4tLvVQzZH+Bhe3Q1pSdQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.17-rc2
X-PR-Tracked-Commit-Id: 33569ef3c754a82010f266b7b938a66a3ccf90a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7b4b0076b5c76090b35c1eb8eebe308ce800b2d
Message-Id: <164339728461.30751.4404221564952754348.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jan 2022 19:14:44 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Jan 2022 14:03:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7b4b0076b5c76090b35c1eb8eebe308ce800b2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
