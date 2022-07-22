Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4D957DB26
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiGVHRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiGVHRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:17:34 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE80936B6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:16:32 -0700 (PDT)
Received: from [10.20.42.19] (unknown [10.20.42.19])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX+PKTtpiXGAuAA--.2939S3;
        Fri, 22 Jul 2022 15:16:26 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: Remove LOONGARCH_CPUCFG48 and some CSR
 definitions
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1658305979-2073-1-git-send-email-yangtiezhu@loongson.cn>
 <fc5a891d-e5a9-c02d-08e0-318213cde8f4@loongson.cn>
From:   Jianmin Lv <lvjianmin@loongson.cn>
Message-ID: <6ccd15ed-bbed-18fd-ec97-510d2150c27c@loongson.cn>
Date:   Fri, 22 Jul 2022 15:16:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fc5a891d-e5a9-c02d-08e0-318213cde8f4@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxX+PKTtpiXGAuAA--.2939S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KF47ZF13AFWkWrW8Cry5CFg_yoW8Gr4xpr
        1UGayUKF4kKF93GF1kJ3yruF13GF4IyrW7Jr1UAws2gr98urW7tryjkF1akFy5Jrn5WF1x
        Arn2y39F9a1kAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9F1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzx
        vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm
        -wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/7/22 下午2:58, Tiezhu Yang wrote:
> 
> 
> On 07/20/2022 04:32 PM, Tiezhu Yang wrote:
>> According to the configuration information accessible by the CPUCFG
>> instruction [1] and the Overview of Control and Status Registers [2],
>> we can not see the descriptions about LOONGARCH_CPUCFG48 (0x30),
>> LOONGARCH_CSR_PRID (0xc0), LOONGARCH_CSR_MCSR* (0xc0 ~ 0xff) and
>> LOONGARCH_CSR_UCAWIN* (0x100 ~ 0x109), they are not used in the
>> current kernel code.
>>
>> LOONGARCH_CPUCFG48 may be used only in the firmware layer, it should
>> not be used in the future for kernel developers, remove the related
>> LOONGARCH_CPUCFG48 definitions.
>>
>> LOONGARCH_CSR_MCSR* is shadow of LOONGARCH_CPUCFG*, no need to access
>> LOONGARCH_CSR_MCSR* and LOONGARCH_CSR_PRID through CSR instruction,
>> use CPUCFG instruction to access LOONGARCH_CPUCFG* is enough, so also
>> remove LOONGARCH_CSR_MCSR* and LOONGARCH_CSR_PRID definitions.
>>
>> LOONGARCH_CSR_UCAWIN* may be not implemented in hardware, use CSR
>> instruction to access them is meaningless, so also remove the related
>> LOONGARCH_CSR_UCAWIN* definitions.
>>
>> The intention of this patch is to keep consistent between the code and
>> the manual.
>>

Agree, they are should be cleaned up for consistency.

Acked-by: Jianmin Lv <lvjianmin@loongson.cn>

