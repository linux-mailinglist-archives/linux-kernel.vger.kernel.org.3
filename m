Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EB1465598
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352581AbhLASi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352594AbhLASgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:36:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4CC06175F;
        Wed,  1 Dec 2021 10:32:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 45EFBCE1DE7;
        Wed,  1 Dec 2021 18:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B6FC53FD0;
        Wed,  1 Dec 2021 18:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638383555;
        bh=H7VixvxMwF8kkBzGs/ft+byDZiL5nE8gUvxsAcUaX8w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YUflDKLmgVf0whc1xA3VB8KzJfPyGLmaPM3n1ST1pTVk4EnpMcdS2MasnGtSyR4Pm
         AdrsAZYy9eBBmPqY3fn3k3fQcjYlrk+coS6sa9ivkBiEe9g4VdMZqhuSn6Ejx6uIpL
         Jvuc0ZQShLn699g22oVAkxoXhdIrdA6bBg6QxkF+Qjwat+042SP8nHAmjb6kInVHqT
         /9V+5IwDlfwQldVBuw/lADgXnTV4wMbytPF7c6sSeetFpoPuw0gNcxTZMSlLgnNssr
         IWS5SXN1GYzIPiFxEa2wEN3WwjMZUWofbE9XSEzQcMcMNgmqL9tvEUIj3QGRwlPcNK
         c8Jaa3JTh10aQ==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        David Collins <collinsd@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>
In-Reply-To: <20211201072515.3968843-1-vkoul@kernel.org>
References: <20211201072515.3968843-1-vkoul@kernel.org>
Subject: Re: [PATCH 0/2] regulator: qcom,rpmh: Add support for PM8450
Message-Id: <163838355339.2179928.6181194813033095813.b4-ty@kernel.org>
Date:   Wed, 01 Dec 2021 18:32:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 12:55:13 +0530, Vinod Koul wrote:
> This add the binding and driver update to support the PM8450 which is found
> in SM8450 platform
> 
> Vinod Koul (2):
>   regulator: qcom,rpmh: Add compatible for PM8450
>   regulator: qcom-rpmh: Add support for PM8450 regulators
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: qcom,rpmh: Add compatible for PM8450
      commit: fa3b06f59a03a3a4639755478e0cf5b508a1b454
[2/2] regulator: qcom-rpmh: Add support for PM8450 regulators
      commit: d69e19723f88a3ba6d4e0e52f51dd4c59cc2ae93

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
