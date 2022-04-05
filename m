Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342C74F45DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389725AbiDEPVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346993AbiDEJpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646C0DCAA9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0EDB616C1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC2CC385A2;
        Tue,  5 Apr 2022 09:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151133;
        bh=Z9FjRlyA0KX5ffVCEjuo3EpyFLIzmAgAwlpgdWulCmE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UWpkqp2myG2riMtTkEm/DY+Z/NNjDiiEcu2Dc9tmyQpzZlmX1qTB3B+cb3QmD+X2e
         nruXUGzOQSp/ATsdEHTaL9DkHKuAjXhGjymMukwqrpH++v1ZEJN5fL2+SpMSDe3j2w
         4EbHAcAJdoBYVQOay8iCBwmBZGHpoDLYOU27l99aeF/RfVGwZe5O+Ng85hyGTK3aru
         zexDJhslyYLuxkI7RLqfb+X5T2DbbUYv6RAGyxuAJkZh2s6doLmLdocqbjiI8loGun
         1QrlCpeI+x4mWjIvceAfOMRxtUyxtQQx9BdKyJo7Ns/lntXCcCpi9yd01fV2N7OI6A
         suozhJm3iysWQ==
From:   Mark Brown <broonie@kernel.org>
To:     axel.lin@ingics.com
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com
In-Reply-To: <20220404022514.449231-1-axel.lin@ingics.com>
References: <20220404022514.449231-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: rtq2134: Fix missing active_discharge_on setting
Message-Id: <164915113203.276837.10187918979668391155.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2022 10:25:14 +0800, Axel Lin wrote:
> The active_discharge_on setting was missed, so output discharge resistor
> is always disabled. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rtq2134: Fix missing active_discharge_on setting
      commit: 17049bf9de55a42ee96fd34520aff8a484677675

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
