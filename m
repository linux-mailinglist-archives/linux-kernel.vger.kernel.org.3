Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486604621E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhK2UO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbhK2UMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:12:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52387C08ECB3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:45:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15C0AB81216
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C47C53FAD;
        Mon, 29 Nov 2021 16:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638204339;
        bh=N4ZsljVphFQ5StDB/sEhAMzkAq4w3lBf222fINgc9tE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XMiY1W5y76QmZfECOYoQ8nyKVg/eBDxnhSwgmYRf5bqpvItsCFYwEq+c/uOY8xMXq
         dPcRYqVi6MogqXQuHGnCwZsUqoDd+rgYmv98wT0wftZEXPqf52+40CICYcJA69JLLV
         FkaSKJ6UgS/FEmXUg5y2nE/xQBGdE6ib9OBBzuD+mdKCRE7cnzOf78PK5hm+GPNQxV
         bxe4nLFv/oKzAOQC1G1bbTXKxzz8EvlOUDLGvaT9N0b2NVEzt1cHmxQkLcmXJYuHru
         ySg0jheIiMe8r9TyGrd7lFS+X5qLXo8cGNH1Id8CItdHPnIkdybFxKy/MA1UhL6S0X
         feot23CSRpXFw==
From:   Mark Brown <broonie@kernel.org>
To:     lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>,
        lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        albertchen@realtek.com, judyhsiao@google.com,
        derek.fang@realtek.com
In-Reply-To: <20211123024329.21998-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20211123024329.21998-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: Re: [PATCH] ASoC: qcom: Add support for ALC5682I-VS codec
Message-Id: <163820433805.1716750.13484199254785400045.b4-ty@kernel.org>
Date:   Mon, 29 Nov 2021 16:45:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 10:43:29 +0800, lvzhaoxiong wrote:
> Qcom machine driver adds rt5682s support in this patch.
> Card name can be specified from dts by model property, and driver makes
> use of the name to distinguish which headset codec is on the board.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Add support for ALC5682I-VS codec
      commit: 425c5fce8a03c9da70a4c763cd7db22fbb422dcf

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
