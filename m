Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B787C56209F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 18:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiF3Qzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 12:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiF3Qzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:55:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4636393DC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 09:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82D9EB82BD5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE685C3411E;
        Thu, 30 Jun 2022 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656608144;
        bh=FxOr7jGqldlmPZhNQ+CVV3r/8IUAgqCNNc1MtsgY0EM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=r4mfjcedqPKPtKQH2gcMD8xlZOUwGtEjp9vyUNphOWyFXGioqqvRE5LSM/tgm1uw6
         /QfdM30uCJtkoxwfHF4795GUpiDd43MS5/2IZKM6fFjvucFW8Z2wjvKQHjc9N58p/F
         r/Gs1JvPfrWCQUjNZDINiMw9mqTetoiI5tHJntxu46c7YWmCqJgQeKGrBZ7xJca/Mn
         WRHBOaV0mgRDCC71nRGf0XUa+wPuRJbixdpXKyAWVcavpMnje/oTCzcJx7+kt6yqLI
         7DU6xBPQqMlttY+Me4W0eIcr8FoQx382b7cygz5T3a7Ixfn6vJ/qD4hiabTJrR3Tc9
         sq1QRPZMcVYVQ==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org
Cc:     perex@perex.cz, linux-kernel@vger.kernel.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        pierre-louis.bossart@linux.intel.com
In-Reply-To: <20220630130023.9308-1-srinivas.kandagatla@linaro.org>
References: <20220630130023.9308-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: codecs: wsa881x: handle timeouts in resume path
Message-Id: <165660814249.771023.7178878929435843579.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 17:55:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 14:00:22 +0100, Srinivas Kandagatla wrote:
> Currently we do not check if SoundWire slave initialization timeout
> expired before continuing to access its registers.
> 
> Its possible that the registers are not accessible if timeout is
> expired. Handle this by returning timeout in resume path.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: wsa881x: handle timeouts in resume path
      commit: cf6af24b54903f9f70c29b3e5b19cb72cc862d60
[2/2] ASoC: codecs: wsa883x: handle timeouts in resume path
      commit: 0df73e1a9f7b1152ace21b6406138f7487239128

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
