Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F6547C574
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbhLURvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbhLURu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:50:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557E3C061574;
        Tue, 21 Dec 2021 09:50:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA301616BA;
        Tue, 21 Dec 2021 17:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AD4C36AE9;
        Tue, 21 Dec 2021 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640109058;
        bh=5f+E7cJULqIn1P5GZHZpSxW+++jdp1IvvCYJFitA2bE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RO079kw1zrxfLpiu9+IoGDdHZZICfml4yYeLh2QQd3uiht3M1IrOGkMbejVV/Pjv1
         0dg1mCJtKhqLc8LFREepRu6wVHNothqXpKExMxsHc9IMZ4VBtV/hhBbQQcHO82mHVB
         5dUjJD2x/6eSjikgHURtiZBUiDLFm0qL8gs4WcPO6EiEzUN3ZTticrIDheJYbBVoNi
         At+eiHgWP1fS2mU8dqd8DFFOemqh0O5C5o6MUoT/zzdeLCQcK1+yv4GXt7VL7urdcE
         Zz6mi6Ma6UfLHcWlRsBK4UJqEj9IdtOm9sTc5dqD3kcj7fgBtaNnhmAjKlRaCQzeuC
         fxkk1JZ60L4CA==
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org
In-Reply-To: <20211216160229.17049-1-digetx@gmail.com>
References: <20211216160229.17049-1-digetx@gmail.com>
Subject: Re: [PATCH v1] dt-bindings: sound: tegra-audio-rt5677: Correct example
Message-Id: <164010905640.2818037.9602407885797991307.b4-ty@kernel.org>
Date:   Tue, 21 Dec 2021 17:50:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 19:02:29 +0300, Dmitry Osipenko wrote:
> Remove non-existent properties from the example of the binding. These
> properties were borrower from the old txt binding, but they were never
> used in practice and aren't documented in the new binding. They aren't
> reported by the binding checker because dtschema needs extra patch that
> hasn't been upstreamed yet to make unevaluatedProperties work properly.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: sound: tegra-audio-rt5677: Correct example
      commit: 3bf4fb25d5c2455396a1decd43f5e6b775f0b377

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
