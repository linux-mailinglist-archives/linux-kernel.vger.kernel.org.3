Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2608A4DE309
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240949AbiCRU72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 16:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240945AbiCRU7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 16:59:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355CD1AD96;
        Fri, 18 Mar 2022 13:58:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A944660EEB;
        Fri, 18 Mar 2022 20:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C18C340E8;
        Fri, 18 Mar 2022 20:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647637081;
        bh=3tZLC4OI4DmCNMJnIOo7RYTAi7LWN2qliV+IISVObGI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=LGPaCodP8eS/7klwaU8q0zEpjY3D6qASKNddY0k53Fyi4Gg4tbqZ/blZgzLUpyGIX
         CwSf3M3qU5kWxh3Kkw4ca1kZBPXA9mnE2oUsnUBlU/YDrWmSMZMOhP9o7425bLgDzD
         melUxHZuxnujObAWSmMTQxD7FDLYAew3fjDEFrzfaBTMC0hZmcFB6TBHo+BoIJezjP
         90KoSdfybx45J4mbhFvuhgcUzfTRlSZtaBf9t4hO1TeVV9InVynuswec84kPEVlCvi
         zZ8LTkqYaW1e1LdblqeRFwqO3YlQxMMAq70GL5JayVgNa6UXgmjsWSe5ClN0kNFWB+
         uq+W6RRir0nmQ==
From:   Mark Brown <broonie@kernel.org>
To:     collinsd@codeaurora.org, lgirdwood@gmail.com,
        linus.walleij@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1647410837-22537-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1647410837-22537-1-git-send-email-quic_rohiagar@quicinc.com>
Subject: Re: (subset) [PATCH 0/6] Add Power Domains and Regulators in SDX65
Message-Id: <164763707833.2336544.6847647511365676482.b4-ty@kernel.org>
Date:   Fri, 18 Mar 2022 20:57:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 11:37:11 +0530, Rohit Agarwal wrote:
> This series adds driver and dt-bindings related changes
> in SDX65 to add power domains and regulators.
> 
> Thanks,
> Rohit.
> 
> Rohit Agarwal (6):
>   regulator: dt-bindings: Add PMX65 compatibles
>   regulator: qcom-rpmh: Add support for SDX65
>   dt-bindings: power: Add rpm power domain bindings for SDX65
>   soc: qcom: rpmhpd: Add SDX65 power domains
>   dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx65 support
>   pinctrl: qcom-pmic-gpio: Add support for pmx65
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/6] regulator: dt-bindings: Add PMX65 compatibles
      commit: e34855b99696433a26d86179552553c6c6fa69b8
[2/6] regulator: qcom-rpmh: Add support for SDX65
      commit: 5999f85ddeb436b4007878f251a30ccc8b9c638b

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
