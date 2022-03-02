Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC354CAB05
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243623AbiCBRCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243614AbiCBRB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:01:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B0CCB663;
        Wed,  2 Mar 2022 09:01:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CE8561841;
        Wed,  2 Mar 2022 17:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D25DC004E1;
        Wed,  2 Mar 2022 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646240469;
        bh=q5LNEujffjAxTpgSvcYY9SGlgAr2cJ+IUu14tj/BT70=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Rpnfhd11eQc3rCfnlTdXz0CKIA0MYqhqqJ17WHmoNqT3M/iMA82LYTyi4MLKV1sgu
         nqTPz3E3nSmua+JdxQyeHuFho/a/N8jrFcLVMujc6DwBZolGBbP9XSvi2KQLnvYQOS
         gsyTSWJUelZXlthSO1P+CYWSygWVsmKK5IYUO+qtMduORhntEFFu31cXipHgVplM3l
         UsI1+n/KkReEU4TTrVTxloFbr066ewqaypkpRQ34wpuXei2GMtE9ofm49a6NUmlZaA
         FY22HLbvEokV5jhdAW4JidXX+gW4GtbIGu7AJHvfUOMYL9Jhw0aZYCXLAGWutp8Py7
         2kEvG6cVm3zKg==
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel@axis.com,
        devicetree@vger.kernel.org
In-Reply-To: <20220301111831.3742383-1-vincent.whitchurch@axis.com>
References: <20220301111831.3742383-1-vincent.whitchurch@axis.com>
Subject: Re: [PATCH v2 0/3] Devicetree support for regulator-virtual-consumer
Message-Id: <164624046835.1145355.163432630010750075.b4-ty@kernel.org>
Date:   Wed, 02 Mar 2022 17:01:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 12:18:28 +0100, Vincent Whitchurch wrote:
> This series adds devicetree support for drivers/regulator/virtual.c which is
> useful for development and testing of regulator drivers.
> 
> v2:
> - Only use the "default" supply name if dt
> - Add a comment explaining the "default" supply name
> - Add patch which warns against production use of this driver
> - Add patch to use dev_err_probe
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: virtual: use dev_err_probe()
      commit: 75c3543e39f0c94644eac5965b3efe50c2c5c39d
[2/3] regulator: virtual: warn against production use
      commit: d2fb5487ecb2a28b61ff261ae18488afc98d24a6
[3/3] regulator: virtual: add devicetree support
      commit: 80c056656d46ffbece6125dee3f25adbc36d1486

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
