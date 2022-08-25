Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323A35A172C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbiHYQrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243147AbiHYQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69F0BD0BE;
        Thu, 25 Aug 2022 09:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 439BA61A38;
        Thu, 25 Aug 2022 16:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048C8C433D7;
        Thu, 25 Aug 2022 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661445846;
        bh=47b+8dw6Yabl2Ls74sWd4pm1LZbHbtIAm09tbNVNxmw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O6UZyjW3sVjDVZK7V8itYReeDH7gSrYOfM+9IbH5i6GD/ddbisZJgQRmFyh3Awl85
         lBzo5qcMC6zl4iXa8I4HNK2AR8UupQURxxb4Bzw/3+ZlGvptt1qwtVQx1f+kVLszws
         AHezYBN8UxLNLuKipJu/cbQjYBqDW5Dz6jiOpbDBD9F6HgUd4lAu9NmNaDkYjFEuZ1
         NYzTO1t1rfgH98TunMBwLKukTKvbKuakFGuCEmgSZCBavs+1D2zYJeUjD9SgQxygvG
         /dp1/R4UYqC+wVTa0tK0R7s9VA+FvnTMh8e+RTaqJtMfx14lj98mfUa3jeJWEMq4+2
         nXgHjbG+LmsXQ==
From:   Mark Brown <broonie@kernel.org>
To:     shreeya.patel@collabora.com, sanju.mehta@amd.com
Cc:     tanureal@opensource.cirrus.com, alvaro.soliverez@collabora.com,
        krisman@collabora.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-spi@vger.kernel.org
In-Reply-To: <20220825143132.253224-1-shreeya.patel@collabora.com>
References: <20220825143132.253224-1-shreeya.patel@collabora.com>
Subject: Re: [PATCH v3] spi: amd: Configure device speed
Message-Id: <166144584356.547508.3222609511396921392.b4-ty@kernel.org>
Date:   Thu, 25 Aug 2022 17:44:03 +0100
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

On Thu, 25 Aug 2022 20:01:32 +0530, Shreeya Patel wrote:
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

   broonie/spi.git for-next

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
