Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BF358BE8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 02:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiHHAsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 20:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbiHHAsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 20:48:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D38CAE78
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 17:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 584C0B80DB6
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 00:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D42BC433C1;
        Mon,  8 Aug 2022 00:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659919684;
        bh=oFtJBYHyufMfsrJZDbsdjBqH9pIBlezZMqSdWpoU90Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lI2xwRxHuj3K3G5KoqoXjg/upcX7vQX/mO8kY3w6PYXPVpPsj5EFgtwRpXZ21itav
         XWcG8zo03mm9XBYzvmazp0jwHoiprIKNM+EgaMXKZWHKOIOzFVpaO8nKh55nifaIwm
         MFYhHOxS15BlUu5J54ZMGRDBgI58ArhNC6iT7+p0aGnCRNa1K+8VVuhqkjNo/PRXOw
         49Y6ZxTnJS4z1tKFt3cEtZDQ9U3PYcVsuPva6PjylnVzPIMywKhpze6spSSzkCWPJB
         aGRzbktBBp1B+Ioj7EsPB20fup3Zttvcy+sUgBOHOZZUiFXxY7XnxKhCS+BJKDupcU
         JbL9OUcBXzejw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DAA2C43140;
        Mon,  8 Aug 2022 00:48:04 +0000 (UTC)
Subject: Re: [GIT PULL] Bitmap patches for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220805022940.1637978-1-yury.norov@gmail.com>
References: <20220805022940.1637978-1-yury.norov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220805022940.1637978-1-yury.norov@gmail.com>
X-PR-Tracked-Remote: https://github.com/norov/linux.git/ tags/bitmap-6.0-rc1
X-PR-Tracked-Commit-Id: 36d4b36b69590fed99356a4426c940a253a93800
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ab9250751ee91b0ca7bee887894fccfd44ff26a
Message-Id: <165991968404.10077.6220067519297859381.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 00:48:04 +0000
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  4 Aug 2022 19:29:40 -0700:

> https://github.com/norov/linux.git/ tags/bitmap-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ab9250751ee91b0ca7bee887894fccfd44ff26a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
