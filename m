Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81DD552895
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 02:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242593AbiFUAUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 20:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiFUAUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 20:20:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A001B7A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 17:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+YmNWCks1/dJwdziGRo9iF81qlkyopZV7A3y12cRD8Q=; b=jmkMy0ad2ZGddc0G6w2baHEa2t
        Nq8Lj3XdxuW/EOYuKhhfkWYOgVLAo+YSJVC2RQr7CRtMsp+J1ZZnlbgEXcE1ukfIit1L1QzkPvjbg
        jnc2jmGG9O7Pri8bwjX44ZNU0sJ5zzMCjCNkQm4tptRwlc+HuYko7EYUpU7UbudzT0hTMC7YCD0AP
        +x/RSXsYIwJWPmE0l+4mxwo5KeXGrbDKLWTl8LQUTZ2CW4GjP38xMtqB52QfRMOTQOVGehVrd18CX
        taoBu/yjO7E6uVhqee4tUsxZkfPa1kMxr0X1hmEbpLFPqCXM3ME3KlsmU7jUk1Qq4g+5rkj0Qg6mM
        PcbPuqCA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3RbE-00A1Mv-VO; Tue, 21 Jun 2022 00:19:08 +0000
Message-ID: <0225146b-9331-8ed2-3e14-24441f4eb298@infradead.org>
Date:   Mon, 20 Jun 2022 17:18:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 4/6] rslib: Fix kernel-doc style for rs_modnn()
Content-Language: en-US
To:     Zhang Boyang <zhangboyang.id@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>
References: <20220620062015.15612-1-zhangboyang.id@gmail.com>
 <20220620062015.15612-5-zhangboyang.id@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220620062015.15612-5-zhangboyang.id@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/22 23:20, Zhang Boyang wrote:
> This patch fixes the style of kernel-doc of rs_modnn().
> 
> Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/rslib.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/rslib.h b/include/linux/rslib.h
> index cd0b5a7a5698..e92923fff3bc 100644
> --- a/include/linux/rslib.h
> +++ b/include/linux/rslib.h
> @@ -107,7 +107,8 @@ struct rs_control *init_rs_non_canonical(int symsize, int (*func)(int),
>  /* Release a rs control structure */
>  void free_rs(struct rs_control *rs);
>  
> -/** modulo replacement for galois field arithmetics
> +/**
> + * rs_modnn() - Modulo replacement for galois field arithmetics
>   *
>   *  @rs:	Pointer to the RS codec
>   *  @x:		the value to reduce

-- 
~Randy
