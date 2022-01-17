Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4812D490224
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbiAQGyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbiAQGyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:54:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F0EC061574;
        Sun, 16 Jan 2022 22:54:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C948560F33;
        Mon, 17 Jan 2022 06:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 390D0C36AE3;
        Mon, 17 Jan 2022 06:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642402491;
        bh=IIoGIZsu8TZOhpPFqABcuqaKklkGbS8xoA9L90Whlf4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pMEwLZpCzFvsKy3XIHZk1u8f16sZ4g7nBcseGCvKYimPCIQHM0QiSnuOtv5cX9tLD
         nZVuuPLhXwaP7XqNe1nEi545n0pM1KpHg/zdBwtQ8EjQiur+DOewDU8+qYg0mxv3Y2
         iarAcKV9FfziorapKqW+cCnLbSymSdoiY+0sNmdyAJ0lrtfN1pAQLruY8daOfiwQx+
         IyxjG3CyDgYHuFtv/9AvtwoPvZgquzyKMHF1lHyAUE9LnZH6aumDAjKW2ny7nmm3Et
         foE0C5wtQVZbGSiv3l7Rht7grZYJBuT1Fb93m8dije8aonIivwHXlLckSrLdHuVlR3
         zs0X1MhHmF9dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26E37F60799;
        Mon, 17 Jan 2022 06:54:51 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v5.17 Merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220115085522.GA30865@www.linux-watchdog.org>
References: <20220115085522.GA30865@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220115085522.GA30865@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.17-rc1
X-PR-Tracked-Commit-Id: ffd264bd152cbf88fcf5ced04d3d380c77020231
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2225acc32275085d5e0ce5845c6fd18d61204b49
Message-Id: <164240249114.26213.1224292278462004383.pr-tracker-bot@kernel.org>
Date:   Mon, 17 Jan 2022 06:54:51 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        AaeonIot <sophiehu@aaeon.com.tw>,
        Andrej Picej <andrej.picej@norik.com>,
        Artem Lapkin <email2tema@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Palmer <daniel@0x0f.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Luca Weiss <luca.weiss@fairphone.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Sander Vanheule <sander@svanheule.net>,
        Sven Peter <sven@svenpeter.dev>,
        Tzung-Bi Shih <tzungbi@google.com>, Yunus Bas <y.bas@phytec.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 Jan 2022 09:55:22 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2225acc32275085d5e0ce5845c6fd18d61204b49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
