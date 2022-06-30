Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06758561B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbiF3NcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiF3NcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:32:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3025D38BC4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C06AB61F88
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500F9C34115;
        Thu, 30 Jun 2022 13:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656595927;
        bh=MQ99EA8MPq4y6QBBwwIjkqow6PwqZgEuhPY0Ewq7swc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YHL2cisNZD3hQ3ALsm0hnNYkJ8paM/cVAfmE28lt/JE4P7K8p7HWEZU/1i+r9zHPd
         S53UuyXwutDkAsbVMJkV759XsE5WCYZj3NuC+Hjea7IYXkPOd++G2Ml7k8vccj5pL8
         3HPCT4pYkY9BTVXGDzciojlB8Ji6/RyAWGIpl58dtRVw366v7Ma6wqtoYEl7AEqUCA
         ebM4l9FaLECWzDHyOPCqd9AinIJ+VdvPKHh/cLYPfsmssha56TY4EEkoLRERP6gJxB
         7YoLcBC1tnfhRO6Qb++YJQNr3VIW/Bjbbf6z/570pZYueWoz9MLVTX23n7xP9GHVhP
         a2UpCcShZfxTQ==
From:   Mark Brown <broonie@kernel.org>
To:     gregkh@linuxfoundation.org, schspa@gmail.com, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220629130951.63040-1-schspa@gmail.com>
References: <20220629130951.63040-1-schspa@gmail.com>
Subject: Re: [PATCH] regmap: cache: Add extra parameter check in regcache_init
Message-Id: <165659592604.540673.9610049646395507575.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 14:32:06 +0100
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

On Wed, 29 Jun 2022 21:09:51 +0800, Schspa Shi wrote:
> When num_reg_defaults > 0 but reg_defaults is NULL, there will be a
> NULL pointer exception.
> 
> Current code has no such usage, but as additional hardening, also
> check this to prevent any chance of crashing.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: cache: Add extra parameter check in regcache_init
      commit: a5201d42e2f8a8e8062103170027840ee372742f

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
