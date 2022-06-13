Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A98E547ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 07:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiFMFKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 01:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiFMFKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 01:10:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524302612A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 22:09:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C93AF61232
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19C3C34114;
        Mon, 13 Jun 2022 05:09:56 +0000 (UTC)
Message-ID: <eb17d321-c16f-5c03-40c3-3ad5f523827f@linux-m68k.org>
Date:   Mon, 13 Jun 2022 15:09:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH -next] m68k: coldfire: make symbol m523x_clk_lookup static
Content-Language: en-US
To:     Wang Jingjin <wangjingjin1@huawei.com>, geert@linux-m68k.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Cc:     zhengbin13@huawei.com, gaochao49@huawei.com
References: <20220610020755.187733-1-wangjingjin1@huawei.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20220610020755.187733-1-wangjingjin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On 10/6/22 12:07, Wang Jingjin wrote:
> Fix sparse warnings:
> 
> arch/m68k/coldfire/m523x.c:31:19: sparse: sparse: symbol 'm523x_clk_lookup' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Jingjin <wangjingjin1@huawei.com>

Thanks. Added to the m68knommu git tree, for-next branch.

Regards
Greg


> ---
>   arch/m68k/coldfire/m523x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/coldfire/m523x.c b/arch/m68k/coldfire/m523x.c
> index 193c178162c1..83a997313393 100644
> --- a/arch/m68k/coldfire/m523x.c
> +++ b/arch/m68k/coldfire/m523x.c
> @@ -28,7 +28,7 @@
>   DEFINE_CLK(pll, "pll.0", MCF_CLK);
>   DEFINE_CLK(sys, "sys.0", MCF_BUSCLK);
> 
> -struct clk_lookup m523x_clk_lookup[] = {
> +static struct clk_lookup m523x_clk_lookup[] = {
>   	CLKDEV_INIT(NULL, "pll.0", &clk_pll),
>   	CLKDEV_INIT(NULL, "sys.0", &clk_sys),
>   	CLKDEV_INIT("mcfpit.0", NULL, &clk_pll),
> --
> 2.25.1
> 
