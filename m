Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A7F50E71D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbiDYR2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244031AbiDYR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CD640E74;
        Mon, 25 Apr 2022 10:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8DEA614C1;
        Mon, 25 Apr 2022 17:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FFAC385A4;
        Mon, 25 Apr 2022 17:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907480;
        bh=sNyDRtC/7/edG4192DhXS564IG/X3PivmYbS6UpIYEQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EUy5Nv080XeCEJFw4WsNs4RwqIWWvY5luB24XrYXKLfbkesQhPpGaXggEthklP5Ox
         sLs2Iyb/WFjnKEzwI2b1tMsaKMfGvtHAjVwWX3YLgNE01IPyoel5moxNfj/jglYLCj
         CbpYc0ocuyt0Ltl8DlKRvrnRZuCPK/ReBas3jn977nOyHlLd4PklRZjriVrxG6Fc6C
         3bUIKhsKSw8RFkAkWl8RciWhfU7bMA0STMLIr/hqOkLKj1SDLSsMEG27Poq9YIaddU
         gsCvDzZb3LiYAyWs/+C8p7NrXJ9WSVX6r32+8pa8oBeFRGnnu3M5s/MGranwOIMc68
         IVyJ71XasD0Qw==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com, ldewangan@nvidia.com
Cc:     linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, chi.minghao@zte.com.cn,
        zealci@zte.com.cn
In-Reply-To: <20220418110103.2558955-1-chi.minghao@zte.com.cn>
References: <20220418110103.2558955-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: spi-tegra20-sflash: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165090747866.584172.3375277625417533425.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:38 +0100
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

On Mon, 18 Apr 2022 11:01:03 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-tegra20-sflash: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 2b8070840e6f48b5406ebe1630a0335843109799

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
