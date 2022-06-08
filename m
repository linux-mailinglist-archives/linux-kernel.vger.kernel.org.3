Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48EC542E50
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237534AbiFHKtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbiFHKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:49:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2691D64CB;
        Wed,  8 Jun 2022 03:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C288B826A6;
        Wed,  8 Jun 2022 10:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C784C34116;
        Wed,  8 Jun 2022 10:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654685357;
        bh=yHR+xAhDwC6CybgYw5sI5rdec09GKeyjJpCfve9lxZI=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=HNyBRqxAbIA2Xe+B+ZUrP2g00CVkQNnWgjoFOlw2/Q+Ry11jLGXjBwteSAuDGhWTd
         +e1N202ARPX5ByjLNzE32F+10aHfTrUgOvr+hcisnK+igWIR4XbKPjMucMjXzZjk31
         uQZ+bconFy1z3drR0HDepzx8u2YgMkNfHzgdrz76lXoWDp3v/t2idT1UewIJTVM9LI
         2sBtPRk5Js6G/kPMjuHcvMd7YRLWI9UubWvYFM1nyMqNhmmu0qwvDTiP5x2DUkbQ3X
         OKN/1jfoZW0NWOC0IDYCjETWtjKSjLolZ+IG//4zIWYLcv/eVjz+dwT5ZcTz3Bjn8p
         dfibvT3R3M5Aw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, lgirdwood@gmail.com,
        robimarko@gmail.com, bjorn.andersson@linaro.org
In-Reply-To: <20220604193300.125758-1-robimarko@gmail.com>
References: <20220604193300.125758-1-robimarko@gmail.com>
Subject: Re: [PATCH 1/2] regulator: qcom_smd: add get_voltage to MP5496
Message-Id: <165468535629.140909.8757110927718700970.b4-ty@kernel.org>
Date:   Wed, 08 Jun 2022 11:49:16 +0100
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

On Sat, 4 Jun 2022 21:32:59 +0200, Robert Marko wrote:
> Add the get_voltage OP to MP5496 ops using the generic rpm_reg_get_voltage.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: qcom_smd: add get_voltage to MP5496
      commit: f210f387c8c05ae0bd5312b8b6b85398c20b94f9
[2/2] regulator: qcom_smd: correct MP5496 ranges
      commit: 122e951eb8045338089b086c8bd9b0b9afb04a92

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
