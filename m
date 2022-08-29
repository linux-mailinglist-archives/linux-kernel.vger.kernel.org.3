Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3095A57FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiH2Xr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiH2Xq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:46:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12FDA573D;
        Mon, 29 Aug 2022 16:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C12896139D;
        Mon, 29 Aug 2022 23:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F41C43144;
        Mon, 29 Aug 2022 23:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661816797;
        bh=82J021kb8nTpi7UEzmswjUShsB6ev8X06dHmneRWxOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9iQ0PrYtblfdMsrqWud02AHFBQ9FPkASE96tp920x/AMWvtAb4MFqS1Y79nVoXkc
         m3epVG9uVqTs76EFrctsi+kXOSRkT7Zf/IFleGpLL52tMIwEqa6/y8vshtozjzaerh
         fthZA4aAd8CKrJU/yT+8KOHNQvwVL99d9454bVtgNn1XVZGW/dfeUYsgfX7OP4Cv5Y
         6XNOJRWb+8xJB/RNBxcy854hUgZ4AdjK97ye1XZeTkhJlbDL08jXUY9ODzsunYX2gS
         EZDc0i3TeoDD+jmP8isc2r2jRKrBd+aiJZQgfKEE6Fsi+iP6gPZ+0+ZAGYqfa20A5d
         VJ+KHgTQii08g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linmengbo0689@protonmail.com, devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        stephan@gerhold.net, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, nikita@trvn.ru
Subject: Re: (subset) [PATCH v3 0/4] Add Samsung Galaxy E5/E7/Grand Max device trees
Date:   Mon, 29 Aug 2022 18:45:59 -0500
Message-Id: <166181675963.322065.8450629313545620550.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719125851.54571-1-linmengbo0689@protonmail.com>
References: <20220715102055.3844-1-linmengbo0689@protonmail.com> <20220719125851.54571-1-linmengbo0689@protonmail.com>
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

On Tue, 19 Jul 2022 13:01:34 +0000, Lin, Meng-Bo wrote:
> v3: Add a cover letter and changelog
> v2: Add dt-bindings documentation
> 
> Samsung Galaxy E5, E7 and Grand Max are smartphones using the MSM8916 SoC
> released in 2015.
> 
> e2015 and a2015 are similar, with some differences in accelerometer,
> MUIC and Vibrator. The common parts are shared in
> msm8916-samsung-a2015-common.dtsi to reduce duplication.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: qcom: Document bindings for new msm8916-samsung-e2015 devices
      commit: dc1b8ce9db8c5181b3345505a66dfe8136b83f21
[2/4] arm64: dts: qcom: msm8916-samsung-e2015: Add initial common dtsi
      commit: 995d1ac509fb92f3288a8eab3342a5667183fd2f
[3/4] ARM: dts: qcom-msm8916-samsung-e2015: Include dts from arm64
      commit: 87c1b199e622bc2d9b16da5d870ab6b92db96154
[4/4] arm64: dts: qcom: msm8916-samsung-e2015: Add touchkey
      commit: 90ca46731599ea364d2d8b5310341ab766fea637

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
