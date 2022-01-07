Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910F8487D2D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiAGTjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbiAGTja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:39:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C4AC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:39:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A7AA61522
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 19:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D8FC36AE0;
        Fri,  7 Jan 2022 19:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641584368;
        bh=eR46zMBDy11gJc3rRJfmmiWthEO+2ukIN1hpDQa5LTA=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=Lsniqt5s1I5QjWNdU62NRm6jp39UqGp6p8UCGqOEyT9pDcXy93BvUOioC3bDhjXCP
         4ON3C+FYJWHL46TjfhuNXuyZa88VoFfKQpz8502uDtSrOdNWjZkkTk1O1fhHSUOnFf
         Bs9KdIz8wmzi90Tm4BnVOQN4L7CYHAfBfaUbVsh3FlOAXaWoP/ijXPh6vqxSOWG77n
         tF79Br+q5Sz6r84qAEfInfyj8AFPFD3dlXHP2dAEFZ3EaVfDgbPN9BCex3Vp/Uahjb
         M4z5axbi6ilZ18t0DcJ0jdvQgT7nBjncm4OWKhpCWAsoXaa2Oq4t+vI8TwI/+0YppE
         E2MsdvdwEdRSg==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
In-Reply-To: <20220107191145.813876-1-broonie@kernel.org>
References: <20220107191145.813876-1-broonie@kernel.org>
Subject: Re: [PATCH] regmap: debugfs: Fix indentation
Message-Id: <164158436805.1749549.4504241367241648279.b4-ty@kernel.org>
Date:   Fri, 07 Jan 2022 19:39:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 19:11:45 +0000, Mark Brown wrote:
> 


Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: debugfs: Fix indentation
      commit: b56a7cbf40c895cbe8b67ce5649a26b7a7bc48be

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
