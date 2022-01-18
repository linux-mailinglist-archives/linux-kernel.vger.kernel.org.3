Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120B7492073
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 08:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbiARHl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 02:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245675AbiARHly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 02:41:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3BAC06161C;
        Mon, 17 Jan 2022 23:41:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CAF17B81259;
        Tue, 18 Jan 2022 07:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 829DEC340E7;
        Tue, 18 Jan 2022 07:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642491711;
        bh=t+hI1YW0i9jZ35nCwHD9ZCKmd5tDavoMIhojnVV/ROg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XewTIp2GEF6HYWk9E18NP7Z1Cbg4riZCKlpZul/+OMmO4raGD5DVlUVr+Qw3xx01t
         XIgIzGfRW6bJp1EPh4WtgW5daPxNUj53Uzk+S7J8XSO32s0ZT+ARMUq49X8PgIOMYt
         5ouAzIh5vpdDw8PESjdHRudYwdZSC/L0hrdwWqvYIXTR+VNlFB/vpdDa654lKK2J9K
         GQPtMvKoZ6jZZNSmy/0eCuc8ph19pNHt5whGk3jN/YFq626Dy3E6iQlP4LHbrRlz8Q
         Ti6HDQSS8bHJf3Sumf3nDBY5tKD6epF1sMWF75OcAedpi2UveDsvSdyWPwVoZHMKEx
         Z28Ueflfsp8wg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E89EF60794;
        Tue, 18 Jan 2022 07:41:51 +0000 (UTC)
Subject: Re: [GIT PULL] remoteproc updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220117221027.1695011-1-bjorn.andersson@linaro.org>
References: <20220117221027.1695011-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220117221027.1695011-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v5.17
X-PR-Tracked-Commit-Id: cfcabbb24d5f4e52ce2e7797cbcfacd8fe932fb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46a10fc3a2beddd79dafc3cd800f14bde0844387
Message-Id: <164249171144.10229.12296458512542955577.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jan 2022 07:41:51 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Massot <julien.massot@iot.bzh>,
        Hari Nagalla <hnagalla@ti.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Jan 2022 16:10:27 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rproc-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46a10fc3a2beddd79dafc3cd800f14bde0844387

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
