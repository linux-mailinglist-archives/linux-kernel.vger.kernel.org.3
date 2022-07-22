Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413EA57D8B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbiGVCl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiGVCl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:41:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A312868A2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CE35B8262D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D27C341C6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658457713;
        bh=xavck+mfMP0z5ZogTwR3JahixUh3QtLQC7XQ95ds+s4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RGPZQ+JOTZy9DExehtfHBMU6uUSrn/iSwMM4exLjNqIyFFOLnoyWY8W8+F4AXr6M6
         tvacNhWotErN1SL2YXw7AlFoVIv60QRxHlFge9V7NySlktLRLIrGk11g6uJM0bqK0U
         a4PoUGGgsg/dAnwLTnZC2DsRgwP1dy8EKH2n93ygfI9yrdfK/a+AJ2BqK2jPCVGNre
         Q4n82gFd8Qhh4rxIU3/S8qss85PXr4q88GKrRpreRJjs4T3YAffZ97En7I6LzOYgA2
         VevKqXz2OojziVOIc5oBuFk3UGNGDDeZbSviT+au33MMHmkhstNEAfXUtcORSdICOv
         dpl7NZxtEg8uA==
Received: by mail-vk1-f172.google.com with SMTP id o10so1545096vkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:41:53 -0700 (PDT)
X-Gm-Message-State: AJIora/Q/SK98jY8t9E8RPxNDfcDmNVkDL/Hpg2ARLoDCaUtf+wfKoB4
        s7lXUMXL4z9b2Oj+fER8w6kUx6Aljps8zkdifNY=
X-Google-Smtp-Source: AGRyM1vifaQjeModGQlhpHoldb4kZ4m5SMkqNhmlkPGitXKFguWl9MbPd4msopVtdHO4VzFyF9V7eyUA1i0RR4I6PxM=
X-Received: by 2002:a1f:a887:0:b0:36c:8458:b061 with SMTP id
 r129-20020a1fa887000000b0036c8458b061mr412967vke.19.1658457712542; Thu, 21
 Jul 2022 19:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220722004231.91114-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220722004231.91114-1-yang.lee@linux.alibaba.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 22 Jul 2022 10:41:39 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Ap=3UvnZsXwiYsX-WtuyP9i25j1oCT-fY9JRnDGvihA@mail.gmail.com>
Message-ID: <CAAhV-H7Ap=3UvnZsXwiYsX-WtuyP9i25j1oCT-fY9JRnDGvihA@mail.gmail.com>
Subject: Re: [PATCH -next] LoongArch: Fix unsigned comparison with less than zero
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yang Li,

Thank you for your patch. This looks good to me and will be queued for
5.20, since Marc said he will not rebase his branch. :)

Huacai

On Fri, Jul 22, 2022 at 8:42 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> The return from the call to get_timer_irq() is int, it can be
> a negative error code, however this is being assigned to an
> unsigned int variable 'irq', so making 'irq' an int.
>
> Eliminate the following coccicheck warning:
> ./arch/loongarch/kernel/time.c:146:5-8: WARNING: Unsigned expression compared with zero: irq < 0
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/loongarch/kernel/time.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/time.c b/arch/loongarch/kernel/time.c
> index 79dc5eddf504..786735dcc8d6 100644
> --- a/arch/loongarch/kernel/time.c
> +++ b/arch/loongarch/kernel/time.c
> @@ -135,7 +135,7 @@ static int get_timer_irq(void)
>
>  int constant_clockevent_init(void)
>  {
> -       unsigned int irq;
> +       int irq;
>         unsigned int cpu = smp_processor_id();
>         unsigned long min_delta = 0x600;
>         unsigned long max_delta = (1UL << 48) - 1;
> --
> 2.20.1.7.g153144c
>
