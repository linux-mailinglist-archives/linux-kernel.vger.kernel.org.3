Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C361947C73B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241751AbhLUTMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241719AbhLUTMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:12:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39012C061574;
        Tue, 21 Dec 2021 11:12:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8E6C6178B;
        Tue, 21 Dec 2021 19:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B6EC36AE8;
        Tue, 21 Dec 2021 19:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640113957;
        bh=PAs5jiYeFo0MBioLBW42YrvXg3HDfr/75mvKAgP84o4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mU333hz0r1ky9N5/Cxf891yMrzILchntrHGZPscClx+sfRB1ORC2u1lgzqaabDVbg
         MzFK5rtV5d0fpUUQMeCKfCXCVsKeUxEBxlMBEbZVGWOfIi9fOrROjFdWx5dy2Kv8xv
         7ROsBWlNoLI1YYooIMxAoSdCPfqW8bNz7nw0elqS482K9+BvB+zdQD5NV7OMLUIjht
         0f4iA9t8RiETnFfczdqAmNTvNLfd2nWTHgFEFBKa/t5/LDy+DMSwEhqfYrzZDW8Q5s
         r6pVoYlqnn3PDsjS/mRgtuV0iwFXJriQoUFKKBL12hUJTuXyvWRsG24T8u3qx0hmoP
         BDfONoq1OfehQ==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        perex@perex.cz, Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     stephan@gerhold.net, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211220193725.2650356-1-vincent.knecht@mailoo.org>
References: <20211220193725.2650356-1-vincent.knecht@mailoo.org>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: codecs: Add bindings for ak4375
Message-Id: <164011395475.93163.15678068758276605566.b4-ty@kernel.org>
Date:   Tue, 21 Dec 2021 19:12:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 20:37:24 +0100, Vincent Knecht wrote:
> AK4375 is an audio DAC with headphones amplifier controlled via I2C.
> Add simple device tree bindings that describe how to set it up.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: codecs: Add bindings for ak4375
      commit: 70ba14cf6dfd7ebd1275562bb9637b8d0ddb8f49
[2/2] ASoC: Add AK4375 support
      commit: 53778b8292b5492ec3ecf1efb84163eac2a6e422

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
