Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CFC5A7DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiHaMlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiHaMlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:41:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006349F0FB;
        Wed, 31 Aug 2022 05:41:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A9B661973;
        Wed, 31 Aug 2022 12:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32D4C433D7;
        Wed, 31 Aug 2022 12:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661949668;
        bh=RS0HeyihGdLib8QRN71zjMIyxfq10lHWDurkcNEVTkY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=msNhnat0q+bvq1KF68qIl5Fp9i1oL96k6ra3yZ8pkM35CjIGOmu/+9IKzSr5ZYVJV
         sueRo8f4pVMTbsHHVxhxl9/v1MA1Q3uCPYm1wjcA2CPgmJ+1Z49E5G8RXUSaxPmZIm
         iBjpCYK5U7s/0ddINHxaBIXgEzmn8J/5h8ORkkWgQ3Ac6aLV0Y6LwGKkgV6IrP2+Ap
         TbYZW86Umwt5RB56PfJQdO4kKdqVIwnygdWmlvshji1JHni5lupyryNzvtcERQZ/p9
         2JI2ZdsYteYWjVdu65/UvHnfqr23Q8p73CL4TgUeakGLdMGzShU7pqDgCBDDhwCxBm
         8Z67GxULggczQ==
From:   Mark Brown <broonie@kernel.org>
To:     sanju.mehta@amd.com, Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        krisman@collabora.com, alvaro.soliverez@collabora.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        linux-spi@vger.kernel.org
In-Reply-To: <20220819123630.368462-1-shreeya.patel@collabora.com>
References: <20220819123630.368462-1-shreeya.patel@collabora.com>
Subject: Re: [PATCH v2] spi: amd: Configure device speed
Message-Id: <166194966658.85432.16168252045246459215.b4-ty@kernel.org>
Date:   Wed, 31 Aug 2022 13:41:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 18:06:30 +0530, Shreeya Patel wrote:
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
> 
> Number of clock frequencies are supported by AMD controller
> which are mentioned in the amd_spi_freq structure table.
> 
> Create mechanism to configure device clock frequency such
> that it is strictly less than the requested frequency.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: amd: Configure device speed
      commit: 3fe26121dc3a9bf64e18fe0075cd9a92c9cd1b1a

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
