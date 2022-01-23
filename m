Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CCD497059
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 07:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiAWGSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 01:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbiAWGSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 01:18:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF38C06173D;
        Sat, 22 Jan 2022 22:18:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC68061152;
        Sun, 23 Jan 2022 06:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F39CC340E3;
        Sun, 23 Jan 2022 06:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642918699;
        bh=cK6NRSvPeqbKI4bl0jMNbw+27vLfFZcsUztrGVVT/os=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D0xfbicGEfYz3n5wJ3tiPryKCpQCFOTjaoqWKdJO54wEE3y+e8EubRHqppfqxIEGC
         9K9URqpiKvckuL4vRkL2pCeZ6mUlygStvgkXYyvm/aHZ67yJWFRdmK4r+VU9d/xmpz
         i0eLSZd4DyRXOcT/jkbSkvpQaoL/DF3fNj742yYivrvJnN0ss2JbSK77m/wYdGElyj
         Fn+2msHOgDw+p1q1u4T33zKRrKQBSpu7Vq3IE4JL6AKqRu9M+KVgE3/i2KF/A1yTDZ
         VxOoTHMaRrJgicSEM4bvU3f0wkw20KXXcSfMxEq6oL5rL4RUWEU7La4cG+mnLjQN5L
         CsFw4YR918zfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0FE5F60795;
        Sun, 23 Jan 2022 06:18:18 +0000 (UTC)
Subject: Re: [GIT PULL] Bitmap patches for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAAH8bW_3mVqCxebkYeY0XKBfTAjPi1dtygCBEy4GpqvyeKAPqA@mail.gmail.com>
References: <CAAH8bW_3mVqCxebkYeY0XKBfTAjPi1dtygCBEy4GpqvyeKAPqA@mail.gmail.com>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAAH8bW_3mVqCxebkYeY0XKBfTAjPi1dtygCBEy4GpqvyeKAPqA@mail.gmail.com>
X-PR-Tracked-Remote: git://github.com/norov/linux.git/ tags/bitmap-5.17-rc1
X-PR-Tracked-Commit-Id: 15325b4f768f2b27b5765489eeab6ec0d6b5e902
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3689f9f8b0c52dfd8f5995e4b58917f8f3ac3ee3
Message-Id: <164291869897.10836.14093065225548269840.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Jan 2022 06:18:18 +0000
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dennis Zhou <dennis@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-mm <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yury Norov <yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Jan 2022 09:10:36 -0800:

> git://github.com/norov/linux.git/ tags/bitmap-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3689f9f8b0c52dfd8f5995e4b58917f8f3ac3ee3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
