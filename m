Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15114EE345
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241860AbiCaVXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241840AbiCaVXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:23:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4B0236BB8;
        Thu, 31 Mar 2022 14:21:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 986B0CE2190;
        Thu, 31 Mar 2022 21:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03501C34111;
        Thu, 31 Mar 2022 21:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648761705;
        bh=3Por+R4u2PfGTrTMD/fhDFrmVc1ptYv9owqBy3MB1eA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tFMGJD9SSERFecAB2dbnWdX1H9LatUal+OHLCw4poYTVw2Xe7gUlo7o4DdhyXFZsR
         YOa95XSwfwWLLRRMAm9nLoq9ye6v1EOGXVkmCL6GsynYNHagytln8M6bPS68odwKDS
         DYqOY9dvO3+rC/g1hIS2uAW9OhIS5VAmhyvZhfDOPltQK02FW4d/PW04EMvhTUI8Pu
         LaAsE5aED6d7rSVfUq8BZSMm5rF9QKTWT7cN73zWy6Pb8+EHvmEDNGbnjsDV1o5pLn
         f0T+h1Yx/fwo6Oe0Cjjvl+Mvr3GVi2A0zf3GcT03/ky7q/jDZe+/Vl99ohZ0gUyhv6
         h12RgAF674arA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2F1CE7BB0B;
        Thu, 31 Mar 2022 21:21:44 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v5.18 Merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220331182454.GA14072@www.linux-watchdog.org>
References: <20220331182454.GA14072@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220331182454.GA14072@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.18-rc1
X-PR-Tracked-Commit-Id: 826270373f17fd8ebd10753ca0a5fd2ceb1dc38e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 354b8bf222ee15bf9aac3d870ba8e0880dd9bc8d
Message-Id: <164876170492.29828.10763277260043867037.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Mar 2022 21:21:44 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Eduardo Valentin <eduval@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Terry Bowman <terry.bowman@amd.com>,
        Thanh Quan <thanh.quan.xn@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Mar 2022 20:24:55 +0200:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/354b8bf222ee15bf9aac3d870ba8e0880dd9bc8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
