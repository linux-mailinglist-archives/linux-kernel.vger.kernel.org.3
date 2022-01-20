Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384904951AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376767AbiATPoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:44:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45098 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376659AbiATPoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:44:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B439B81D0C;
        Thu, 20 Jan 2022 15:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEACCC340E0;
        Thu, 20 Jan 2022 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642693443;
        bh=ihp0ec7tt5hF7Vi4ToVO4gJNFq/l2QBAwS8VTOG1xxo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qzaMuR/KXFYFIVb4Yv153wBqo+/n90mA38QRbjmmlwe3tLzjJ31nRICptCJMnHr/3
         71ET6DX3l4MoUdfm02FchQYwbDTtTIsuGvA4ersUnBNsQixGAkh5zLI6qZEUV06DwO
         e83h6ClQPnZutzM08ni0qYCOqoHcFpX4BzCldaRDuc6IGmTF2UEIwvj+CgbbN4wbTj
         T+jvZU9G+tOd3s8nCsk4ioYArBFoNxPLTdKgE3BmvVRK6zg9pkns8TikbiC2P+LcbE
         PBpRzbxPxDnizt0SILEru8C0VzJ43idrER4jxW4Nt113X0Tx0ZsxBYNuvw/qyOhWI/
         z9d449HqMlwMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B93CFF6079C;
        Thu, 20 Jan 2022 15:44:03 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220120143228.444087-1-brgl@bgdev.pl>
References: <20220120143228.444087-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220120143228.444087-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.17-rc1
X-PR-Tracked-Commit-Id: 9f51ce0b9e73f83bab2442b36d5e247a81bd3401
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c271fe77d52a0555161926c232cd5bc07178b39
Message-Id: <164269344375.21534.7229673855135332005.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jan 2022 15:44:03 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Jan 2022 15:32:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c271fe77d52a0555161926c232cd5bc07178b39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
