Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B874948EBCE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbiANOj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbiANOjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:39:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B26C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 06:39:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36394B82606
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 121C7C36AF2;
        Fri, 14 Jan 2022 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642171160;
        bh=t2npav5wk7hg/sxLnzYSMI9iUeReb0eptV1nx89Q7wI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u1nmll/DOVrvIEHWTBozM4PHRUNR0+NC8YyxZ0zJ30mZ0kiczpz5f4dEAE5OPF/Ro
         yjhfPQTy/HrXx5T6Q5wxH6WcIAvUlnBkMLYhanh3FLs9Rdl/XcXg0OiCy1UCP+pGU6
         o0gwwpDJDMkqQas0rtJ96g1FGUrWxnU00AZUzKlqEKM9Sj3f6WirxUrPbAYjMa+N49
         09gT89VjCGeMCRpYZ8vNBz6CjBrmuia2QaDtyuaagO4TzomaIgThyBHtxt+pv92AcE
         wkqTUTeRNPJCgMvQIn/xbF5izvz/1M9YfiaJtHPQtH+zUuSRWQHha+x0k+spZealy+
         b1ZRkhXXc+5EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F17D8F60797;
        Fri, 14 Jan 2022 14:39:19 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YeF1hpMbYo5PMmkD@antec>
References: <YeF1hpMbYo5PMmkD@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YeF1hpMbYo5PMmkD@antec>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 7f435e42fd6b65fd8759963156e1ef0fb7d213f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 871bfa02d08d9c0ed981c50082b7afd367d3700b
Message-Id: <164217115998.3976.2695828823334798438.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Jan 2022 14:39:19 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jan 2022 22:07:18 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/871bfa02d08d9c0ed981c50082b7afd367d3700b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
