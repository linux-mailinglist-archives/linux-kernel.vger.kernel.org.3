Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A303A4F3DAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 22:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbiDEPQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346723AbiDEJpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4991FDB491
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE18EB81B14
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E7EC385A0;
        Tue,  5 Apr 2022 09:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151087;
        bh=m1VtNLJCV5XLWS6tt7vfyPyB6QR8Pr73DLRKOlt7RQI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RrEGXG2W66uQLHr04moxSeZCTeC4CPuShZEcPYaCzlt39ojk3uNdCCDsfJBvIxz7A
         v9y7ZNYuRklQeKbGtCNOuCjbJVjHINXd69SO5LfG+frix8HCJakt/RAMSQB/Bm57qp
         VpzEyM4aVuZVhHZo6jXoGBOIuQcNaM7wc7D1Jy9kGlssoHxd6otp3lAAact+LJUQda
         hzMaoEee5/wTWJadEEc7qCaCSF2qrAGiuq1iHwwnxsOeYaweqv1IIIZa8MFGTwV/se
         VpguqKo8+6DL8ZYqEGchc9uRJ1smrt/SnLxE8bAwHKp048hvjGFEKdVTcG6H+sDYRy
         0cO5WHaqye0fw==
From:   Mark Brown <broonie@kernel.org>
To:     steve@sk2.org, james.schulman@cirrus.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, david.rhodes@cirrus.com
Cc:     patches@opensource.cirrus.com, wsa@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220325170734.1216018-1-steve@sk2.org>
References: <20220325170734.1216018-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: cs*: use simple i2c probe function
Message-Id: <164915108582.276574.17456095772438726338.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:31:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2022 18:07:34 +0100, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
> 
> This avoids scanning the identifier tables during probes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs*: use simple i2c probe function
      commit: 4a4043456cb82df20e146902cfb3dd84bc393cd3

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
