Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DA955DBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiF0Oym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiF0Oyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:54:40 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FC2115A21;
        Mon, 27 Jun 2022 07:54:36 -0700 (PDT)
Received: from [192.168.100.8] (unknown [112.20.112.134])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX9enxLlinxxgAA--.5695S3;
        Mon, 27 Jun 2022 22:54:31 +0800 (CST)
Message-ID: <00688b96-a194-71e6-726a-15ee949e7648@loongson.cn>
Date:   Mon, 27 Jun 2022 22:54:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 07/20] docs: zh_CN/vm: fix a typo for page reporting
 ReST file
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Shi <alexs@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1656234456.git.mchehab@kernel.org>
 <c7db8f975f461eaebd7ea7489ff9666d89e121c6.1656234456.git.mchehab@kernel.org>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <c7db8f975f461eaebd7ea7489ff9666d89e121c6.1656234456.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxX9enxLlinxxgAA--.5695S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWfZr17uFyDtFWDZF4rAFb_yoW8CryrpF
        ykKr92ga42yw15G347Gw47Cw18ZF4xGa1UCryUtw4rWrsxJ3W0yr40kF90ga9xXr1vqFZI
        9F4SkF90g34jyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkI
        ecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUc73kDUUUU
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
> typo:
> 	_free_page_reporting.rst -> free_page_reporting.rst
>
> Fixes: 9859b277bffe ("docs/zh_CN: add vm frontswap translation")
> Fixes: adeacecbd36c ("docs/zh_CN: add free_page_reporting translation")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Yanteng Si<siyanteng@loongson.cn>

Thanks,
Yanteng

> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1656234456.git.mchehab@kernel.org/
>
>   Documentation/translations/zh_CN/vm/free_page_reporting.rst | 2 +-
>   Documentation/translations/zh_CN/vm/frontswap.rst           | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/vm/free_page_reporting.rst b/Documentation/translations/zh_CN/vm/free_page_reporting.rst
> index 31d6c34b956b..14336a3aa5f4 100644
> --- a/Documentation/translations/zh_CN/vm/free_page_reporting.rst
> +++ b/Documentation/translations/zh_CN/vm/free_page_reporting.rst
> @@ -1,6 +1,6 @@
>   .. include:: ../disclaimer-zh_CN.rst
>   
> -:Original: Documentation/vm/_free_page_reporting.rst
> +:Original: Documentation/vm/free_page_reporting.rst
>   
>   :翻译:
>   
> diff --git a/Documentation/translations/zh_CN/vm/frontswap.rst b/Documentation/translations/zh_CN/vm/frontswap.rst
> index 3eb07870e2ef..98aa6f581ea7 100644
> --- a/Documentation/translations/zh_CN/vm/frontswap.rst
> +++ b/Documentation/translations/zh_CN/vm/frontswap.rst
> @@ -1,4 +1,4 @@
> -:Original: Documentation/vm/_free_page_reporting.rst
> +:Original: Documentation/vm/free_page_reporting.rst
>   
>   :翻译:
>   

