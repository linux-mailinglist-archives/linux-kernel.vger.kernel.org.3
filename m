Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8C556197E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiF3LqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiF3LqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:46:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA115A45D;
        Thu, 30 Jun 2022 04:46:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E03DAB82A3F;
        Thu, 30 Jun 2022 11:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB23C3411E;
        Thu, 30 Jun 2022 11:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656589569;
        bh=KZbwbKY8OlqEXl4fG8750X4KhP+vZADjW8qGjUTlxNQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sXP+op3TTdzeum6xf7A0Mw75HgNt1ocO0cyfnr8m79CLzc6pr/5l0cThAnbkE1xNO
         iM8llkQrRpeAJpwTUGojkhXXskFCVKZoFhXUCPLi1aKlGgsDyh2iuRdqfOeye+ekXM
         BjODwm459vvnpwP1UgtUfiG6RL4CgLn7Tck+Rx1e8pIMXUvUI0vB/u00XyiyE5NgKO
         QgTNw9EDDL/2brLXDR3Pyb2qj5Iig2HHLnsBFLcStez0fDJl6g6vEhsmrtk1IR+4TU
         TcczZfxwrHkIuz+xHOxjYYpyfWAUy/UheOO48KN0pMNhNReUdN1JjgU7b1UbFNvjFw
         9HzBrIHiBjr+Q==
From:   Mark Brown <broonie@kernel.org>
To:     yassine.oudjana@gmail.com, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        perex@perex.cz, bgoswami@quicinc.com, tiwai@suse.com,
        agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, y.oudjana@protonmail.com,
        phone-devel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20220622161322.168017-1-y.oudjana@protonmail.com>
References: <20220622161322.168017-1-y.oudjana@protonmail.com>
Subject: Re: (subset) [PATCH v2 0/3] ASoC: dt-bindings: Add bindings for WCD9335 DAIs
Message-Id: <165658956629.346792.3984245362995741043.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 12:46:06 +0100
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

On Wed, 22 Jun 2022 20:13:19 +0400, Yassine Oudjana wrote:
> Add DT bindings for WCD9335 DAIs and use them in the driver as well
> as all device trees currently using WCD9335.
> 
> Changes since v1:
>  - Make header guard match path
>  - Maintain the alphabetical order in msm8996-xiaomi-gemini includes
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: Add bindings for WCD9335 DAIs
      commit: 53447365ccb442bbd3dfffc2d7fd96203770dfb6
[2/3] ASoC: wcd9335: Use DT bindings instead of local DAI definitions
      commit: 66348f178d5a842c8afe52c3b743fb4af24cdb2a

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
