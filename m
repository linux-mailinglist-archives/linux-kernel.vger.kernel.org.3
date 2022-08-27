Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575DA5A3A6F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 01:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiH0XHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 19:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiH0XH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 19:07:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694D731200;
        Sat, 27 Aug 2022 16:07:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16B2BB8076B;
        Sat, 27 Aug 2022 23:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE8C7C433B5;
        Sat, 27 Aug 2022 23:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661641643;
        bh=ifEk5/irKBoaIAXHuZXOBQeyz4wetSQAMGTrGrWdy/k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Z/1pw0JZMdZr7XzQLxNS2s1UpxPifMXT5IMYI73jR2VycHtZAGiuzDkGSsr7hepJW
         Xw7k5RgrFi7IUpD0oBWFcT/VvPGC2m+/07dpDqZoNb6xaHkPysD5J6iXA3RemtWRqR
         hDnlSpPKLF6wWWecSIF5Q1SZgk6IUapKDLKCXlXOXMWwW5LGNH3WeYsNHpueydUc6S
         Zg5xxE023fIzzktHbQ2VRX8F5ea1WpKSa9ji8D1OezvcY8hsMeJqAL4vmsGwe3hy1A
         T4IO6z+wyiw6xCh1C2R6CYqNhZvZJheHEZBUOjUIxXWU2WSYGVPIDIY0VTsrfN2M9K
         LS7sbxYUdJzpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD625E2A03B;
        Sat, 27 Aug 2022 23:07:23 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01661594879-ext-8999@work.hours>
References: <your-ad-here.call-01661594879-ext-8999@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01661594879-ext-8999@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-2
X-PR-Tracked-Commit-Id: 41ac42f137080bc230b5882e3c88c392ab7f2d32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dee1873796aff90bb932b0e0073a0073863b4b94
Message-Id: <166164164370.8591.12616995106715615164.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Aug 2022 23:07:23 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Aug 2022 12:07:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dee1873796aff90bb932b0e0073a0073863b4b94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
