Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B49A53E024
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 05:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbiFFDeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 23:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiFFDdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 23:33:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE27A37A88
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 20:33:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F3ADB80944
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00B5FC3411F;
        Mon,  6 Jun 2022 03:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654486430;
        bh=Z1pePjgcN1IgrpbJsD0/+cmu5rnSefmSEhf+TUR/2f8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UDfMVyxlMJzzDE1U+gqyzxD7JwMea7qrAh7bO+GEfwZxE/nt53JQheED/OClgMR6z
         kmbbggwsruNxMkYh/vGf6Vi3ydeHOvD+xemdZvX1AypsCXihdM0uJVLwFZiX922lw5
         irbFiIs1VdtTjXnmeHwHvbSgCY7hWbZVp3QVOFZ6oRO9tv+a3SIZv1XTTt+qZRDbnC
         /y5uIVa4bl1awvFwAnwalS96qa8AqTzihni5za3Y10UMTmVq4DVIOOxh5CgJNTfwWo
         o/0F8i0MMdPEcHGqSv732AJLTO2Ijm9k/IIvRrE2HWj5HlFQVq8FaRk4RSJBg+Mbpf
         lg2q1AQp4xpdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D88EBE737EE;
        Mon,  6 Jun 2022 03:33:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] chrome-platform changes for v5.19
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165448642988.20111.15410420940660314102.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Jun 2022 03:33:49 +0000
References: <Yo7YztZklByTINZp@google.com>
In-Reply-To: <Yo7YztZklByTINZp@google.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     torvalds@linux-foundation.org, pmalani@chromium.org,
        bleung@chromium.org, linux-kernel@vger.kernel.org,
        groeck@chromium.org, chrome-platform@lists.linux.dev
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This pull request was applied to chrome-platform/linux.git (for-next)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 26 May 2022 09:33:02 +0800 you wrote:
> Linus,
> 
> Please pull chrome-platform updates for v5.19.
> 
> Thanks,
> TzungBi
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] chrome-platform changes for v5.19
    https://git.kernel.org/chrome-platform/c/f1f88bb51f1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


