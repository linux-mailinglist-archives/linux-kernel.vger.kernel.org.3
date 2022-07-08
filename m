Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E0656C356
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbiGHUrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbiGHUrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:47:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F6A0279
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:47:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 345D5628D8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 20:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D618EC341D3;
        Fri,  8 Jul 2022 20:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657313262;
        bh=g4PglUdEdW7HC6uJZfr4a+EghlnelE/EgV3+Knnak0w=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=TW9+u/RstdPpZzk2YckRW5YKMexi5N/oR8CIzeU0JFaHmH5YsRoG4V5Vok5kteGY8
         Mtv3g+LsIbqx2c461NQUzjpUxTS72kD1h02Ujp1fWhjfFqOmKzW/0TdWDlhTHbdvaj
         hwpQv+0vGK1Rpn7HQ7V+zCl0Yim7MU12mk9YUZz9QEGsbKlBfM0bMFEeSCtZvi8Oey
         uRCF8A0e78kAsZby4QIzyVOpqkwLggtsL9XvZYA7rT4QB7zgoBSMGpZKTV7wo/sAz7
         NBtvZyZNEHl//5tA925a/sFtG32QtMuwB0nNC1SNlYdu15j+C4FZtF74nW3qyHWmQZ
         91pV70AufX19Q==
From:   Mark Brown <broonie@kernel.org>
To:     mranostay@ti.com, linux-kernel@vger.kernel.org
Cc:     nm@ti.com
In-Reply-To: <20220708013125.313892-1-mranostay@ti.com>
References: <20220708013125.313892-1-mranostay@ti.com>
Subject: Re: [PATCH] regmap: add WARN_ONCE when invalid mask is provided to regmap_field_init()
Message-Id: <165731326159.2471691.15710953551238113950.b4-ty@kernel.org>
Date:   Fri, 08 Jul 2022 21:47:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2022 18:31:25 -0700, Matt Ranostay wrote:
> In regmap_field_init() when a invalid mask is provided it still
> initializes with any warnings.
> 
> An example of this is when the LSB is greater than MSB a mask of zero
> is produced.
> 
> WARN_ONCE() is not ideal for this but requires less changes to core regmap
> code.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: add WARN_ONCE when invalid mask is provided to regmap_field_init()
      commit: cf39ed2e8ecddbee38e02691d6293b812e98e397

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
