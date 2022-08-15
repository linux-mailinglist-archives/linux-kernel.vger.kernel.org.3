Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EE2593330
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiHOQZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiHOQZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:25:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A67240A0;
        Mon, 15 Aug 2022 09:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D879611E8;
        Mon, 15 Aug 2022 16:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0C1C433D6;
        Mon, 15 Aug 2022 16:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660580579;
        bh=00opu7Jl4uqjr0Td6sGAV8yEUvH/0wMplSwVn+zuZJo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TMZL/lvEj6KGpWG+ScvbPm2kNPrt22Zd+6oorYe74odqhJaC2eoYvuRnLwGxdg4BE
         4wfKXP3/SFbWiX34QwyMWMOo+iQtaEZkN2ly3d3lEZfdtc6Hxq+/Imo6AcO5X4a7bA
         PUpHlBBUjkdrVt7l7ZajC1eUWSryKdfaZUZLmJeW5a+h9m9LMFpR0CEBX1L9QL+eLI
         6vGVs01tCOFzu5GVvZj3fSblMrAFNuCLMnOgCZ7A2tTih3YvCzIZvNC+hTfpG02FN9
         YRgng/mBacC1pj/v1kNkknjvPW0jkM4Fc4Yd8swflvmFBknCYQ2IiyWgkVlCfpfi9D
         vMHAEw8hTRv4w==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        devicetree@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
In-Reply-To: <1659443394-9838-1-git-send-email-shengjiu.wang@nxp.com>
References: <1659443394-9838-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v4] ASoC: dt-bindings: fsl,sai: Convert format to json-schema
Message-Id: <166058057756.769843.7829360954309157566.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 17:22:57 +0100
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

On Tue, 2 Aug 2022 20:29:54 +0800, Shengjiu Wang wrote:
> Convert the NXP SAI binding to DT schema format using json-schema.
> 
> The Synchronous Audio Interface (SAI) provides an interface that
> supports full-duplex serial interfaces with frame synchronization
> formats such as I2S, AC97, TDM, and codec/DSP interfaces.
> 
> Beside conversion, 'fsl,shared-interrupt' and '#sound-dai-cells'
> are added for they are already used by some dts.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: fsl,sai: Convert format to json-schema
      commit: d563336877b21ede46053103c726f50a0206d155

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
