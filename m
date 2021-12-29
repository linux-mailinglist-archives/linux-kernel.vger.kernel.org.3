Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13479481384
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbhL2NaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:30:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54152 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbhL2N3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:29:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D328F614CC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 13:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD0AC36AED;
        Wed, 29 Dec 2021 13:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640784576;
        bh=MVd5KxCSC+WZfhjw2O7WEcyUHBPE/JuOeakntOcIc14=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=C5gSrjwRStroLkZ/epa1jGi2OA8EOu32iTt1btMArfi06cXJ7ITIMnVk87msdu8IF
         K3Oz+tsCBORRd8fxjqGxlPPU33SUQs6TeqaZOaRk16E7LIavEtVemojAa7v5zCLPnG
         3Sh8NO8aIV0BabukM9WJkdD23tGP8XatUztzWlalIhaq02ZhsZv81DUeUR0ZfWcHj3
         lUtiordOhrC2uRibydkZreZnvANV3wLz4u7X7eXubjC+IRoVuKSLr6jtPc7jNZRRGA
         LCAWnU+aN7j5mdqw/GpizeVKo5PaWnpJ/WuI7nJMVHS04A6vue+jDQhWGzYEgaI5mQ
         aJ8RxG3/4uJ3A==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com,
        krzysztof.kozlowski@canonical.com, s.nawrocki@samsung.com,
        perex@perex.cz, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20211228034026.1659385-1-jiasheng@iscas.ac.cn>
References: <20211228034026.1659385-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: samsung: idma: Check of ioremap return value
Message-Id: <164078457442.1246652.6708919601470029287.b4-ty@kernel.org>
Date:   Wed, 29 Dec 2021 13:29:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2021 11:40:26 +0800, Jiasheng Jiang wrote:
> Because of the potential failure of the ioremap(), the buf->area could
> be NULL.
> Therefore, we need to check it and return -ENOMEM in order to transfer
> the error.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: idma: Check of ioremap return value
      commit: 3ecb46755eb85456b459a1a9f952c52986bce8ec

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
