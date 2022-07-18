Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8815A578520
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbiGROQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiGROQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D754FBF59;
        Mon, 18 Jul 2022 07:16:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D0FF60A39;
        Mon, 18 Jul 2022 14:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7383DC341C0;
        Mon, 18 Jul 2022 14:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658153765;
        bh=aLKEXqH+iK0TIbbqnSk+kdHP+hrFwQ1Kd8T8kvQmRiU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=qpyLZyEX+qCdhosZiguYz6Fkw6k8+mA1UaPjdTIeW1OSm2P4VD5/4ZcYxe+MDTplE
         /rAYVDXhurNNN/zl5hEAJ8/SQ2Ru8B/7yrd3156oRLwtnRg3EuN5X8PN1/j1xuQON8
         hb1YW3PPHxlt1ZgndPwp5uZwdweMCVumxPwxpQktJOOHTdsh8tect8539E6YAcZcJj
         NgtipGFq1xlN44poqlyeyxvTRBAj4TaBiZT+WdLIp3fRwUzyO2ItV/Yu6f3MiwcNDu
         Yri6ojb+N+2FzPDAfWL4j0GS9Nnfrd/yYdiA7DyGmSibZjf3dtLMwcKXgb+ah5dOHy
         L2B2tt80Bat/g==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, johnson.wang@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20220715120114.4243-1-johnson.wang@mediatek.com>
References: <20220715120114.4243-1-johnson.wang@mediatek.com>
Subject: Re: (subset) [PATCH 1/3] spi: dt-bindings: Add compatible for MediaTek MT8188
Message-Id: <165815376317.235243.3004661183751772073.b4-ty@kernel.org>
Date:   Mon, 18 Jul 2022 15:16:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 20:01:12 +0800, Johnson Wang wrote:
> This commit adds dt-binding documentation of spi bus for MediaTek MT8188
> SoC platform.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: dt-bindings: Add compatible for MediaTek MT8188
      commit: 0ee0ab0bdab4f9e6754cc6a294e90c46b53f565b

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
