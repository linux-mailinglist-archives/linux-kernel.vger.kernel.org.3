Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DF24A6650
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242618AbiBAUqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242531AbiBAUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:46:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB45C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 12:46:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F5AEB8293D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 20:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 139ECC340EB;
        Tue,  1 Feb 2022 20:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643748374;
        bh=5Uuwe2VsUYSHJnd0ODiV8yQVyoDmE93Z9X9ba1eW3B8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RjZ50mBG4U7O47t4sfj/VVYEajp2BWolSfwM9rdGIoRvMkv3gl1fhFwEiRQHOl8li
         s356BDMVhmxrE+C0atDhbOyoxIbHLSk0TB7hkWjN4ULUFR+gzysAjsrR+c3xJV0Vzm
         Q0KW+8GJWfAOAkvBshqYbrCGz4ff0tVjVodciMYss0As0ypK93203PoG5oKp6LhPzz
         66NJHh+8zDzFuODGKpPazwMW4YYVOBfe7iq1NdlZspuPsxLH9lQ5Zfx7OQZ4wPazBV
         UV+yVRnXAcKEZJN9z/fPL+srE2uw3ZnVTP6DgODUrh0eZuQ1GDMMULPRlZXLcxwpRO
         wHzYIahAQ6yKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 029DCE5D07D;
        Tue,  1 Feb 2022 20:46:14 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.17-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220201155210.2D79AC340EB@smtp.kernel.org>
References: <20220201155210.2D79AC340EB@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220201155210.2D79AC340EB@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.17-rc2
X-PR-Tracked-Commit-Id: b4c18c18ebf7cf1e602af88c12ef9cb0d6e5ce51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e155101c24adb32b26475ca09bab93cf8fd80c6
Message-Id: <164374837400.6282.16773782253194600462.pr-tracker-bot@kernel.org>
Date:   Tue, 01 Feb 2022 20:46:14 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 01 Feb 2022 15:51:57 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e155101c24adb32b26475ca09bab93cf8fd80c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
