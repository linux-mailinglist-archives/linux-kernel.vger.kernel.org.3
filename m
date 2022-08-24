Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D9C59FB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiHXNUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiHXNUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C87275C2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B22446164C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4143C433C1;
        Wed, 24 Aug 2022 13:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661347214;
        bh=bODKFTQuSMzql3SxzMoBF/qen+dHwPXNa7w7aWhKbkE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=sSUYnu3kIjMCO0NCHmStEP5YQQmIz7ymhwXWqxLu2c3EIDvNY8VzkT+6Tx3ywFZnE
         C3YLwyv7/RTgAlPIzznY4QM+DI5wkWlHiEVNZs3zPAMK2YmvRCwkNvnyQjXVu+JMJb
         1a8/N3pvfJFw4V89zmD1S8eblvPOCBdfwRoYzIKk2THo3rbZ9B1VUPShte2jWWeBE2
         ILjYwf04gDltI7sGiw4+IEX4FPGIsLzrrNvvy8I4D14hGJ8rqPQQ3PTL72pPN1NArs
         htUnKrMKIhr7U8xBUaINKq6jleq3lhb6PXj3R2KYWeC/qlDjR3f4mGd+hocJDZMERl
         6tOGbSEk92Y6A==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
        lgirdwood@gmail.com, ye xingchen <ye.xingchen@zte.com.cn>
In-Reply-To: <20220824074707.221159-1-ye.xingchen@zte.com.cn>
References: <20220824074707.221159-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] regulator: max597x: Remove the unneeded result variable
Message-Id: <166134721255.181585.1510109649063511335.b4-ty@kernel.org>
Date:   Wed, 24 Aug 2022 14:20:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022 07:47:07 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value from regmap_write() directly instead of storing it
>  in another redundant variable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max597x: Remove the unneeded result variable
      commit: 48aa47308de609e687dc187b72de92e3346c4187

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
