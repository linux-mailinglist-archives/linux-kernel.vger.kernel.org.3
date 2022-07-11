Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1EA56D2FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiGKCc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGKCc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:32:58 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C12B638C;
        Sun, 10 Jul 2022 19:32:56 -0700 (PDT)
Received: from [192.168.100.8] (unknown [223.106.33.172])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax+eDWi8tialsWAA--.52709S3;
        Mon, 11 Jul 2022 10:32:54 +0800 (CST)
Message-ID: <2617617a-286a-dd3d-ee87-cec84b013b01@loongson.cn>
Date:   Mon, 11 Jul 2022 10:32:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 02/21] docs: update vmalloced-kernel-stacks.rst
 reference
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Wu XiangCheng <bobwxc@email.cn>, linux-kernel@vger.kernel.org
References: <cover.1657360984.git.mchehab@kernel.org>
 <71f4ccf95aa2de93be469b1e64606f9fc16dcaa2.1657360984.git.mchehab@kernel.org>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <71f4ccf95aa2de93be469b1e64606f9fc16dcaa2.1657360984.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Ax+eDWi8tialsWAA--.52709S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1UKw45XF18tw43ZrykuFg_yoW8XrW7pF
        1DKr1xt3Zxtw17Kw48Xw42kFy2ya1kuF43GwnxJwnYvrnFyw4Ikws0g393XasFv340kFWj
        qFn3K345Kw4jy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
        xK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x07jbBMtUUUUU=
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
> Changeset ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
> renamed: Documentation/vm/vmalloced-kernel-stacks.rst
> to: Documentation/mm/vmalloced-kernel-stacks.rst.
>
> Update its cross-reference accordingly.
>
> Fixes: ee65728e103b ("docs: rename Documentation/vm to Documentation/mm")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Yanteng Si <siyanteng@loongson.cn>


Thanks,

Yanteng


> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/
>
>   Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst b/Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst
> index ad23f274f6d7..d02a23f7f07e 100644
> --- a/Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst
> +++ b/Documentation/translations/zh_CN/mm/vmalloced-kernel-stacks.rst
> @@ -1,7 +1,7 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   .. include:: ../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/vm/vmalloced-kernel-stacks.rst
> +:Original: Documentation/mm/vmalloced-kernel-stacks.rst
>   
>   :翻译:
>   

