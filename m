Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F01250E730
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbiDYR2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244066AbiDYR1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFF940E71;
        Mon, 25 Apr 2022 10:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9DAB61584;
        Mon, 25 Apr 2022 17:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E565C385A7;
        Mon, 25 Apr 2022 17:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907487;
        bh=cleYBeIiFaQSB0ySqyNgSRQvQT4wn5ve85lUCtx6Ta4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rfJNN2JWHF9W4uegXtu/lqcacg1Wx/laHxPNZEA8r6FK8CxL2NZOb9P6V79Aiq+rR
         pDS4CDxJ7tCWwot+dhYuOj5kG5cmpf3eC855qyW4GsOkJ+KwICcQvDFSnSJEoVp138
         YBr/6BdUtNyNANH3n3iMlEnSuRKLEHbHT2dDq1pZZG+93eGlrRNXNHHC15ZT25KGij
         78TvSsc3qPRqObZhaq44VpCIORWuU13+CUM8uYeRDYCiIeF/OWItgZ1w/jbxGxGz9b
         lHDfO4e5xm+1YgMkiebXmDgIdadX0lDHFEW5RQNJDXG4skSh6Avgiu3m/Wvvy/9NId
         7xDdo1Gf9LgpA==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     zealci@zte.com.cn, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn, linux-spi@vger.kernel.org
In-Reply-To: <20220414085506.2541732-1-chi.minghao@zte.com.cn>
References: <20220414085506.2541732-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: spi-sprd: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165090748578.584172.5039668709284291105.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:45 +0100
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

On Thu, 14 Apr 2022 08:55:06 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-sprd: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: b9db82e5f24932d3a1005ce17b2ef564487c1bca

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
