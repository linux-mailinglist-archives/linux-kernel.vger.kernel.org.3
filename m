Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BA54D7DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbiCNIzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbiCNIzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:55:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B88E20F72;
        Mon, 14 Mar 2022 01:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E7BA1CE1099;
        Mon, 14 Mar 2022 08:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70F3C340F6;
        Mon, 14 Mar 2022 08:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647248064;
        bh=pOJJw1xO8gJXjWgBRnxa5bjvsoFtsXrMDM88AR9YVYs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=h9yMSvcsMlqsjB/0bz0VkbzBh7ZYDkkImBHp/r5frg0YOIiSdj5e9H8HZydZNAqNG
         GB5OLl8/ejWx6WR/MTIZxFc4qP+B0uTJfR8v1m1rgbJofLJXslHGY+Jxs+2OVJa4Wl
         +4WvYgAyStpZVYvyHc7XRrlNB4LK3X0SfWN5HjG2+7OU9bmLOCB5eEyQ3QFen8eVCP
         oOc16u0ClC7qotQaBYoOh0SrFB6/5VS2qZyXZMN92zM1qgQ9he3foRnl5bFyPquGDc
         eYZN1dNPeg6wgURs7QAa+BwgfPiYGsOjl8PbcTl7iJFBZkHKLrXR1UGYvDl18hnqQS
         XaBuUU4nBsTWw==
From:   Mark Brown <broonie@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220311234802.417610-1-robh@kernel.org>
References: <20220311234802.417610-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Fix patternProperties with fixed strings
Message-Id: <164724806240.972788.14565468208010113949.b4-ty@kernel.org>
Date:   Mon, 14 Mar 2022 08:54:22 +0000
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

On Fri, 11 Mar 2022 17:48:01 -0600, Rob Herring wrote:
> The simple-audio-card and renesas,rsnd bindings used 'patternProperties'
> with fixed strings to work-around a dtschema meta-schema limitation. This
> is now fixed and the schemas can be fixed to use 'properties' instead.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Fix patternProperties with fixed strings
      commit: 910f42bfe96783fc633196bd975731a420c7a066

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
