Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60548DCC1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiAMRQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiAMRQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:16:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20419C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 09:16:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE3C0B80934
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 17:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8487EC36AEB;
        Thu, 13 Jan 2022 17:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642094200;
        bh=A0qwIcrArpKdkSLw1mZRgcHEcD+Xd/5PHSzQZjcXIRI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CUWtlrXudTPAyrUbyr3Stg/jra1j3JghclNfIz+OY2JDR2he6M/99IxpgTEiFAEWX
         JnDG6kXyHv02jcVr6hr0Pi8SvO4Y6a93CDzPpXsX02fURyUwgY1u+ddGLM4HY1zoPr
         y5vfn7+QA3lrAqFk60WCJE44KIs8/pfoeFpqVJ6xktTn1KlBZH4f2ipO1ssQRom6zT
         FwHY7+maTRL/rNqJgBNL1X1AYD0QwT/jZ4RP5OadVIfc/MAK1SOaSkioicj8lkbEwg
         PWcVeCfhrF0V2+O00xaFF+5d5J8S0gkqgYt0Ndh7bWJHqDY4jlgb4Jjut8WLjZBAS8
         B332aAgLHjWYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71F26F6078E;
        Thu, 13 Jan 2022 17:16:40 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <164206863332.82661.16045492031950918045.tglx@xen13.tec.linutronix.de>
References: <164206863083.82661.4520085707599437707.tglx@xen13.tec.linutronix.de> <164206863332.82661.16045492031950918045.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <164206863332.82661.16045492031950918045.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-01-13
X-PR-Tracked-Commit-Id: 35e13e9da9afbce13c1d36465504ece4e65f24fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd04899208d2057b2de808e8447cfd806fd0a607
Message-Id: <164209420045.1143.12263721761712637361.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jan 2022 17:16:40 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Jan 2022 11:13:21 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-01-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd04899208d2057b2de808e8447cfd806fd0a607

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
