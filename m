Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D224D85C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241554AbiCNNLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiCNNLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:11:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3DA26E6;
        Mon, 14 Mar 2022 06:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6936661181;
        Mon, 14 Mar 2022 13:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD52C340F4;
        Mon, 14 Mar 2022 13:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647263416;
        bh=OBsH32SjfImTKdIFeqvuOy2qDlC46bBa8wDT6FSKdbM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DAVj1ByBt79KtNtPHtU5zXvZRDutA5kApkHANV/eigsree1RcJAEuSX6H4IYyb2aW
         vYNIA52qquCy91eM4cnDHyMhx/806ak8xEjzbKL++6rzx+LSLP/ejxcu9ET/DVcNRp
         KBALhthOq0JA6VPFJrDRrvAAsxH/ZxmqSNV4MUphu1tJNCtSfHqTApO4PkYWGjwbMV
         Xp+zb+EdiqsR7Zx14HYkLLLiPFcM1c5ONLwazaLSSgoBbqDHyy4GFrnR60z360RqRA
         oCDCGrJ2oxrNDMUx6+KVJ5SUDAl+HBLpjSL4zFScwIBFW/NSYCKGVLPKoDN74lFdqA
         TkBaZomph875w==
Date:   Mon, 14 Mar 2022 14:10:08 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Hugues FRUCHET - FOSS <hugues.fruchet@foss.st.com>
Cc:     Alain Volmat <alain.volmat@foss.st.com>,
        Niklas =?UTF-8?B?U8O2ZGVybHVu?= =?UTF-8?B?ZA==?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitriy Ulitin <ulitin@ispras.ru>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 17/24] media: platform: rename stm32/ to sti/stm32/
Message-ID: <20220314141008.13e32acd@coco.lan>
In-Reply-To: <1122a956-0650-f948-512b-d3447e34df30@foss.st.com>
References: <cover.1647167750.git.mchehab@kernel.org>
        <dc5be62a56ac19c6f49f4c8432558fd7b0efe7e6.1647167750.git.mchehab@kernel.org>
        <20220314083942.GA526468@gnbcxd0016.gnb.st.com>
        <20220314121454.7432e231@coco.lan>
        <1122a956-0650-f948-512b-d3447e34df30@foss.st.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 14 Mar 2022 12:34:47 +0100
Hugues FRUCHET - FOSS <hugues.fruchet@foss.st.com> escreveu:

> Hi Mauro,
> 
> Ideally we would like to stick to sti/ and stm32/ at same level, as it 
> is done in various other locations:
> 
> ./Documentation/arm/sti/
> ./Documentation/arm/stm32/
> 
> ./arch/arm/mach-sti
> ./arch/arm/mach-stm32
> 
> ./drivers/media/cec/platform/sti/
> ./drivers/media/cec/platform/stm32/
> 
> ./drivers/gpu/drm/sti/
> ./drivers/gpu/drm/stm/
> 
> ./sound/soc/sti/
> ./sound/soc/stm/
> 
> Is this possible to keep those media folders as is ?

If we add them under:
	./drivers/media/platform/stm/sti/
	./drivers/media/platform/stm/stm32/

They'll both be at the same level. 

It has been increasingly hard to maintain media/platform, as the file
become too big and disorganized. Sorting it per-vendor seems to be the
best thing, as it will keep things better organized. 

As a side effect, with such kind of change, it is now possible to 
have a MAINTAINERS entry that would point to a mailing list and/or 
some SoC maintainers/reviewers that should be c/c to all patches 
affecting drivers/media/platform/<vendor>.

Thanks,
Mauro
