Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F357165B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiGLKBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiGLKBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:01:11 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BD672B63D;
        Tue, 12 Jul 2022 03:01:09 -0700 (PDT)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxCeFkRs1iBggZAA--.55841S3;
        Tue, 12 Jul 2022 18:01:08 +0800 (CST)
Subject: Re: [PATCH] MIPS: fix pmd_mkinvalid
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1657181495-33004-1-git-send-email-zhanghongchen@loongson.cn>
 <20220707092206.GA9894@alpha.franken.de>
 <bfb97f6b-7a39-8253-bc14-08f2f54ed312@loongson.cn>
Message-ID: <0fd4e823-493f-07f0-08d5-f4a22491b602@loongson.cn>
Date:   Tue, 12 Jul 2022 18:01:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bfb97f6b-7a39-8253-bc14-08f2f54ed312@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxCeFkRs1iBggZAA--.55841S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary8Zw4xZrW7JrW7Gw48WFg_yoW8Xr4xpF
        y0yF48JrWDtFn7Gr4xtr1DJFyYyw15tw15Grn8JFyUAay8Xr92qr4UX3yq93y7JF48Wr15
        JF4aqFW7Zw1UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWU
        AwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUgg_TUUUUU
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/7 下午7:12, Hongchen Zhang wrote:
> On 2022/7/7 下午5:22, Thomas Bogendoerfer wrote:
>> On Thu, Jul 07, 2022 at 04:11:35PM +0800, Hongchen Zhang wrote:
>>> When a pmd entry is invalidated by pmd_mkinvalid,pmd_present should
>>> return true.
>>> So introduce a _PMD_PRESENT_INVALID_SHIFT bit to check if a pmd is
>>> present but invalidated by pmd_mkinvalid.
>>
>> What problem are you trying to fix ? What are the symptoms ?
>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> the test robot showed problems with your last version of the patch,
>> which hasn't been integrated into at least the MIPS tree, so no
>> need to that.
>>
>> Thomas.
>>
> 
> Hi Thomas,
>    The idea come from the commit:
>    b65399f6111b(arm64/mm: Change THP helpers to comply with generic MM 
>   semantics).
>    There is an problem now:
>          CPU 0        CPU 1
>      pmdp_invalidate        do_page_fault
>      ...              __handle_mm_fault
>                      is_swap_pmd == true
>                      trigger VM_BUG_ON() ?
>      set_pmd_at
>    the reason is that pmd_present return true,after this commit
>    pmd_present will return false,and the VM_BUG_ON will not be triggered.
>    Like arm64 does,we can introduce a new bit to fix this.
> 
> Thanks.
Hi Thomas,
  Is there problem of this patch? What's your opinion of this patch?

Thanks

