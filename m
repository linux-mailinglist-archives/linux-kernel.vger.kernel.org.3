Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCF250A705
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390746AbiDUR1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390580AbiDUR1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:27:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F10A48885;
        Thu, 21 Apr 2022 10:24:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 440E1B82874;
        Thu, 21 Apr 2022 17:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82287C385A5;
        Thu, 21 Apr 2022 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650561888;
        bh=5INB3gN/SAkPNZQ5UM6mylptmqZsyfxjKbIbVC01LrI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WPluND3RRWmNFYki8i0haBuoDbhRSwkLhpi0SBbKFVTEbEGu8TDF5smKJ1O+R3De1
         kbA3y25fHEhnDkgjIfmIq5FqmQI8M8qf4eHLS6dxI7uVkPMvd5PPoIKRpBUKKJTKLb
         1G/a+rgqbrfME/0gluBI6SOMgxacAEBmM2F8WuotRi+ZsK5q2QI3QM38dpXMEMlAdv
         /6KAe2IVvjW4LOCgsZR2AV9bAPJCJLLOA7e+VWYxhAv3I3W3h1H5M6O0D3kFsFAnad
         vgnm/zHnj2GnDwMASKt1ShZn77gqEHH6yx7YU820rRUuOWm8/iSl3BSILjUMy8AJNa
         1Pb4mYK/78eJg==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, steve.lee.analog@gmail.com, lgirdwood@gmail.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        ryans.lee@maximintegrated.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220311132906.32292-1-steve.lee.analog@gmail.com>
References: <20220311132906.32292-1-steve.lee.analog@gmail.com>
Subject: Re: [V2 1/2] ASoC: max98390: Add reset gpio control
Message-Id: <165056188725.376935.1518021217219450490.b4-ty@kernel.org>
Date:   Thu, 21 Apr 2022 18:24:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022 22:29:05 +0900, Steve Lee wrote:
>  Add reset gpio control to support RESET PIN connected to gpio.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: max98390: Add reset gpio control
      commit: 397ff024960634962af93e9e2775fc0e4fe7de92
[2/2] ASoC: dt-bindings: max98390: add reset gpio bindings
      commit: 68514c9f6aa676f98328844336fc4400244a8479

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
