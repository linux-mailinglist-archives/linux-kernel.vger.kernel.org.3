Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A8858819B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiHBSDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237383AbiHBSC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 14:02:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A79F109
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 11:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2899661251
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 18:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 846B8C433C1;
        Tue,  2 Aug 2022 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659463365;
        bh=pHi1VNzQNYYrEAazfcs+IO4X6ByfarBbFHRbzXcnaJE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UazWjUizlCXEPHkVwOytQRwWs/v8K46fFX4vtVl8LJSI1U7xbx3Msn3TdfC2sQLDj
         +rs1N2++CpmelQbai+nBntD/YeZCks066HNHpiyiD4O5mwYtUkS4DuEgZQ61n6BVBM
         0CeIIwJ+1qqA1PVS3SHRHeIJ3hX5t4IC+aKl9/udhxYJbp0Sr8DCsMmpZxEJMCVAzr
         E/fI0ivfZg4OvcBUifIMUr/62QkWFfMqjxDTFgNEqvlWQGUt6kZMA4l9Ds/3OzLHub
         LVTeUzGgiSxVZTgeEfprIykIoHcK5AJtNjjDQhj1Q8KufuDxf7GCXrY7L3Y4d7m/CI
         ZlOHUH7ZTOv8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BA21C43142;
        Tue,  2 Aug 2022 18:02:45 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220801123757.A82E9C433D6@smtp.kernel.org>
References: <20220801123757.A82E9C433D6@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220801123757.A82E9C433D6@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.20
X-PR-Tracked-Commit-Id: 739f872e48d47c97fa17a86a7b3356771b75240c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e7a95156d64667a8ded606829d57c6fc92e41df
Message-Id: <165946336541.14716.13225153587743355120.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 18:02:45 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 01 Aug 2022 13:37:40 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e7a95156d64667a8ded606829d57c6fc92e41df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
