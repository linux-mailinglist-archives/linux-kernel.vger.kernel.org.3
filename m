Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC094EA2D2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiC1WPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiC1WPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:15:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FE9BF7D;
        Mon, 28 Mar 2022 15:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01EF9B8125C;
        Mon, 28 Mar 2022 22:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8E3CC34100;
        Mon, 28 Mar 2022 22:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648505172;
        bh=f124ex64mDGLRkeWXtyO3LQtmKBCuXZnCYXLUZOcsiU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JZiA9cWw0G//ajgIeKkBbBGl37O5qUdw+RUDHEsZU7zUOh08aKHHUr+G2Lx3ZNdbV
         gDMpdGXkPHbX2wdZ1PfjKB/RltFATdwBNTRHb954Ab5Fagoilku6poGVJG6sKaITJc
         lsx7uP2t0SJ/kkl4G5bS+Yv/qKBHdm7H9brGxlZ27vdAhP27cGhGm0K63fFrYBvNjk
         r9mghHxnv9qtin/PqWSf4up+jFulKlLS4sEavvhz8URRdKiBD0IOOLwex0SVwJAXHj
         NuSOq7k/lF/rnBeip8iZaxG1K8eNxMrqiR47zSZ2t4m40ojkhsjagfFgnd/JHfYujZ
         dtJf41smKHgjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3A14E7BB0B;
        Mon, 28 Mar 2022 22:06:12 +0000 (UTC)
Subject: Re: [GIT PULL] hexagon changes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <SN6PR02MB42053E6FCED122482A5893D0B81D9@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <SN6PR02MB42053E6FCED122482A5893D0B81D9@SN6PR02MB4205.namprd02.prod.outlook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <SN6PR02MB42053E6FCED122482A5893D0B81D9@SN6PR02MB4205.namprd02.prod.outlook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/bcain/linux tags/hexagon-5.18-0
X-PR-Tracked-Commit-Id: b0cf9b4b26e697886bf0986579953c16cf92d3d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 023f3fef8386555a303f73d3bbd50c2237cb0adf
Message-Id: <164850517266.27348.13988208745387167805.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Mar 2022 22:06:12 +0000
To:     Brian Cain <bcain@quicinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Mar 2022 21:08:23 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/bcain/linux tags/hexagon-5.18-0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/023f3fef8386555a303f73d3bbd50c2237cb0adf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
