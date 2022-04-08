Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFFC4F9D62
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbiDHS6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiDHS6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5313A209A50;
        Fri,  8 Apr 2022 11:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E38A261545;
        Fri,  8 Apr 2022 18:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4972CC385A1;
        Fri,  8 Apr 2022 18:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649444191;
        bh=nIAQQiM25OUwJCglLgOqN04FfV2hY/JrotWsrqPqsPs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PL0p03H2RZ4zrIHtNHXATSJ3k3akFyjyrULUbduj2T8cHrs+mrZAetrUj0jB9qpkR
         tIjGHo2c2KQZY6EsO21t+TT6G03NltB9Kelpcjyu3XTtqvIXt4v3vAIF1dL3o5I2Fe
         imzc7Qt64iVcFCJ/GclFSrWXMQBl471JnnLJl5JiPAiKWcxLmvFo9pcSRlumehztUv
         xaFhVs0xhI+A+xetEEyimj1gARyBick7ly/TYvgTxWqOd9JrHD/MkXMXi2GoNNikQf
         P9bEentAIdovHsZXwX9vLqs0eyrTrVxgrsvUzVRWRlfZpnW6oRhcTK2fdEHcv0r5q4
         P/i3vFaMBzeuA==
From:   Mark Brown <broonie@kernel.org>
To:     quic_srivasam@quicinc.com, perex@perex.cz,
        quic_potturu@quicinc.com, christophe.jaillet@wanadoo.fr,
        srinivas.kandagatla@linaro.org, tiwai@suse.com, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5b5a015a9b1dc8011c6a4053fa49da1f2531e47c.1648969065.git.christophe.jaillet@wanadoo.fr>
References: <5b5a015a9b1dc8011c6a4053fa49da1f2531e47c.1648969065.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2] ASoC: codecs: Fix an error handling path in (rx|tx|va)_macro_probe()
Message-Id: <164944418901.1442858.13330584837821971131.b4-ty@kernel.org>
Date:   Fri, 08 Apr 2022 19:56:29 +0100
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

On Sun, 3 Apr 2022 08:58:27 +0200, Christophe JAILLET wrote:
> After a successful lpass_macro_pds_init() call, lpass_macro_pds_exit() must
> be called.
> 
> Add the missing call in the error handling path of the probe function and
> use it.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Fix an error handling path in (rx|tx|va)_macro_probe()
      commit: ddfd534528146660de75ee84d6db10f10e778f95

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
