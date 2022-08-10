Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4D58F264
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbiHJSdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiHJSdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:33:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2084C8C00E;
        Wed, 10 Aug 2022 11:33:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBC46145E;
        Wed, 10 Aug 2022 18:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D20D8C43140;
        Wed, 10 Aug 2022 18:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660156418;
        bh=HGMKA+Q/KnafgwGINIM+LJIuf5lEDJIsbcMjjP0o8hs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JiOrJy+6RmfQxqUEjc2HZnj5kN+4k7SoYRPWpNnjENKUb1wfFyyWKIwniAFmWVDim
         zlOBl0SAHglRMHGdMe+F1Jk+xgZpztqXycN0Nw8Q/I34aHXxLIOiazbMlrooWWDCmZ
         fbIXU7cGqJGU9/rb51Gsqut+VkkC9tCF+7rR8x1B+lKweBirOopFMhx4ZYejySvE6/
         MHeItlEkXwYQdGLL0E6hdF/2Gmvvh3IFhx7ncgZkWKNvPzyXaM44lj3tVnXsLc1tR5
         Dz5YaJzE77/A+5TcCAxGyXbLBreblvypqMXSd/ZdpL4t+64253LN8nLY7FD7BlGCjk
         keolhL01EXjag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF43CC43141;
        Wed, 10 Aug 2022 18:33:38 +0000 (UTC)
Subject: Re: [GIT PULL] hwmon fixes for hwmon-fixes-for-v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220810134533.380417-1-linux@roeck-us.net>
References: <20220810134533.380417-1-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220810134533.380417-1-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-fixes-for-v6.0-rc1
X-PR-Tracked-Commit-Id: f4e6960f4f16b1ca5da16cec7612ecc86402ac05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f41445645ab5d172e6090d00c332c335d8dba337
Message-Id: <166015641877.32353.6766035225478723944.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Aug 2022 18:33:38 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Aug 2022 06:45:33 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-fixes-for-v6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f41445645ab5d172e6090d00c332c335d8dba337

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
