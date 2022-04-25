Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7E50E740
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243976AbiDYR3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243924AbiDYR16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4904130C;
        Mon, 25 Apr 2022 10:24:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60EA7B8191A;
        Mon, 25 Apr 2022 17:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E85AC385AC;
        Mon, 25 Apr 2022 17:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907491;
        bh=6XynIAUlKU+eIGdXdXHnMxNzWfnJXAp5GLggB05OTNI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tJvKNcYpc2VeO1yqs/QUZ6q3AoGTTb4kXSVUMT5rqCCKZIdvEzdlt2iVTOz0kVThG
         UBjz40RVxYTuclx2/V4ObQiVOX7W8w31gYmN7piMU0bhbJ4SKhmE3MCniKuxK04WiF
         i3uHJ7owWC+Ko7yjMedRHFnELWeQYUPHmHThBmwGf/WigV+hyNvt/HbLOwLazH0NGN
         R5el3RbcDhArM8DJF8B2I8iWyoLWZbW+QygJ2VpXJS3Da6Va9nDRLv7cBmMc73zqAE
         FuKTcAdoEnr8BmTAhLHkPhpWFcQIBtUfnm9jwuCil8JqtZgIo4qeZWvGWSVUaV+eAb
         hjCrOrjo4pjGA==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com, alain.volmat@foss.st.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, chi.minghao@zte.com.cn,
        zealci@zte.com.cn, linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20220420090452.2588930-1-chi.minghao@zte.com.cn>
References: <20220420090452.2588930-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: stm32: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165090748917.584172.18257693792767365784.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 09:04:52 +0000, cgel.zte@gmail.com wrote:
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

[1/1] spi: stm32: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 1af2fb6283fb82755a6fe819f863e4c3d9772e69

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
