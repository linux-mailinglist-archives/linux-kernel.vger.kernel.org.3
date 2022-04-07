Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67874F7BD6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbiDGJkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243866AbiDGJk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:40:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8771B254B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 02:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 129E361B6F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6E2C385A4;
        Thu,  7 Apr 2022 09:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649324304;
        bh=6NDuvD6dPDfYjOIGxLFIfAC4asHc6YIvrkxa0F3AB24=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T6K/Z7/63n8z1zZ7tG46DGyv0IWdHOIrwHY8ujy8K+SBHeTQ+aJxcwizdRmu65QtL
         3ypLlDretmm24XpdArE8IOgJdOYVkJgcWgFhxE9a1l4r+BgvZQ3ZMF2nhvhbs7qRc+
         E4YHwbMnfkUm+uyoDabV6Hz2WEkVbs3MvWzpxCcE6Ysv1KIGccfrSmoDK2MFaDqoId
         gWKUMUkCJ93eMbZ0U3OCdx3H/KsNZUbYBZa93VdYRAz8KHrcmRqw13UCyovCNrrooF
         lu5VpX3ROl/Ith/A2NvLOum8QRXUNA4KcU/Geh/PGWqLLaKCpnPdf9Yjm6pYNmqg3y
         aeD8cDgnFsS6g==
From:   Mark Brown <broonie@kernel.org>
To:     steve@sk2.org, lgirdwood@gmail.com, festevam@gmail.com
Cc:     wsa@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220405164031.2160888-1-steve@sk2.org>
References: <20220405164031.2160888-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: sgtl5000: use simple i2c probe function
Message-Id: <164932430303.3844153.10602976471070924458.b4-ty@kernel.org>
Date:   Thu, 07 Apr 2022 10:38:23 +0100
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

On Tue, 5 Apr 2022 18:40:31 +0200, Stephen Kitt wrote:
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

[1/1] ASoC: sgtl5000: use simple i2c probe function
      commit: 67f51bfecf9e72511419ded0e4148e2b7a7a30b1

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
