Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12B14937AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353292AbiASJsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353207AbiASJsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:48:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDB7C061574;
        Wed, 19 Jan 2022 01:48:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76820B81910;
        Wed, 19 Jan 2022 09:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 476C3C004E1;
        Wed, 19 Jan 2022 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642585690;
        bh=9lxZq+V4fSgTWNQiG1VvKwxS0DDDwwI9vkyCXU5Dadc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MRfpYKSb8lqKw4tTykefdx8ci8PYb9ZCVwUMaUX6KFXmxOuLcxDToLTqVScC0uUTe
         TEtXKUpk2DODrLYxUPpTuvmklvOKkjFYSsl13BNKiSAvJXjMHk7IWbkygf19h1Yc7i
         2LDcmffqS3CklBq+hMaaTxTAkGz0xe6juqsWKMCbJTblDXQAB1F+6NaIbbF3C3Vwxl
         v2DXJc1LmjVg2Nd765Djp7zakehxX5qMstXROVRBxI38ipB8t37Fj7JdG4GzyPxRDL
         mnRgyIeOWYLI9yo8ZOGT2U+MENgqSVXlsBc9A/ON8FbCFeq38+EOwm17OKchj7vDc4
         Xf2ui+EXhfJsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36037F60797;
        Wed, 19 Jan 2022 09:48:10 +0000 (UTC)
Subject: Re: [GIT PULL] hwspinlock updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220118142809.1751011-1-bjorn.andersson@linaro.org>
References: <20220118142809.1751011-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-remoteproc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220118142809.1751011-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v5.17
X-PR-Tracked-Commit-Id: 60630924bb5af8751adcecc896e7763c3783ca89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39b419eaf0df0de720ed417e785e6c0b004b0a51
Message-Id: <164258569021.19279.10799535405213687040.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Jan 2022 09:48:10 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 18 Jan 2022 08:28:09 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git tags/hwlock-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39b419eaf0df0de720ed417e785e6c0b004b0a51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
