Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC045834D0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 23:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiG0VZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 17:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiG0VZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 17:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E25C977
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 14:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8C2860A6D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 21:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B065FC433D6;
        Wed, 27 Jul 2022 21:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658957145;
        bh=RQDcnihAQECpIPIGtWrEQpvzYtBnkf+NmAmzZ4dC/+Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qKpjjjqn72xgTFE8Qs967fz8bQD3tFQehF+DhEXll8ngJ6CijQxk74P78F9PgEEAl
         cPg3QrIlLgVmk9c8J6XrPwFx4duifuTOvNznH6a4FL9d2EXnRTcpuK6NO1IKzp6zF+
         CFsOzPkhTWpmv9M74RzJYoHPOlb5/ogttmxg6adjPewcBNoGK33dJh/vXxU5IWfTtO
         /QgOK9PSHj1BfJAtuKKQoB5wu1YQbYZc3D3JpOO2OQxeK0B14LBJqRCgnsUCfcdXHH
         Ap+5hzZ6i52hj6/zevDEdIJCfzT0HDS8bw5VAgLgWCrzQz4eCKLWDLcvKFA44uTWNw
         Wd5jvPxQxF58g==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com
In-Reply-To: <20220727124749.4604-1-srinivas.kandagatla@linaro.org>
References: <20220727124749.4604-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: codecs: va-macro: use fsgen as clock
Message-Id: <165895714343.1039659.13792597737035466028.b4-ty@kernel.org>
Date:   Wed, 27 Jul 2022 22:25:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-d1cc2
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 13:47:49 +0100, Srinivas Kandagatla wrote:
> VA Macro fsgen clock is supplied to other LPASS Macros using proper
> clock apis, however the internal user uses the registers directly without
> clk apis. This approch has race condition where in external users of
> the clock might cut the clock while VA macro is actively using this.
> 
> Moving the internal usage to clk apis would provide a proper refcounting
> and avoid such race conditions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: va-macro: use fsgen as clock
      commit: 30097967e0566cac817273ef76add100f6b0f463

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
