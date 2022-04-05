Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA474F44CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384335AbiDEPOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346652AbiDEJpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1C3DAFF1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F8F0B81CB9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D97C385A0;
        Tue,  5 Apr 2022 09:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151071;
        bh=6MwsuXDRjEq94GOgLMbEvcC+juAuLqlZNLDbjEN5PaA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RWsdilXUL4D6CQUAY2ovCLLU77VJ/YRXtyI9C7ydSH4Q2uQych47dCUTcGFCmCnhS
         WFWeADaoppamZr8C9YR6NSwb7UDd4qtdWGVV/Fz3d0inN7WNtLWHesHucOMMiD7gnR
         cr++Hwki9rM2P1xDENAIMMEkFDf6KkVcSKCjhO/tIsBVDV7mxhQzj2vlIqKcmb2PrK
         RPFlLlt47zb/jgNWuse1VYLRVdA9iOjtY5Y2pJpVy2d2lFqo2NRPCeBQD2EJWiXzgW
         tf3HnPqB7ffFHtJQVMxBZmpX+A+9ADd0HbUFZa21JhuqOHB8IXl3H2QESPHNRKXAM6
         VrfNOfn0BQjLA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, steve@sk2.org,
        support.opensource@diasemi.com
Cc:     patches@opensource.cirrus.com, wsa@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220325171904.1223539-1-steve@sk2.org>
References: <20220325171904.1223539-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: da7218: use i2c_match_id and simple i2c probe
Message-Id: <164915106951.276574.12214473275004613648.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:31:09 +0100
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

On Fri, 25 Mar 2022 18:19:04 +0100, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
> 
> This patch follows the model set by da7218_of_get_id().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7218: use i2c_match_id and simple i2c probe
      commit: 5e9058ea2bc6e73aeb54b585af38d043490a8509

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
