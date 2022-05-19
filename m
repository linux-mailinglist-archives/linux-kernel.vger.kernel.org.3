Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE3A52C96B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbiESBuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiESBuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:50:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C81EC64
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 18:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E2D4B82291
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8585C385AA;
        Thu, 19 May 2022 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652925011;
        bh=YnnFx/uzzM1tBbXnLKSSk/4FQ0gNk3N88sLxoeYPXNQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Oa/SPjkKgMUjaYUSXg1VF9orebl3CtvZijB7cEMnAFOuvHjM5bIcHYzK/UkGyYWML
         hGk0aBB2qL0osXRPiyTwMClwEVQeG3dsSsrXUoCRpOQfA6zN1gRpUdFpY0HvLf6KGS
         soAnugkzOSv7V/eHezzZQqQWMp+knkLriKB7iamd8ue3p1ilor8cNXKPOh0bt3sd4V
         EEFX7Ouja8WzUboqBV1eEtGhGEukJ+KgfjZc1JJEe8vC66dWi6gY0TWda+ddghYtWc
         Hr4WYICo2LE6T2DUt0aVLh2ncNcilvJ3wCrR5lMzisa5wv+0mlA8kXRDEfvSmXV1oP
         XFZ485gRFNPow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC04BF0383D;
        Thu, 19 May 2022 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] platform/chrome: cros_ec_proto: add initial Kunit tests
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165292501176.725.12319166348769924651.git-patchwork-notify@kernel.org>
Date:   Thu, 19 May 2022 01:50:11 +0000
References: <20220518091814.2028579-1-tzungbi@kernel.org>
In-Reply-To: <20220518091814.2028579-1-tzungbi@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        dianders@chromium.org
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
    https://git.kernel.org/chrome-platform/c/2c2d9dc1541b
  - [2/4] platform/chrome: cros_ec_proto: factor legacy out from cros_ec_prepare_tx()
    https://git.kernel.org/chrome-platform/c/c81768cb844f
  - [3/4] platform/chrome: cros_ec_proto: update cros_ec_check_result() comment
    https://git.kernel.org/chrome-platform/c/a78a6540e90e
  - [4/4] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_check_result()
    https://git.kernel.org/chrome-platform/c/90ce792231d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


