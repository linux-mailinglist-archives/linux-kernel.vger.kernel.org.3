Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDCA53671B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354461AbiE0StQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354455AbiE0StD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:49:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBAC33A24;
        Fri, 27 May 2022 11:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5F7DB82402;
        Fri, 27 May 2022 18:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9315BC34114;
        Fri, 27 May 2022 18:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653677339;
        bh=iCi2ge7+7qkJoJ9idiEfXMXr8NgaKupblKoVhw9CFD8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e/0X/rpyeUFMM47UeD0Ngiofxvr4xXWhDVySsbcNXGcAZ7H6/XU9Wttn0XNiYAihR
         mVryFfvyT/D4gi9XAbx4uO9Zec6xs3AnTHtyDOdGM9PQXspgFvGS0xAwK7/0f7prLI
         9eGXvS93HXN3IQAohpqf9OZYYDuS6Fc2F6FoQDOMwdJZ59n9SQVh66iJd608Tx9SSd
         R4JxdvfkMG5LMGWXhtPo+bNjwF7CMxDxiqwEIAPMdEVrbNrTzmv8CVugIqlKPHgEZa
         sNaQLdZULPJYdX+3jokJ98SL8DerUfCskM18vxpjYLfz6MySQehuGq0PnqWAt+QnVi
         ZU5UbtPmCp2gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 790F9E8DBDA;
        Fri, 27 May 2022 18:48:59 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220527102947.9c7e74d491765ba74bb81374@linux-foundation.org>
References: <20220527102947.9c7e74d491765ba74bb81374@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220527102947.9c7e74d491765ba74bb81374@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-05-27
X-PR-Tracked-Commit-Id: 24c8e27e63224ce832b4723cb60632d3eddb55de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77fb622de1393b1d54f24f4f7ed98f84feeda502
Message-Id: <165367733948.12450.11737914281895723153.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 18:48:59 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 May 2022 10:29:47 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-05-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77fb622de1393b1d54f24f4f7ed98f84feeda502

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
