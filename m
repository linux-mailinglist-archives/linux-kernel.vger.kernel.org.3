Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE94659ECB7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiHWTrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiHWTqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:46:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD36D2748
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 11:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F61DB8206B
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 18:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF26C433C1;
        Tue, 23 Aug 2022 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661280599;
        bh=4m1byrsQRJLm/cJqTDuKbmUd4hieFD6ic0Yp5Uh7iUc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=EDc86ypg0C2gWgwtP6WdeRwdjj9VXBXXmzAlmXTqPS+ZnvMuKTuWWtA3Skt8qjmYs
         xMcuhlMKFYbNfML6QXJoG3MajtPomjOL2Cs7al+pVh3opxshqlZpdgPgGF+zwBOaC3
         REhYwJNqCmbGhxu4MJT64qzUgrWDW7pqPLiFKT0C+Gsa2cTHJ9EaIZW5Z62a4SSF+e
         gbMKe+16XyJvtVgpn/J64oZ9T42RSEG6tWfNrWdjht5y7+ooCEdhDjAp+926oI4v4p
         kN976afNmOnPjjR2LqACAdonfxeQN2rzQefUXHDPnq4Qo0zZsC4yeshTJPBEA9H+al
         /lKVlOpdI8vgQ==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com,
        Daniel Baluta <daniel.baluta@nxp.com>, lgirdwood@gmail.com,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, kai.vehmanen@linux.intel.com
In-Reply-To: <20220822174937.254873-1-daniel.baluta@oss.nxp.com>
References: <20220822174937.254873-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH] ASoC: SOF: compress: Remove dai_posn variable
Message-Id: <166128059751.1031684.6362088791172112373.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 19:49:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 20:49:37 +0300, Daniel Baluta wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> dai_posn is set but never used. Initial intention was
> to use dai_posn to shorthen one code line but it looks fine
> without it too.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: compress: Remove dai_posn variable
      commit: d45f552a1e44e2885c4b7551564241959d8138be

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
