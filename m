Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C9A4D0892
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245317AbiCGUku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245368AbiCGUke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:40:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B73E7CDEA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:39:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8A8FB8170A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 20:39:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052D9C340E9;
        Mon,  7 Mar 2022 20:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646685574;
        bh=g2m2wVkjCPJzMz6bubs3Rutz89zigBWuWRzbVnPrdBg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lJ07MYEPtWwqVdTufBosjQJbJ7a6QE2+ZqletNyQ5FW477ZS1rcDGXWpO3q5xYZAc
         uqQRy5puabZ39yCmIJpyxcK9ShYfazyr4Dj5/iHxHRWO5MGVHpeWhzs65YMCeliFb5
         CBiH7EC+zwsLbhplWpH8LA/u2aE++ZFBivu42Wba+q1lQHPUZEkR2C253e1e8oVo6g
         2BMFXkRaQ7dFUCTXmvZoGjPs0P+533hi76mIzYDWOKedUSBZ/XEZxdOLK8Cc5LBdk5
         9eagQhumm+5mw/mm6RA8ld/44LLF1QN0D6vNaKX4g1F+9qgNgkJT000kFkz1FSXDSG
         uiEQWmsnki3fA==
From:   Mark Brown <broonie@kernel.org>
To:     zhang.lyra@gmail.com, orsonzhai@gmail.com, lgirdwood@gmail.com,
        trix@redhat.com, baolin.wang7@gmail.com
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20220305162438.689442-1-trix@redhat.com>
References: <20220305162438.689442-1-trix@redhat.com>
Subject: Re: [PATCH] regulator: cleanup comments
Message-Id: <164668557274.3137513.14672957811652545659.b4-ty@kernel.org>
Date:   Mon, 07 Mar 2022 20:39:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Mar 2022 08:24:38 -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> For spdx
> Remove leading space, add space after //
> 
> Replacements
> overriden to overridden
> Calulate to Calculate
> addional to additional
> regulatior to regulator
> devive to device
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: cleanup comments
      commit: bbc7ba0fa06ab4aee26969a9454ca32e4a8fcb1c

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
