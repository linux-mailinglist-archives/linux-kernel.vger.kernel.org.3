Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE1A56850E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiGFKRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiGFKRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:17:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0910C24BDE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1AB7B81BCF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E36FC341CA;
        Wed,  6 Jul 2022 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657102631;
        bh=XjcKeAQVQG+yHoXVErP9byRJUVznXxdAWaloT3bDLRY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gkRjDnNXXMGna0mJreuuYeUMV0GkNwIXr0wbe8fz+MD8VQe3tFFagJ7KZ6l2ay6tz
         oQbzJvYD4bWyH2gJgvGnWMpBzM1nsxIn730j/r0ve9o9iKpEWc7eQJfEXjrATwjfpl
         b6fbOiwHuCjUvWxOj51k8sEPYZrkg0xIdbRlghexl9rx247d9v1inrixebFqxzoqB3
         QO1MqkRzcC97kRm8T3jv527d59sLz+vgbdEQSrotG5NL809pO/cLxD/7gJyzvnfmt9
         Ase/YPrYnHr0N9IJqT8JbMbUtR57zzZcuetWcbsp60nUYVZPsVC+7oDZgRf6T5QK3u
         vrL2eMyE4qu8g==
From:   Mark Brown <broonie@kernel.org>
To:     lee.jones@linaro.org, naresh.solanki@9elements.com,
        linux-kernel@vger.kernel.org
Cc:     Naresh.Solanki@9elements.com, patrick.rudolph@9elements.com,
        sylv@sylv.io
In-Reply-To: <20220705122244.472894-2-Naresh.Solanki@9elements.com>
References: <20220705122244.472894-2-Naresh.Solanki@9elements.com>
Subject: Re: (subset) [PATCH 1/5] dt-bindings: mfd: Add bindings for MAX5970 and MAX5978
Message-Id: <165710262998.218847.2059131000668986827.b4-ty@kernel.org>
Date:   Wed, 06 Jul 2022 11:17:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 14:22:39 +0200, Naresh Solanki wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> The MAX597x is a hot swap controller with configurable fault protection.
> It also has 10bit ADC for current & voltage measurements.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[3/5] regulator: max597x: Add support for max597x regulator
      commit: 38493f008deb435577361d4c4cdd69f7bb30f4b9

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
