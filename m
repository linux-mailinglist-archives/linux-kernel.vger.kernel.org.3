Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2856E50E72F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbiDYR2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244057AbiDYR1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9047A40E74;
        Mon, 25 Apr 2022 10:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B0EF614C1;
        Mon, 25 Apr 2022 17:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A01BC385A9;
        Mon, 25 Apr 2022 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907485;
        bh=p5qwzWII6INTjRbhI7IGjXpEcD4KrFVexGB210tQ54Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Zdb8iTUKr27l6u/p4WBQbq9jJbO9I0oxC+KJfyHNnOHyF/FqjsqeZky8TmfaspkUj
         McYr63qXz5Rnf5VF2bHS21iTEKkQSubRmRUtx2ikm0AYzbFWlelAsN+B8sFMmq5mmU
         MUFLZ/GN4ZrnwvUBoJ0Y86tiXAsQua//0hnWme99ABN7QwObbnCoO3F6rLrQ0d3xyt
         s+aiIkqYBdECeQd5uErGWHuvQnyjKiK9nqJxP+msiorDBpagdBrqfvmygS3pruU2EZ
         KsTtx8SQS3EHllBlWtCOqHWC2D4Da0w3RjyaZ++ggDADWKSWqJu08PV9VlZr/4LNEC
         GRdpppmGcQRQg==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     zealci@zte.com.cn, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn, linux-spi@vger.kernel.org
In-Reply-To: <20220414085433.2541670-1-chi.minghao@zte.com.cn>
References: <20220414085433.2541670-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: spi-omap2-mcspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165090748428.584172.9400403191565334729.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:44 +0100
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

On Thu, 14 Apr 2022 08:54:33 +0000, cgel.zte@gmail.com wrote:
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

[1/1] spi: spi-omap2-mcspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 40b6a137717bb5ca5ccb4e4b051e0d22019cd188

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
