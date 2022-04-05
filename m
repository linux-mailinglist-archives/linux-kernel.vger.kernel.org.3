Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497694F423D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389646AbiDEPVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347114AbiDEJqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:46:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA42276678;
        Tue,  5 Apr 2022 02:32:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55F5261368;
        Tue,  5 Apr 2022 09:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E035C385A4;
        Tue,  5 Apr 2022 09:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151146;
        bh=Pj7W+vm9/Lp1bs2VNWguTcW8ZdW7M9VQ5AaH3adc3cU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MotvbsnzwbhrK0F96wxCU4WtMKr5Li9cva2QeU7vbqBzNNCZ74ZEqfcnHRnklX1Ks
         1RjW7+s842jpmtTRWjJW7bbm0ZXczhjVSm/DV2GkO1JORw8SAk+pfMQEgqbybE7sMp
         VFmS4vjQPxZctOd88jnYFpJ963+3sSdGp8zz7wYfjLFiLXqFwhOg0Tw+Wodx68CMJU
         9JfurBnTcvQjSznoeN/pFk/cumt3gWH8e9B//XHfMtDQbWlg7Ulg5zQUTjDvlA/MZ1
         IWKfY366iShazYN8iw506M9lADcVXGe9JAY9SYciqAfM4YG3llW9m0zWxoKogUUZ5a
         AytJp4LOMbHLg==
From:   Mark Brown <broonie@kernel.org>
To:     jakobkoschel@gmail.com
Cc:     linux-kernel@vger.kernel.org, bjohannesmeyer@gmail.com,
        rppt@kernel.org, c.giuffrida@vu.nl, h.j.bos@vu.nl,
        linux-spi@vger.kernel.org
In-Reply-To: <20220324072534.63420-1-jakobkoschel@gmail.com>
References: <20220324072534.63420-1-jakobkoschel@gmail.com>
Subject: Re: [PATCH] spi: spidev: replace usage of found with dedicated list iterator variable
Message-Id: <164915114510.276894.6837144397974645999.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:25 +0100
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

On Thu, 24 Mar 2022 08:25:34 +0100, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: replace usage of found with dedicated list iterator variable
      commit: d50d7e91c6e5ccd71f21ba1aec3fef7ee4229fd6

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
