Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D9B57AD3B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241668AbiGTBjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240583AbiGTBi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:38:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755065F112
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F116B81DEA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 355CFC385A2;
        Wed, 20 Jul 2022 01:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658280617;
        bh=LW09UeSUakkinqEkK6hI1hdXAaURdqQSi59cs59LmU0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GUWTBNEnxnAA+5BfqFEHDPxJ+uhNhi76Z+Os4pNw4VwMFaNWdwgLJG53MxjG567PH
         wb/5oPgIn9/EjCcewMCtjH7IX1jC6EJJPGcB6QqBuzUg3GlZnuZxZ+k6cpc3LVUwyH
         fBXPluRCQ5txjuGiL/vVtKKOnPi2zxTUO/a7ESAJrQv6HPy/gFwHEzQu+DhRudsJp9
         iJHOloCq0pL2WG7MmEuiUL09Yj/Bt5z/AsaHBww6JKEP0BeICqKjwbRWGX8MAOoo9l
         Tqe+agDKClTJ+FMwAP7abygd7CDHCQJ66I3IT/QCdTMBoFOHZGP3hrjvLReLfu4oaI
         ReO/XfVwsSIPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06A86E451B0;
        Wed, 20 Jul 2022 01:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/7] platform/chrome: cros_ec_proto: add Kunit tests
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165828061701.6388.4283210644814265598.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Jul 2022 01:30:17 +0000
References: <20220622041040.202737-1-tzungbi@kernel.org>
In-Reply-To: <20220622041040.202737-1-tzungbi@kernel.org>
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

On Wed, 22 Jun 2022 04:10:33 +0000 you wrote:
> The series add Kunit tests for the rest of exported functions.
> 
> The series applies after
> https://patchwork.kernel.org/project/chrome-platform/cover/20220615051248.1628156-1-tzungbi@kernel.org/.
> 
> Tzung-Bi Shih (7):
>   platform/chrome: cros_ec_proto: add Kunit tests for cmd_xfer_status
>   platform/chrome: cros_ec_proto: add Kunit test for cros_ec_map_error()
>   platform/chrome: cros_ec_proto: add Kunit tests for get_next_event
>   platform/chrome: cros_ec_proto: add Kunit tests for get_host_event
>   platform/chrome: cros_ec_proto: add Kunit tests for check_features
>   platform/chrome: cros_ec_proto: add Kunit tests for get_sensor_count
>   platform/chrome: cros_ec_proto: add Kunit test for cros_ec_cmd()
> 
> [...]

Here is the summary with links:
  - [1/7] platform/chrome: cros_ec_proto: add Kunit tests for cmd_xfer_status
    https://git.kernel.org/chrome-platform/c/74bed42fd5fa
  - [2/7] platform/chrome: cros_ec_proto: add Kunit test for cros_ec_map_error()
    https://git.kernel.org/chrome-platform/c/1242688fc2f0
  - [3/7] platform/chrome: cros_ec_proto: add Kunit tests for get_next_event
    https://git.kernel.org/chrome-platform/c/2b7ed927953f
  - [4/7] platform/chrome: cros_ec_proto: add Kunit tests for get_host_event
    https://git.kernel.org/chrome-platform/c/7cb1eb82642b
  - [5/7] platform/chrome: cros_ec_proto: add Kunit tests for check_features
    https://git.kernel.org/chrome-platform/c/00238864435f
  - [6/7] platform/chrome: cros_ec_proto: add Kunit tests for get_sensor_count
    https://git.kernel.org/chrome-platform/c/33f0fdba6066
  - [7/7] platform/chrome: cros_ec_proto: add Kunit test for cros_ec_cmd()
    https://git.kernel.org/chrome-platform/c/9399b2cb2070

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


