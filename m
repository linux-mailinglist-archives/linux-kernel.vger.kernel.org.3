Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F149FD4A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349777AbiA1P6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiA1P6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:58:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCC6C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 07:58:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC8161EAF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 15:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0D4C340E7;
        Fri, 28 Jan 2022 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385517;
        bh=I6A4BBJmtFNGYfY78duMBHkLQCr0djtkeEScL1vltss=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uxFmIBryjr1ZV/KyebvQMJQU+bWY32fswAF28YtL/G/IHgGGWI/hlsqjnfWZ6+8gO
         E2z+rs3/R1ES+fCALYc2CsCDNuhzXJlyqQLUDe7rX5cvzpGJIx21TFd3B3EEmYyKyY
         AtodREZQ21a1bDt4Jy+/0TvrrTUtDEeT+BUZNLB6zXjsRwSd+RJhGghhUYRGZRn4b8
         wRMH5oBmqIyqFCYECp4BNmtI+XR9wsMPPOEr1ULJFELfmbAXtockQw2/lnZmeTjITn
         ryoE50AVvLXJJBKveUrnPg8sOMc8ReGYBB8ocurmVlIX7GH8R0ucXmJk3KXHCZqosy
         Wftc6pCTjL2+w==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, perex@perex.cz, lgirdwood@gmail.com,
        quic_srivasam@quicinc.com, pierre-louis.bossart@linux.intel.com
In-Reply-To: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
References: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/4] ASoC: qcom: fixes for Qualcomm codecs and q6apm
Message-Id: <164338551575.1711238.8376590607688196814.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 15:58:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 11:35:45 +0000, Srinivas Kandagatla wrote:
> Some recent testing found few issues with wcd938x and lpass-tx codec drivers.
> WCD938x was accessing array out of boundaries resulting in corruption and
> system crashes along with not handling kcontrol put return values correctly
> and rx-macro had incorrect sidetone registers offsets. One final fix in q6apm
> to add a check if graph started before stopping it.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/4] ASoC: codecs: wcd938x: fix incorrect used of portid
      commit: c5c1546a654f613e291a7c5d6f3660fc1eb6d0c7
[2/4] ASoC: codecs: lpass-rx-macro: fix sidetone register offsets
      commit: fca041a3ab70a099a6d5519ecb689b6279bd04f3
[3/4] ASoC: codecs: wcd938x: fix return value of mixer put function
      commit: bd2347fd67d8da0fa76296507cc556da0a233bcb
[4/4] ASoC: qdsp6: q6apm-dai: only stop graphs that are started
      commit: 8f2e5c65ec7534cce6d315fccf2c3aef023f68f0

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
