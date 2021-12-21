Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5B47C1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbhLUOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:43:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37842 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhLUOnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:43:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 797586162C;
        Tue, 21 Dec 2021 14:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BA0C36AEC;
        Tue, 21 Dec 2021 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640097802;
        bh=zs0pRYfzDm3/92K39XTHazInHRGHzlCY1oDliqEaOWg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EIwg3vm8l3VYBpxKKzXdVD7DyH73kBkDVGdZnD79uyYAcAc1z3+LJa5BvgxxZhcHH
         xDku7+yt84zAOs0yhNGIwiEEvgd02ejnwFhmdkjQBcBD57F/PGm9F8H3sjeqGXA6cG
         k1uYyFGcoCeZLUixQ5b9n9GXIeVe6p9DXj09bXwP7Q+Vrp8e/5B3bsDbiFnmlhlFa5
         pVmXs08BzUGAuC96XJMaWkjBKxy7U3i6HAj5XfFMiQ7tfEuXOnDJoJWMwBjQfQKYiN
         77+3txuAk+P8vZaur8bMK0O4LjdwPINsv9KwN5NYwUQqTM8tm+7wJKY6Rs1knPCImR
         nfAMgupR89zcw==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211221120744.1118518-1-robh@kernel.org>
References: <20211221120744.1118518-1-robh@kernel.org>
Subject: Re: [PATCH] regulator: dt-bindings: samsung,s5m8767: Move fixed string BUCK9 to 'properties'
Message-Id: <164009780128.868718.2419980624533374160.b4-ty@kernel.org>
Date:   Tue, 21 Dec 2021 14:43:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 08:07:43 -0400, Rob Herring wrote:
> There's no need for a fixed string like 'BUCK9' to be under
> 'patternProperties', so move it under 'properties' instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: samsung,s5m8767: Move fixed string BUCK9 to 'properties'
      commit: 5d55cbc720cc3650aafed6c1f5dbcf7e3f276312

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
