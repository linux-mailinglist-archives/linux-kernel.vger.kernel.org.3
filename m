Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB99655397F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbiFUS1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiFUS1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB110140DC;
        Tue, 21 Jun 2022 11:27:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38298616C2;
        Tue, 21 Jun 2022 18:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96E5DC3411C;
        Tue, 21 Jun 2022 18:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655836064;
        bh=08o5cJcqh4TSpnvNgZLgb7SuuDxnhTb4Sc3QKcvSjlg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oNnKtPQrUG1pDTYgvOVdPSgQ+Ex0xuz9lbWvU+s7K1NAA6twsomZEYMT01uaSdkPA
         UQibmvNW4gPl0Yz8KCU4Qvo/8sfcXSpVwlzbgcpUabo4yMfL9RU2fWlZkckfsnsWRY
         2O7i7BM5gbT392FwHROxOt7pZqaqdZLjLIVOC+ZGersb1klp+b5MmWnuWF8X+j5RPM
         B01aQPljzRZ2bvzfVHJrljIfYQuVcejP+ZmifHfwWSLGjKjXzk9Zh2IgNzkdjj6+tP
         4MDGOw1l2NqaR4LJlNfl8Ut7S9khasa0cWIHbu3o9X0KpaWMMDl5ajy0qEdrx9lW/F
         5FsaTTmdCu3Vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F921E574DA;
        Tue, 21 Jun 2022 18:27:44 +0000 (UTC)
Subject: Re: [GIT PULL] certs: Make signature verification FIPS compliant
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1276151.1655824809@warthog.procyon.org.uk>
References: <1276151.1655824809@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <1276151.1655824809@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/certs-20220621
X-PR-Tracked-Commit-Id: 3cde3174eb910513d32a9ec8a9b95ea59be833df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0273fd423b2fe10af96ff713273137c63a7736c0
Message-Id: <165583606449.899.9595608204952181986.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Jun 2022 18:27:44 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        simo@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 21 Jun 2022 16:20:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/certs-20220621

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0273fd423b2fe10af96ff713273137c63a7736c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
