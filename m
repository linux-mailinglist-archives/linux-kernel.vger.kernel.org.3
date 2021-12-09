Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0EE46E94A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbhLINtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbhLINtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:49:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10ACC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 05:45:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D4ECACE25C8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 13:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68540C341C7;
        Thu,  9 Dec 2021 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639057546;
        bh=nzHJ+8AUgscYkeKl42+DtprhAE5fDcB0eMN1+c5CDg8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GjFY2KAgxOB3/B5Dv8BE3Zhq+MjQkHI1wBUQUnFyNRttv/4quQ2wtmcxlCyFsdMJP
         yTntvXjxRei4oh5no34BYOXB7Jew3bsdeFZMq1HzjbSih9SGzpX2nnfQl50LBMtGdX
         88MEWAGxPcF8lzpQuRnKuDNOcJDRVDg0uJWENKb3k5/s/LWkZxbLf2q/Y5aYWQVd9m
         LhRc7IeaZZn1f0WIIMu4Duh1//Uc2uU6xKdr3Le5nz153Z6OckyNXb1+S4I+mpJDx4
         Zwyo/+zTp/XsEc5RhsYzBW0FycTj5nqAGdbkbiIhITYhKI8nghVoj32E5CAby30Nvp
         BaMTTcPdQdtfg==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, perex@perex.cz,
        kuninori.morimoto.gx@renesas.com,
        Ameer Hamza <amhamza.mgc@gmail.com>, lgirdwood@gmail.com,
        tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20211207142309.222820-1-amhamza.mgc@gmail.com>
References: <Ya9YxoUqkATCOASh@sirena.org.uk> <20211207142309.222820-1-amhamza.mgc@gmail.com>
Subject: Re: [PATCH v2] ASoC: test-component: fix null pointer dereference.
Message-Id: <163905754513.1053127.9268237437282458172.b4-ty@kernel.org>
Date:   Thu, 09 Dec 2021 13:45:45 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 19:23:09 +0500, Ameer Hamza wrote:
> Dereferncing of_id pointer will result in exception in current
> implementation since of_match_device() will assign it to NULL.
> Adding NULL check for protection.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: test-component: fix null pointer dereference.
      commit: c686316ec1210d43653c91e104c1e4cd0156dc89

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
