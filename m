Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEF14DCA38
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiCQPmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiCQPmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:42:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036D720D8AE;
        Thu, 17 Mar 2022 08:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A1773B81E9E;
        Thu, 17 Mar 2022 15:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A52FC340E9;
        Thu, 17 Mar 2022 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647531656;
        bh=rWIaBvO//2xmfb9yyG1aQcd+fBgMES6AnK2ION38dqk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KHdnYZs01KcJfISh18HVHnO0j2edeKjkvZ5wizRgMjNYu3c7EMLD+ztQEd3xkIgni
         W/SxXICteDSysFO1jih5fglDQQdHcg+Q7HrDJL31KYbJM599PuRGw3qKxoApsgmDJO
         9y8ESbY7l2ZGV8wo217JBAnmgK7jxr/evIxOdZJrwJ66qXSWOMfEpoRzDyN44/Fv9e
         i8jTZ3gBJbemDYvdzYhcWXv5Uqu7sDCuvBdL24fYSy9R4bjfIDbM/X+elTG8eTaHAN
         ifW1nHAvaZUnsbCWxtV5rq6m5bizgLYsDLpKRJa9q5LXqPLtj+xMwDlKGuBhlaVJO3
         09ZjOO7E6fTNw==
Received: by mail-ua1-f42.google.com with SMTP id t40so1869246uad.2;
        Thu, 17 Mar 2022 08:40:56 -0700 (PDT)
X-Gm-Message-State: AOAM5303f5aLwwoxU/gDfLSdDxnf1cQY93X94Msr5bq4b9ayGCxoW6TZ
        5+vfFtQD+Rrk6EbFB8H7Kmjy4NM5c78VIr44B0o=
X-Google-Smtp-Source: ABdhPJxEJnImsdSQdAc5KBTf26/XRjA9fUefxAiwA2dm9CHBpIffqMejSrTmnKCZHpU2asmR+3vRKeBjS0Ee95ACLCo=
X-Received: by 2002:ab0:2883:0:b0:350:e1c0:72b7 with SMTP id
 s3-20020ab02883000000b00350e1c072b7mr1865809uap.83.1647531655238; Thu, 17 Mar
 2022 08:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <1647487284-30088-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1647487284-30088-1-git-send-email-baihaowen@meizu.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 17 Mar 2022 23:40:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRXH=oDpfogaT6WgwOmvECRb4BiGr0DQULf5JkbS7YYMA@mail.gmail.com>
Message-ID: <CAJF2gTRXH=oDpfogaT6WgwOmvECRb4BiGr0DQULf5JkbS7YYMA@mail.gmail.com>
Subject: Re: [PATCH] irqchip: Return true/false (not 1/0) from bool functions
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's my coding conventions' problem, thx for pointing out.

Acked-by: Guo Ren <guoren@kernel.org>

On Thu, Mar 17, 2022 at 11:21 AM Haowen Bai <baihaowen@meizu.com> wrote:
>
> Return boolean values ("true" or "false") instead of 1 or 0 from bool
> functions.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/irqchip/irq-csky-apb-intc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
> index d36f536..42d8a24 100644
> --- a/drivers/irqchip/irq-csky-apb-intc.c
> +++ b/drivers/irqchip/irq-csky-apb-intc.c
> @@ -136,11 +136,11 @@ static inline bool handle_irq_perbit(struct pt_regs *regs, u32 hwirq,
>                                      u32 irq_base)
>  {
>         if (hwirq == 0)
> -               return 0;
> +               return false;
>
>         generic_handle_domain_irq(root_domain, irq_base + __fls(hwirq));
>
> -       return 1;
> +       return true;
>  }
>
>  /* gx6605s 64 irqs interrupt controller */
> --
> 2.7.4
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
