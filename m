Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F77C4F41BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388437AbiDEPUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346955AbiDEJpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF5CDBD37
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76788B81CBE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4C5C385A2;
        Tue,  5 Apr 2022 09:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151128;
        bh=C5+ZhnmgvPcUlTaO5vUVt+eMJ/8dgp+chszAlxRRhQw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=a816CQqQWSlIOGDg5RzBeTqTBrdmIlfwEIPnLW3ltLQDhAbZjJnT2yDAUoz2reV3s
         YjNtmQGvl3+I3mh+Q6F67GZNu9Ybww0iljQKvxaXmTDAKd8FUrIKXTyvLW+l1qdOlp
         FSwMH7oTxTFrtwujcHqGgdLRJp7mOKOSMJszralyE6XGyBXI5lhXTbKq7CrusuhHD9
         /RcVH+DkOMfUxuugMSnJni3LxB9La2Fea/9ZQa9PMZ8bJpCMTIA1HjcDGX/5YIbIGq
         U+rj7FMsJVsESLhyy9pZCW76Fri1TT7yww1Twt8LdQkRW11SF+uZlQz4gF2aCXJUiu
         //jMO22X7vS7A==
From:   Mark Brown <broonie@kernel.org>
To:     xc-racer2@live.ca, lgirdwood@gmail.com
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <CY4PR04MB056771CFB80DC447C30D5A31CB1D9@CY4PR04MB0567.namprd04.prod.outlook.com>
References: <YkDpozx+ZmSWwwH0@sirena.org.uk> <CY4PR04MB056771CFB80DC447C30D5A31CB1D9@CY4PR04MB0567.namprd04.prod.outlook.com>
Subject: Re: [PATCH v2] regulator: wm8994: Add an off-on delay for WM8994 variant
Message-Id: <164915112704.276837.5262967047212269778.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:07 +0100
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

On Sun, 27 Mar 2022 18:01:54 -0700, Jonathan Bakker wrote:
> As per Table 130 of the wm8994 datasheet at [1], there is an off-on
> delay for LDO1 and LDO2.  In the wm8958 datasheet [2], I could not
> find any reference to it.  I could not find a wm1811 datasheet to
> double-check there, but as no one has complained presumably it works
> without it.
> 
> This solves the issue on Samsung Aries boards with a wm8994 where
> register writes fail when the device is powered off and back-on
> quickly.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: wm8994: Add an off-on delay for WM8994 variant
      commit: 92d96b603738ec4f35cde7198c303ae264dd47cb

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
