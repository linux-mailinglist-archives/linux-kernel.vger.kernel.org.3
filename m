Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F19524F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355116AbiELONQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355118AbiELONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:13:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7525562CEB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:13:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08C2761AC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB3CC34117;
        Thu, 12 May 2022 14:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652364780;
        bh=68GFkRgsrtca9GWvE/A57OESbgWrNobjqyS8pJVM7kA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mztajfliKVo8agx+Q0g9wLIjqs8vonKuc7nEbgPpRWPEKw/8YEk4ud55fybgtQedV
         9kAacqe3ZgYgyDbON5D4W6DLTYQHYPAeJR5aPIVe4dKGy+ccVFrmBl/Tm9Yms3EfYZ
         ViF1hq0qz6lLvWA1xjLa6pLLm/JEzq2dDcOq61LRZZ1WCNVTND6s+K9CRIt2EB73KE
         tEdf93K62NPXKJxmPcPABkUL7hMYo8XO2nbQrdJT5uyJdgFKf5WuR4tF/5LT0IHbgQ
         icBKcm5YJcG3YmiNybUEDUtRwXya7MCm0pGL+F3fi/Px8/7YgxgiZbcc9gYfUCRmC/
         BAg2Nu9akh7EQ==
From:   Mark Brown <broonie@kernel.org>
To:     tanghui20@huawei.com, lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com, ricardw@axis.com,
        linux-kernel@vger.kernel.org, ryan.lee.analog@gmail.com,
        steve@sk2.org, perex@perex.cz
In-Reply-To: <20220512074640.75550-1-tanghui20@huawei.com>
References: <20220512074640.75550-1-tanghui20@huawei.com>
Subject: Re: [PATCH -next v2 0/2] ASoC: codecs: Fix build error
Message-Id: <165236477836.1016627.1128343126631448820.b4-ty@kernel.org>
Date:   Thu, 12 May 2022 15:12:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 15:46:38 +0800, Hui Tang wrote:
> Fix two build error, as follows:
> 
> Changes in v2:
>  * Add missing header files instead of adding dependencies.
> 
> Hui Tang (2):
>   ASoC: max98396: Fix build error for implicit function declaration
>   ASoC: tlv320adc3xxx: Fix build error for implicit function declaration
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: max98396: Fix build error for implicit function declaration
      (no commit info)
[2/2] ASoC: tlv320adc3xxx: Fix build error for implicit function declaration
      commit: 19c5bda74dc45fee598a57600b550c9ea7662f10

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
