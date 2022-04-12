Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D05F4FE74E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358419AbiDLRkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358338AbiDLRkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:40:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789F362A25;
        Tue, 12 Apr 2022 10:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FFF8B81F61;
        Tue, 12 Apr 2022 17:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32F1C385A1;
        Tue, 12 Apr 2022 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649785090;
        bh=zZkQCYesF/sm5DoAVfI8r+QbjE7oMDeDYotH3+XpDaU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=s0NFGWHc5QAgTBSymp29uk7oQhEMqGisqfHn4x1/xF9xqYlm5JMsTxRA89yI00uPL
         rHvTifL97r26jNMjXlDwvsFUTNbPcbknnhm16iVxHcEgAfc2KC/i93gS+XOx7TdEnh
         z/0t6h9hCb/uHkNDg4LQnfipwYVRxQUApuf3A6SRs03Qpxba5eKIAOWFeez3PyWUVg
         iQThjtzcxRxMbIH8mY9QnYLF0tUCm3RHdgf96vkJeSnrcKvnOIRWRf4T7fJXHFp2RH
         euZQUtMZWgA+85Fd/DpOI0l3476J+qCfb3gv4F1ql4QtBktXYvVuBgF67rvxBOoUPC
         nFC9C4o9CRRtg==
From:   Mark Brown <broonie@kernel.org>
To:     thierry.reding@gmail.com, lgirdwood@gmail.com,
        jonathanh@nvidia.com, perex@perex.cz, tiwai@suse.com,
        spujar@nvidia.com, yuehaibing@huawei.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org
In-Reply-To: <20220411020908.580-1-yuehaibing@huawei.com>
References: <20220411020908.580-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: tegra186_asrc: mark runtime-pm functions as __maybe_unused
Message-Id: <164978508863.404572.4357231774639790524.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 18:38:08 +0100
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

On Mon, 11 Apr 2022 10:09:08 +0800, YueHaibing wrote:
> sound/soc/tegra/tegra186_asrc.c:90:12: error: ‘tegra186_asrc_runtime_resume’ defined but not used [-Werror=unused-function]
>  static int tegra186_asrc_runtime_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/tegra/tegra186_asrc.c:80:12: error: ‘tegra186_asrc_runtime_suspend’ defined but not used [-Werror=unused-function]
>  static int tegra186_asrc_runtime_suspend(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra186_asrc: mark runtime-pm functions as __maybe_unused
      commit: dc7680ca7ac6c32b8c18aff36bca728a2f83e2a0

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
