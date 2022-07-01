Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D275639A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 21:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiGATTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 15:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiGATTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 15:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645F71115A;
        Fri,  1 Jul 2022 12:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0113B61F20;
        Fri,  1 Jul 2022 19:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62F75C3411E;
        Fri,  1 Jul 2022 19:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656703177;
        bh=pS6RUqqw9tQ8Spx0pzMbzlHYYFkraT7sr6DZKG+RgAg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pAqyZaIeS/y+lNE5nxjmYR3uAahGy0Id6/SSsqGRR/L6eo4MBOmr00tZpFekv84As
         Su9waIeKpynmIxdiPGPjak20y2I+pc+e8oyP1bYXCkgf9ZFtMuDtc6USh/1374Z2qt
         5GfEzvA28BlhLoNnIb53I3/ZtaSL6cBkDXuhGB+fWe5p4Xlu7Va/OmmN2WuAOoLb1k
         /JggGtzhN9IBCE58zfT8rx9M7UBK9NgoYyco0SCnmEoBocxsXhcnA52fUnshWxeILp
         PAWihHPSwYM6ljXd/2MSnZNarZKFeomcCuMI7fr2dJcyrdcp7fNA70p23ma28Uzl9Z
         n9IMGaQXXl+3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C479E49BBC;
        Fri,  1 Jul 2022 19:19:37 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for v5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220701190101.2982333-1-linux@roeck-us.net>
References: <20220701190101.2982333-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220701190101.2982333-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.19-rc5
X-PR-Tracked-Commit-Id: d0e51022a025ca5350fafb8e413a6fe5d4baf833
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b336ad598a3bbeddfdb71d86349b9d4024bddefe
Message-Id: <165670317729.18967.8392888459752129636.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jul 2022 19:19:37 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  1 Jul 2022 12:01:01 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.19-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b336ad598a3bbeddfdb71d86349b9d4024bddefe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
