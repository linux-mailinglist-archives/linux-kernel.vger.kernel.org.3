Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD8852A77E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350720AbiEQP7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350686AbiEQP72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:59:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17727496A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:59:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A67A861222
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 15:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50C4C34116;
        Tue, 17 May 2022 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652803167;
        bh=fERQZggsBwWdHxLHZxC0R2Zo7qJEWV8qww8X1ChV7yQ=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=UmswcLTQcZ6lYohR+eGjuKxzz/8hmQSfYpceg8ruIh3IcM1uLe4ucUO/QGLDH/NHi
         amZVYSEL2ZvFXzKDCS9TYFBNnmHOUhy+5Y6RDeM7S650l39uIg7CFMzgqVsTeLavUb
         tRy3q0+U2GDPeU7tGCfYQye7JFjfRJ8iN6euPxdMVftG6LzSEYMBHJd9BqyMOpFY2G
         GUjijiX0OUIRY6H+G4kdEb3okth1LkLkUlYFPZbj40EKcTugJMhew8AauQzJqt2CQ4
         GoaZrgLp7ukC6qONRfMshQoycYExFIFBGRUUJIoIoygKbwghAxs7Y4W5olp+1USBd4
         jFOU+73QxR+XA==
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        perex@perex.cz, linux-kernel@vger.kernel.org, linmq006@gmail.com,
        peter.ujfalusi@gmail.com
In-Reply-To: <20220512111331.44774-1-linmq006@gmail.com>
References: <20220512111331.44774-1-linmq006@gmail.com>
Subject: Re: [PATCH] ASoC: ti: j721e-evm: Fix refcount leak in j721e_soc_probe_*
Message-Id: <165280316539.1635268.5141203985086127855.b4-ty@kernel.org>
Date:   Tue, 17 May 2022 16:59:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 15:13:30 +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not needed anymore.
> Add missing of_node_put() to avoid refcount leak.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: j721e-evm: Fix refcount leak in j721e_soc_probe_*
      commit: a34840c4eb3278a7c29c9c57a65ce7541c66f9f2

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
