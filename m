Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49BC465596
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352587AbhLASic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352591AbhLASgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:36:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E00C06175D;
        Wed,  1 Dec 2021 10:32:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 493B5CE1EEE;
        Wed,  1 Dec 2021 18:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E019C53FAD;
        Wed,  1 Dec 2021 18:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638383551;
        bh=k2RPRS4bfjVfz7mCoadcSXBrEPElf3gU/exvA6eYqNI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IegrtML5gxAQBzH5g0FG14VD+0lmSOP85HEXxv7B3maolSzkR+6FoF4JTwBlyDyZr
         UphzirPlJdxvSHtorBWjAUZDyjLzY2IiUiuSXGXSy8mIo+qYlmbFiy0312NQb4Bxr3
         8Ofwtt0r5/yGcssm+TeLJf3VUYVMznNS4rrVUeM9i+zlYW0+ykWtcAL2wfoD3WlzaO
         5CTQLnNzRgXlyH6/4q4pbfIGU6ZpJXiAh6ZbMi/rBFQIDZyjU1uTkHVXtR37XLuoyS
         FNiyz2ur8MhbFdP6fE45lILerzjhBhxyL3RthVTy5sKHy/DmDowDcEP/IAQKJJN2Lf
         tq0SZFJjNLkzw==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
Cc:     devicetree@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
Subject: Re: [PATCH V3 0/3] regulator: da9121: add DA914x support
Message-Id: <163838354996.2179928.12475633790824117230.b4-ty@kernel.org>
Date:   Wed, 01 Dec 2021 18:32:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 23:27:54 +0000, Adam Ward wrote:
> This series extends the DA9121 driver to add support for related products:
> 
>   DA9141, 40A, Quad-Phase
>   DA9142, 20A, Dual-Phase
> 
> The changing of current limit when active is now prohibited, for the range,
> due to possibility of undefined behaviour during transition
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] dt-bindings: da9121: Remove erroneous compatible from binding
      (no commit info)
[2/3] dt-bindings: da9121: Add DA914x binding info
      (no commit info)
[3/3] regulator: da9121: Add DA914x support
      commit: c5187a245e9bb0af2da8d37ede191569c824c66b

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
