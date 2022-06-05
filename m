Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F78153DB33
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 12:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244316AbiFEKHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 06:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbiFEKHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 06:07:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAA15FAD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 03:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2653260EEC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AE7C3411E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654423629;
        bh=ClDK8782jY9SXch9/nyH9tnpj6Ro9WPrcn8dDhjremU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZP+U9V/KeOiwrTdGVqsw+FGbKLYJimnD7LuvtKgH5xSmT0VRzn1nZXZxaQgD+4mP7
         Vq9mkN7jbfQqE1GeLSiLENbYNrvUs35c1ptvtujeeXgm1s/VZE/0h38o0dhCLX9t0j
         2EKAwM16iyEVCPFGnn7C2fYr6K4ICBy2R3EybRWBB/yLxKIxKPIRRp6EYz4gv1ixJ7
         15b9Q24URIPErMqHbh3tLuRX5YbG7far6q7TsIZRgRE4bHz4bvigB1c8CX2zdLI8fo
         fNiOehGWQnfR6E6/z5Z90WWHzaoagf5zREm53Z5cU5Ov5s96HYDm9v62y3YYEDSFBd
         DuWDFZGhx3hOA==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2f83983782fso118866607b3.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 03:07:09 -0700 (PDT)
X-Gm-Message-State: AOAM533nZ5nLTjSro114nOTfaQqsSU2GKMTMDpBaCIUFbUL0OE1rKbKJ
        mgcEjVd2z0Z7gpo97G2Pmh0sg1sjHlylZ1pwSoY=
X-Google-Smtp-Source: ABdhPJxpQl8PzINQwhvhllNaZ67Overstnq0FM09HFOlnuaHvNGim/VqGoRXfyRRzLcZtmj2LhABSMKktYdRlSDjpTk=
X-Received: by 2002:a0d:f8c6:0:b0:2fe:ca9c:f937 with SMTP id
 i189-20020a0df8c6000000b002feca9cf937mr20855647ywf.62.1654423628632; Sun, 05
 Jun 2022 03:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220602035827.18012-1-jiapeng.chong@linux.alibaba.com> <20220602035827.18012-2-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220602035827.18012-2-jiapeng.chong@linux.alibaba.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 5 Jun 2022 13:06:41 +0300
X-Gmail-Original-Message-ID: <CAFCwf10dzga7D0KiSyat-B36xDbVssmukuHW0WUNvZ0RWmAjbg@mail.gmail.com>
Message-ID: <CAFCwf10dzga7D0KiSyat-B36xDbVssmukuHW0WUNvZ0RWmAjbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] habanalabs: Fix kernel-doc
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 6:58 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following W=1 kernel warnings:
>
> drivers/misc/habanalabs/common/mmu/mmu_v1.c:425: warning: expecting
> prototype for hl_mmu_fini(). Prototype was for hl_mmu_v1_fini() instead.
>
> drivers/misc/habanalabs/common/mmu/mmu_v1.c:449: warning: expecting
> prototype for hl_mmu_ctx_init(). Prototype was for hl_mmu_v1_ctx_init()
> instead.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/misc/habanalabs/common/mmu/mmu_v1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/mmu/mmu_v1.c b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
> index e2d91a69acc2..ad4b49281cd7 100644
> --- a/drivers/misc/habanalabs/common/mmu/mmu_v1.c
> +++ b/drivers/misc/habanalabs/common/mmu/mmu_v1.c
> @@ -412,7 +412,7 @@ static int hl_mmu_v1_init(struct hl_device *hdev)
>  }
>
>  /**
> - * hl_mmu_fini() - release the MMU module.
> + * hl_mmu_v1_fini() - release the MMU module.
>   * @hdev: habanalabs device structure.
>   *
>   * This function does the following:
> @@ -438,7 +438,7 @@ static void hl_mmu_v1_fini(struct hl_device *hdev)
>  }
>
>  /**
> - * hl_mmu_ctx_init() - initialize a context for using the MMU module.
> + * hl_mmu_v1_ctx_init() - initialize a context for using the MMU module.
>   * @ctx: pointer to the context structure to initialize.
>   *
>   * Initialize a mutex to protect the concurrent mapping flow, a hash to hold all
> --
> 2.20.1.7.g153144c
>

Both patches are
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>

Applied to -next.
Thanks,
Oded
