Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5344848C683
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354326AbiALOwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:52:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50506 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354308AbiALOwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:52:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF509B81EF2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 14:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F211DC36AEB;
        Wed, 12 Jan 2022 14:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641999118;
        bh=4bXOYi2po9ChxQikcMSbKftEl0oPCwWdt//SzZM/Brw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bktxcMZcoQjM+6sw7PsLJyfpBB6iEo022Top+h/Wvin1+LF15ONBAlSiBfs/8+KEL
         kN3VyFrj5kSboT9tI3xORdj5YVkWkzjar9TmOQ6iFc5EwWR1fgGRVj3v3FlYaek74V
         SVJCcDXRPeUT3gOeXOQgCHGDSgIurJxZR8oX3uPk0k8De6CmAcj8akcPhzXZoK9qsb
         kKZGDp8wBO5WA73L50UlI83SqmWyy1o35htrig8E92ZYZdIs6DNsSTRUEuROZ1s9cJ
         LgQMq2hCFm/Oq0jwL5JGlkTeMRfrg8vAyfl0Fwxrvl1VFBOnhBBJf3PhZRC57ZvSU9
         f++9RPv3KzT+A==
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, pavel@ucw.cz, sre@kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>, lgirdwood@gmail.com,
        tony@atomide.com, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20220111025048.524134-1-jiasheng@iscas.ac.cn>
References: <20220111025048.524134-1-jiasheng@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: cpcap: Check for NULL pointer after calling of_get_child_by_name
Message-Id: <164199911671.1042212.15547958448190798911.b4-ty@kernel.org>
Date:   Wed, 12 Jan 2022 14:51:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 10:50:48 +0800, Jiasheng Jiang wrote:
> If the device does not exist, of_get_child_by_name() will return NULL
> pointer.
> And devm_snd_soc_register_component() does not check it.
> Also, I have noticed that cpcap_codec_driver has not been used yet.
> Therefore, it should be better to check it in order to avoid the future
> dereference of the NULL pointer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-linus

Thanks!

[1/1] ASoC: cpcap: Check for NULL pointer after calling of_get_child_by_name
      commit: f7a6021aaf02088870559f82fc13c58cda7fea1a

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
