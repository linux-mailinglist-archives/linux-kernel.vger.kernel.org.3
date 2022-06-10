Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B643546C3E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349634AbiFJSVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349696AbiFJSVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:21:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955752050C7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:21:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A9E1B836F3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D5EC34114;
        Fri, 10 Jun 2022 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654885288;
        bh=+jL/FC6xNNAbT8Uw3SBjykGPd+t4UmekGOKQaiNQUyU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=HXdAhEg5WMuAU4u6m0swWeIb51mKl1BNq1Cn78ib1UmBgP7ti1+jCoF2n6gLD4b+O
         9OSAQVVvNb9j9tn0fnBn2MMyUvdJ0A8Yu6KUvTAGSXu/HeKT9TxhN9sStA9XXN6CEb
         SXsqSi7XTTrYiQsSr1+7O4j2dMaEolosG7xfEOlhljblbuEQ1wEQVemmN+U7xMqN4d
         mHO3LswenshdpTw1P/rBy7fA04jQl4tllJjx2+b2LcLAeb/F1W5HtDHyk2OvCs1OL4
         jSQ6y7RAAIMO3nXZVPNdN7v7NY2CZvGzZn7us4x7dsPbyL2eSjeDcPC1/T0H/FN0UN
         bnfCbfOvYjiiw==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org
Cc:     quic_srivasam@quicinc.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com, lgirdwood@gmail.com
In-Reply-To: <20220610144818.511797-1-srinivas.kandagatla@linaro.org>
References: <20220610144818.511797-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qdsp6: q6apm-dai: unprepare stream if its already prepared
Message-Id: <165488528620.2064162.10605272639883600182.b4-ty@kernel.org>
Date:   Fri, 10 Jun 2022 19:21:26 +0100
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

On Fri, 10 Jun 2022 15:48:18 +0100, Srinivas Kandagatla wrote:
> prepare callback can be called multiple times, so unprepare the stream
> if its already prepared.
> 
> Without this DSP is not happy to setting the params on a already
> prepared graph.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qdsp6: q6apm-dai: unprepare stream if its already prepared
      commit: 6548c884a595391fab172faeae39e2b329b848f3

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
