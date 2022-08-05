Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FDF58A508
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 05:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbiHED1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 23:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240495AbiHED01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 23:26:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DE81D0D0;
        Thu,  4 Aug 2022 20:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3E2A60DE1;
        Fri,  5 Aug 2022 03:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2163FC433C1;
        Fri,  5 Aug 2022 03:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659669981;
        bh=lKMGHqIP3flqKB3agwbRTWmOUjkW+/TisnGw8nLLEJw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uRZH9L/eYamOopZ6+RD4WOinFEwItT3cbKgntmGLrgYHmZikdFzcGf8uoZXiSyZwx
         P8GU6ErVdkNIJyjG1lhThjn2FH6GUQCnnFrYop7L3QhDUvufrY3w38P4TmLlyb1Ys2
         2uMDnSxTIEAkcSGpRNSs2oWfmM1OlgKePHRXHEGYua9AOk2nEVBA2PG7D0ZzB//S9i
         qf1ezFkcMK9+Drf/7y7TLas1Jo2HbIIRu2r/47DavIe8fESANeu8BFVODd+zUNzEFx
         Z2qHX0L69mkTUZtAYLNYw8SfoMg0cF5N9cTg2RREfu7ilLGgvFJYWBl0ZQy8mf6N50
         KS7xTZ7hJk6PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 11012C43142;
        Fri,  5 Aug 2022 03:26:21 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220804112914.14380-1-ulf.hansson@linaro.org>
References: <20220804112914.14380-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220804112914.14380-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.20
X-PR-Tracked-Commit-Id: 527f36f5efa45b6a897190cabf982e2d207887da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 328141e51e6fc79d21168bfd4e356dddc2ec7491
Message-Id: <165966998106.9883.3525849790848711856.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 03:26:21 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  4 Aug 2022 13:29:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/328141e51e6fc79d21168bfd4e356dddc2ec7491

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
