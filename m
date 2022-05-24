Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FBA533400
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 01:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242327AbiEXXmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 19:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242683AbiEXXmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 19:42:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061DB5AA42;
        Tue, 24 May 2022 16:42:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93A31617AB;
        Tue, 24 May 2022 23:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F329EC36AE5;
        Tue, 24 May 2022 23:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653435735;
        bh=dSK8pgu0ECZNC/zY2WxhrqE15Z8aJZxCySmrJDL3Ggg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Yn/2gqLD5RJzDoajwYo8n7dT0Zva8IF9Mlhdy4DnPi2Z5W7i+fiyBLUE/37RQoFCD
         +X0HpaHbGgvPuxyigA5NZduciBCBgz+IpB5kfmpkZZWDxj+/jdQQukp2TsidaPFa2a
         zsiOc5jLQbyx2L3MPVH++m5Ds6EPuALzLGvC33ilB1imU6FtjPG/Dxxcs+laNI4Pqv
         6X2s+keV//agm2GAikR+KR/D88cYdr1NIatzjIpOpu5kOw1T7l2biRlfKMd3Qa3LRM
         GgZjJff2MHthejgz8GzqpQ3ZzQXFFvd6+IwNHWlTaXKCRIg77JUq0mvJhwPBhbWakN
         5sn5ja7LuDIKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7C8AE8DD61;
        Tue, 24 May 2022 23:42:14 +0000 (UTC)
Subject: Re: [GIT PULL] Thermal control updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h803aUmDW-oHh6+DkBkSXftmrVTwD463YkHW-h+8c=kQ@mail.gmail.com>
References: <CAJZ5v0h803aUmDW-oHh6+DkBkSXftmrVTwD463YkHW-h+8c=kQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h803aUmDW-oHh6+DkBkSXftmrVTwD463YkHW-h+8c=kQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.19-rc1
X-PR-Tracked-Commit-Id: bbb544f3349197d1e7f4f9b921b75e919cd45f39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f4fb8596657c998ca4cdb833bc0f509533a38ddd
Message-Id: <165343573488.8820.6519095006967998279.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 23:42:14 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 21:44:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f4fb8596657c998ca4cdb833bc0f509533a38ddd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
