Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49B94621E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbhK2UOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbhK2UMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:12:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A3EC08ECB6;
        Mon, 29 Nov 2021 08:45:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69982B81215;
        Mon, 29 Nov 2021 16:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337B6C53FAD;
        Mon, 29 Nov 2021 16:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638204352;
        bh=4Gqnsc8eJT8RGnAR77WhxngkWMm7XUHlUU4m60Zgkqk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=W2GRWoPP07J8SXxP4UtGzSceMfq+SFFmEWOgs+mCqdzLOqTtqbvfWKlKh5Bwko5+R
         ywRQMpIMZms1HpEMF/2Kg9U/jd8KomaS2jAl/gzunKgllYVPWce8SBSYX1jYF1EA9e
         rtGIA8zYoB6cz+eqdOsbdyFxGVy3DH7Mjosy68Sv4gmtfWm4lqNLTiank7hCQTG6im
         EvnY7mVKupZfhcri+trkRGfTZ2DSqVf7Q7xGb6RenfozhBYP80vjOsABpOgMfb9qfr
         v36z8KPTiP6/QOkNg5BqcA1V+wqtaJKqSsCAD3b0Wwri4EjRQpfCrgQEmoi3NDZ9fy
         biyaVjmYQcAvQ==
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mka@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Collins <collinsd@codeaurora.org>, swboyd@chromium.org
In-Reply-To: <1637668167-31325-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1637668167-31325-1-git-send-email-quic_c_skakit@quicinc.com>
Subject: Re: (subset) [PATCH 0/3] Add PMG1110(Seco Jr) PMIC support
Message-Id: <163820434992.1716869.8358627296301312921.b4-ty@kernel.org>
Date:   Mon, 29 Nov 2021 16:45:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 17:19:24 +0530, Satya Priya wrote:
> This series depends on below series which adds the base CRD dts
> https://patchwork.kernel.org/project/linux-arm-msm/list/?series=584349
> 
> Satya Priya (3):
>   dt-bindings: regulator: Add compatible for pmg1110
>   regulator: qcom-rpmh: Add PMG1110 regulators
>   arm64: dts: qcom: sc7280: Add pmg1110 regulators for sc7280-crd
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] dt-bindings: regulator: Add compatible for pmg1110
      commit: ac88e9526d68f2532be3b4b439d45c0c8de7e170
[2/3] regulator: qcom-rpmh: Add PMG1110 regulators
      commit: 59eadd2af3f717f2ff70dbb6c153757dc1650651

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
