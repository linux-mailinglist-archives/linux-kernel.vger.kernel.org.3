Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FDA4F7BCE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243868AbiDGJkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiDGJkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:40:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352B2104A7D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEDBDB826EE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92328C385A4;
        Thu,  7 Apr 2022 09:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649324291;
        bh=nxRdElh0vk+IXTQCrcB898n7wUD2KeNpFSmnXuRAGVA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FtaDKzjVPsO/2BDY3aupkyGwrFi4VPXjDm5ZXsT5/lu0ZYiceONqxoLj+yLAjAFxH
         SBCNn7kSvooeVmCJJMYJmIkejTWK8myCf+sLysyWScMR09+RPgj6o/0IlUIiEJXYao
         7UTS7ll3rofg6kDA+RetVvIhyvdlByJ9FAN9xHgNNvvjQk8Eo0jjrTK+fF0LxHBzCE
         GfA8X4BD42Jrwdpmoml/HYKgFyQmFPz3ujNYR5c+r8Xp7RYwasCNxfumj6rgg6azca
         CJjOdujeLgM2xTloVk7ITS0OTJPThmN/Gilfl/f0tzz0pzo3nOjipm2bZRQC118ZMH
         pkdDGUqnLzV7Q==
From:   Mark Brown <broonie@kernel.org>
To:     kmarinushkin@birdec.com, lgirdwood@gmail.com, steve@sk2.org
Cc:     wsa@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220405163618.2158090-1-steve@sk2.org>
References: <20220405163618.2158090-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: pcm3060: use simple i2c probe function
Message-Id: <164932429031.3844153.8075755988733330975.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 10:38:10 +0100
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

On Tue, 5 Apr 2022 18:36:18 +0200, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
> 
> This avoids scanning the identifier tables during probes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pcm3060: use simple i2c probe function
      commit: 5a07a41fed93e7c7f7ba5ac710c2ccdf3a168bee

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
