Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4CC46BEDA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbhLGPNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:13:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35094 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbhLGPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:13:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 897C9B817F8;
        Tue,  7 Dec 2021 15:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32572C341CE;
        Tue,  7 Dec 2021 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638889792;
        bh=PpbQSP51Mj24YSQZmjKBbOhl+We3PajnAHFwiLGiQ2k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tHyVKOrn/IysdNgeJFNu7zzw0uD9J92LC0YxFaI+4YYu6ScRKGGHoYrgSdhQ/8twc
         OCZkr5lJaVZZebk547Ox96iDPWMZbGFFYPtn9DZJLsHO5+atvGZn+1HCgOtsXBtNVk
         dZuc3a/5kanF34mfvJGWfovU5BuFTk7q+Lvps/lXM/5dfKwOKxJ7BcdS0cV7Eiy5wJ
         9hG1v9Hf9DMk3XOhT0Njddk2Fc1rmmE6IdWwLzrau3nI7FZK4itg7BdGFc29yuufo6
         hxfQyOnwZ+uyN678SQ0ElQ6iTrAVxB5B6lLdoM7amtJrK0Zy7cb0nwdzeg31kfhJbr
         QGaaSuV2EtsQw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20211206153726.227464-1-thierry.reding@gmail.com>
References: <20211206153726.227464-1-thierry.reding@gmail.com>
Subject: Re: [PATCH] dt-bindings: regulator: Fix type of regulator-coupled-max-spread property
Message-Id: <163888979092.1135191.12102324768230028501.b4-ty@kernel.org>
Date:   Tue, 07 Dec 2021 15:09:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 16:37:26 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> According to the description and the various uses of this property it is
> meant to be an array of unsigned 32-bit values, so fixup the type to
> match that.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: Fix type of regulator-coupled-max-spread property
      commit: 8d2de3a548ad05fe09bca58f09ff1ab2e69cf40a

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
