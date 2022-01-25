Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298A449B196
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350350AbiAYKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbiAYKU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EBEC061755;
        Tue, 25 Jan 2022 02:20:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C25B61635;
        Tue, 25 Jan 2022 10:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54366C340E5;
        Tue, 25 Jan 2022 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106023;
        bh=bPm0LjPdqkJuh3S4vN12VSn0qh8bPUdA5DbAm6JDSKI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=E0g1wqBLEi1ip7lwDDh6jAKSNrueJIO+J0FOpq62I7AyowojSutWWFQbU8me7o04V
         rsYRAH9ZkB1Ri9RGHM636oiMoGhse+mlfVjQ+X5ue3y/7EIiB4jhYyHBc7vDhxy92a
         f07gXfB7UvO0Gd5Wfu5xUWZmB+GlNVb/ewuAuZ0zlWLVeIfOhI8how56sbrGszcnSj
         ZgqVhR7FLfQ/qNHy3cWz1qYwGZDU+TEkFV+MjW0J1Z//bCqPB34erCS7otnbW7CEek
         nJtv5F3/F3zA8LBmta6Qe03PefruPPgKOq1peyynvmGAlK8ZqGvZS6b+z1WGf2q/4h
         0/AuOhLHqfo0w==
From:   Mark Brown <broonie@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     tiwai@suse.com, michael@amarulasolutions.com, tony@atomide.com,
        lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com,
        nicoleotsuka@gmail.com, bcousson@baylibre.com, Xiubo.Lee@gmail.com,
        shengjiu.wang@gmail.com, festevam@gmail.com, perex@perex.cz,
        robh+dt@kernel.org
In-Reply-To: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
References: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
Subject: Re: [PATCH v2 0/5] fsl-asoc-card: Add optional dt property for setting mclk-id
Message-Id: <164310602006.74844.15557219169532586931.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 10:21:04 -0300, Ariel D'Alessandro wrote:
> This is a follow up of patchset:
> 
>     [RFC patch 0/5] Support BCLK input clock in tlv320aic31xx
> 
> Sound cards may allow using different main clock inputs. In the generic
> fsl-asoc-card driver, these values are hardcoded for each specific card
> configuration.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] dt-bindings: sound: Rename tlv320aic31xx-micbias as tlv320aic31xx
      commit: 85f856f790b5fd427cb31b3f62755713174da0aa
[2/5] dt-bindings: tlv320aic31xx: Define PLL clock inputs
      commit: 6045ffd366283236f0de79c8a0e98ae766e9a8f9
[3/5] ASoC: bindings: fsl-asoc-card: Add mclk-id optional property
      commit: 55915f20ad9ae92015bf7b2c4ac854e5b720d63f
[4/5] ASoC: fsl-asoc-card: Add optional dt property for setting mclk-id
      commit: e6ec5a3936ee0c01f46e1d09dc758bb762e06dd9
[5/5] ASoC: fsl-asoc-card: Remove BCLK default value for tlv320aic31xx card
      commit: d4c4e2861560ab1cbf540bbda5bcdf4c92b17110

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
