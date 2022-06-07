Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE08F53FC10
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbiFGKtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241862AbiFGKrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:47:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D05F339F;
        Tue,  7 Jun 2022 03:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5745B81F0C;
        Tue,  7 Jun 2022 10:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A377DC34114;
        Tue,  7 Jun 2022 10:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654598798;
        bh=4sLZ5BLxpPRtzF03O8ywJPLV0cvQkKFtC0bybqn9p88=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YsAqwwTHkOJHQEFoeGgkkdlXLhPkJ4VVN4aSFTB+nezqWlrhtLbSdUps1gSJh7JNd
         ollHT9Slr9ePBNIrDu2awLCK3IEVy30z/DC5VY5pAcxUy6Y86zkVNKvZ0KF3FMQ2ay
         /ucw+cnOgqgpkUUeqgIFI0/3TSKTPudOGLxM2X4zjzzZRXoGZYaLe3oS5NIjpgDdx2
         sdKzuljcjm/SP104bdlhY6oqN5OAq1zIPjexWBjhXo+H/cAFIQOU1CWGS0J7KRy/5I
         RqLz2g0idcCM8GqOc8X3JJ5E0g3bAOCJxvFo9eRyiIBjoEAdBHNUIVKpJ2pgKjyIlC
         wJxAApMIkjBLg==
From:   Mark Brown <broonie@kernel.org>
To:     Julia.Lawall@inria.fr
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
In-Reply-To: <20220521111145.81697-13-Julia.Lawall@inria.fr>
References: <20220521111145.81697-13-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] spi: fix typo in comment
Message-Id: <165459879738.302078.9645268491215493172.b4-ty@kernel.org>
Date:   Tue, 07 Jun 2022 11:46:37 +0100
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

On Sat, 21 May 2022 13:10:23 +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fix typo in comment
      commit: 657f8bd88cb5a968d907fd1c891cee52dc156caa

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
