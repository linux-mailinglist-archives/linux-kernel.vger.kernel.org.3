Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96684575244
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbiGNP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 11:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239735AbiGNP4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 11:56:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC05D4598F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 08:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71ECEB82730
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 15:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2639AC341CA;
        Thu, 14 Jul 2022 15:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657814191;
        bh=M8ftTXABzDvKMG0XKIyxzF3NtJtmh1Tp0FznAxl/zQU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ugh1PoSgziTvmmdjKZyu5ut01qdqJVisNBA89EdFIq37PtAOXESE94LVA8/FxuONS
         oxxJtUGhQAE4q0gK+jEEvsxWSK5pXIZtIOv1hqmZfba9D23YSkcaRhtV3opSvLFbo3
         /JIFTCTsc3o6500Mn2v3koO2wD3/TEGTXszWHRIHKXf68yBRk6F+08fCpALuUnrjl5
         zz9C8XosamBQm4xdcN3OTdajM1K5rBAmf2iRSwGrWks01WqLV9DYi7M52G7lL0eGMu
         njFEWdhYhgGHfXuTt37La6GhNGNGVG9AZnA5fU6odF9E0O4RSCN6cUzvlFn+61hZga
         AngSAyMjEDd8g==
From:   Mark Brown <broonie@kernel.org>
To:     axel.lin@ingics.com
Cc:     linux-kernel@vger.kernel.org, patrick.rudolph@9elements.com,
        lgirdwood@gmail.com
In-Reply-To: <20220714101212.502824-1-axel.lin@ingics.com>
References: <20220714101212.502824-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: max597x: Don't return uninitialized variable in .probe
Message-Id: <165781418986.107719.7474087128436200879.b4-ty@kernel.org>
Date:   Thu, 14 Jul 2022 16:56:29 +0100
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

On Thu, 14 Jul 2022 18:12:12 +0800, Axel Lin wrote:
> Remove the code checking and returning uninitialized variable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: max597x: Don't return uninitialized variable in .probe
      commit: d1d9d40891f92573ab2aff9bed9293be9b667067

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
