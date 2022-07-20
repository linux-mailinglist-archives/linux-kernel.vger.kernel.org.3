Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C057BD69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiGTSHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiGTSHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:07:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC63A3AE57;
        Wed, 20 Jul 2022 11:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0787FCE227F;
        Wed, 20 Jul 2022 18:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946FFC3411E;
        Wed, 20 Jul 2022 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658340430;
        bh=JWV/F2msIyQc/Z1zlF2MD+qGz260XB+/zEVQWxqmxog=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uXkfeYZp43MO82SDOYFRwLWvkmFoAHgV3P211bZ3qZzJai5UtdSlv+xg1NwIehJpT
         Gb0mtHOQbP/iQ0dQ8aR90KtrFopGbwZKcWjtVGI9lXcRo/crwxx7FJVnrRmw+jm8PB
         MIfen/dpIzvFj1KcsPdvooxvqV/xIUe2F5NE1ranFPjbxX0kMsGMoKjjrtPLY60V1E
         dTzxy7JVw9oxI/LU7YHRPxFB3Uw4EgS+BNs0MoktWfNEHrVPEV7yt9C/XtHdCujCZN
         3nVT6Cca5DeWs2ITNmRClzjg3p4hzNm2KZrQbfET8COtUuJHEZTl0OQoI2wzedwiB5
         RDPvZNO87Zl0w==
From:   Mark Brown <broonie@kernel.org>
To:     benjaminfair@google.com, tali.perry1@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, venture@google.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, yuenn@google.com,
        joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org
In-Reply-To: <20220718081146.256070-1-tmaimon77@gmail.com>
References: <20220718081146.256070-1-tmaimon77@gmail.com>
Subject: Re: [PATCH v1 0/3] spi: npcm-fiu: add Arbel NPCM8XX support
Message-Id: <165834042733.589042.2864906716831607368.b4-ty@kernel.org>
Date:   Wed, 20 Jul 2022 19:07:07 +0100
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

On Mon, 18 Jul 2022 11:11:43 +0300, Tomer Maimon wrote:
> This patch set adds Arbel NPCM8XX Flash Interface Unit (FIU) support to FIU NPCM
> driver and modify direct read dummy configuration.
> 
> NPCM8XX FIU supports four controllers.
> 
> The NPCM FIU driver tested on NPCM845 evaluation board.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: npcm-fiu: Modify direct read dummy configuration
      commit: 7c3193f7890a03fc1b5b979f3f8dc8750ef47b13
[2/3] dt-binding: spi: Add npcm845 compatible to npcm-fiu document
      commit: d50fef8ae939c2b50431fe6a11457e7ff85aea55
[3/3] spi: npcm-fiu: Add NPCM8XX support
      commit: 650b014facca5238e25399f28da1e59747bddb99

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
