Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF42F49FD5D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 16:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349826AbiA1P7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 10:59:08 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53272 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349806AbiA1P7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:59:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0197B803F5;
        Fri, 28 Jan 2022 15:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5236DC340E0;
        Fri, 28 Jan 2022 15:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643385540;
        bh=Ey00GCGMz8DhWyX/BWwWoapqFAyU905LC/zaSGyVAxQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JiM7HZ2hJj5quYV1YmUfhhLe5Zq7jLloxsFTJWNQx0Jnqn/PASS94Ee9oJLqTqOYI
         7hh23Anjze6GjMqcNbLjCTwS0DxlOcWqJuz7liPiX0tnKmKw3l5JjZUFiEXNLhPWNM
         nlFS0yDrmeH3eOJD/NOT5rwsLR5LImvGEU+95R7ZUyWwaToDlbxcT/1WaF7Z8RXW49
         DB1552XjXNOBamGFd92idPL41cCncTc16/fG+vEwp5mgz2jLWk9P3whg/yGHnqX7VP
         qvVKoIGZaKz18u8nCjnvMtXkVwqaa3VuD0X1CuteuCnNz53rcgDsNjhJGBQvR+CWdv
         3hlzkOdwwWErg==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20220126231250.1635021-1-robh@kernel.org>
References: <20220126231250.1635021-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: regulator: maxim,max8973: Drop Tegra specifics from example
Message-Id: <164338553904.1711445.13850736441373070169.b4-ty@kernel.org>
Date:   Fri, 28 Jan 2022 15:58:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 17:12:50 -0600, Rob Herring wrote:
> There's no need to complicate examples with a platform specific macro.
> It also complicates example parsing to figure out the number of interrupt
> cells in examples (based on the bracketing).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: maxim,max8973: Drop Tegra specifics from example
      commit: fa183433bf53ee092323005f05cb3491e4aaaa8b

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
