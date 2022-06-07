Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC2353FE57
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243536AbiFGMId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbiFGMIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:08:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AF88BD10;
        Tue,  7 Jun 2022 05:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D57FBB81F6F;
        Tue,  7 Jun 2022 12:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF57EC385A5;
        Tue,  7 Jun 2022 12:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654603678;
        bh=nHE1DVu+fUv8cZvdfRHSwShQafvIqrXmQrldkvf66xI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GVpNCgxf7qma2p57EIyUvU1Gh2gVi9axDW/HpLX3095LCXZHX//UjwBQJZliZ46qo
         Lnc/QBV6k43CJhH2ggACxmN0BEzWGyFrq1PMKBOvoghz/ZNPXM0Yn1iLuIKRjdnxFy
         BJ0ftEyBLYHrt/WW/0qdnOxjKsOUKXdKVsq6SI78kfM6haSOw9UJerKV0udljYcuUn
         tnOr+ALA6tzhbMW9+MfD4AYwJQ3GvNquE/wrg6Fagilk75rzVgmMCL62ssiutdKUia
         K18LoG/mQLeciSYngVIih1YiDTY9JCyY1JSJHYU38WoHIsUS5qiRUWkemux1aSaTAl
         txOTKtUalz4MA==
From:   Mark Brown <broonie@kernel.org>
To:     robh@kernel.org, briannorris@chromium.org, lee.jones@linaro.org,
        lgirdwood@gmail.com, acourbot@nvidia.com,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20220606184310.1057797-1-robh@kernel.org>
References: <20220606184310.1057797-1-robh@kernel.org>
Subject: Re: [PATCH] regulator: dt-bindings: Convert pwm-regulator to DT schema
Message-Id: <165460367660.763141.3678690822911695459.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 13:07:56 +0100
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

On Mon, 6 Jun 2022 13:43:09 -0500, Rob Herring wrote:
> Convert the pwm-regulator binding to DT schema format.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: Convert pwm-regulator to DT schema
      commit: a9369fd316cf3002642295250b6a52c4554aa74c

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
