Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6750B4A4A61
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348674AbiAaPTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:19:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58244 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbiAaPTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:19:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C8EC6136E;
        Mon, 31 Jan 2022 15:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A771C340E8;
        Mon, 31 Jan 2022 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643642374;
        bh=22wprm+poGEnOpfPLghnWFdYNEbG343GxfTtoARThUs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OXn5E61HYagB6ljowhjsk3TIRAmDOT17XEALV2kLpncFwxGPEXZXCewPFh3/qMU+4
         r+FhSr41z8KOiSa9L9CZyGKIrcJczPo18zXIhN33i3MgxDYD0BrkJwOUovqGMunn6+
         XPsJXj6BnfGUkfOOcpmotZ4Iv590sJo4FXEJIfWDT06HhbxjzKpdrUZe6IQQ28Yjr1
         9Dyfrlu4ywQJclZwBCL9uSVmg5XJhV1M/zvXRHcG2XqH9nnn+8VExPkrvy9v47p+EG
         ACnQhGi00bg95kve4MWIUOLXXxKCGbtfJ5mTOw5Ep/nlGeCsK77X5apGX2DC0wyYGq
         3I/QfStCBBjXg==
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <87dce7e80ea9b191843fa22415ca3aef5f3cc2e6.1643529968.git.christophe.jaillet@wanadoo.fr>
References: <87dce7e80ea9b191843fa22415ca3aef5f3cc2e6.1643529968.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] Input: wm97xx: Simplify resource management
Message-Id: <164364237288.3159052.16795963706278985978.b4-ty@kernel.org>
Date:   Mon, 31 Jan 2022 15:19:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2022 09:06:36 +0100, Christophe JAILLET wrote:
> Since the commit in the Fixes tag below, 'wm->input_dev' is a managed
> resource that doesn't need to be explicitly unregistered or freed (see
> devm_input_allocate_device() documentation)
> 
> So, remove some unless line of code to slightly simplify it.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] Input: wm97xx: Simplify resource management
      commit: a4f399a1416f645ac701064a55b0cb5203707ac9

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
