Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4687048BBB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiALAOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:14:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36372 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347000AbiALANr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:13:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD43D61624
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43C85C36AEF;
        Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641946426;
        bh=B+sE0Y1tgVrEWvKmPLYv4GmEQRQPrkms2ZT0/qsWG6c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AF/bPrPTfjPZ8rwpBcEinH2jnlw159ocGsM8Cx2WCIWW7D0NwLnzZ0nELvawmVTNm
         2DZWgAlx+AkwZHukLdXuFYUDmmQ66Wu7/Oq7qKaAclQ/bk6z/NeG/w77fvMyRl7VXJ
         oHTJ4Z4KOoNgFod03c2DOCp93ADuTNq6TMQq9e+OOP4O2nKd+Sk9reZeTj6tAFeeQ2
         FlHhcYRGZTKWQIdf4k2FVDAfu+iTymvFni5/lSlbwjBwLUZUiOQ/iVAnUb/LiyvPzs
         hgSmYQQXPX4wqpVCVG190+tIvl1mFq+odsR8VkepSErZReyEBDhTSF7b5DeIuzHbUf
         viM01wVBkViCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32507F60793;
        Wed, 12 Jan 2022 00:13:46 +0000 (UTC)
Subject: Re: [GIT PULL] UML updates for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <10132756.248426.1641887569979.JavaMail.zimbra@nod.at>
References: <10132756.248426.1641887569979.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <10132756.248426.1641887569979.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.17-rc1
X-PR-Tracked-Commit-Id: db0dd9cee82270e032123169ceff659eced5115d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f69212114220edf8372867088b97b47760b6839d
Message-Id: <164194642620.21161.4424766424927690878.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 00:13:46 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 08:52:49 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f69212114220edf8372867088b97b47760b6839d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
