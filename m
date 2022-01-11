Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C3B48B8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiAKUxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244587AbiAKUxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:53:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817FAC034004
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:53:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 221F66177A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89A26C36AFC;
        Tue, 11 Jan 2022 20:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934388;
        bh=bsCwPr8YjZCV5B5JUKIbuBfkvnohHQOycXZF8HcZi6E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MTqsN2I3ev/FtFAQIpiUUqGtzibTOsSGDzcaaKzJlBMF5GYXoWhFLKiX+AiLsXvJk
         3zS660ZlE5q9Cmd7RSimnpk43lBWMPX2bIZIu25XH57xr3qRkByxa96tFtmtt1J6P5
         5GU3GI4bHezwdLESpblaytSJYT2tDQr6JtRK81A8VJUNhy58tvXo7RRWR5Y1HkQ/Vp
         0jnu+ylH6dqBWutcpDNTFIywMGbm7Mg3z+luWwzvFZJVq80pYcBKE/jyolb0T86nG5
         L8BrJ3m8cs4XdU91njpc4cpwLAlUYYZUg+dP3QMv37P7AuscANhQT3ogKXFob9GZMA
         c+DDL58dKb5/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79120F6078C;
        Tue, 11 Jan 2022 20:53:08 +0000 (UTC)
Subject: Re: [GIT PULL] hsi changes for hsi-5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110094924.2s4tczld5jjroeu5@earth.universe>
References: <20220110094924.2s4tczld5jjroeu5@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110094924.2s4tczld5jjroeu5@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.17
X-PR-Tracked-Commit-Id: a1ee1c08fcd5af03187dcd41dcab12fd5b379555
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46a67e764884878b61007c9cea40295d02a24fe1
Message-Id: <164193438849.11435.17028707475042180133.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:08 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 10:49:24 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46a67e764884878b61007c9cea40295d02a24fe1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
