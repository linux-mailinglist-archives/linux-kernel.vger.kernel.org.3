Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA0B5357DD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiE0CwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiE0CwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A385B6B7E8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:52:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F33F61D78
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AD6C34116
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653619919;
        bh=OhUSVwwxmQWmtdYehk2z+rTsYhQelhX/UsHYByr0FqA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gNEFVg8VpES7qyfTs9UZK6a/EoBEP9rHRQZgrEb9ycWCsRkKYGQcitJrxcIQesWwO
         0W3H1SFpC4jZj8+ygsc9PQNI3vKBpZcIelWyuGscvzopoSKomwk26ZYwuTykV9ft2+
         x8LXguvGiqncljQE2maiMXdLJ7H0wuWA3ULhScIcQV993xXD28g0UR+LYwTce73E/K
         uJbUGVAlzPG7gXp6CBDuMJPQm1G3RSe7hkh3Y/B48abcUP8dkmZOJgTw7Wj9afu34c
         JgQdPPZ8IKtcw4NyWltlE/1ce/n26st3t2B+tyAeTS9497qeUNPSG0JJuulh6aX3k5
         MGG89ws7BKYxw==
Received: by mail-vk1-f181.google.com with SMTP id e144so1499248vke.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:51:59 -0700 (PDT)
X-Gm-Message-State: AOAM533cMJL4DmvQ6k4iR0CG+sRO6hImcHpiMdwHSOLQg0K54VRADBw8
        bht+OTS4GgZy/qxrQf3wu4MnPOeXvJKvPv/btss=
X-Google-Smtp-Source: ABdhPJyzoytGEgPaq6S94T0HlxJIxiV6vIsr0HjRiAqFC2P06wXo4MZ5JQvchtpJf2KygzwmAzX0onAw2PR63kBlVb8=
X-Received: by 2002:a1f:1f55:0:b0:357:a8d7:b76c with SMTP id
 f82-20020a1f1f55000000b00357a8d7b76cmr9159707vkf.35.1653619918334; Thu, 26
 May 2022 19:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220526205646.258337-1-heiko@sntech.de> <20220526205646.258337-3-heiko@sntech.de>
In-Reply-To: <20220526205646.258337-3-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 27 May 2022 10:51:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTSd-XJiSQcS=dY5YTSL_V4wJQb+e7yRywNsrTfLstQfA@mail.gmail.com>
Message-ID: <CAJF2gTTSd-XJiSQcS=dY5YTSL_V4wJQb+e7yRywNsrTfLstQfA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] riscv: Improve description for RISCV_ISA_SVPBMT
 Kconfig symbol
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Nick Kossifidis <mick@ics.forth.gr>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Fri, May 27, 2022 at 4:57 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> This improves the symbol's description to make it easier for
> people to understand what it is about.
>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Suggested-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/Kconfig | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 65285b980134..a4b299ad4473 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -356,8 +356,13 @@ config RISCV_ISA_SVPBMT
>         select RISCV_ALTERNATIVE
>         default y
>         help
> -          Adds support to dynamically detect the presence of the SVPBMT extension
> -          (Supervisor-mode: page-based memory types) and enable its usage.
> +          Adds support to dynamically detect the presence of the SVPBMT
> +          ISA-extension (Supervisor-mode: page-based memory types) and
> +          enable its usage.
> +
> +          The memory type for a page contains a combination of attributes
> +          that indicate the cacheability, idempotency, and ordering
> +          properties for access to that page.
>
>            The SVPBMT extension is only available on 64Bit cpus.
>
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
