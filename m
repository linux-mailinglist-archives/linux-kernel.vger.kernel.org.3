Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669D0549D64
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348948AbiFMTUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351403AbiFMTTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF0453B69;
        Mon, 13 Jun 2022 10:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E383B60C7C;
        Mon, 13 Jun 2022 17:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B252C385A9;
        Mon, 13 Jun 2022 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655141077;
        bh=6G5KLJNw2S9txJZg1qcDhOoMAsqsWM/W9qB/nY+Juqw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=MhVdrVipfMKpXttaDbveFOybPe41Kse2OTIwJ9+M2e2qv8gLNIJo+/wOdGGyU1qGo
         m+5MAjhVOYQ1QjLT+h/Sq57rl+8Wh4+lHkbFpiNpi2jBCunrjWZPNX8QCh1Lo4dYgX
         atzgkLR5so6LJDRerU8Rs9e+4rZElA+lo1cK50/uP5rbtuICyeL0M1NGSIObq9tSfh
         hxzuFA47nGCGRnrnEIRs5dbCLR+bETf7QnmFK6XnMssoaMVldmuR5YRSUDdnxJVobl
         +qKVoJzt0pcdhTGtFt2W1IlxCCTg1ql8aRMK0bhWZSXHBNmKdfIlNgxCGes3xP1cW3
         iy1kGhhBQJRvQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, linux-samsung-soc@vger.kernel.org,
        alim.akhtar@samsung.com, Colin Ian King <colin.king@intel.com>,
        andi@etezian.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220612203428.2754823-1-colin.i.king@gmail.com>
References: <20220612203428.2754823-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] spi: s3c64xx: set pointers to null using NULL rather than 0
Message-Id: <165514107536.671611.6251857721264911131.b4-ty@kernel.org>
Date:   Mon, 13 Jun 2022 18:24:35 +0100
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

On Sun, 12 Jun 2022 21:34:28 +0100, Colin Ian King wrote:
> There are pointers being set to null using use. Use NULL instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: set pointers to null using NULL rather than 0
      commit: 845d3fd8a0aadf5dd97e6d345d3df4bf80099e69

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
