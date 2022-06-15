Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E4754CA62
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346795AbiFONyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241638AbiFONyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:54:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B2E13D51;
        Wed, 15 Jun 2022 06:54:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5CA061B39;
        Wed, 15 Jun 2022 13:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF4DC34115;
        Wed, 15 Jun 2022 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655301276;
        bh=68WDubxLhalXX3kweNLoMTxlg/l57c7HnJZeSRidsVA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QAzXoOV4qTFwG8YVlXC05IjRNwEjXExoHhXn1AJGsF2HS0KEVA8CHGNSnsVxcld7b
         Lpy/pDwaajKjuxdzaKnpZopJnoHqlK0qOeA0D30gc/1dpJsalqe+kIoWj77uMnIZKm
         AYtqFbLhKAnM5RTT9Z3nubRWFeKItEKKS3d/sPFhNo0J9OUdWn2jlHzGIT2fmBPP/A
         lxr0fBwcbCKNWaBRSDzct1hfBlPPB4ABVbs6w+pltkrAWvGn623voDTOSIFzRJ4qav
         Y27Xy48O3BNDprSliQP2gHws+avLinAhZWla3FEhuQTND6dA/X5r2WfadKvgBKLt5W
         7g+fEjhytoDLg==
From:   Mark Brown <broonie@kernel.org>
To:     spujar@nvidia.com, dan.carpenter@oracle.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        thierry.reding@gmail.com
In-Reply-To: <1655267914-24702-1-git-send-email-spujar@nvidia.com>
References: <1655267914-24702-1-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH] ASoC: tegra: Fix MBDRC bypass mode check
Message-Id: <165530127422.947339.13523217289289739247.b4-ty@kernel.org>
Date:   Wed, 15 Jun 2022 14:54:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 10:08:34 +0530, Sameer Pujar wrote:
> MBDRC supports different modes of operation. There is no configuration
> required for bypass mode. The hw_params() call does not filter bypass
> mode correctly and it leads to following Smatch static checker warning:
> 
>   sound/soc/tegra/tegra210_mbdrc.c:778 tegra210_mbdrc_hw_params()
>   warn: bitwise AND condition is false here
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: Fix MBDRC bypass mode check
      commit: 4edf738d4c7989c315e37d4d61e34c94557b6ed2

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
