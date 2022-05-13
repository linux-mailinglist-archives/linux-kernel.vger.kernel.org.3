Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0254526881
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383024AbiEMRaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383060AbiEMR34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:29:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432B71DB4;
        Fri, 13 May 2022 10:29:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30A8D616FC;
        Fri, 13 May 2022 17:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9566BC34113;
        Fri, 13 May 2022 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652462990;
        bh=6zz2+j+VWmmRk+05xh9TuMNaA2B9IrABbEbwuR3n0aY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S2s4+wCI4FEU/V9bdd6x+h0pdIgB+NG3k4DCIAjIyKaOm5HceK02N83iqrrIex0FV
         2wqGkSc64euAh4HaPR1kgwdoeXn9YR8jaL3ETjwMJ8Bg1JnovDfDXMO5+cxsxnqU0Q
         uXMJL8P+oWhRX19KTRDxlW8pUFHXwKcZd+oppu9lCY+DD8DVOu97FTogirO+SBEeij
         /pejfsC8gAXIHJFmFE5Gp9hnhB/QW9LCFpATxOTXmfTAn/w/X5CoqZm9k6UQpvk1tn
         Ka0rIFA9sQlna/MDHCZybEQdAW4USoScgTcIjfsIN15nCM3K2syo/osYorLe5NYhlx
         mjaWLglmhKEzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 835D8F03934;
        Fri, 13 May 2022 17:29:50 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 5.18-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220513100825.701c0801de7f18168c4d838c@linux-foundation.org>
References: <20220513100825.701c0801de7f18168c4d838c@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220513100825.701c0801de7f18168c4d838c@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-05-11
X-PR-Tracked-Commit-Id: 9039b8335276569670caaf23606335946625e764
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 364a453ab9123f493edfa246798ce9eeda452bdb
Message-Id: <165246299052.14811.7799084677511536955.pr-tracker-bot@kernel.org>
Date:   Fri, 13 May 2022 17:29:50 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 May 2022 10:08:25 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-05-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/364a453ab9123f493edfa246798ce9eeda452bdb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
