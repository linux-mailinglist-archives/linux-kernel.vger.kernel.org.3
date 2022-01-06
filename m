Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591C7486B1C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243795AbiAFU2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbiAFU2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:28:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95552C061212;
        Thu,  6 Jan 2022 12:28:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C2F5B823F5;
        Thu,  6 Jan 2022 20:28:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33F2C36AE3;
        Thu,  6 Jan 2022 20:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641500908;
        bh=4Tm8lIJbayYVxgJwvNC72NWqqUSjJNNTYUqBQif91Jk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uPjadOGMkQKU6rfYSjF1dH2cjguOooXzLJrvK7sc0x9/9zwRcJ53FL+C6li8vxs3d
         gzZCjKgfhZG4h/YnwxBht2MlXYrIpAdNznxxPUMcYyEHPsIxo+kPpUEDS8Cdp6WEW0
         91w/TSCViT/fgI0SdG/lniVKT5dKQ5TUw8NlIJpQqUYVzRtSyGGCzN9O8PZJWK7FwF
         EGqs1+mn2soFfUhwNhsRBRugACCQ2Hs7IKGez/V1xAA6Yox1jwsPkRMxbni6dgxHqS
         p/TkRKcfPHXbRbD5KvNu0IvQnjj+3aU27CIrOn7lTcOPNhnn3+2w/BgKpsHrceHGBc
         k3+FhpwuJhSqg==
From:   Mark Brown <broonie@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     jamipkettunen@somainline.org, Liam Girdwood <lgirdwood@gmail.com>,
        martin.botka@somainline.org, Andy Gross <agross@kernel.org>,
        angelogioacchino.delregno@somainline.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20211230023442.1123424-1-konrad.dybcio@somainline.org>
References: <20211230023442.1123424-1-konrad.dybcio@somainline.org>
Subject: Re: [RFC PATCH] regulator: qcom_smd: Align probe function with rpmh-regulator
Message-Id: <164150090571.2243609.1684347122306028222.b4-ty@kernel.org>
Date:   Thu, 06 Jan 2022 20:28:25 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 03:34:42 +0100, Konrad Dybcio wrote:
> The RPMh regulator driver is much newer and gets more attention, which in
> consequence makes it do a few things better. Update qcom_smd-regulator's
> probe function to mimic what rpmh-regulator does to address a couple of
> issues:
> 
> - Probe defer now works correctly, before it used to, well,
>   kinda just die.. This fixes reliable probing on (at least) PM8994,
>   because Linux apparently cannot deal with supply map dependencies yet..
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom_smd: Align probe function with rpmh-regulator
      commit: 14e2976fbabdacb01335d7f91eeebbc89c67ddb1

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
