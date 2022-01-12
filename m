Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA68348CC26
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357460AbiALTkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:40:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50542 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357376AbiALTkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:40:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A695561AB9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 19:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C3ECC36AE5;
        Wed, 12 Jan 2022 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642016406;
        bh=SakW0s7MCtFOn5S2YW1zPJ6Ax+ZgmrV6AidBw7w2pOM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QpA5pJ14RPY3dTcy67bhmKy8/XrC+pZ+cidWsWzkbL/2pZEtki0byqkLfhOufc0H1
         Qz6PIvowcoudwVU4T6tAwwQNVSCaBhpLYCEJzVqV/q9cRkzmJOYceCeaGvv8Kx/PMH
         XKdycvpeenxrcTUGE7AkDUHqw6d4vDLoWUPwlju2YgLkkKQC8r4IooQXevaF5dRynN
         nfI7queXgRH+VQVKSsmyQ0jMdOy6XBg8HfJ5+jsSkU4jHvuadHSnfqp84Dwy+tCXUy
         MwidE00Df2D9ofV/C1ke5iIm2ozdqVBbp7W/EUEXyaSZXMdjV7H35RLkPEDYbVC9ql
         D3sXoMwbMpqqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09512F6078C;
        Wed, 12 Jan 2022 19:40:06 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd7d1E/0k0IIEl0G@kroah.com>
References: <Yd7d1E/0k0IIEl0G@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd7d1E/0k0IIEl0G@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.17-rc1
X-PR-Tracked-Commit-Id: c9512fd032acfe6f5198c30b6e7e52e0a7df5d31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6dc69d3d0d18d587ab9d809fe060ba4417cf0279
Message-Id: <164201640602.24328.6304285397674346024.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 19:40:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 14:55:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6dc69d3d0d18d587ab9d809fe060ba4417cf0279

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
