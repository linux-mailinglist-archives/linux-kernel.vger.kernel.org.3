Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D7E596FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbiHQNfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiHQNfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:35:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4B6DC9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AD3DB81DD1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D576C433D7;
        Wed, 17 Aug 2022 13:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660743297;
        bh=kr0FR9Z+V5WfuK83d1JvmmyAxyKeg/XARl8kO1LD0f4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BhpvSXN4iFt2WMnBEP1Nb6HJBEOHYo4lZmz0NHjsSOd2eQo6gPBAoIaKWPgsdeIun
         8hCq7JMYeO8c9SQJ2vTtaMZBNGBIFh6brzvKC+EUdQZP6eJuG4nND+GuwG2vLl1xxd
         NGO5JtbsJmO3XtLIjnDcesvyoogaJithdyHrUuRDg2fxc2/+vTkSytWmGaTJhNYxpP
         ghsZnApb5w58YE2K7w9XlST23Zl9dCgKPZYqC5HEKvl7bPT5RKu7JlOk5YyUaKq7HC
         9WCBZhq9HPXXdYZsnwATUwe/6HJxUi1cyWTPEwMKlhIlLYxNEJxCFiR2QYuyyp1gGC
         EW+6drosPI9EA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220725141036.2399822-1-linus.walleij@linaro.org>
References: <20220725141036.2399822-1-linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2 v2] regmap: Support accelerated noinc operations
Message-Id: <166074329711.125185.16628497508711108759.b4-ty@kernel.org>
Date:   Wed, 17 Aug 2022 14:34:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 16:10:35 +0200, Linus Walleij wrote:
> Several architectures have accelerated operations for MMIO
> operations writing to a single register, such as writesb, writesw,
> writesl, writesq, readsb, readsw, readsl and readsq but regmap
> currently cannot use them because we have no hooks for providing
> an accelerated noinc back-end for MMIO.
> 
> Solve this by providing reg_[read/write]_noinc callbacks for
> the bus abstraction, so that the regmap-mmio bus can use this.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/2] regmap: Support accelerated noinc operations
      commit: c20cc099b30abd50f563e422aa72edcd7f92da55
[2/2] regmap: mmio: Support accelerared noinc operations
      commit: 81c0386c1376da54f05d6916936db5220df9f97d

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
