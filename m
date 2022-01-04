Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45D84845BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 17:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiADQCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 11:02:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49518 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiADQCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 11:02:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02C0C614E6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 16:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43AEC36AED;
        Tue,  4 Jan 2022 16:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641312137;
        bh=bQKZ3qioIULVMm21JOCcr8tIMugI86yzGzaKSnpPJ0Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Ez19Phz8Wp7n1zoIPtLHW/HXKm7rwk1U6VwBaK5bmfBE6RDOZJJNs01B+yrh03x21
         K0QuquhsHpAWzJLDubct8umRsLMwhKWM1nYH06jHvXDs8aQGVpqn/e7M16EYGFqQBJ
         hfOZNnUYcRgZ7K3au713ECOmxph1DpdF7kGiXOtDLx1PHHUou2QNh/wUXx7D3TP/E/
         m8XTmic4+kH8zJRWuiAcrywiOeVmsMDVre5R+oIF3+jXD24LUyCiM8SnX9iSAqKHwT
         aflL00x90aNvhz3L/shBxGXq4fP4KkAkqYjtLCKBmljxNu7yoRDPFyXdL7GwS9nlc0
         raT80vJ6Uot8w==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com, lgirdwood@gmail.com
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Zeal Robot <zealci@zte.com.cn>,
        Minghao Chi <chi.minghao@zte.com.cn>
In-Reply-To: <20220104104139.601031-1-chi.minghao@zte.com.cn>
References: <20220104104139.601031-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] drivers/regulator: remove redundant ret variable
Message-Id: <164131213558.2665148.2101695497540419615.b4-ty@kernel.org>
Date:   Tue, 04 Jan 2022 16:02:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 10:41:39 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from regmap_update_bits() directly instead
> of taking this in another redundant variable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] drivers/regulator: remove redundant ret variable
      commit: 1f156b4285865dc2eb66e7a78c7ba80c17bb2b0a

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
