Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DEC593334
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiHOQ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiHOQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:25:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3686727145;
        Mon, 15 Aug 2022 09:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7485611E7;
        Mon, 15 Aug 2022 16:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4280CC433C1;
        Mon, 15 Aug 2022 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660580595;
        bh=klkdRZjVUCbKPYpLrXmZGgCw2bm0eoGm07/vH67fHm0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BMdZqWCxmbAZX9JDyxke8qQpRlT4L+NPW1DcofI0qztzENni/UHoGA4svFEfyS8eW
         RqXzeZb/7U98PyFyDzofA4055jKsxu6Hcwvo+nla/MLrvX61504i+UrtPpAF27M3/j
         RnQdzNuauvgthRMCZij2EVvk3stf8NFty1+Iojwfrod7oHg5HMSoliBpVrzmi4e9ro
         dL3rQJG+efXyn6eCW8dBDYL0GGoIs+ZWjsg9f9wDuZ2Q+/4IcJQJ6NAKIp5avGaoyI
         POgTa3GKjiCzJraX0miXU5ZDd8NRAV/YqDR6VLYzpuDW8K+WJ3hz/TGaW9gJTxgnMD
         F/Qkb+C00iJuw==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Sameer Pujar <spujar@nvidia.com>,
        robh+dt@kernel.org, tiwai@suse.com,
        krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, perex@perex.cz
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1659936452-2254-1-git-send-email-spujar@nvidia.com>
References: <1659936452-2254-1-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH v3 0/3] DT binding for sample format conversion
Message-Id: <166058059299.769843.16903933604865911201.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 17:23:12 +0100
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

On Mon, 8 Aug 2022 10:57:29 +0530, Sameer Pujar wrote:
> DT binding properties are available to fixup rate and channel
> parameters of a DAI. This series extends this to sample format
> conversion as well. With this now DAI PCM parameters (channels,
> sample rate and sample format) can be fixed up as necessary in
> an audio path.
> 
> Changelog:
> ==========
>   v2->v3:
>   -------
>     * Fix DT binding errors in simple-card.yaml
>     * Drop simple-card binding changes from the series since
>       there is no usage requirement. It can be extended later
>       when necessary.
>     * Use definitions instead of properties in the common schema
>       and re-use this in audio-graph related bindings.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: Definitions for DAI params
      commit: b79b6220a753995b80054916f1f8f037113d8d93
[2/3] ASoC: dt-bindings: Add sample format conversion
      commit: 955927873d82c5127e31e618703d804033a93e4f
[3/3] ASoC: simple-card-utils: Fixup DAI sample format
      commit: 047a05366f4bb2e32eabbd3c8990d1d91ab87c89

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
