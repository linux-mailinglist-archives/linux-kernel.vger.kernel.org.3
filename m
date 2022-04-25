Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEDB50E72C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243983AbiDYR2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244059AbiDYR1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:27:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9547440E7A;
        Mon, 25 Apr 2022 10:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52830B81923;
        Mon, 25 Apr 2022 17:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE2BC385A7;
        Mon, 25 Apr 2022 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650907484;
        bh=ndYHCz+cvbr+ZO1xQz4NVo08bvZQCrP58iyiU3dQNU0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FBY6QKIp8AVOtmwp1AWjfUeI5y5U9sOeXg/s4kQ+JS02Fl0IpREH6J3WdluAihouG
         Y6wuQTCG159/mA8UWUEn3/mlEP92YxspNyKLj/WAiDxO7KvchzVZbhnk4eQcv6C2om
         NphLng4hjdxxr539jvxVdjgEl1m46cSYvb4EjB1qiXJxMkqxvqYoI5bSnNNbhs7uCV
         TI8cFKj4vFo2PsoYHeBkL8Iuuozw+q9nRGVML5hVS7Nk6EQiubKr7OWAv2yN8WHtKJ
         J+DG6YAt3cVxiuVYiaYqBjTXt1/8cP9L/96lxLR+D/h7IVNQnDYLREhM1z2fS8hS0c
         VvYXlKsDhIbBQ==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, chi.minghao@zte.com.cn,
        shawnguo@kernel.org, zealci@zte.com.cn
In-Reply-To: <20220414085343.2541608-1-chi.minghao@zte.com.cn>
References: <20220414085343.2541608-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: spi-imx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165090748242.584172.3191487859916815458.b4-ty@kernel.org>
Date:   Mon, 25 Apr 2022 18:24:42 +0100
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

On Thu, 14 Apr 2022 08:53:42 +0000, cgel.zte@gmail.com wrote:
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

[1/1] spi: spi-imx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 7d34ff58f35c82207698f43af79817a05e1342e5

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
