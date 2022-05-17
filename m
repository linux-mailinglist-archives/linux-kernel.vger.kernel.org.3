Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466DE52A785
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350785AbiEQQAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350754AbiEQP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:59:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B7C49F8C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4359F61230
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5F2C385B8;
        Tue, 17 May 2022 15:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652803183;
        bh=Lh31lDQ82GzGRhFEOHQmYWow+mG7mQ5baG2aGEBaOtg=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=rey//DwJXh1YaTQtxNDTgW72IPdtlWn99lWZE9ZnXz1Y3u3lpxnNgBKkGeet8dIq4
         VnRovwAW8DAetcG9tuYoFmTKY/JXfBBNmRn0ZVgCSp/MUWADiCujs2y4VkzKfyE1tV
         vejtGu+ZEETXXuyabtJmc06cd8p6i9PZiXD0XYoUkBrI0Ufy6/ljBCFLuoh3QMPVIB
         XqT4m5rVkWUobjnNluHZ1MoMr3F51+mZpsKDsA6DlrP8SDKZCra92NP5IIlKi1KsAU
         U4+K1OMCKUxUzy3NTIsh0698jqeBqtiXA3K03JVucvPGykunbGSuewaecbBtY8Itd2
         aTUeb58/VKZcA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, linmq006@gmail.com, cristian.marussi@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com
In-Reply-To: <20220516074433.32433-1-linmq006@gmail.com>
References: <20220516074433.32433-1-linmq006@gmail.com>
Subject: Re: [PATCH] regulator: scmi: Fix refcount leak in scmi_regulator_probe
Message-Id: <165280318216.1640749.6900818798567070249.b4-ty@kernel.org>
Date:   Tue, 17 May 2022 16:59:42 +0100
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

On Mon, 16 May 2022 11:44:33 +0400, Miaoqian Lin wrote:
> of_find_node_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: scmi: Fix refcount leak in scmi_regulator_probe
      commit: 68d6c8476fd4f448e70e0ab31ff972838ac41dae

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
