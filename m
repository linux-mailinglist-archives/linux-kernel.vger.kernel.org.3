Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16EB55E7B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346334AbiF1ORk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346237AbiF1ORi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:17:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306652EA28;
        Tue, 28 Jun 2022 07:17:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E664DB81E3F;
        Tue, 28 Jun 2022 14:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521CEC3411D;
        Tue, 28 Jun 2022 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656425854;
        bh=/2o6Cn+wlOC6M4+LDwBixIIRgNm0JkPO5/D8l7zwm1w=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=jV18BWsK2+4axT3lbN28G1XGohb2mLJv2qK16Odx0NrsY7knbqE+10Ye6BiCSxcFi
         FA9Q42hpZO+IVoErbHYkkdimpm9Wbp9K5taJY9iM/KuPcKBRvM/rLwLF1KsSYreG7U
         43AxwETYWO/iTsGS2KHOagMI+mATxE6lHvcJhqeoswffLiLqsxEo4mtVNdimpTNsDa
         9AAdNVn9vj4kz3Kcxw3VthIOGSWbx1OFbOhLgLcvch8vQOZlgt3Nsa6UNDG7JD6SE2
         tu7ofZGzVg1pa/CF0SN2YlGNmHYAwPYFf+XLJUEN8TUI3RKIK6BcNBupNJuO8r9nwa
         DHreUPgMYyG3Q==
From:   Mark Brown <broonie@kernel.org>
To:     quic_plai@quicinc.com, lgirdwood@gmail.com, judyhsiao@chromium.org,
        agross@kernel.org, quic_rohkumar@quicinc.com, bgoswami@quicinc.com,
        quic_srivasam@quicinc.com, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, perex@perex.cz, tiwai@suse.com
In-Reply-To: <1656326662-14524-1-git-send-email-quic_srivasam@quicinc.com>
References: <1656326662-14524-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH v2] ASoC: qcom: Add driver support for audioreach solution
Message-Id: <165642585106.1712503.17346348780044575252.b4-ty@kernel.org>
Date:   Tue, 28 Jun 2022 15:17:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 16:14:22 +0530, Srinivasa Rao Mandadapu wrote:
> Add Machine driver support for audioreach solution, which uses
> ADSP in SC7280 based paltforms.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Add driver support for audioreach solution
      commit: 5f78e1fb7a3ed1acc355145536ddd54f183b635d

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
