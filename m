Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4FE53E059
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 06:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiFFEQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 00:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiFFEQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 00:16:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EDD132A3F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 21:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FEF360F00
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B75BC3411F;
        Mon,  6 Jun 2022 04:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654488497;
        bh=uOB7KPk7OzcxFcTIl5ZeKeU1g/3eHhnNNyuBe1UvRlg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Up0jL7zpkCQsMbwYAxfXWapM4tErTVVpCIOsCXsQL4agZGdiYnnTKB/7EIxtjOA++
         PCJ3u9UV3RT3B92gb4dmnVlA2ToSYaStx4DBsrl1JC1QlGjaO5upyDlCKebS8G6LWj
         zoX2IEikRDlHyax70VShpJuxgfXIgRV5dGUWqsUNOmQBO/4VX3tS6Pb8wHwLY2aW4/
         JjlYa4k8c9qU9HB/p/HV4kKRAAaoROIsaYX1jvqe7gO991Gu6C9dUHlx0ID00N7hcw
         u1++z3stzyahWcsk4f8qiPm/IlG2Gx6H/FFWAwP/efr7qpVuC4LHSbti0YbDcj8rGl
         M6PNbuUscfxdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77F53E737F0;
        Mon,  6 Jun 2022 04:08:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] platform/chrome: cros_ec_proto: add initial Kunit tests
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165448849748.12364.4550031089902033684.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Jun 2022 04:08:17 +0000
References: <20220518091814.2028579-1-tzungbi@kernel.org>
In-Reply-To: <20220518091814.2028579-1-tzungbi@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        dianders@chromium.org
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

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed, 18 May 2022 17:18:10 +0800 you wrote:
> The series adds some early Kunit tests for ChromeOS EC protocol.
> 
> The 2nd patch is a refactor.
> 
> The 3rd patch updates code comment.
> 
> The 1st and 4th patches add Kunit tests.
> 
> [...]

Here is the summary with links:
  - [1/4] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_prepare_tx()
    https://git.kernel.org/chrome-platform/c/db681eaf7145
  - [2/4] platform/chrome: cros_ec_proto: factor legacy out from cros_ec_prepare_tx()
    https://git.kernel.org/chrome-platform/c/23a34e3a9d00
  - [3/4] platform/chrome: cros_ec_proto: update cros_ec_check_result() comment
    https://git.kernel.org/chrome-platform/c/97b11dd6350a
  - [4/4] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_check_result()
    https://git.kernel.org/chrome-platform/c/4319cbd4ed99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


