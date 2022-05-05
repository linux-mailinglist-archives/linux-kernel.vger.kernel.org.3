Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6DB51CC87
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386610AbiEEXNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386622AbiEEXN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:13:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2489960070;
        Thu,  5 May 2022 16:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4E3EB831BD;
        Thu,  5 May 2022 23:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80C72C385AE;
        Thu,  5 May 2022 23:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651792186;
        bh=7uDnBDby8dlL1nlvTXdpeh6OAcrg9I8qMGiM8rWJzC4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HpCCzI9Eh5x7mzC+2FHPcyKPJVoVx8ONV1oiBzMB8hAYvyifHckoeVb4c+rE1H+Db
         kgLzM83Ond2qucTC96XwZ7GufskV0MGJw3bSnPnqTzGxWTQEs4XH+FNYpaHNlFuWVI
         njhKnCJaNcRjefgm3ccGNYBMSDAYI7FQpxwmFe6tfAX1rM2HUMhL7+rS85sAcR7FcD
         y7XBHlTfWImiGIOenIgBMRzhggFnOqF5xmpipPSWkU8bExw5OgR6budF04bLBTrgX5
         1HnIBrIn0zAyfssExO+lZm1+33qmRjqwnjmDGsDC6EiH6GakUn2UzTmwW0YzEASob4
         LZ5AFiKi3Id7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6999EE8DBDA;
        Thu,  5 May 2022 23:09:46 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.18, take 3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YnQuiPwutfe6EKGf@robh.at.kernel.org>
References: <YnQuiPwutfe6EKGf@robh.at.kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <YnQuiPwutfe6EKGf@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.18-3
X-PR-Tracked-Commit-Id: 5dc4630426511f641b7ac44fc550b8e21eafb237
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f47c960e9395743a8aa3bd939d4d3a0f582f565e
Message-Id: <165179218642.20357.7040709401710476084.pr-tracker-bot@kernel.org>
Date:   Thu, 05 May 2022 23:09:46 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 May 2022 15:07:36 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.18-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f47c960e9395743a8aa3bd939d4d3a0f582f565e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
