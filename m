Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A433533538
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 04:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbiEYCQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 22:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243769AbiEYCQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:16:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E3F140DA
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD45261523
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CD1DC3411B;
        Wed, 25 May 2022 02:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653444993;
        bh=hPahS//sGRgkg5pt0E9DmHXwcGUhtWov73ivLBOkM20=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y8alHf58phxo5cdgAt3DZuNkn7nX4i51XRWSZK4F3TnYvatBrUn5R4MCygDd4l+uS
         0VtRlkhZaNRzTHyD8rTdZmbo9pngG+TFr+JykceuWiruWL+lCdgAkx4LEOU1Kl0XRE
         X6+d1Yo8+60gWTFcYlXS0ydris/rJcGxUAgL+hDiL3BiMhVXRDiFuIKLq5oud7ctRc
         asjnaNEtAXsasArmmMoYXn4xnsk+QKujE0FNdEme+jZOD2NtVQeh1mfCb485xmxSuq
         7HEMh6cH0eOLY86qmdKm+XhdAgvjYCtCb5RBSJ1cuPUvA1wb1F97uIaocmfNy5USMR
         05FwBrzwIq1IQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07017E8DD61;
        Wed, 25 May 2022 02:16:33 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd_tOxGD7syqV17YEbpNkcmi3-cNoLz5mKneXyLGbQyjhA@mail.gmail.com>
References: <CAKYAXd_tOxGD7syqV17YEbpNkcmi3-cNoLz5mKneXyLGbQyjhA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd_tOxGD7syqV17YEbpNkcmi3-cNoLz5mKneXyLGbQyjhA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.19-rc1
X-PR-Tracked-Commit-Id: 64ba4b15e5c045f8b746c6da5fc9be9a6b00b61d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 850f6033cd2bf3b1fcbf9a20d078edab7e7c67b4
Message-Id: <165344499302.22339.11893654041691194537.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 02:16:33 +0000
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 22:05:56 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/850f6033cd2bf3b1fcbf9a20d078edab7e7c67b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
