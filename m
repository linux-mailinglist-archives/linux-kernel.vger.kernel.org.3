Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCB153FBB8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241436AbiFGKpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiFGKpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:45:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223281EEF1;
        Tue,  7 Jun 2022 03:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D60AFB81EEF;
        Tue,  7 Jun 2022 10:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CDEC385A5;
        Tue,  7 Jun 2022 10:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598719;
        bh=dWi9pVoSXFMjNQasXg+itxXBUXG1usYFJbMM2nTrsb0=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=jbbJVJHznc3BWrvL9hvWGW4/IGx4f9ENxcWG7iVdMkdZZkNnISL4d7mjeKfubXrKK
         8oPtTg3eNzeA68a4oOOg0kkVVwIuIoGXkdZpV/vYd2tSjFtKgITsle39SazOg118Pm
         Mf+eXY4bu7Zxiay+y++FcaKk9OMzuy4ymsYPo4Mu/kSBYEVwMcwZ8CM629Bj061DgT
         sJXD3LI7cYrabxXNs9qSkQb6cbzB/iPlh+YtJCjjEg3M3ZJdi53jIHjOwbpKitXMcg
         MgwAm0rX3ZF8O3d5eZqJiSkjd+X4FVd1U4A+JZiBt2TsmSWZztnAobUsMsc8Ni2+u2
         4yFlXg4mWM/lQ==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org, bjorn.andersson@linaro.org,
        swboyd@chromium.org, tiwai@suse.com, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        quic_plai@quicinc.com, bgoswami@quicinc.com,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, quic_rohkumar@quicinc.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        quic_srivasam@quicinc.com, alsa-devel@alsa-project.org
In-Reply-To: <1652877755-25120-1-git-send-email-quic_srivasam@quicinc.com>
References: <1652877755-25120-1-git-send-email-quic_srivasam@quicinc.com>
Subject: Re: [PATCH v2] ASoC: qcom: soundwire: Add support for controlling audio CGCR from HLOS
Message-Id: <165459871566.301808.10281011736457954166.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:45:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 18:12:35 +0530, Srinivasa Rao Mandadapu wrote:
> Add support for controlling soundwire audio CGCR interface using clock
> framework to make hclk ungating with software. As per new hardware
> changes, software has to always ungate hclk if soundwire is operational
> and keep it running. This requirement is for latest LPASS chipsets for
> RX, TX and WSA path to work.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: soundwire: Add support for controlling audio CGCR from HLOS
      commit: 32882881078bd8f8fae47ff69c102d9e691f5bb9

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
