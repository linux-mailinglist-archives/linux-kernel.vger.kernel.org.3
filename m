Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AD251C38E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381129AbiEEPPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380513AbiEEPPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:15:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D897012757
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 08:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 897ECB82DB5
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8E2C385A8;
        Thu,  5 May 2022 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651763527;
        bh=6qY/H7PnXRQuP5EX1Md1pWAhX259HlPJLeGM/4Ewz2k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=f3QG3rn/OIT/SgJu7aYWSfIAcUO43kIWsvpoIv1hAmJ81r7dzCoySPUXCH4xdy7Jn
         oAYGJYtyxdiZs7nmzSD6aJ8nO9opWGvRnY0wBUsj7JmyaBXqIv6rvJjeuxpkOBJLZD
         SqZRRRpHVXMsQnUptxYbaNRs740tFHIaCoLPwGS/+YM20cYSZ++/F6c5tf2S7mIVx/
         1vhpRxDcdU+FqxvLPJBgytlzpjEEM3MfpeIVZXDUrk6RROMoqQ6AeBDSAEnKkGhXLM
         KbACW6fxnEiUBWjpQ50kL+EviV/sGAm7jgs5Y2V7/0xjDGo9XL1kp5hZk1la1AQYhP
         py3i9oCqaFLjQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, andriy.shevchenko@linux.intel.com
Cc:     lgirdwood@gmail.com, tanureal@opensource.cirrus.com,
        tiwai@suse.com, james.schulman@cirrus.com,
        rf@opensource.cirrus.com, perex@perex.cz, david.rhodes@cirrus.com
In-Reply-To: <20220502120455.84386-1-andriy.shevchenko@linux.intel.com>
References: <20220502120455.84386-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: cs43130: Re-use generic struct u16_fract
Message-Id: <165176352438.543130.16785839452900264536.b4-ty@kernel.org>
Date:   Thu, 05 May 2022 16:12:04 +0100
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

On Mon, 2 May 2022 15:04:55 +0300, Andy Shevchenko wrote:
> Instead of custom data type re-use generic struct u16_fract.
> No changes intended.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs43130: Re-use generic struct u16_fract
      commit: e14bd35ef44606c7d55ccb3660cededd421a14a1

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
