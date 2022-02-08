Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727764AE1B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385718AbiBHTAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385683AbiBHTA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:00:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADD3C0612C0;
        Tue,  8 Feb 2022 11:00:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8901A614EB;
        Tue,  8 Feb 2022 19:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CD3C340ED;
        Tue,  8 Feb 2022 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346826;
        bh=gfXvkga31gtScG3PAFSqii8DL+WtjmYgzBiRFXGx1GY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QNZDKkyExtsuQjcMmhBQxqMJ23HorD3atbPdnojZbnclKEDLYjg5BT3fP+jFPxOv3
         7F1wezf9S0YAPCE4rLGAIrM6H/llBo2RYi2U+QUS/+tDM2z2m8V3WqY8XtfmWZLOQv
         z67w5MarMgT5aBfDUCY24kcex4xBegQ6TpajI62OyCqnQ7K1DedAt8Bet7NUbi69E4
         yt0lKrefwq+MX3kwJbEV+1/p8DETSmckrpYmpp7UdzQMucpxmCHuaEy0fA4tHppxUu
         tpE4VCFoTVhPeyAH+hX/35obpnkrse6KK2oWZfIO63pw1i5ss35nJGhRgcRPwUdZKV
         1RLQuxUEchsoQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Li-hao Kuo <lhjeff911@gmail.com>,
        linux-spi@vger.kernel.org
Cc:     lh.kuo@sunplus.com, wells.lu@sunplus.com
In-Reply-To: <a94e3b123773fe303221d2bd2e4ce36ffa905a1c.1644198957.git.lhjeff911@gmail.com>
References: <a94e3b123773fe303221d2bd2e4ce36ffa905a1c.1644198957.git.lhjeff911@gmail.com>
Subject: Re: [PATCH next] spi: Modify irq request position and modify parameters
Message-Id: <164434682465.1135514.5039896591915156527.b4-ty@kernel.org>
Date:   Tue, 08 Feb 2022 19:00:24 +0000
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

On Mon, 7 Feb 2022 09:57:22 +0800, Li-hao Kuo wrote:
> - Change irq request position to the back.
> - Add temporary varilable and setting (as suggested by Mr. Andy Shevchenko)
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Modify irq request position and modify parameters
      commit: 47e8fe57a66f72c5734b981b21557c732b9a5eb6

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
