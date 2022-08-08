Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C6D58D03A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244498AbiHHWhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244546AbiHHWhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:37:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713291167;
        Mon,  8 Aug 2022 15:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17AA8B810FA;
        Mon,  8 Aug 2022 22:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3581C433C1;
        Mon,  8 Aug 2022 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659998236;
        bh=re3wgf2cII88p6GYbtFgnrixhOuE+6xzAYpWtAE0QcI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VO6SZrVn5xKBFJCfN8eZTp7OkSCTMvO7JEs+IQsi4DOWO0GB+Bw0k1LUz7DvUbHYM
         yQ/2gRM80UlgsCZpf6tgrYoOUZZ/9LzwWgXoepKKKWhNnv53g4IlyPM90DrC+jrueu
         ElUrCb4DvO2GvumaNgSsD2SKgDGICo+i4cB0jTmxqvMCtHDxbjnNV6PJYRCpXYe3Yx
         9S7wFZIFjlzuF9PPJZZFR86Pv13OtI4mKZOxI5riR3QLJwgW8GZhP8+TqHGorTa0jC
         Bk2x3St5g5g/NnBYg2ilMa95vkGw+2jb2XzlXF4AJxxWIO7pWe5aYprJ42x5dqTJP4
         vhU1B6+9xfzVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0ECEC43142;
        Mon,  8 Aug 2022 22:37:16 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v5.20 release cycle.
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220808171216.GA19810@www.linux-watchdog.org>
References: <20220808171216.GA19810@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220808171216.GA19810@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.20-rc1
X-PR-Tracked-Commit-Id: 2d27e52841092e5831dd41f313028c668d816eb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6cc0b56e2be8746824915d3f7130899b98a1242
Message-Id: <165999823671.1400.13627569663709420570.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 22:37:16 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Abel Vesa <abel.vesa@nxp.com>,
        Bing Fan <tombinfan@tencent.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Jean Delvare <jdelvare@suse.de>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Luo Xueqin <luoxueqin@kylinos.cn>,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Sander Vanheule <sander@svanheule.net>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        William Dean <williamsukatube@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Aug 2022 19:12:16 +0200:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6cc0b56e2be8746824915d3f7130899b98a1242

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
