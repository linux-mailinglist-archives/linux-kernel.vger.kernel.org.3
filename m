Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F8521DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345426AbiEJPP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345216AbiEJPPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:15:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF51F26C4E6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E83361978
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43120C385A6;
        Tue, 10 May 2022 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652194174;
        bh=okWehPSv94o5n4/YHnWsmeTik2HBIjXblj7tJPWDO9E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=t1SxeHdp7fQWC9lw9euzejlkdo37j7bMZVQAqq6jmXaUhqFbk4GkvQ5QjwxGzYmbs
         cCIAKfAM0tpqpEpqA+GHIiC3DsaQBYnQekmQctwNx0OvP6jsUj3S8AL4OCmjAZD1Zb
         zVccDEt4TFv3t5ci7d+G7qPcint0YWkIMm7XRljq59e8WUPV72vqKZVdTH93os0mgw
         ME7Saj6J6c2hpxBhDV8nXLXH2I8Bm8vY+b5AqZ4MAEPuqTsZe3FpxFNYDgkM/kIkQL
         TsU+oe8eDEQEW03XmGau/8vqaS1rSwkVAPUpPBKgJ9ccxRUlJTxSJVviLw5yhA8kb0
         TYECMedw9XmNQ==
From:   Mark Brown <broonie@kernel.org>
To:     yangyingliang@huawei.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     krzysztof.kozlowski@linaro.org, lgirdwood@gmail.com,
        s.nawrocki@samsung.com
In-Reply-To: <20220510124749.2663874-1-yangyingliang@huawei.com>
References: <20220510124749.2663874-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: samsung: spdif: remove unnecessary check of mem_res
Message-Id: <165219417300.388769.4515467081124288900.b4-ty@kernel.org>
Date:   Tue, 10 May 2022 15:49:33 +0100
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

On Tue, 10 May 2022 20:47:49 +0800, Yang Yingliang wrote:
> The resource is checked in probe function, so there is
> no need do this check in remove function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: spdif: remove unnecessary check of mem_res
      commit: 9d62ba94266be3ddc864348a4df7e54f5562f0d5

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
