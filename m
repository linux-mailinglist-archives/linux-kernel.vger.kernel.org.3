Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF561561ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiF3PK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbiF3PKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:10:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77FC2A97E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78965B82B75
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 15:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C25C34115;
        Thu, 30 Jun 2022 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656601821;
        bh=FyTqsR5EybY7iM7iEaNhoXEYisNEPyb47zA76fc//G8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tEJdqW3fFrs6IZJs0Z0xMIAz6dYJa3FkZbT2ZtVa+n8gnU1Rv4nfq9jAiCZ3YxTxc
         EyTCEfs0JYj54Mi5I7WLxxCKB7eBR/tq14csHutOlS8RBVIJB1vzYOEzZC2zKoBxYZ
         y6oL7c1XmowAFo+3IbUJ/Pp4bGZp1GkpJQPP1RZuRcsgxkAsyDDhwfthUl4WwaeGU2
         xXjXQBq8StJgKiCyWveWJlIUzONGwKzmnRQLJtpGOvYSShrEDzPYaaz1J/GBZyAtJy
         n1r8XiRerB2IYhUZs52bjUaBy2Hu61H0qfxU0nOjRGb1bKf2r+GjJNYb8sOMzIXT41
         kl6hSYp84J5EQ==
From:   Mark Brown <broonie@kernel.org>
To:     srinivas.kandagatla@linaro.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com
In-Reply-To: <20220630123633.8047-1-srinivas.kandagatla@linaro.org>
References: <20220630123633.8047-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3] ASoC: codecs: wsa883x: add control, dapm widgets and map
Message-Id: <165660181971.664251.15530815759209640132.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 16:10:19 +0100
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

On Thu, 30 Jun 2022 13:36:33 +0100, Srinivas Kandagatla wrote:
> Add controls, dapm widgets along with route.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: wsa883x: add control, dapm widgets and map
      commit: cdb09e6231433b65e31c40fbe298099db6513a7f

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
