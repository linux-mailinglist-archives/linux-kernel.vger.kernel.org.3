Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DB6536E12
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 20:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbiE1SZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 14:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbiE1SZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 14:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D187F175B4;
        Sat, 28 May 2022 11:25:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F269E60A20;
        Sat, 28 May 2022 18:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CAFCC34113;
        Sat, 28 May 2022 18:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653762320;
        bh=ZjLfmuTmPkGzbOfQreDoS2xmlwZDMJs2YBv5v6dYJvU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YfwlycYSWZkuNu2wZJl9zcvqmQaMUZfN9NZiFVGym6niuPcYLlbirAKjoWneF2UKR
         iggCd4h5JnquD9SG7JGlPcxDMcfx3N9SpYSKqCzPBXonAodQTnfYiZztKOeoh/Q7bH
         jZNmwGxPkpa/+69+Zlz858aEryFboHqhp3fcrFpL/zmDprByNVsTxhvBye97+nJvqD
         jOvdP6M3y4z+R7pU4jKA4/0yAMGUS/vWOt25kKe5uIA3jA4+zqFQSHmRwpBteRwMTY
         ves0V+WhPVvXwwNmvOnT1shToRfCfgMHfcTkbD/twFmGE8BA/z+natkeifIGdFBgAh
         f3uBuAWtKevaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AF58F03942;
        Sat, 28 May 2022 18:25:20 +0000 (UTC)
Subject: Re: [GIT PULL] bulk pin control changes for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdYvRzWUzySWR-VNo87_Kg0M_d7cKcyHruPW9fMTeet9XA@mail.gmail.com>
References: <CACRpkdYvRzWUzySWR-VNo87_Kg0M_d7cKcyHruPW9fMTeet9XA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdYvRzWUzySWR-VNo87_Kg0M_d7cKcyHruPW9fMTeet9XA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.19-1
X-PR-Tracked-Commit-Id: 83969805cc716a7dc6b296c3fb1bc7e5cd7ca321
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 907bb57aa7b471872aab2f2e83e9713a145673f9
Message-Id: <165376232029.16759.3445799523793577165.pr-tracker-bot@kernel.org>
Date:   Sat, 28 May 2022 18:25:20 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 May 2022 11:34:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v5.19-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/907bb57aa7b471872aab2f2e83e9713a145673f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
