Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D544F59AAA9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 04:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiHTCUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 22:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241413AbiHTCUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 22:20:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AC94BD4D6;
        Fri, 19 Aug 2022 19:20:13 -0700 (PDT)
Received: from [192.168.100.8] (unknown [112.20.110.237])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrmvVRABjM4AFAA--.13028S3;
        Sat, 20 Aug 2022 10:20:06 +0800 (CST)
Message-ID: <727a1f6e-113b-3ba4-87ec-2ba568343089@loongson.cn>
Date:   Sat, 20 Aug 2022 10:20:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 04/13] docs: zh_CN: remove references to rust
 documentation
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        corbet@lwn.net
Cc:     Alex Shi <alexs@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1660829433.git.mchehab@kernel.org>
 <d0b2ead8c86cb1820695f400156b0be435aa7b74.1660829433.git.mchehab@kernel.org>
From:   YanTeng Si <siyanteng@loongson.cn>
In-Reply-To: <d0b2ead8c86cb1820695f400156b0be435aa7b74.1660829433.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxrmvVRABjM4AFAA--.13028S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF18Xry8Cw13uFy8Jry7Jrb_yoW8CF4rpF
        40kr4xGFyYyr1Yk34UWr47CFW8CayxWw43KFZrt34rXrnIkw4vvw4j93sF9as29rW8tFW7
        XF42vFyj9w1jvFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU8JCztUUUUU==
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/18 21:38, Mauro Carvalho Chehab 写道:
> There is a note on this file that, using a robot to translate,
> says:
>
> 	"The kernel-doc cannot contain Rust code: please refer
> 	 to Documentation/rust/general-information.rst."
>
> Such note doesn't exist at the original file anymore, so, just remove
> it from the translation, in order to solve this warning:
>
> 	Warning: Documentation/translations/zh_CN/doc-guide/kernel-doc.rst references a file that doesn't exist: Documentation/rust/general-information.rst
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Yanteng Si<siyanteng@loongson.cn>

Thanks,
Yanteng

> ---
>
> See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/
>
>   Documentation/translations/zh_CN/doc-guide/kernel-doc.rst | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
> index ccfb9b8329c2..9fd170faf951 100644
> --- a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
> @@ -14,8 +14,6 @@ Linux内核源文件可以包含kernel-doc格式的结构化文档注释，用
>             实际有着明显的不同。内核源包含成千上万个kernel-doc注释。请坚持遵循
>             此处描述的风格。
>   
> -.. note:: kernel-doc无法包含Rust代码：请参考 Documentation/rust/general-information.rst 。
> -
>   从注释中提取kernel-doc结构，并从中生成适当的 `Sphinx C 域`_ 函数和带有锚点的
>   类型描述。这些注释将被过滤以生成特殊kernel-doc高亮和交叉引用。详见下文。
>   

