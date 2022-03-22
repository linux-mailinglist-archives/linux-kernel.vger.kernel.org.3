Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62E54E3F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiCVNUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiCVNUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:20:36 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F8F65D0E;
        Tue, 22 Mar 2022 06:19:05 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E2E283201487;
        Tue, 22 Mar 2022 09:19:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 22 Mar 2022 09:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=Iq17f1d6WDzZIj
        +LCJ2gSlurEnU5chlu8q4xCYvcv4w=; b=zNrv8VHNtBwtTaBqt7m5brV09gqhoB
        ioyy/DExZO4OgVoMTK1/SZUW9HI3LWcibrJMimy+mxmKoXOruzytcBJhhyR4+EnP
        dPGWq3rqFjczc/In7Q7MSUIP7LveGlm6fmJDABgrPahrWsFii6bevbYc3umHLINr
        sEYhiJpS++QDmTE4YqjucxRoX9si+WKMfAri5lsD/j7vJWQMDko+ZWmYyGVWy7i8
        94c8kjUWccMvhSy2y/lha1kwayE9lB+U3DLkHIHTvYmX93V7ypHkcpQ4F3QAh3wH
        jCTirsE9fripT7KIciiqk/7aTrotpZDpOPwIvduzOqKZGpqleswL2QWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Iq17f1d6WDzZIj+LCJ2gSlurEnU5chlu8q4xCYvcv
        4w=; b=GG4iMedJ8xu2rfi4ILWyTPnLQxQsc2s6hvxfOQme/th7M4EHjUv63KSUu
        uFkvZCPAJTdJwzVqcrvlFEsuzTmJFXhYSl5JgKmpZ01ovyF2XWmBKu4HLCJT/d8l
        qVbrkMXXGpZXvjjlYlHXsUqG+7mmrlPK9jMG31MGiJNgfdJxvvOjRntpS6GCoFl6
        tlsuE2ETc1xKlNxwXGptI7GUM35pcc9+VM6wBIkdY1PIIARgnBmzY9SC7ekUXSUc
        NUDgVJ2ilGXAXJwdKC5DHcdyrOqLuLfC7V3LQ90ojyD1aoUq9uOYEemp5mhbuG9Y
        4ds9q9dWzACv3600VW008qc/TKLiQ==
X-ME-Sender: <xms:x8w5Yjio8oVmu6_RQL1HdG1H4hTSy0HMtmypXGQZBfrX1T6yyQ8diQ>
    <xme:x8w5YgAMCvewIA0KOSH6aKjmScJ-ETXevwzb74ti1Ze4yHXuE1rGNi1JOv_jOA3JC
    nZr_AxnIcCY5OBRQ0w>
X-ME-Received: <xmr:x8w5YjF0bz17ssSAxM4Zwp7vwj4WpTrlmrpU2IEvUisdGhrCsl3qHXIrvTRRi-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeghedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeehieduvdevhfekjeeftddtkeeitefhudekvdeiueeulefgleei
    jeeghedvkeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:x8w5YgTr5ypXqvvik-ypru-mLlNUsaJo9Tlf7l58kOH44xKwTohecA>
    <xmx:x8w5Ygxt2P2b-rD0dwYU82-2fdehopj1635eKkjFK5JJXl2qmafw5g>
    <xmx:x8w5Ym7SFfdFya5ODRWoDQN8yQgxZI_8hPRStW8sOV11dTiDXfzzbg>
    <xmx:yMw5Ys_XEAlbAXolqjomnU-PsW9vsWL96X_fq5lo7E6PI8uiaeCoNA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Mar 2022 09:19:02 -0400 (EDT)
Message-ID: <33241bd3-2f12-954c-6701-56cf563060bb@flygoat.com>
Date:   Tue, 22 Mar 2022 13:19:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] MIPS: Use memblock_add_node() in early_parse_mem()
 under CONFIG_NUMA
Content-Language: en-GB
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1647615920-23103-1-git-send-email-yangtiezhu@loongson.cn>
 <1647615920-23103-4-git-send-email-yangtiezhu@loongson.cn>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <1647615920-23103-4-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/3/18 15:05, Tiezhu Yang 写道:
> Use memblock_add_node to add new memblock region within a NUMA node
> in early_parse_mem() under CONFIG_NUMA, otherwise the mem parameter
> can not work well.

Hi Tiezhu,

pa_to_nid doesn't exist when CONFIG_NUME is disabled.
So probably you want #ifdef macro instead ？

Thanks.
- Jiaxun

>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/mips/kernel/setup.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index c8c8f60..50cdc08 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -37,6 +37,7 @@
>   #include <asm/cdmm.h>
>   #include <asm/cpu.h>
>   #include <asm/debug.h>
> +#include <asm/mmzone.h>
>   #include <asm/sections.h>
>   #include <asm/setup.h>
>   #include <asm/smp-ops.h>
> @@ -378,7 +379,10 @@ static int __init early_parse_mem(char *p)
>   			memblock_end_of_DRAM() - memblock_start_of_DRAM());
>   	}
>   
> -	memblock_add(start, size);
> +	if (IS_ENABLED(CONFIG_NUMA))
> +		memblock_add_node(start, size, pa_to_nid(start), MEMBLOCK_NONE);
> +	else
> +		memblock_add(start, size);
>   
>   	return 0;
>   }

