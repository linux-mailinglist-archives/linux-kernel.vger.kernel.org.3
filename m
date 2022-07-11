Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EDD56D2C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 03:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiGKBwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 21:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKBwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 21:52:00 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05055175B9;
        Sun, 10 Jul 2022 18:51:58 -0700 (PDT)
Received: from [192.168.100.8] (unknown [223.106.33.172])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Axf+I4gsti1ksWAA--.52029S3;
        Mon, 11 Jul 2022 09:51:54 +0800 (CST)
Message-ID: <c5d674f6-bc24-c3f4-ccf3-3e74bff011c7@loongson.cn>
Date:   Mon, 11 Jul 2022 09:51:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Documentation/translations/zh_CN/mm/page_owner.rst:
 adjust some words
To:     Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Cc:     alexs@kernel.org, corbet@lwn.net, rppt@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220708172351.20928-1-caoyixuan2019@email.szu.edu.cn>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <20220708172351.20928-1-caoyixuan2019@email.szu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Axf+I4gsti1ksWAA--.52029S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4DZF17WFyfCF48CFy5XFb_yoW8CFyfpr
        sF9a4xG3WFy3WF9a4fWw4xur18CF4xGF4UGFyUt345XFZ8A3s3KFyDKasFg3y7Gry8Xayj
        qr4fCr4DAF909FJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7GYLDUUUU
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/9 1:23, Yixuan Cao 写道:
> I noticed that there are some Chinese words that can be more accurate.
> So I fix them as follows.
>
> 首先，英文原文中的"release" 在这个语境下
> 是物理页面“释放”的意思，而不是“发布”。
> 其次，标准表的第一列和第二列，
> 表达的是“长短键”的意思，第一列是“短键”，
> 而第二列是“长键”。这样翻译或会更清晰一些。
>
> Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>

Acked-by: Yanteng Si<siyanteng@loongson.cn>


Thanks,

Yanteng

> ---
>   Documentation/translations/zh_CN/mm/page_owner.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/mm/page_owner.rst b/Documentation/translations/zh_CN/mm/page_owner.rst
> index 6514cb9e03da..b7f81d7a6589 100644
> --- a/Documentation/translations/zh_CN/mm/page_owner.rst
> +++ b/Documentation/translations/zh_CN/mm/page_owner.rst
> @@ -156,22 +156,22 @@ page owner在默认情况下是禁用的。所以，如果你想使用它，你
>   
>     --sort的选项:
>   
> -	键		键长		描述
> +	短键		长键		描述
>   	p		pid		进程ID
>   	tg		tgid		线程组ID
>   	n		name		任务命令名称
>   	st		stacktrace	页面分配的堆栈跟踪
>   	T		txt		块的全文
> -	ft		free_ts		页面发布时的时间戳
> +	ft		free_ts		页面释放时的时间戳
>   	at		alloc_ts	页面被分配时的时间戳
>   	ator		allocator	页面的内存分配器
>   
>     --curl的选项:
>   
> -	键		键长		描述
> +	短键		长键		描述
>   	p		pid		进程ID
>   	tg		tgid		线程组ID
>   	n		name		任务命令名称
> -	f		free		该页是否已经发布
> +	f		free		该页是否已经释放
>   	st		stacktrace	页面分配的堆栈跟踪
>   	ator		allocator	页面的内存分配器

