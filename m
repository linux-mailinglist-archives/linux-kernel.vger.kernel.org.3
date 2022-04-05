Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9AD4F44DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387166AbiDEPQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346727AbiDEJpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841D4DB494
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1181F616D4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35960C385A4;
        Tue,  5 Apr 2022 09:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151089;
        bh=uiHlZ9B3W5lGU7aCGfu3OCnkS1lVxbCtOKddSVWv370=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Aw/uVEikYg8w3z5RTaGTNwjjbtuQmJM8DVW6rEK0C8n4NeO/0vceVMQqZnybRJheT
         oHX+s9DXOpjM3QFZQN92Se2ntxM/2zWzZN3Hd8OuXO+BBF90CtCu/kuY4aR8OQ7LfF
         w1T0hYlrTiK2NNewvy9WGaslxhv1ltyZdKhQ/+9c2lXTviiWD2UxOK3f6J8YwSEhYG
         lGO4Wa8wuHSL4F9QaS+c0PypM85PvX+WmfYiJEEdPMr5TkCFd5F3actAy/YxPG5rXq
         7s7Yyy7treNrWRXWH9HaNSikWHwPG9Vjtuwidt5niqeRz9gsPldh1x3ms7giwpJ3pV
         l4p3JRPez9bUg==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, steve@sk2.org,
        support.opensource@diasemi.com
Cc:     patches@opensource.cirrus.com, wsa@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220325171243.1218003-1-steve@sk2.org>
References: <20220325171243.1218003-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: da[79]*: use simple i2c probe function
Message-Id: <164915108791.276574.934197360062835441.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:31:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2022 18:12:43 +0100, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
> 
> This avoids scanning the identifier tables during probes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da[79]*: use simple i2c probe function
      commit: 89be5dc60d67b377be60b47dd12d1a3ee142aacb

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
