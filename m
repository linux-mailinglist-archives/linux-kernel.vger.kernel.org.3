Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9514E544DE8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbiFINlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbiFINln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:41:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAFA25EB5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:41:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B209F61D42
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 13:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8304C34114;
        Thu,  9 Jun 2022 13:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654782099;
        bh=YfwemhhRNfHkDcE7hmvHDoWfd3apl8aK4u9+a87TYAU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=j6NCY82atJdRW+KDfnW10DrMSfLqY+EmOIQyNSG4Tfr3eoio+yE9T2rPOp1IeO1E+
         PGqCi7NT+bUklMuWQinSASg0FxPEAW31dDfB6AErks7p6O43T12oUgPkfCzuP53h2p
         O4bporKziDJnDVZ/9Z5AUn2PCu6JNev8RDpud/cbmgpyRDlN7MdIU/OToaqCtFiknN
         +xMaYj7UO9+y+X6z4JVWNAbNmH36Sar2yz5w5oRbcAv8Hy5MNAhVHEkuP6TcfApGsd
         Yj5N3r9FLXNbmjD+IcFuVY7X/St6Us9AvlKDNAlD97hMtGVXaX4H91wL22A67T0UMb
         gNdr6wJFeQGjQ==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com, shengjiu.wang@gmail.com
Cc:     perex@perex.cz, Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        chi.minghao@zte.com.cn, linux-arm-kernel@lists.infradead.org,
        zealci@zte.com.cn, nicoleotsuka@gmail.com
In-Reply-To: <20220606033705.291048-1-chi.minghao@zte.com.cn>
References: <20220606033705.291048-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH V2] ASoC: imx-audmux: remove unnecessary check of clk_disable_unprepare/clk_prepare_enable
Message-Id: <165478209647.1066808.13320829803906102569.b4-ty@kernel.org>
Date:   Thu, 09 Jun 2022 14:41:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022 03:37:05 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Because clk_disable_unprepare/clk_prepare_enable already checked NULL clock
> parameter, so the additional checks are unnecessary, just remove them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-audmux: remove unnecessary check of clk_disable_unprepare/clk_prepare_enable
      commit: 142d456204cf4dabe18be59e043d806440f609d4

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
