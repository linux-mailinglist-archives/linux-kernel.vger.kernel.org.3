Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B6B4B53D4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355445AbiBNO4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:56:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355426AbiBNO4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:56:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CAE4349F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:56:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 394A3611DF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2634C340EE;
        Mon, 14 Feb 2022 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644850566;
        bh=Uc98g1lVuOYfRfH91a+hIMcAHiRvMPGBJmFnP6gYZvk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=o99LiqlRtV+JLk85PpDPa/oppuT0YXBptTayevujczcAlD2R72B+sZoyKUVedbB+y
         BIFTn1JL3kVY65RF+WvU93f7y6banEqKeVex+LiVYxDA1goI7cqzNhwLh3FiQ/uV/D
         ZWxTZ9SGq6biAj3rOHaT13HpFTnFEzBMDdFMCz2/Fx6KFMPBqS6iserxy1WmjW0RY8
         ofwNMJSKRMbkmqkLmNq5rpqD5sPKWtmDCItS9MX2h5W2C3SgGn8PcXvcMF/EU9hYdQ
         VTjDnGX7Kh43Ox4yHbnoMlYGgbJPxbJaSg8J2idUijWPBUhGe8y7uxNj2Z0Nl6t7LU
         HNkmqVdWb/BIQ==
From:   Mark Brown <broonie@kernel.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, trix@redhat.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220212143144.2648689-1-trix@redhat.com>
References: <20220212143144.2648689-1-trix@redhat.com>
Subject: Re: [PATCH] regmap: irq: cleanup comments
Message-Id: <164485056551.398067.3762061357320438274.b4-ty@kernel.org>
Date:   Mon, 14 Feb 2022 14:56:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Feb 2022 06:31:44 -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Replace the second 'which' with 'the'.
> Change 'acknowleding' to 'acknowledging'.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: irq: cleanup comments
      commit: 2d2329787ba2e70eae330f1cecd61a9576fe65de

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
