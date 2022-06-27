Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0D55D3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235254AbiF0NRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiF0NRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:17:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 579481260B;
        Mon, 27 Jun 2022 06:14:35 -0700 (PDT)
Received: from [192.168.100.8] (unknown [112.20.112.134])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxSeQ2rbliIAdgAA--.6503S3;
        Mon, 27 Jun 2022 21:14:31 +0800 (CST)
Message-ID: <56df3676-6408-04e5-8b88-31df7841be5a@loongson.cn>
Date:   Mon, 27 Jun 2022 21:14:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 09/20] docs: zh_CN/vm/index.rst: fix a broken reference
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Tang Yizhou <tangyizhou@huawei.com>,
        linux-kernel@vger.kernel.org
References: <cover.1656234456.git.mchehab@kernel.org>
 <ee45d72ff3e3b2ba8245fa01a35a46fed72664c3.1656234456.git.mchehab@kernel.org>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <ee45d72ff3e3b2ba8245fa01a35a46fed72664c3.1656234456.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxSeQ2rbliIAdgAA--.6503S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWkGF4ruw4UJry8JFyDtrb_yoW8Aw4kpF
        1DKrySga13Jw1UC3y8G3y7C3W5Wan7uay3GF4DGw1FkrZxJ3yvyrZ2vrZ0gas3WryI9FWU
        XFZavF1vk34jyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkI
        ecxEwVAFwVW5GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07jOqXdUUUUU=
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/6/26 17:10, Mauro Carvalho Chehab 写道:
> The reference is missing a .rst on it, causing its cross-reference
> to not work.
>
> Fixes: 9c3519d2b509 ("docs/zh_CN: add vm/index translation")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/
>
>   Documentation/translations/zh_CN/vm/index.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/vm/index.rst b/Documentation/translations/zh_CN/vm/index.rst
> index a1c6d529b6ff..81a9b782a427 100644
> --- a/Documentation/translations/zh_CN/vm/index.rst
> +++ b/Documentation/translations/zh_CN/vm/index.rst
> @@ -15,7 +15,7 @@ Linux内存管理文档
>   这是一个关于Linux内存管理（mm）子系统内部的文档集，其中有不同层次的细节，包括注释
>   和邮件列表的回复，用于阐述数据结构和算法的基本情况。如果你正在寻找关于简单分配内存的建
>   议，请参阅(Documentation/translations/zh_CN/core-api/memory-allocation.rst)。
> -对于控制和调整指南，请参阅(Documentation/admin-guide/mm/index)。
> +对于控制和调整指南，请参阅(Documentation/admin-guide/mm/index.rst)。

Thanks, This index has been refactored.

<https://lore.kernel.org/all/35d10864fb9b57bf288d4efa5642f93a60079029.1655362610.git.siyanteng@loongson.cn/>


Thanks,

Yanteng

>   TODO:待引用文档集被翻译完毕后请及时修改此处）
>   
>   .. toctree::

