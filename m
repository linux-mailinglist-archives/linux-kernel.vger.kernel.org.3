Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE42D47B88F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhLUCvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:51:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53044 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbhLUCvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:51:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B9C4B8108E;
        Tue, 21 Dec 2021 02:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E090C36AE8;
        Tue, 21 Dec 2021 02:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640055064;
        bh=MWsSe+f/4lMO4ek8jRQKfguvVlMxW/ReWXj6iBmyEvg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=X/O5ikSYgLXRodJDAAnqTOhuyNlIrIuAM9T9rObSgJhXQe5hi4q16Rk8N2mHD8I46
         4USHq6FL8+6WYdYrCJImrmzYsf6nfp5buosLqARxr2fWRfGqN5+8sjW/gF2/AOHuDN
         Dog2B/4btB9HkKiGIiq3W51b/jXTK92gMdlnGMxwG3xz3Sh7R/CsxRkLy8+OlxdBeM
         JRSEktZ+eF9/9Mb94GreDbTS+qVwp48oUZcHjDWOTsNiOUKMLv3XYfTO5ML+36dQTq
         QZdMJA/LXkiKHdsQbgX9e1A4OQEsC29ny2QgaCHsod7CrF/VkaovlZG8lFE0GWPPCz
         fHTFL8WWctCVA==
From:   Mark Brown <broonie@kernel.org>
To:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        bayi.cheng@mediatek.com, sean.wang@mediatek.com,
        linux-arm-kernel@lists.infradead.org, gch981213@gmail.com,
        bgolaszewski@baylibre.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
In-Reply-To: <20211220121825.6446-1-tinghan.shen@mediatek.com>
References: <20211220121825.6446-1-tinghan.shen@mediatek.com>
Subject: Re: (subset) [PATCH v7 0/4] Add basic SoC support for mediatek mt8195
Message-Id: <164005506109.2648034.14953790658708739553.b4-ty@kernel.org>
Date:   Tue, 21 Dec 2021 02:51:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2021 20:18:21 +0800, Tinghan Shen wrote:
> This series adds basic SoC support for Mediatek's SoC MT8195.
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[2/4] dt-bindings: spi: spi-mtk-nor: add new clock name 'axi' for spi nor
      commit: 6008cb4c98d935a844edf2f3c13639104f533e30

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
