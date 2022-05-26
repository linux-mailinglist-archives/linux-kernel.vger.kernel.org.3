Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AD95355F1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 00:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349985AbiEZWEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 18:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349976AbiEZWEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:04:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761605DE79;
        Thu, 26 May 2022 15:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0570C61BF7;
        Thu, 26 May 2022 22:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47745C385A9;
        Thu, 26 May 2022 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653602682;
        bh=9rAdDNUeiTqFEswZ+RjExUG8S4CG+BiQ32cKmCKJHbE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jFQUn2Ic80vXvYJZzvoZ9mmqyx/6QHoI37/RDTy5wEx9Iwbfs5H1NHv7QqJmFTGP2
         M1PXgNz9gAyl01NuHe/sEfzTNU+XnCjXHy3cihCd6eXfVcPa0TSHwqMaMDDSDsR2xh
         vWsh4ygXKDYyOcEcjD/nAaWbxpBaLeIah7meusTZX8kfNVUaoTi0RzsJmg4aQcdDPI
         KfL2eBs6dCVSiaHOWo8aSGZpFKA9avOFleayoJMWuNRgQ+hrqtAxBk3AY+c/mV/75l
         0oSRVZtw+ehcetbQUFzfnBHes9lqqkBYzSOX9r6B8A5HDAo8G8AlzomLs/J6grsv2l
         OHAQbIHf39vzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35503F03942;
        Thu, 26 May 2022 22:04:42 +0000 (UTC)
Subject: Re: [GIT PULL] MM updates for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220525114208.223f45e4b361d99b83be0c52@linux-foundation.org>
References: <20220525114208.223f45e4b361d99b83be0c52@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20220525114208.223f45e4b361d99b83be0c52@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-05-25
X-PR-Tracked-Commit-Id: f403f22f8ccb12860b2b62fec3173c6ccd45938b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 98931dd95fd489fcbfa97da563505a6f071d7c77
Message-Id: <165360268220.24340.4739282118223603966.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 22:04:42 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 25 May 2022 11:42:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2022-05-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/98931dd95fd489fcbfa97da563505a6f071d7c77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
