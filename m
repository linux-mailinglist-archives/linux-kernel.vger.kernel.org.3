Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB694FE750
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358384AbiDLRkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358491AbiDLRk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:40:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E509362A07
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2ADBB81E8C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 17:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BF4C385A1;
        Tue, 12 Apr 2022 17:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649785087;
        bh=NiMcRpwUj8sCHPkk0t+oLj5Va+JzuURQ0/7rLl8Z3wQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=c/87oWqVWd4f2WaJUqxLp7IqTPRgLlo8sE+I0UnsA7+LeP7r+BP1QtWvzi1fsG+C7
         lzhcadRuzZSXJIGlZB7T+y9imJBEembDG1pIzgbPxVyO10aMYgFqOGUVB6p54ShWmP
         WW7QTi3jDQkdiViGUuzG37M7WRGWaU3da1lZG/szq4wcYr4z9cnVXbfv7KxAnGutPO
         KjpAct5cKfUOYDhznMWgCeQpnZNSIxJYp+KiVAfWTdHUd7a5ZzebMLZsyjUwehNyc1
         RKrpBM7UrVdarI07zHubmwZskKeK0v1dXUyvUPsumxqjm/d1WnCyW7bVqswNqG/Nwv
         9OZ4rhDCO6Ylg==
From:   Mark Brown <broonie@kernel.org>
To:     steve@sk2.org, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, wsa@kernel.org
In-Reply-To: <20220405165836.2165310-1-steve@sk2.org>
References: <20220405165836.2165310-1-steve@sk2.org>
Subject: Re: [PATCH 00/14] ASoC: remaining simple i2c probe changes
Message-Id: <164978508613.404572.6173454201391778038.b4-ty@kernel.org>
Date:   Tue, 12 Apr 2022 18:38:06 +0100
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

On Tue, 5 Apr 2022 18:58:22 +0200, Stephen Kitt wrote:
> This series covers all the remaining changes to migrate
> sound/soc/codecs i2c probes to probe_new, where the const struct
> i2c_client * argument is unused; there are a few remaining files which
> use the argument and will need i2c_match_id migration.
> 
> These are all files without a more specific maintainer than Liam and
> Mark as SoC supporters (unlike all my previous patches).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/14] ASoC: ak4*: use simple i2c probe function
        commit: a1111048ec4629ddc273d8821b2299ca23480153
[02/14] ASoC: cx2072x: use simple i2c probe function
        commit: e86e7de1c52afefec61b5cfe254d888117a6d5ab
[03/14] ASoC: es83*: use simple i2c probe function
        commit: a327bdc6c69521bc9ad9ed931a01e505956d4947
[04/14] ASoC: lm4857: use simple i2c probe function
        commit: 182f3ebd5d34437f8bf53fe4d37ccc817b003648
[05/14] ASoC: max9*: use simple i2c probe function
        commit: fead49e33b3df85326cf00eb27a461a8d2ac32a1
[06/14] ASoC: ml26124: use simple i2c probe function
        commit: f7537e3a99fd8f9cd8702bfa52dcfd56d5ac2db7
[07/14] ASoC: nau8*: use simple i2c probe function
        commit: 7325ed4d1250ddb838dc6f96d1f20492a3d52b20
[08/14] ASoC: pcm*: use simple i2c probe function
        commit: 7f7d7214bb5208454aa4ce13780de326402e89c3
[09/14] ASoC: sta*: use simple i2c probe function
        commit: 6f51c15877ae7a2b57bd4ec90eeb146dbac36fa5
[10/14] ASoC: tas*: use simple i2c probe function
        commit: ad11678fd0c39a766318f2dd0385008dd111b5fc
[11/14] ASoC: tda7419: use simple i2c probe function
        commit: 33108917c8a6b597782cff0bd31bea3c7737df3b
[12/14] ASoC: tlv320*: use simple i2c probe function
        commit: 9ba0daa6efa30b1837560a5ce5f41d31093adb42
[13/14] ASoC: ts3a227e: use simple i2c probe function
        commit: 2d4668c6b16fd5b476e84a7fcc54cd38f326e0eb
[14/14] ASoC: uda1380: use simple i2c probe function
        commit: cbd5ce7f428b4caf3f1e3b07cd068cc073eab909

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
