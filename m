Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72C1465593
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352523AbhLASho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:37:44 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:57790 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352518AbhLASgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:36:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C42BECE1DE5;
        Wed,  1 Dec 2021 18:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A617DC53FCC;
        Wed,  1 Dec 2021 18:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638383561;
        bh=XMwothHRCXVzZ7qmcrWNOO81dC0kkr6UvNf5WH7ltLM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Y1nuZMGHOzUV0Ug1r3QA0CeX9J7FOZKu4HRVU1axUgnUZDxVpj2qLy4uwCO2/dGTA
         QeUar4guoqNcudmg3u5RsCpuo7xm/sZS2981z2hmHOErkVbLT2uTU1r9ovleILRCrn
         WR1fki0IuRMn2D+ZR9R4g5AvXrAbY5D788eQnRG5My6rXnzMpLnAyVQcy4oSYQHAWN
         7wase2qkq3sJuc5Tb5s+r2B80UKr7dT2pbV7V105eosxrnFfKUghlIxeoupf7d66Qv
         P8ISnA2JAHKpLlZWC2my+Jw2Or8VgXaTPoPVnekPT+XYEhZvUQF9Tu+Nw6achlZz4+
         bqjq4mp9mxB/Q==
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Pratyush Yadav <p.yadav@ti.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nishanth Menon <nm@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20211109181911.2251-1-p.yadav@ti.com>
References: <20211109181911.2251-1-p.yadav@ti.com>
Subject: Re: [PATCH v3 0/3] Add bindings for peripheral-specific SPI controller properties
Message-Id: <163838355839.2179973.4774761056314884390.b4-ty@kernel.org>
Date:   Wed, 01 Dec 2021 18:32:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2021 23:49:08 +0530, Pratyush Yadav wrote:
> This series adds bindings for peripheral-specific SPI controller properties.
> See patch 1 for more info on the motivations behind this.
> 
> This is the best approach that I came up with with my limited knowledge
> of JSON schema. It has some limitations that are mentioned in patch 1. I
> don't know of any better ways to model this. Suggestions are welcome!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: add schema listing peripheral-specific properties
      commit: 8762b07c95c18fbbe1c6b3eb1e8e686091c346b5
[2/3] spi: dt-bindings: cdns,qspi-nor: Move peripheral-specific properties out
      commit: b6bdc6e043906c70e949b2747772e6aa1d36f2a3
[3/3] dt-bindings: mtd: spi-nor: Add a reference to spi-peripheral-props.yaml
      commit: e9d7c323cfbbd07c365a419b4ce3dc2f161442c7

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
