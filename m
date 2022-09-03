Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D435ABD97
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 09:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiICHKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 03:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiICHK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 03:10:28 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D11A5A146;
        Sat,  3 Sep 2022 00:10:26 -0700 (PDT)
Received: from [192.168.100.8] (unknown [112.20.110.237])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx72vY_RJjzl0QAA--.891S3;
        Sat, 03 Sep 2022 15:10:17 +0800 (CST)
Message-ID: <34c19e49-1752-9d8c-0766-2f55416c2f10@loongson.cn>
Date:   Sat, 3 Sep 2022 15:10:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] Documentation/zh_CN: add latest kmap_local_page
 translation
To:     Zhao Liu <zhao1.liu@linux.intel.com>, Alex Shi <alexs@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <bobwxc@email.cn>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
References: <20220902081304.2259706-1-zhao1.liu@linux.intel.com>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <20220902081304.2259706-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx72vY_RJjzl0QAA--.891S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF13Ww1ktF43KryDCw13XFb_yoWrAFyxpF
        929ry2gw43A342v3ySg342v3WrJ3W7GF42kFW7JasrX398A39Yy3y7KF98X3Z7Z3s7CFWx
        ArWUurn5Ar909wUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0g4fUUUUU=
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/2 16:13, Zhao Liu 写道:
> From: Zhao Liu <zhao1.liu@intel.com>
>
> Translate the lastest description of kmap_local_page into Chinese.
>
> The translation is based on these commits:
>
> commit 516ea046ec555 ("Documentation/mm: don't kmap*() pages which
> can't come from HIGHMEM")
>
> commit 6b3afe2eeec27 ("Documentation/mm: avoid invalid use of
> addresses from kmap_local_page()")
>
> commit 84b86f6054c42 ("Documentation/mm: rrefer kmap_local_page()
> and avoid kmap()")
>
> commit a9e9c93966afd ("Documentation/mm: add details about
> kmap_local_page() and preemption")
>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Acked-by: Yanteng Si <siyanteng@loongson.cn>
> ---
> Suggested by credits.
>          Ira: Referred to his task document.
>          Fabio: Referred to his work on the original English document.
>
> ---
>   .../translations/zh_CN/mm/highmem.rst         | 20 ++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/mm/highmem.rst b/Documentation/translations/zh_CN/mm/highmem.rst
> index f74800a6d9a7..ac4c86ed74d8 100644
> --- a/Documentation/translations/zh_CN/mm/highmem.rst
> +++ b/Documentation/translations/zh_CN/mm/highmem.rst
> @@ -58,14 +58,28 @@
>     在可行的情况下，这个函数应该比其他所有的函数优先使用。
>   
>     这些映射是线程本地和CPU本地的，这意味着映射只能从这个线程中访问，并且当映射处于活动状
> -  态时，该线程与CPU绑定。即使线程被抢占了（因为抢占永远不会被函数禁用），CPU也不能通过
> -  CPU-hotplug从系统中拔出，直到映射被处理掉。
> +  态时，该线程与CPU绑定。即使抢占永远不会被这个函数禁用，CPU也不能通过CPU-hotplug从系
> +  统中拔出，直到映射被处理掉。
>   
> -  在本地的kmap区域中采取pagefaults是有效的，除非获取本地映射的上下文由于其他原因不允许
> +  在本地的kmap区域中获取pagefaults是有效的，除非获取本地映射的上下文由于其他原因不允许
>     这样做。
>   
> +  如前所述，pagefault和抢占永远不会被禁用。不需要禁用抢占，因为当上下文切换到不同的任务
> +  时，传出任务的映射会被保存，而传入任务的映射会被恢复。
> +
>     kmap_local_page()总是返回一个有效的虚拟地址，并且假定kunmap_local()不会失败。
>   
> +  在CONFIG_HIGHMEM=n内核和低内存页面上，这将返回直接映射的虚拟地址。只有真正的高内存页
> +  面会被临时映射。因此，用户可以为已知不是来自ZONE_HIGHMEM的页面调用普通的
> +  page_address()，但是，使用kmap_local_page() / kunmap_local()总是安全的。
> +
> +  虽然它比kmap()快得多，但对于高内存情况，它带有指针有效性的限制。和kmap()映射相反，本地
> +  映射仅在调用者的上下文中有效，并不能被交给其他的上下文。这意味着用户必须绝对确保返回的地址
> +  仅在映射它的线程的本地使用。
> +
> +  大多数代码可以设计为使用线程本地映射。因此，用户应该尝试这样去设计他们的代码，在地址会被使
> +  用的同一线程中映射页面来避免使用kmap()，并且更倾向于去使用kmap_local_page()。
> +
>     嵌套kmap_local_page()和kmap_atomic()映射在一定程度上是允许的（最多到KMAP_TYPE_NR），
>     但是它们的调用必须严格排序，因为映射的实现是基于堆栈的。关于如何管理嵌套映射的细节，
>     请参见kmap_local_page() kdocs（包含在 "函数 "部分）。

