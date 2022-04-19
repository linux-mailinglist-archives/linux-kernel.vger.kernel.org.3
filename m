Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86430507CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358330AbiDSWsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358308AbiDSWsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:48:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF222B3B;
        Tue, 19 Apr 2022 15:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0474617F2;
        Tue, 19 Apr 2022 22:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C3FC385A7;
        Tue, 19 Apr 2022 22:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650408347;
        bh=oFrmVt7diUGg23xnq8Ws4i7Aqg6iMPkDGSrPSwGwlDY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=oGZWZuNxO+7MYIkQ1yssO1l8yH/w2QRcEHMPmFqO5J5+P0toNtcMJTwIiFJ6gNgft
         gJox92+cTE28ejC27INmIJp4zOYgDmHqDmsJrJjN3jGzxsPFmi9iFL/9VtX2VFQyQZ
         rbg3Uf3F9vFJXBHxDnv2WH+5bSrWAzjgP9BIxg3XiwlNgTCQfgAlsAmIm2T2jj7CEw
         AizjrI3zIucNW8K/sJAJWnVYIWpAbuaR/wPHEKU/xbiBWc3Evc9//IR2V21QD37Y4p
         5cDDaroz+2ppg7QWd6uTBZTHl5cqceB3Pb/D3E/L3Xgn2Sb3G6MAdS2u5QaKmNr0Bp
         W80iEI93UCDmA==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     zealci@zte.com.cn, chi.minghao@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20220418110226.2559081-1-chi.minghao@zte.com.cn>
References: <20220418110226.2559081-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165040834609.1910395.1272535105725628075.b4-ty@kernel.org>
Date:   Tue, 19 Apr 2022 23:45:46 +0100
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

On Mon, 18 Apr 2022 11:02:26 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: dd769f15483cac1895fd219eb17e6f04c9a5548f

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
