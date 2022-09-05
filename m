Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FD65AD88B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 19:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiIERob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 13:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiIERo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 13:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFE7302
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 10:44:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7884461451
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 17:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19E8C433D6;
        Mon,  5 Sep 2022 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662399860;
        bh=S0siCZf1fplDVdZQaH2EOINhg0VPl81P6I2vcDAk3Jw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=aY934ob2giC8uRrh3q7gcCs6uiRCzelK43Kh8urk1UZFHy6f5hmf7NXs363jM4evY
         lj0trfKLu+AD91b2lNpA3p1/if9QhmI61LO2IDfDDMv8AYicDIqAIGCZ8KgZ2a+sqT
         7xKq4RLfEmwauWev+UXVMMNez/cqgcTnl+TKyt3dk9aOnuPwhZzAAziSaAElAURpt3
         ScNNXJs/IJUdNBuUkQ6nAwtq+f1yUc3etByvIqv6C/0P6xh/q0HlDYu/9k2QuJFh+s
         rEzKw6QdlewOCwZCcar2fnG00sKmXz07NxUjHPBSfm/v+H7Ellz/wBiIeMyjwLFr87
         9bOD7+qfzXBgA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
References: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/3] regmap: trace: Remove useless check for NULL for bulk ops
Message-Id: <166239985949.822508.8248374962835676727.b4-ty@kernel.org>
Date:   Mon, 05 Sep 2022 18:44:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2022 16:23:34 +0300, Andy Shevchenko wrote:
> If the buffer pointer is NULL we already are in troubles since
> regmap bulk API expects caller to provide valid parameters,
> it dereferences that without any checks before we call for
> traces.
> 
> Moreover, the current code will print garbage in the case of
> buffer is NULL and length is not 0.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/3] regmap: trace: Remove useless check for NULL for bulk ops
      commit: f78d5e1168e08429bc948d09b6dc11fec5e019f7
[2/3] regmap: trace: Remove explicit castings
      commit: d10268a50bdbc03ebb6d340d63bf78c44d7c66a8
[3/3] regmap: trace: Remove unneeded blank lines
      commit: 6ed406ef9f74372282c3b515e64986120823f769

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
