Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCED52049C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbiEIShw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbiEIShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:37:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63FB52507;
        Mon,  9 May 2022 11:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AC26B8115E;
        Mon,  9 May 2022 18:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C45C385B5;
        Mon,  9 May 2022 18:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652121229;
        bh=/xv7HUCbZ4GcHES/hTY69qU5Wnk174brdxHC9qD13jQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BftOeXMMRYLJ9cNsZzEIM/CcfHPPNdDBppbQEM/waG2wbTocU/GoWBmucpQ4hyTJ4
         Ld0bBa5+I6fnsGmX3oywnei7nFFCXyE7O3JAkazlRf6zQVmf5hev8AvCU+Q8RuSPhk
         KJT+cAnZ+dgWaRoyqL7toINV6oW+2fUYImdzvG1MMkzIDSQmy2ag5NyQvYmVlj6v8D
         Ri10W58BpRblk4UqJnkRlGacngxxTRiQJvbj7zLcFwlcOJJDbCpU/Kf9hj5LaEQISc
         47/5J+ev3cZ7PdFu1SQwC+V9mnbkWGm2qHj2nKFFZ3O1T/UTpES9O+G1xIQf8ZNCGy
         5OzmU/gvt7OUQ==
From:   Mark Brown <broonie@kernel.org>
To:     konrad.dybcio@somainline.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org, agross@kernel.org,
        bjorn.andersson@linaro.org, kholk11@gmail.com,
        angelogioacchino.delregno@somainline.org,
        jamipkettunen@somainline.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, marijn.suijten@somainline.org,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20220430163753.609909-1-konrad.dybcio@somainline.org>
References: <20220430163753.609909-1-konrad.dybcio@somainline.org>
Subject: Re: [PATCH v2] regulator: qcom_smd: Fix up PM8950 regulator configuration
Message-Id: <165212122648.1242901.8952054943926488317.b4-ty@kernel.org>
Date:   Mon, 09 May 2022 19:33:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2022 18:37:52 +0200, Konrad Dybcio wrote:
> Following changes have been made:
> 
> - S5, L4, L18, L20 and L21 were removed (S5 is managed by
> SPMI, whereas the rest seems not to exist [or at least it's blocked
> by Sony Loire /MSM8956/ RPM firmware])
> 
> - Supply maps have were adjusted to reflect regulator changes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: qcom_smd: Fix up PM8950 regulator configuration
      commit: b11b3d21a94d66bc05d1142e0b210bfa316c62be

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
