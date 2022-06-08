Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D87542A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiFHJBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiFHJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:01:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA8740435A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C36E61444
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A88AC3411E;
        Wed,  8 Jun 2022 08:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654676413;
        bh=lUm70LVC7KHrJCC6hJUxHZlVlqipO3QMpVoBtsU8kPI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lMiE+uzp11EJoTPZBXTfOmHiAUnqhnQWVI+hewqyJ/DhLo6y4ib0KDfj9docE1wKJ
         qfmYmrZkDhVU8C0CeV0o8Ssoxu3/cv0dEjrc0vxBzlqPCPT57v3ce0opcCNWx40puU
         nI0U01XrnvyDE4WzGPKdnIZ4qR+6U9latffqppIpJ7O3ozC0gLRS8BsO4PsEvCCR/Y
         ZCG5hn3+T06Ka1CHFUWVTIgTmqYIJa1W73f9IhUTArqVbY4wB8t7rSNrWqsMfvREdx
         HORCicdePEbHpvBOlNg8Dq9hEVzv8PTG0fQwa++LvxAhAXSdKE3mXkXKVdm29JSzkO
         MitH9aMad9gMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6127DE737FA;
        Wed,  8 Jun 2022 08:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] platform/chrome: cros_ec_command() improvements
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165467641339.18526.746439827549226974.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Jun 2022 08:20:13 +0000
References: <20220606201825.763788-1-pmalani@chromium.org>
In-Reply-To: <20220606201825.763788-1-pmalani@chromium.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org,
        briannorris@chromium.org, chrome-platform@lists.linux.dev,
        enric.balletbo@collabora.com, groeck@chromium.org,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        tzungbi@kernel.org
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

This series was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Mon,  6 Jun 2022 20:17:59 +0000 you wrote:
> This is a short series related to cros_ec_command(). The first patch
> updates a couple of Cros EC regulator callsites to use the common
> cros_ec_command(). The next couple of patches do a rename and argument
> type update.
> 
> Prashant Malani (3):
>   regulator: cros-ec: Use common cros_ec_command()
>   platform/chrome: cros_ec_proto: Rename cros_ec_command function
>   platform/chrome: cros_ec_proto: Update size arg types
> 
> [...]

Here is the summary with links:
  - [1/3] regulator: cros-ec: Use common cros_ec_command()
    https://git.kernel.org/chrome-platform/c/015cd0043503
  - [2/3] platform/chrome: cros_ec_proto: Rename cros_ec_command function
    https://git.kernel.org/chrome-platform/c/b1d288d9c3c5
  - [3/3] platform/chrome: cros_ec_proto: Update size arg types
    https://git.kernel.org/chrome-platform/c/f87e15fbf6d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


