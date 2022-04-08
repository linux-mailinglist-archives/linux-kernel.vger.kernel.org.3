Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6424F93E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiDHL0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiDHL0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E422E0A0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 04:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E81D061FA7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 11:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76124C385A1;
        Fri,  8 Apr 2022 11:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649417058;
        bh=bZKhUAef1apcWbdBzo3Iz78dUuFA/2hoSWiMN4ip0sQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=E+HTIi1oTNk0sg7A2kDG5btHwhPFkUdAgLH+p44hzeMGF4yTpExspHMuCzrP/878A
         P+JBbGSOANbtFiK+Cd948O2LrdO4LRBCLaxSrqPcm4DRGLi8crvNVbHZqlAf/2p3FW
         p7RsEF0GiKTPpyH2CIZpLkNgi5pC9OjDoS9ksgX0dgaiO4tEiHIiYeQbtM/S87cBUN
         mZRzD2qFy/LMDucjWIyOdcVHhDoFP6rzlZSLqKpIFw+XJ9HgQkKyis0gi7cDlUqdBa
         ao+RDO/ge9nMX5ZGbfbVwgRFNPUTPQcCdf8Db/nXVUFvhsfrPvusccacd6l/WAzGuI
         oh7kU5zSxlF8A==
From:   Mark Brown <broonie@kernel.org>
To:     ranjani.sridharan@linux.intel.com, liaoyu15@huawei.com,
        linux-kernel@vger.kernel.org
Cc:     liwei391@huawei.com
In-Reply-To: <20220318021616.2599630-1-liaoyu15@huawei.com>
References: <20220318021616.2599630-1-liaoyu15@huawei.com>
Subject: Re: [PATCH -next] ASoC: SOF: topology: Fix memory leak in sof_control_load()
Message-Id: <164941705720.1295287.17447478946565917709.b4-ty@kernel.org>
Date:   Fri, 08 Apr 2022 12:24:17 +0100
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

On Fri, 18 Mar 2022 10:16:16 +0800, Yu Liao wrote:
> scontrol doesn't get freed when kstrdup returns NULL.
> Fix by free iscontrol in that case.
> 
>      scontrol = kzalloc(sizeof(*scontrol), GFP_KERNEL);
>      if (!scontrol)
>          return -ENOMEM;
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: topology: Fix memory leak in sof_control_load()
      commit: 9b91d0ece22b9ab37fc185511c7f992e51c93d6e

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
