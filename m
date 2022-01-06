Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465CC486B22
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbiAFU2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:28:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50168 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbiAFU2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:28:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72CFEB823F5;
        Thu,  6 Jan 2022 20:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC97C36AED;
        Thu,  6 Jan 2022 20:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641500914;
        bh=7JPgGGSC3mETrSZWLiqb/rm0G2DWTS3MmMRMZRaLWOg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ubJMff7c+5YhV+mTJNXBnSsbJFzpYbKCYljquIFZG/T53cKbM2Q1lveOlzb1n7Y5G
         qzLBbRKaQ3gYjHt6daCVbwxcrvCUFBT4NrRaOQxJUSKgOV7ZZXjI2AayaYDnpLrx5U
         vCTaVtWqVamhW4h0n592imXbzcmbJ5p3APvqxByN3owSZ9xHeTdGfTZnK//UN4cXA/
         CGPi1dda8xpTU2jJlTc/UgCevVWsqZ12Uf7Vk2Q1neOW7r1A3P6eiHX/aqQ/v2QO42
         BDnVYmI6HmqrhjUeL5eNosbsdjv9yT1fIadFLciFnmKBA58WPACaKwymjNsio0d0AC
         g9aMLzwpX3LXA==
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
In-Reply-To: <20220103071118.27220-1-vkoul@kernel.org>
References: <20220103071118.27220-1-vkoul@kernel.org>
Subject: Re: [PATCH v2 1/2] spi: qcom: geni: set the error code for gpi transfer
Message-Id: <164150091257.2243644.8975625877918588032.b4-ty@kernel.org>
Date:   Thu, 06 Jan 2022 20:28:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022 12:41:17 +0530, Vinod Koul wrote:
> Before we invoke spi_finalize_current_transfer() in
> spi_gsi_callback_result() we should set the spi->cur_msg->status as
> appropriate (0 for success, error otherwise).
> 
> The helps to return error on transfer and not wait till it timesout on
> error
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: qcom: geni: set the error code for gpi transfer
      commit: 74b86d6af81be73bb74995ebeba74417e84b6b6f
[2/2] spi: qcom: geni: handle timeout for gpi mode
      commit: f8039ea55d4ccac2238a247a574f0acb3bc1dc4b

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
