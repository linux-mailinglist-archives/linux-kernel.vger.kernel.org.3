Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786964DB974
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357943AbiCPUhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349967AbiCPUg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F379465817
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:35:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ACD76134A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 20:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E6CC340EC;
        Wed, 16 Mar 2022 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647462943;
        bh=ftssrwglpKKVQfdsgq1xKuGibUN8q6X5uF9Eg6Rr1qs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UIV6sxB3RgWdIC/J02qcht7N50hr0GeSgxzIKXEuhX1tCV7N1fyrLlxlpS44GotSO
         Y55kydz5IQhtbPA/aD9ZAVgN6j9f6dYbgfo5HDjIziySBAL9Q6ZEDBMvZkZgXmaKmk
         rz2inRtSs1df4rM8BhIxypEfsae7/JPM4TLVOMbGcbf7ZURNZkKOJFCqUvU7hHvQMl
         sWZ31qrMHFAOeknf8t7I42AKpKNT1HBE4ZqHqaHPIzfl03MC4z6NTJly7uAVP6LBGi
         rJp9Y9wJ8tmaApGUiv295RmE+1P2Qbadyb/E2JdHdw00c78F3Y4O/s892ljDA9OKuE
         EiEfn+40w8Arw==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     Zeal Robot <zealci@zte.com.cn>, alsa-devel@alsa-project.org,
        Minghao Chi <chi.minghao@zte.com.cn>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220315023226.2118354-1-chi.minghao@zte.com.cn>
References: <20220315023226.2118354-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] ASoC: ak4642: Use of_device_get_match_data()
Message-Id: <164746294144.1220201.15254830524209110436.b4-ty@kernel.org>
Date:   Wed, 16 Mar 2022 20:35:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2022 02:32:26 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Use of_device_get_match_data() to simplify the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak4642: Use of_device_get_match_data()
      commit: 835ca59799f5c60b4b54bdc7aa785c99552f63e4

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
