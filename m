Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BFA58AB7C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbiHENUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbiHENUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:20:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE9926A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 06:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFF2AB828C8
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 13:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604DFC433D6;
        Fri,  5 Aug 2022 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659705641;
        bh=7o0cimbLP3DJS7c5Umhmno/pUUb9ozfJhSgiKERWHro=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tt+nhnFlh2QFxFGozPuvdwChO9Ntax26GqVD95O3wn8CyLKYUhwNQHkNdVWPDhD0M
         DLUFMJxnnIaibJLdSluPkjGKGcvZqv/Dc7sUIMrGaWjqnHdm6axXoHg2WmkJzPqFlm
         IroVnsmDBBLmd3enUabDGy8HIzHNd5owuKu1Gby9oCxLIFvACvmqoWVY94YLGNzw3/
         KS450dhodWffuTU6fbZVAADR6wv0a/aKdiZy1fhRxgfqRWPoghrVX3sJ9YhzZ4j5Kt
         Yu138wBlQT52g6pABCceoXDEi/TD10sye62BG84P7RZ4un2HsW8onq7l1byVSJiTEt
         mZOalj+4N/gmA==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>,
        Justin Stitt <justinstitt@google.com>,
        Jaroslav Kysela <perex@perex.cz>
Cc:     sound-open-firmware@alsa-project.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        alsa-devel@alsa-project.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Tom Rix <trix@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        llvm@lists.linux.dev
In-Reply-To: <20220803204442.2996580-1-justinstitt@google.com>
References: <20220803204442.2996580-1-justinstitt@google.com>
Subject: Re: [PATCH resend] ASoC: SOF: ipc3-topology: Fix clang -Wformat warning
Message-Id: <165970563810.1032419.6494155990235554892.b4-ty@kernel.org>
Date:   Fri, 05 Aug 2022 14:20:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Aug 2022 13:44:42 -0700, Justin Stitt wrote:
> When building with Clang we encounter these warnings:
> | sound/soc/sof/ipc3-topology.c:2343:4: error: format specifies type
> | 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
> |                  SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
> |                  ^~~~~~~~~~~~~~~^~~~~~~~~~~~~~~^~~~~~~~~~~~~
> 
> Use correct format specifier `%d` since args are of type int.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: ipc3-topology: Fix clang -Wformat warning
      commit: b7bf23c0865faac61564425ddc96a4a79ebf19b0

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
