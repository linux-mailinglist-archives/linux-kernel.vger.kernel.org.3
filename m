Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5731A53D70F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 15:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbiFDNqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 09:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiFDNqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 09:46:43 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FE02C11F;
        Sat,  4 Jun 2022 06:46:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 24A5F32003C0;
        Sat,  4 Jun 2022 09:46:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 04 Jun 2022 09:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654350398; x=
        1654436798; bh=rUGhNqosCaJGWgpyLmYVfMrRwpqvKKDo49Pbm+4zht8=; b=s
        OoxChwUQ6fh3ZeD30iz4ZsFFFInLqvE9aTxPGkS42kjxUvGk+Jn6U6MOnNUZbqXP
        vGGXLH+aVTrqiCzlrdsfgyY5poU76Ouz42YnPJkgynZ2w3YvFFCZ/koRImuNZIWM
        gPMzZavD5QXlIwCviQvwz2m0UrpBowUC6+RHweGDuH7hq5r8NXR9IzR6XfdwAQ4Z
        0To7LiVrjVTLKk9viqytfwXQNy3r4AtnG1kYTPhko4sEVYFlvraKIwFShE6B8OoU
        lFtxPeSpU9k/t2zq1vMXKJ2bUSjdO67DoRP8ROLwAU0Z7jUVXRe4ypVNdnMIylE+
        L9Ps27yzhDXUDC28hC4EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654350398; x=
        1654436798; bh=rUGhNqosCaJGWgpyLmYVfMrRwpqvKKDo49Pbm+4zht8=; b=i
        UKN6QJxL2eheOwNJNaR2v6DzJG5VzQFvoVVwn+B64cFSh/6W1puWhQSYrbYTqpmu
        NKyMa3QdE4GWRhW1TaC/OGVuD+2B0cH6bnHYbpKoJlup1KE580n6Fb1E+aGfVno/
        u6G9r5adqHHbljqK4X85iohVnawMS/jN+w0hP5hXuRMg6m3COJlh/aPMOiupjVmB
        tWjf3/aXJbXdt39CQkISQ8hnDFKhJT26FJQSGvoaYw10ViWw0ZUO/jgmNNxMrsoV
        a0BaaDB2OHM7pDrLui0vGCmFR/abEn1g6YyreIjqkZsiMrL6XO29LQuEegkCFwkt
        zI2OlUOeB/4oJdv+wOW6Q==
X-ME-Sender: <xms:PmKbYjDzBjGXoXDXbaTqv6e7_KwCT_pdCDKVzg4Advhp6V9P8pojFA>
    <xme:PmKbYpjHqDZp7qgrSnyLvWhxNSgo10uiFZqoakq2FM1dKzj7b7pUe8WEA_tMcRADL
    0jbKpPnEHk2tWdMwgE>
X-ME-Received: <xmr:PmKbYunjr7BpxAR-F5veIqiTkzcqPfjUJVkIzDo0iLDi8wAGj7--9di-B5aGwaY4FrR5AmoxSIhqFKZBllNXkOAYf_T4C2VrLQ4o5fjN1fjMT3mY6RLH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleekgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeduhfekvedvtdeukeeffefgteelgfeugeeuledttdeijeegieeh
    vefghefgvdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:PmKbYlzMVq8jv8PAIYG7COblLtKCsGnY36rQdiFE9SgP9US0TL7wnQ>
    <xmx:PmKbYoRvowwVA1Y63sXLwyTroD36bF4NYRsYBQKLwxEAETQ1V2I8mQ>
    <xmx:PmKbYoavXf4rzMOwnFaU7aJRXyc8Sd7ya069cGehlai2A1-OQqXRvg>
    <xmx:PmKbYuc_Hng7GuNYETYrH45C2hSk-KdFwwutrKP2MdnR0Sn0b4LEIA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Jun 2022 09:46:36 -0400 (EDT)
Message-ID: <01dd74cb-b53c-93e3-d27f-57603d348f67@flygoat.com>
Date:   Sat, 4 Jun 2022 14:46:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-5.19 1/2] irqchip/loongson-liointc: Use architecture
 register to get coreid
Content-Language: en-GB
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
References: <20220604124052.1550-1-jiaxun.yang@flygoat.com>
 <CAAhV-H6KMC7OiLO74nN05+qfcR6ZZCih12T-iBGQ4_L9RVOjoQ@mail.gmail.com>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <CAAhV-H6KMC7OiLO74nN05+qfcR6ZZCih12T-iBGQ4_L9RVOjoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/6/4 14:18, Huacai Chen 写道:
> Hi, Jiaxun,
>
> On Sat, Jun 4, 2022 at 8:41 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>> fa84f89395e0 ("irqchip/loongson-liointc: Fix build error for
>> LoongArch") replaced get_ebase_cpunum with physical processor
>> id from SMP facilities. However that breaks MIPS non-SMP build
>> and makes booting from other cores inpossible on non-SMP kernel.
>>
>> Thus we revert get_ebase_cpunum back and use get_csr_cpuid for
>> LoongArch.
>>
>> Fixes: fa84f89395e0 ("irqchip/loongson-liointc: Fix build error for LoongArch")
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   drivers/irqchip/irq-loongson-liointc.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
>> index aed88857d90f..c11cf97bcd1a 100644
>> --- a/drivers/irqchip/irq-loongson-liointc.c
>> +++ b/drivers/irqchip/irq-loongson-liointc.c
>> @@ -39,6 +39,14 @@
>>
>>   #define LIOINTC_ERRATA_IRQ     10
>>
>> +#if defined(CONFIG_MIPS)
>> +#define liointc_core_id get_ebase_cpunum()
>> +#elif defined(CONFIG_LOONGARCH)
>> +#define liointc_core_id get_csr_cpuid()
>> +#else
>> +#define liointc_core_id 0
>> +#endif
> Thank you for your quick fix. But I think it is better to do like this:
>
> #if defined(CONFIG_LOONGARCH)
> #define liointc_core_id get_csr_cpuid()
> #else
> #define liointc_core_id get_ebase_cpunum()
> #endif
>
> Because this driver doesn't depend on COMPILE_TEST, it can only be
> built under MIPS and LOONGARCH. Moreover, let the else branch be the
> same as the old behavior looks more reasonable.
Thanks for the suggestion.
Will do for v2.

- Jiaxun

>
> Huacai
>
>> +
>>   struct liointc_handler_data {
>>          struct liointc_priv     *priv;
>>          u32                     parent_int_map;
>> @@ -57,7 +65,7 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
>>          struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
>>          struct irq_chip *chip = irq_desc_get_chip(desc);
>>          struct irq_chip_generic *gc = handler->priv->gc;
>> -       int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
>> +       int core = liointc_core_id % LIOINTC_NUM_CORES;
>>          u32 pending;
>>
>>          chained_irq_enter(chip, desc);
>> --
>> 2.25.1
>>

