Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA9057C705
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiGUJAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiGUJAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:00:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8D213F79
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01D4CB82398
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D801C341C6;
        Thu, 21 Jul 2022 09:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658394014;
        bh=QPUDJV0fNdMRTGBbCPO7Bb4R2uBcxlxiVLcn+GFuN7c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jOBLtjMxY618IzVsKJVTWQCq0UJViiKpMHlJtoF26wFRIZaWQayk+PUVKwasu58+t
         DuVthAEXtUYs3PZ5Y+vEGtyH/1lYJ1Txufj7rRl3ZCGXFA4FSsduqx4H81khRAtOrB
         vBDX6pkO4mHQdRmSRJ6HL0ZaXX/tmTygVmuDh8BLfQ7srkU4oDOpd0QCBt+10UoDgg
         F+9LcKyiE/yrPPYJgfZwex8tJU51DjQ4ruk2u4setn2kW4Aq7b2CsUxcVDWYuEWk/q
         OIkbyD4lvW5yIDRnZdTY96TCbcxZz2BCOQHWOuP2Yka3dsWklsUnMMuwxeUIyzXKl8
         YkNKKX/u7j2cQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72688E451B9;
        Thu, 21 Jul 2022 09:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] platform/chrome: avoid garbage bytes in `msg->result`
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165839401446.1783.13392318717431480948.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Jul 2022 09:00:14 +0000
References: <20220720044754.4026295-1-tzungbi@kernel.org>
In-Reply-To: <20220720044754.4026295-1-tzungbi@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed, 20 Jul 2022 04:47:52 +0000 you wrote:
> The 1st patch merges Kunit utils and test cases.  The idea is basically from
> the review comment in [1].
> 
> The 2nd patch fixes that `msg->result` would be garbage bytes if the mock list
> is empty.  This is separated from previous series [2].
> 
> [1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220718050914.2267370-2-tzungbi@kernel.org/#24944149
> [2]: https://patchwork.kernel.org/project/chrome-platform/patch/20220718050914.2267370-2-tzungbi@kernel.org/
> 
> [...]

Here is the summary with links:
  - [1/2] platform/chrome: merge Kunit utils and test cases
    https://git.kernel.org/chrome-platform/c/f92dd1475b06
  - [2/2] platform/chrome: cros_kunit_util: add default value for `msg->result`
    https://git.kernel.org/chrome-platform/c/afef1e1a0223

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


