Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E63533274
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbiEXU1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241621AbiEXU1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:27:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1170660DA9;
        Tue, 24 May 2022 13:27:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBA7DB81BBB;
        Tue, 24 May 2022 20:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 845ABC34118;
        Tue, 24 May 2022 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653424017;
        bh=txjWrb0zV6Y0Jm1KR+pa59JbumZ33VprP+yMEx25ows=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vpx2K/sdlEvf8J9A/jc2nPNFh8qJurqOX0Pi7t+OiOiRRFafRlTrTLqoGij4PFv0s
         fAdU3TAFhNK4n00QxpNHyuQDyTwfJXBBUmXxt2vqew0JIdkGNtX1Tvf/bmVT4v/VCn
         pAlUCdYm1wY2B8WpizrgYIt1UxbVk0LubyH7fMNUWV3BhL03me30quSjAIb1orI0//
         2gJUV4DKEXhpC1Fo3pyNB8nyWnDXlY2XKWzWOfuhrDof/08nl2JAeJox6HOkhZzoOv
         lc/YE3rJvFgrpIl6Y71oMhEZ/avHD5z1im8ZANx7GeAKotPXdYvLE0PTsHpotlQjy/
         +W2wIuSpNqEtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6783AF03944;
        Tue, 24 May 2022 20:26:57 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for v5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <52db2436-fe75-0810-aa82-382aa4ffd0b5@schaufler-ca.com>
References: <52db2436-fe75-0810-aa82-382aa4ffd0b5.ref@schaufler-ca.com> <52db2436-fe75-0810-aa82-382aa4ffd0b5@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <52db2436-fe75-0810-aa82-382aa4ffd0b5@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-5.19
X-PR-Tracked-Commit-Id: eaff451d4b7c86e3db3c03611426f5ce1d3826fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9d1046a846571422a92d2b8fbf8a8b24221b9a3
Message-Id: <165342401741.5255.2103153154534441713.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 20:26:57 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 12:12:19 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9d1046a846571422a92d2b8fbf8a8b24221b9a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
