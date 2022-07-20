Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3635A57BEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbiGTTnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbiGTTnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:43:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD09366AD2;
        Wed, 20 Jul 2022 12:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D9EDB821D6;
        Wed, 20 Jul 2022 19:43:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0B8C341CA;
        Wed, 20 Jul 2022 19:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658346188;
        bh=RzWVDJljyuYtz/wuc3UwRzqp1JBga9tqKqYOdngdl+M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=L8UVVyciCVERphvxpf6h/I78Wrw+/l6S/uAQICLHimwI8zPlAoB8faepX4EngxWMW
         7+OGyKk4RMF5SL7xcHVlnVHOMfywIXBbQxyjSHRMQZf5Hr8I/kZEN6kzAgwOJtbbOZ
         zSuf2RT7ZICqyFvJl0aXsgdpTBl9yvisa8aBwJHunzoCDqWtcaPlnk4LfleESr8vEA
         UD9NXeQAqCvdr6V58k21fgkuRxmbZYTXdqV+GffgNgSkN4P9alykoAJRNmAcg9yZCb
         LoZ5ZJmZ1o6S5TRXY8iyC6KFzk7/Qf/GPlic0m5+9yclkcnOG7YJr5xHuIUdiaAlUQ
         M9i/m+gRb+G/w==
From:   Mark Brown <broonie@kernel.org>
To:     robh@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, festevam@gmail.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20220719215134.1877363-1-robh@kernel.org>
References: <20220719215134.1877363-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: sgtl5000: Add missing type to 'micbias-voltage-m-volts'
Message-Id: <165834618702.685508.4578685174512904321.b4-ty@kernel.org>
Date:   Wed, 20 Jul 2022 20:43:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 15:51:34 -0600, Rob Herring wrote:
> 'micbias-voltage-m-volts' is missing a type definition. '-m-volts' is
> not a standard unit (should be '-microvolt'). As the property is already
> in use, add a type reference.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: sgtl5000: Add missing type to 'micbias-voltage-m-volts'
      commit: a6229b53194fda971213f7f0be00f3d6c70a79c2

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
