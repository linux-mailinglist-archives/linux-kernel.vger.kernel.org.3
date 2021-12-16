Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357444767D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhLPCVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhLPCVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:21:18 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137F4C061574;
        Wed, 15 Dec 2021 18:21:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61DF8CE1FCB;
        Thu, 16 Dec 2021 02:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398ACC36AE4;
        Thu, 16 Dec 2021 02:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639621274;
        bh=nkUMHXuChFJ8SQgxBc9IJz2hTIZPrCqyutTFbE6fZns=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T14vMczy1z/wkd6xvGn6Vjn82zR//KMjlmv3PY/WmrCY21PtkDw9UqBO5x8A5PVVN
         K3DaQ/boRM6SKh4o4OT23Brugxa81aEa2zkSgxzvTWf7gcAP8RPx84tKixS7Nb9mFL
         7w0OvQ53P2PMOspSqEiKLS5eAfyCJBmBGEEvXgpKGzSEst4KPaLjWvt9LP5/b5h3hP
         jxOleB2O17pecn+5RkWVRbufzCvkf+8MepmTZkJTiDALkqMJA14SDaI1Dcmqn4PLYL
         nhv4k76OYzKLSvM9oTaBY3uxJtMvro/Dznuw3xTmQGzCIj1M4gr+Li0Vfarwb8JyCG
         LQjv8LZYZpvFQ==
From:   Mark Brown <broonie@kernel.org>
To:     David Heidelberg <david@ixit.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     ~okias/devicetree@lists.sr.ht, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20211211224946.79875-1-david@ixit.cz>
References: <20211211224946.79875-1-david@ixit.cz>
Subject: Re: [PATCH v2] dt-bindings: sound: nvidia,tegra-audio: Convert multiple txt bindings to yaml
Message-Id: <163962127187.2075333.9430552763697046784.b4-ty@kernel.org>
Date:   Thu, 16 Dec 2021 02:21:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021 23:49:44 +0100, David Heidelberg wrote:
> Convert Tegra audio complex with the
>   * ALC5632
>   * MAX98090
>   * RT5640
>   * RT5677
>   * SGTL5000
>   * TrimSlice
>   * WM8753
>   * WM8903
>   * WM9712
> codec to the YAML format.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: sound: nvidia,tegra-audio: Convert multiple txt bindings to yaml
      commit: 88dffe43cbc625eb52a57daa0d1c0fb7037b63d2

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
