Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7E649FD57
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiA1P7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:59:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53186 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349792AbiA1P6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:58:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB4EAB8263E;
        Fri, 28 Jan 2022 15:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3741BC340ED;
        Fri, 28 Jan 2022 15:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385527;
        bh=SG0hgFKjqWwBCUkDI0TEOtxJTRzQD+ug6SvmhGJoPNE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=dM7FKElzgK5/EIrq4HLLjJRGcdxqdwJHyMketq/GIVO3YulxTdDJ69awmByZDEtCa
         ot/1O2+PBWng50JkL65onkOEIUv6SPv5jYNKGGzVG5R54X0fAvHb4aZLayFbJUrs6a
         quj3IMsdUoAJ2eQU9FKOH1pWLBfjTCjOsl6Z4wbYQG5Mrd9ZY7NJrFveXyaieRikb6
         keTNUKTdbh+4GocJLOS0UEczUmz4B60wjScCJEEyjjIKqOnjH2FoqxVq7a9svCasDQ
         mZXpY9MN69nQYfcQTcvPT5nicayRBGr/HvFuDYFTGHaPRxkuogFnRaWxwJbznq3/hj
         TXCK228dndnCA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com, thierry.reding@gmail.com,
        perex@perex.cz, Sameer Pujar <spujar@nvidia.com>,
        robh+dt@kernel.org
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        mkumard@nvidia.com, linux-tegra@vger.kernel.org
In-Reply-To: <1643268455-15567-1-git-send-email-spujar@nvidia.com>
References: <1643268455-15567-1-git-send-email-spujar@nvidia.com>
Subject: Re: (subset) [PATCH v2 0/5] Tegra234 APE support
Message-Id: <164338552494.1711274.10416282145153327937.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 15:58:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 12:57:30 +0530, Sameer Pujar wrote:
> This adds APE support on Tegra234 and enables sound card on
> Jetson AGX Orin platform.
> 
> 
> Changelog
> =========
>  v1->v2
>  ------
>    * Rebased patches on latest linux-next
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: tegra: Update AHUB driver for Tegra234
      commit: 4fcc8710fdd91b37760ccd99bbfbe10352df7600
[3/5] dt-bindings: Document Tegra234 APE support
      (no commit info)

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
