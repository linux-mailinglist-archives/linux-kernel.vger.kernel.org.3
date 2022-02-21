Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726304BE551
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381537AbiBURPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:15:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381527AbiBURPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:15:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B926122;
        Mon, 21 Feb 2022 09:15:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66583B8169C;
        Mon, 21 Feb 2022 17:15:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B001C340E9;
        Mon, 21 Feb 2022 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645463708;
        bh=nbmya3JwWM1AJJmuDf5HSsPpK4nSioEJ/MYrhIw2rBM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IP4PaCz0N6B6Qy2g4JLwApVEgxDiFtf8/WEh2IpNblojxNyz239yyKIDtaiwzjBMK
         5AnS3BoWDZVahXQJq+N/KcHJ/GSRIE0SMq7z+zZqvjtZ4r98JTF7pg1kjg3KYow53y
         VcVZhJoJ/+Ron8zFEx7VdxTFiAy0aHJ5WjFJl8zYWMwoCZstVBnfK8xwFCUdNeOwSQ
         xTpFwSFc14+uv8AZh9ShIlgdl58Zj19zdKFFl5NEz5IKHtw0Rit8zvk/QE3ioiqlCz
         H8b0gofWt1Log1Os6fhyxmy4XSdAlolizZtdNCVFfMKdnGsYYlR7lJdYvnyF5x5OgG
         I+NVBgQUgeZjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A54DE6D3E8;
        Mon, 21 Feb 2022 17:15:08 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.17-3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7ea773bf-c020-c815-fe1c-8401dbc6a86e@redhat.com>
References: <7ea773bf-c020-c815-fe1c-8401dbc6a86e@redhat.com>
X-PR-Tracked-List-Id: <platform-driver-x86.vger.kernel.org>
X-PR-Tracked-Message-Id: <7ea773bf-c020-c815-fe1c-8401dbc6a86e@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.17-3
X-PR-Tracked-Commit-Id: ae09639e3b2a0291b37b122c94dd4f773cd4e513
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 038101e6b2cd5c55f888f85db42ea2ad3aecb4b6
Message-Id: <164546370810.23801.1231884751699104221.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Feb 2022 17:15:08 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Feb 2022 17:01:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.17-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/038101e6b2cd5c55f888f85db42ea2ad3aecb4b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
