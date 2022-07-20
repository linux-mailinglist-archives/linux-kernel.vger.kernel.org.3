Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E4B57AD40
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 03:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbiGTBlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 21:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239993AbiGTBi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 21:38:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B9D4B0D9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 18:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3E9B619AB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32C52C341CA;
        Wed, 20 Jul 2022 01:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658280617;
        bh=fZwQtaFYuizNw7lEwji+c2ITfTYKCofJLx9evyiq0Yo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MlDlKUsRH7SnRaQo41ZRW7VUXO41W5XLTMbJEVItHcGTpoIVZzUjc0zE8i3Y7MPZu
         rbi/pVuMyY2Pkvp90aEnqwdDpQqA/GWA4SkgJOGJcqilHO4F8JjGajdf28/sZbirWA
         l1J8iMM3ZqnjnUNf0FSA4Lwu56NSZg4P9OM6EpPjE4ZrwpBy6DK5pqa5rZwoF4mvsy
         TW5iAJoLSY0LPg+0Ekn4NmaTzW0NpWsEZ3CSmTbsLa/rq5bG+KcSNHVNMsm0Oi8wEi
         N+ke7nRBJiTleVVBUSX8xwvQHgET9ELxU8NYES0r282qKfkm7DmBnh6Ji6lM0+KWxg
         K6xdsXK8S79zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 130DAE451BD;
        Wed, 20 Jul 2022 01:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/10] platform/chrome: Kunit tests and refactor for
 cros_ec_cmd_xfer()
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165828061706.6388.15708318327609247616.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Jul 2022 01:30:17 +0000
References: <20220718050914.2267370-1-tzungbi@kernel.org>
In-Reply-To: <20220718050914.2267370-1-tzungbi@kernel.org>
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

On Mon, 18 Jul 2022 05:09:04 +0000 you wrote:
> The 1st patch fixes an issue that cros_kunit_ec_xfer_mock() could return
> garbage bytes for `msg->result` if the mock list is empty.
> 
> The 2nd ~ 6th patches add Kunit tests and refactors for cros_ec_cmd_xfer().
> 
> The last 4 patches change the behavior a bit by altering return codes.
> 
> [...]

Here is the summary with links:
  - [v2,01/10] platform/chrome: cros_kunit_util: add default value for `msg->result`
    (no matching commit)
  - [v2,02/10] platform/chrome: cros_ec_proto: add "cros_ec_" prefix to send_command()
    https://git.kernel.org/chrome-platform/c/d311664b9057
  - [v2,03/10] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_cmd_xfer()
    https://git.kernel.org/chrome-platform/c/82f4def2d822
  - [v2,04/10] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_send_command()
    (no matching commit)
  - [v2,05/10] platform/chrome: cros_ec_proto: separate cros_ec_xfer_command()
    https://git.kernel.org/chrome-platform/c/810be30d27bd
  - [v2,06/10] platform/chrome: cros_ec_proto: separate cros_ec_wait_until_complete()
    https://git.kernel.org/chrome-platform/c/0aad9aff6a64
  - [v2,07/10] platform/chrome: cros_ec_proto: change Kunit expectation when timed out
    https://git.kernel.org/chrome-platform/c/00eb36d52872
  - [v2,08/10] platform/chrome: cros_ec_proto: return -EAGAIN when retries timed out
    https://git.kernel.org/chrome-platform/c/7f95d2b68b9a
  - [v2,09/10] platform/chrome: cros_ec_proto: add Kunit test for empty payload
    https://git.kernel.org/chrome-platform/c/82c9b7ed8c5c
  - [v2,10/10] platform/chrome: cros_ec_proto: return -EPROTO if empty payload
    https://git.kernel.org/chrome-platform/c/3e1c715ea179

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


