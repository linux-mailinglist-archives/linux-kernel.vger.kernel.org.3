Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9F24F422D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386064AbiDEPPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346677AbiDEJpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D42667
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:31:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 918D3B81CB9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:31:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DE6C385A4;
        Tue,  5 Apr 2022 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151076;
        bh=zDCsNEl7H8PnL5ktVJwI/nIGobxdS2BjeTEsoBPQaTY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S5vv0P6I2xumlWh4uRNq8gk2FgAcSFgHdERriqIEzNilotIGO8FC+QkLYWwJiLvBb
         qeHv8lOsdC5YeaWaG7KzRIKEahb4ozTWYJd1HmOX9ref8RTg0h5ybmwCBZ2gXH5L3s
         0Yyn0HMB9dkuGxRWvthOqtcoSdhrHpfGdX9JiraZ4vbtTAYjjkB+6MptY4gDcuipiu
         bhrGVVPsDzkyT2xEnsMRQ8khG7EO+EjdWU0kWFf43U1K5WBg/bRkmzz3EK1qjqn2Eo
         mK7M/jzD+wm2hfmqv65Im4VWfagUXQL2ISVPYfhZ9AuyKe+NiLdel0wYaIUH0u2j3O
         xC9urHAP8y8VQ==
From:   Mark Brown <broonie@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>, steve@sk2.org,
        nuno.sa@analog.com
Cc:     wsa@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220325165452.1212975-1-steve@sk2.org>
References: <20220325165452.1212975-1-steve@sk2.org>
Subject: Re: [PATCH] ASoC: ad1*, ada*, ssm*: use i2c_match_id and simple i2c probe
Message-Id: <164915107488.276574.6454737043438632692.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:31:14 +0100
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

On Fri, 25 Mar 2022 17:54:52 +0100, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ad1*, ada*, ssm*: use i2c_match_id and simple i2c probe
      commit: e5cd0623d7879eb98059223b9eb233a686d58b40

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
