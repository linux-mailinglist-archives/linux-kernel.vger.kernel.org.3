Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890054D0884
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245320AbiCGUkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245312AbiCGUkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:40:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E170069
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:39:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13A7BB81714
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 20:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5B7C340EF;
        Mon,  7 Mar 2022 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646685550;
        bh=y3xTSCOAcDKIY8/TSo/4DU7Lm7NXIZjNrsfIiWP4fcQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uNAzrzlaVuyW8l2r13Ja+vlzcJJsmeJf/xihcqojGkyG+IUB+eV7tsB5MXlVIyGK1
         ZfXZLiiCjZucWolj7Hz/ZPXnrlLNGN5TU62kX0KnMZZjmt9rwa1IgOzti7Sv8y5bF2
         e7yxT0M1CdLCb8zeu+FifurlaXkomVsWv7YaDK/lmm/nz3Yk2SNCgfagV/yIExoPvn
         FgwkFfvBTjo2FNf5faaR5R5xrgtiFZrimq3zywDZSQiHUEZEzmCj/l3wXN8v9KHkRi
         /c4nH99RslKJOvrbqasVsiO5+mxdRIljkhNqmCKA8NsH2AqDlz0JMeBdcAD8L/fiAx
         3pZ5PpxbpQRrA==
From:   Mark Brown <broonie@kernel.org>
To:     Simon Trimmer <simont@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20220303155016.122125-1-simont@opensource.cirrus.com>
References: <20220303155016.122125-1-simont@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Expand firmware loading search options
Message-Id: <164668554896.3137316.16631599995013598455.b4-ty@kernel.org>
Date:   Mon, 07 Mar 2022 20:39:08 +0000
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

On Thu, 3 Mar 2022 15:50:16 +0000, Simon Trimmer wrote:
> The parts supported by this driver can have product-specific
> firmware and tunings files. Typically these have been used on
> embedded systems where the manufacturer is responsible for
> installing the correct product-specific firmware files into
> /lib/firmware. However, the linux-firmware repository places all
> available firmwares into /lib/firmware and it is up to the driver to
> select the correct product-specific firmware from that directory.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Expand firmware loading search options
      commit: b6b62d942bbc4d926bcf3799ea3bcaeb105fd04f

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
