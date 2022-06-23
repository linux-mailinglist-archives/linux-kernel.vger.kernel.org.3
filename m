Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D78D557CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiFWNX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiFWNXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:23:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7338249C93;
        Thu, 23 Jun 2022 06:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D3E8CCE23C6;
        Thu, 23 Jun 2022 13:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1F5C3411B;
        Thu, 23 Jun 2022 13:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655990630;
        bh=Hdb4Ruy1col6i9EYYDDaRP5Zk72c/01tRo+65IYems4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jrTWCw7TKeXofqUESXw7sNIhCov56pgJVsL1OSbpW353CQ18Fd/YcT+3qjPzsm/QY
         1Mp5NEp+cN2qeZNGa4tA/tmlzobo86TuJmQ22zEdnlK/WWSdaOPyhU27SueusKUBPu
         DxU3HkKfClY4a5ZUqPiMz+KqQo/qtMAUcSK+5pPPUt9cKFWhTEYye7NDuAOQHwvwPO
         eYwWp04JAg1Rj3T10JXtI2Aq96rGyj2fP8K5haSKraT50hDnNmnovM98frLJIVzSF+
         jJGkL4ro5z64UKCq1VbavPanMDyiAGCFgeIJ3pqREGBgxF0678xLFsg4rogHB8vXmq
         LbOMr8k5OFfCQ==
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dmitry.torokhov@gmail.com, u0084500@gmail.com, lee.jones@linaro.org
Cc:     linux-input@vger.kernel.org, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org
In-Reply-To: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
References: <1655892104-10874-1-git-send-email-u0084500@gmail.com>
Subject: Re: (subset) [PATCH v2 0/4] Add Richtek RT5120 PMIC support
Message-Id: <165599062767.127406.12571486984170083213.b4-ty@kernel.org>
Date:   Thu, 23 Jun 2022 14:23:47 +0100
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

On Wed, 22 Jun 2022 18:01:40 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> This patch series is to add Richtek RT5120 PMIC support.
> In RT5120, it integrates four channels of buck converter, one channel of LDO,
> and one external enable channel to control the external power source.
> 
> Since v2:
> - Add 'unevaluatedProperties: false' for regulator buck1~4/ldo/exten.
> - Fix indention and remove status for powerkey.
> - Refine powerkey description for more HW details.
> - For the regulator property parsing, use of_property_read_u32 instead.
> - Not to overwrite regulator constraint.
> - Refine regulator desc coding.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[3/4] regulator: rt5120: Add PMIC regulator support
      commit: c0216c0e68f736d20ac02bbaaaf4a216c10e53af

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
