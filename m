Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BB349B1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356775AbiAYKb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:31:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46696 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344733AbiAYKU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:20:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B51DCB81626;
        Tue, 25 Jan 2022 10:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BCEC340E0;
        Tue, 25 Jan 2022 10:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106055;
        bh=YtEK2QrVTxCqt+3W3/QgzHCRCsuXuZsJpRPOEOnHStw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fiPNRpxhcMz0B+IFRWYT71b7YDCC6lSMubr7ALYbrQvQO66ScO64Xu6xAUp7JXCjQ
         u6b2jJl/7EuTLTZ8G9lRFiC04ufO8Vg5yPEbTm5osm5pbvfphTWjA6DGZiGIzTr7/O
         fuaScrl0W13ZljXXFGxIB1I9tFWuspfhyv8Kuks5UkSagbbj8h1l7NYLRiLX6iBhmi
         Zw+4439Me2PmfC/GeedNkVyzyhiJQhZ7W4bJBCxn4N34Z9MnCuF6loLQEziWe72rsB
         mS6VcYO1QbI5BrxJwkUNf1bookc9ceOeW7WKE7gfKfnGStKv7W4xPKNP6f0xs6U4rG
         1yI+ZB8OglHmA==
From:   Mark Brown <broonie@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>
In-Reply-To: <alpine.DEB.2.22.394.2201151210170.3051@hadrien>
References: <alpine.DEB.2.22.394.2201151210170.3051@hadrien>
Subject: Re: [PATCH] regulator: qcom_smd: fix for_each_child.cocci warnings
Message-Id: <164310605364.75017.9038445361122316011.b4-ty@kernel.org>
Date:   Tue, 25 Jan 2022 10:20:53 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jan 2022 12:11:38 +0100 (CET), Julia Lawall wrote:
> From: kernel test robot <lkp@intel.com>
> 
> drivers/regulator/qcom_smd-regulator.c:1318:1-33: WARNING: Function "for_each_available_child_of_node" should have of_node_put() before return around line 1321.
> 
> 
> Semantic patch information:
>  False positives can be due to function calls within the for_each
>  loop that may encapsulate an of_node_put.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom_smd: fix for_each_child.cocci warnings
      commit: 6390d42c21efff0b4c10956a38e341f4e84ecd3d

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
