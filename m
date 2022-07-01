Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A44562956
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiGAC7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiGAC7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:59:06 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E9E13FB2;
        Thu, 30 Jun 2022 19:59:06 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b125so954821qkg.11;
        Thu, 30 Jun 2022 19:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w8jtgJk8lKmi1lh7Z/FaMsrSXu4qJRNfOEHwq2z+9Cw=;
        b=B73s0lzLR4OhX1ScC5Ahw5BOXS88W2mhi5JkKvKhgxp6s4EYkGEFJWytem7La14+OK
         fnKy+60m4odwLoeHGXgNkfaxHc3NHneTeOW3T2XrScSd/zxE9p1cCkFXd0is/ArlshU7
         SmE/bzHE+2eqUuKP7IaiWgYSDZueQdNk7wBC9xO0JryxKjCmWgbUUvg7iCets+aFRvPZ
         FN9BKN/v0ifLLxbVVeptR5mnju3UhyFAjZKaXFUJfKRWporDvb87bYE6haX0fHGITJn2
         4lLbKGyjqziuyLFGxfiAhbXLSPTPr0U6Wb6KaUsNDH/rhII6neNf9A08ArYiX4zarufJ
         93+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w8jtgJk8lKmi1lh7Z/FaMsrSXu4qJRNfOEHwq2z+9Cw=;
        b=8H1wPgtiwo2e9V3izbzsLKGt6tNfQhdVb2+849Tvg6lgetUyoLGJqkqfhUz1NgKjHo
         PPCMvfrRtTyqI94pkhn69FCPlHTwnuqaGLs7NXKJn5aioSg91Run2538CJBongRoq4mf
         rqWjbEitpps7GJH9gLcR2JM5cQ11xGKIqPU1HfW+uHk41pdYw4w3YoDFMbBbPwf3ViPU
         pTrZCBgvgL4bGluWPOCEq+B/wUcifOFDu1SY3lXbkWa5NKxFQFJVaJwzmpQEvqi96Xw8
         mXJPjn/qB3VOE3caYFrlNp5MZa2DURvPvldQlGrcf8B1wKlk8IeApWRhHh/GOyf2jCb4
         FN5w==
X-Gm-Message-State: AJIora/UmQW+Wcpb8pumCTDUS0S8V+FswoPWA/U2QJ2xStTKw4nguXNm
        +y7TVwNUP3Zy8dyJ1+Mca+k=
X-Google-Smtp-Source: AGRyM1vkp0kNdpv+FyQWbvtcc+xRsjTPaBED7uHrXq1Gp/PTmDWpSU1p5viE+18bXplYf9BjspK5jQ==
X-Received: by 2002:a05:620a:294c:b0:6a7:4413:941b with SMTP id n12-20020a05620a294c00b006a74413941bmr9027281qkp.159.1656644345108;
        Thu, 30 Jun 2022 19:59:05 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:1dde:deb7:a57c:900d])
        by smtp.gmail.com with ESMTPSA id x2-20020ae9e902000000b006a6a6f148e6sm16454587qkf.17.2022.06.30.19.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 19:59:04 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:59:04 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexander Lobakin <alobakin@pm.me>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mao Bibo <maobibo@loongson.cn>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] mips: micro-optimize calculate_cpu_foreign_map()
Message-ID: <Yr5i+OCeb89YMNZw@yury-laptop>
References: <20220621144729.533026-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621144729.533026-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 07:47:29AM -0700, Yury Norov wrote:
> The inner loop in calculate_cpu_foreign_map() walks the whole
> cpumask to check if we have siblings for a given cpu.
> 
> We can just break after a 1st match and avoid useless traversing
> the rest of mask.
> 
> Loongarch has an identical function, so fix it here as well.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Ping?

> ---
> 
> It looks like loongarch copied quite a lot from arch/mips/kernel/smp.c.
> For loongarch folks: Guys, can you consider moving shared code into a
> shared file(s)?
> 
>  arch/loongarch/kernel/smp.c | 7 +++----
>  arch/mips/kernel/smp.c      | 7 +++----
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> index b8c53b755a25..c1c91df3c8ac 100644
> --- a/arch/loongarch/kernel/smp.c
> +++ b/arch/loongarch/kernel/smp.c
> @@ -463,17 +463,16 @@ static inline void set_cpu_core_map(int cpu)
>   */
>  void calculate_cpu_foreign_map(void)
>  {
> -	int i, k, core_present;
> +	int i, k;
>  	cpumask_t temp_foreign_map;
>  
>  	/* Re-calculate the mask */
>  	cpumask_clear(&temp_foreign_map);
>  	for_each_online_cpu(i) {
> -		core_present = 0;
>  		for_each_cpu(k, &temp_foreign_map)
>  			if (cpus_are_siblings(i, k))
> -				core_present = 1;
> -		if (!core_present)
> +				break;
> +		if (k >= nr_cpu_ids)
>  			cpumask_set_cpu(i, &temp_foreign_map);
>  	}
>  
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index 1d93b85271ba..a2ce641f5f18 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -115,17 +115,16 @@ static inline void set_cpu_core_map(int cpu)
>   */
>  void calculate_cpu_foreign_map(void)
>  {
> -	int i, k, core_present;
> +	int i, k;
>  	cpumask_t temp_foreign_map;
>  
>  	/* Re-calculate the mask */
>  	cpumask_clear(&temp_foreign_map);
>  	for_each_online_cpu(i) {
> -		core_present = 0;
>  		for_each_cpu(k, &temp_foreign_map)
>  			if (cpus_are_siblings(i, k))
> -				core_present = 1;
> -		if (!core_present)
> +				break;
> +		if (k >= nr_cpu_ids)
>  			cpumask_set_cpu(i, &temp_foreign_map);
>  	}
>  
> -- 
> 2.32.0
