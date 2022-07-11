Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DF056D2F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiGKC2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKC2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:28:48 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1D99634F;
        Sun, 10 Jul 2022 19:28:46 -0700 (PDT)
Received: from [192.168.100.8] (unknown [223.106.33.172])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx39LXistio1kWAA--.12200S3;
        Mon, 11 Jul 2022 10:28:41 +0800 (CST)
Message-ID: <6561ae2c-64b4-bb60-39f0-e27eca306408@loongson.cn>
Date:   Mon, 11 Jul 2022 10:28:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 04/21] docs: zh_CN: page_migration: fix reference to mm
 index.rst
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Wu XiangCheng <bobwxc@email.cn>, linux-kernel@vger.kernel.org
References: <cover.1657360984.git.mchehab@kernel.org>
 <b263eef6480040befa582e8e00162e6fb4407853.1657360984.git.mchehab@kernel.org>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <b263eef6480040befa582e8e00162e6fb4407853.1657360984.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx39LXistio1kWAA--.12200S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1UtF13WF1DKr13Ar43ZFb_yoW8WFyxp3
        Wvkr4Igay3Aw15Cw4xWrW2kw1UA3WIga13Gr1DtwnYqFZ8Aw4vyrW3Kwn0g3Z3Jry0gFWD
        XFs5KryFk34jyw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkGb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j189NUUU
        UU=
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/9 18:07, Mauro Carvalho Chehab 写道:
> This got renamed, so we need to also rename at page_migration.rst.
>
> Fixes: ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/
>
>   Documentation/translations/zh_CN/mm/page_migration.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/mm/page_migration.rst b/Documentation/translations/zh_CN/mm/page_migration.rst
> index 566880a41ea0..ea9647d060fb 100644
> --- a/Documentation/translations/zh_CN/mm/page_migration.rst
> +++ b/Documentation/translations/zh_CN/mm/page_migration.rst
> @@ -1,6 +1,6 @@
>   .. include:: ../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/vm/index.rst
> +:Original: Documentation/mm/index.rst

Oops! I wrote it wrong. Let's use:

diff --git a/Documentation/translations/zh_CN/mm/page_migration.rst b/Documentation/translations/zh_CN/mm/page_migration.rst
index 566880a41ea0..076081dc1635 100644
--- a/Documentation/translations/zh_CN/mm/page_migration.rst
+++ b/Documentation/translations/zh_CN/mm/page_migration.rst
@@ -1,6 +1,6 @@
  .. include:: ../disclaimer-zh_CN.rst
  
-:Original: Documentation/vm/index.rst
+:Original: Documentation/mm/page_migration.rst
  
  :翻译:
  

Thanks,
Yanteng


>   
>   :翻译:
>   

