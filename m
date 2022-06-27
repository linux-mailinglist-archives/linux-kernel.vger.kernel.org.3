Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653E255DF1B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbiF0Oye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiF0Oya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:54:30 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26FFF140E6;
        Mon, 27 Jun 2022 07:52:50 -0700 (PDT)
Received: from [192.168.100.8] (unknown [112.20.112.134])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxb906xLliVxxgAA--.6409S3;
        Mon, 27 Jun 2022 22:52:43 +0800 (CST)
Message-ID: <5b6be487-13ab-835a-fac3-768700421754@loongson.cn>
Date:   Mon, 27 Jun 2022 22:52:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 05/20] docs: zh_CN/devicetree: fix typos
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>,
        Huilong Deng <denghuilong@cdjrlc.com>,
        linux-kernel@vger.kernel.org
References: <cover.1656234456.git.mchehab@kernel.org>
 <b4ca010ef223ab9cb76e8caa0a3cde734e0b6b2f.1656234456.git.mchehab@kernel.org>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <b4ca010ef223ab9cb76e8caa0a3cde734e0b6b2f.1656234456.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dxb906xLliVxxgAA--.6409S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF17Ar4DGr4kCFWUtw4xWFg_yoW5Xw18pF
        92kFyxWF1Svr17W397WF4UGF4xJ3Wxuw45GF1UJw1FgFs8JryFyr9rt3yqg3W7Xr1xWay5
        XF4rKryFkr4vyF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkI
        ecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
        j0ksgUUUUU=
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/6/26 17:10, Mauro Carvalho Chehab 写道:
> The devicetree directory was using wrong case:
>
> 	Devicetree/ -> devicetree/
>
> Fixes: a17b0169f29b ("docs/zh_CN: add devicetree index translation")
> Fixes: c56481299df3 ("docs/zh_CN: add devicetree usage-model translation")
> Fixes: 09d4466d3f3c ("docs/zh_CN: add devicetree of_unittest translation")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Yanteng Si<siyanteng@loongson.cn>

Thanks,
Yanteng

> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/
>
>   Documentation/translations/zh_CN/devicetree/index.rst       | 2 +-
>   Documentation/translations/zh_CN/devicetree/of_unittest.rst | 2 +-
>   Documentation/translations/zh_CN/devicetree/usage-model.rst | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/devicetree/index.rst b/Documentation/translations/zh_CN/devicetree/index.rst
> index 23d0b6fccd58..3fc355fe0037 100644
> --- a/Documentation/translations/zh_CN/devicetree/index.rst
> +++ b/Documentation/translations/zh_CN/devicetree/index.rst
> @@ -1,7 +1,7 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   .. include:: ../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/Devicetree/index.rst
> +:Original: Documentation/devicetree/index.rst
>   
>   :翻译:
>   
> diff --git a/Documentation/translations/zh_CN/devicetree/of_unittest.rst b/Documentation/translations/zh_CN/devicetree/of_unittest.rst
> index abd94e771ef8..11eb08ca8866 100644
> --- a/Documentation/translations/zh_CN/devicetree/of_unittest.rst
> +++ b/Documentation/translations/zh_CN/devicetree/of_unittest.rst
> @@ -1,7 +1,7 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   .. include:: ../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/Devicetree/of_unittest.rst
> +:Original: Documentation/devicetree/of_unittest.rst
>   
>   :翻译:
>   
> diff --git a/Documentation/translations/zh_CN/devicetree/usage-model.rst b/Documentation/translations/zh_CN/devicetree/usage-model.rst
> index accdc33475a0..c6aee82c7e6e 100644
> --- a/Documentation/translations/zh_CN/devicetree/usage-model.rst
> +++ b/Documentation/translations/zh_CN/devicetree/usage-model.rst
> @@ -1,7 +1,7 @@
>   .. SPDX-License-Identifier: GPL-2.0
>   .. include:: ../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/Devicetree/usage-model.rst
> +:Original: Documentation/devicetree/usage-model.rst
>   
>   :翻译:
>   

