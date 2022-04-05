Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750784F438B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388337AbiDEPUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 11:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346945AbiDEJpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 05:45:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A037ADBD21
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 02:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 262A2B81CBD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F887C385C8;
        Tue,  5 Apr 2022 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151126;
        bh=cyjNmzP4+Kb9mNRHxfI14UVsnwuJ9e4OEWsxaaLXjXs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=fxjObYA7bnl9Iq8ifldVTz10ZiHa9gpXme6bi1FUAeBJRWVbxpl7Oh0/aMCGjqOKq
         VKYrySSYN+u9x3RmdEtV1nVmwu93sHvNBgQQxpGSbsHDa3vrU174KZ5eQWVHn72RGB
         6CrYVNT/EgQzyA1UgN0UySYKiFtmsFn4S7acBk69qfk3xTFPNqRyMiaGcKIPlRS5/E
         +k0H9aTM9VdJ3ns2EDw8nDqKLxgwodl24eyYEWpHzEIxku89daCQuxH/K76oQRKBFU
         XhcV/cSbxNmZ3KWvN9waczE1sbVIegrF1q8gXcA31zrJtG+aBgtnI0OCj9QRX10Vak
         CmeIN1X/zn6jQ==
From:   Mark Brown <broonie@kernel.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20220325144637.1543496-1-broonie@kernel.org>
References: <20220325144637.1543496-1-broonie@kernel.org>
Subject: Re: [PATCH] regulator: Flag uncontrollable regulators as always_on
Message-Id: <164915112589.276837.9497597666608060283.b4-ty@kernel.org>
Date:   Tue, 05 Apr 2022 10:32:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2022 14:46:37 +0000, Mark Brown wrote:
> While we currently assume that regulators with no control available are
> just uncontionally enabled this isn't always as clearly displayed to
> users as is desirable, for example the code for disabling unused
> regulators will log that it is about to disable them. Clean this up a
> bit by setting always_on during constraint evaluation if we have no
> available mechanism for controlling the regualtor so things that check
> the constraint will do the right thing.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Flag uncontrollable regulators as always_on
      commit: 261f06315cf7c3744731e36bfd8d4434949e3389

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
