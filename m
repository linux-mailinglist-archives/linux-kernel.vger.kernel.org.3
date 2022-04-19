Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25107507CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358334AbiDSWsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348030AbiDSWsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:48:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBDE1CFE9;
        Tue, 19 Apr 2022 15:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17941B81CA5;
        Tue, 19 Apr 2022 22:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF78BC385A8;
        Tue, 19 Apr 2022 22:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650408348;
        bh=u69tYpHiAO1T14mzItzq1PV3SIJNfovbMUKmvNnUygA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b5Ah13kbR9kv8OlkKQ4QXtj3Xw1AgbsPxI+F3xXGWSAgpMp61O8TKOduebNlUR0zt
         wVB1RNs/P28ofCAUvY9eL8nvvFdI5b4cyMQlOX21xkl8seeGWpzSgPAZFP8D6rygRm
         eplAIPeQTOwPZAftvUiHRzGhdNDiPsfR7AjWNvvB+HKKZJkntE9p5uHOHWcb1WQZme
         e0CzjbT2dY2GH6Frh1Reiijmmn+emqRKad+v4v8c/Lgsmx61WChbNMKniPJpN2kd6a
         8XtQLgeqxgPa/74ScbVdfjQk58c+Av/cbB0JLDovbLZStRl5UqMpHN6aZ2uLoeTQgu
         Mh056axtM1vCQ==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     zealci@zte.com.cn, chi.minghao@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20220414085637.2541805-1-chi.minghao@zte.com.cn>
References: <20220414085637.2541805-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165040834757.1910395.4140546749023589299.b4-ty@kernel.org>
Date:   Tue, 19 Apr 2022 23:45:47 +0100
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

On Thu, 14 Apr 2022 08:56:37 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. This change is just to simplify the code, no
> actual functional changes.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 3a2ac5809935e6043dae916bab6cf4741d9dcdeb

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
