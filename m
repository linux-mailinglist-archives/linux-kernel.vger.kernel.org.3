Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082B747F010
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353219AbhLXQRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353244AbhLXQRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:17:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C83C06175C;
        Fri, 24 Dec 2021 08:17:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6ACDB82331;
        Fri, 24 Dec 2021 16:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA71C36AE8;
        Fri, 24 Dec 2021 16:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640362664;
        bh=IYe5mJ3hvrvjoRF3BknS8fKbhq3NF3XKuVnlR7l+1uw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Jsb25bg4kpb1Llk8DRVYMlimGw5RRtIbvX/wb+bCE6Vy+4MAM9m2Abi1ZAwK9/Bz9
         FKIHbNcAqzE3SHXEtw7zrwHjj1QbrE/yKt4Z40g+wEMWHGoTg9/3X5zd1m9CAcuuAi
         Hloo8f1HrJzqJMi7Cf6fYj2JZpIrq2Tju/QS6rFSuHKAbM3A9I1PtamHZZLK1GnfC7
         tAjmG3gQ2Ez+88KGoZu3FIpCVPvl9CbQ7qx3b9JjYi9ccHNi6puqFNMtHTGl0QMD2u
         mf0xvnn9zol+tDFMplMBe1095vagfejbD3f3PmN2g+aks7x8+SynupYsI4JiEYg696
         NgEdELiG+Qubw==
From:   Mark Brown <broonie@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     Pavel Dubrova <pashadubrova@gmail.com>,
        linux-kernel@vger.kernel.org,
        Martin Botka <martin.botka@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20211224113450.107958-1-marijn.suijten@somainline.org>
References: <20211224113450.107958-1-marijn.suijten@somainline.org>
Subject: Re: [PATCH] regulator: qcom-labibb: OCP interrupts are not a failure while disabled
Message-Id: <164036266175.3720266.13529108336109588098.b4-ty@kernel.org>
Date:   Fri, 24 Dec 2021 16:17:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2021 12:34:50 +0100, Marijn Suijten wrote:
> Receiving the Over-Current Protection interrupt while the regulator is
> disabled does not count as unhandled/failure (IRQ_NONE, or 0 as it were)
> but a "fake event", usually due to inrush as the is regulator about to
> be enabled.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom-labibb: OCP interrupts are not a failure while disabled
      commit: d27bb69dc83f00f86a830298c967052cded6e784

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
