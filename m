Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB7558F267
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 20:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbiHJSeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 14:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiHJSdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:33:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7119C8C00F;
        Wed, 10 Aug 2022 11:33:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A682D6145A;
        Wed, 10 Aug 2022 18:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FD01C43141;
        Wed, 10 Aug 2022 18:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660156419;
        bh=hVAbdiP2Z6UnKHpsvzCcRvQYD27krsUM31u+Poz8ZCI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XrI+SQIK5uEghL5QjhIXwXSMQ+Jy2EoFdgYx14TLZ7PEHxTGpqnxnRFObFgJR2FF1
         PkBvv/NdhLjgbB+FZm17rmxrDuDRbTzQxAafThZfPuxEu10tvyYPZyNNeRr3WL1mgG
         KwsmMdxqq3GwwZ79gMFGhznnfdDgi0j9nTieQT7/TRp9ww6dZKNQdHZGMSZuGuGTw/
         ad93rQ/7Absfcg0f7QyGAGoPtexeRg3uK19Wo62oT74XdkeoNn71RvBw2SNOj4zNY3
         PwZrKMvgUwOK92FFrwHri5pgZqmBRluzNUooXs44WLjBYfs458z7yjM0Em0coMlnJW
         AimRpbGjFBAjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0082AC43142;
        Wed, 10 Aug 2022 18:33:39 +0000 (UTC)
Subject: Re: [GIT PULL] rpmsg fixes for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220810155804.2837934-1-bjorn.andersson@linaro.org>
References: <20220810155804.2837934-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220810155804.2837934-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.20-1
X-PR-Tracked-Commit-Id: 56e07c0c9e4a4b59a47a848b021a42cf203c982c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b196f3d101fecbd25ca5ccf0d3ef65a272bc2b43
Message-Id: <166015641899.32353.9949496119984433504.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Aug 2022 18:33:38 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Aug 2022 10:58:04 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/rpmsg-v5.20-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b196f3d101fecbd25ca5ccf0d3ef65a272bc2b43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
