Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFBB552A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiFUEDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 00:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiFUEDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 00:03:51 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBF021812
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 21:03:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 42A293200392;
        Tue, 21 Jun 2022 00:03:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 21 Jun 2022 00:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1655784225; x=
        1655870625; bh=5CIwMNK/gDKbcFBkIn3kz8/WBVGi20o0cyPDTNwTmpY=; b=Y
        EVvCmRcwiwEkKVOixkHKaw4FnCCGRDL4Lwffa6a9WnWgiE4za54P2O825/xtZ8wf
        ZOcg4ksqFogHUpa8sVAQbxShi3z6py/FkoKloywVQPYjtJs/9CVWxhh3KPL86Fgd
        TjsxLnI4d7IBIuaGYUdxXULFzyfHsY1MVXB/QAGpVQfSAibGOqd/ZrcPJRo7bf0+
        qM8RfTWca/LPFSXmBGIW2VASHA37BXOw5ZMHKhLFySQxDbjQ3x1pw4LULKQTb15T
        LBtkM0NdFCwdQG8NrSASJ+ofbjn7jYJ1wII6YvA7kQS0AKk0nhFt+gG6pOLYlEUo
        HX2w3j8bnQFwwOYvn+tAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655784225; x=
        1655870625; bh=5CIwMNK/gDKbcFBkIn3kz8/WBVGi20o0cyPDTNwTmpY=; b=f
        VFDS0BVqFGoerCvpcfOjYOPdNj5yJ7BFia7kyzzM1I9xnuR5wuUebDKqgKG/A+sp
        muEuASPgTV9vsiG39KXQ2kzz/aD+ZA+vsMlxbJb2+muvccyOsHwsMXe2PP5cyUkI
        kT+pw+AH0l8zcq3oYj0oB6vfqbLBabq3Oc7KPE+v2/xaDNVA8tstIgbuCq0Bz9Jn
        b/z0Jvc3Igl5R3TmOiYeh/UGWuTsW/iRyx90i/qSZ97pTJCjtwgr1WYkMzZwo1kD
        NJs51eUVuhzuDWxQJDiY+11mQDFLnnBt4ygqrDE19aj2N8+U+B6W8+Bwxrmt+WXs
        KiP81uVLcOslkURnRdCnw==
X-ME-Sender: <xms:IUOxYkCUw2d9XYo2q_V1xW69mLSxEJ_j5egjcaJpI_9yYvL8z1UdVg>
    <xme:IUOxYmi7bVhWMUZ9-aGQnz6N6KMOaFliVO-g-CiUWz7qlhwGDX3mCduGplGtvqq_1
    QlIcIVzHx8bkAZvLQ>
X-ME-Received: <xmr:IUOxYnmTWChUqZNLe4LRizf99FLlRaHec5JskfOF1DtRvtQ6ipngr0FtoUdFzHaQr1PcuBhH2CRhOEC44MKJtfcRy89ytnkRwRMm8-lEw5Hag7nTV09E2eLqrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefvddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:IUOxYqzspOgQl9oeqeM3wRuuVziC9SiuzgDs_cyJVClxMWiZbckUhQ>
    <xmx:IUOxYpQRr82KIdmBFSG1QdWXuo1NLzVYl0MdSDEFzgCuiC3Hy_jRxQ>
    <xmx:IUOxYlYQrOpudGAEwXHfPZvb7wAisX505cjNr61Z8FrQJR6WpgC-XQ>
    <xmx:IUOxYpbkXtO_6aiPN4B4QnYwUPOA1urHWJpN0yFCBGWy5-cTUW43Uw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jun 2022 00:03:44 -0400 (EDT)
Subject: Re: [PATCH v2 4/6] genirq: Provide an IRQ affinity mask in non-SMP
 configs
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Guo Ren <guoren@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20220616064028.57933-1-samuel@sholland.org>
 <20220616064028.57933-5-samuel@sholland.org> <87h74ipcos.wl-maz@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <eb0a74ce-f444-de74-d944-87fc42091c46@sholland.org>
Date:   Mon, 20 Jun 2022 23:03:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87h74ipcos.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/22 4:01 AM, Marc Zyngier wrote:
> Hi Samuel,
> 
> On Thu, 16 Jun 2022 07:40:26 +0100,
> Samuel Holland <samuel@sholland.org> wrote:
>>
>> IRQ affinity masks are not allocated in uniprocessor configurations.
>> This requires special case non-SMP code in drivers for irqchips which
>> have per-CPU enable or mask registers.
>>
>> Since IRQ affinity is always the same in a uniprocessor configuration,
>> we can still provide the correct affinity mask without allocating one
>> per IRQ. We can reuse the system-wide cpu_possible_mask.
>>
>> By returning a real cpumask from irq_data_get_affinity_mask even when
>> SMP is disabled, irqchip drivers which iterate over that mask will
>> automatically do the right thing.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>> (no changes since v1)
>>
>>  include/linux/irq.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/irq.h b/include/linux/irq.h
>> index 69ee4e2f36ce..d5e958b026aa 100644
>> --- a/include/linux/irq.h
>> +++ b/include/linux/irq.h
>> @@ -151,7 +151,9 @@ struct irq_common_data {
>>  #endif
>>  	void			*handler_data;
>>  	struct msi_desc		*msi_desc;
>> +#ifdef CONFIG_SMP
>>  	cpumask_var_t		affinity;
>> +#endif
>>  #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
>>  	cpumask_var_t		effective_affinity;
>>  #endif
>> @@ -881,7 +883,11 @@ static inline int irq_data_get_node(struct irq_data *d)
>>  
>>  static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
>>  {
>> +#ifdef CONFIG_SMP
>>  	return d->common->affinity;
>> +#else
>> +	return &__cpu_possible_mask;
>> +#endif
> 
> I have a bad feeling about this one. Being in a !SMP configuration
> doesn't necessarily mean that __cpu_possible_mask only contains a
> single CPU, specially with things like CONFIG_INIT_ALL_POSSIBLE. I can
> also imagine an architecture populating this bitmap from firmware
> tables irrespective of the SMP status of the kernel.
> 
> Can't you use something like:
> 
> 	return cpumask_of(0);
> 
> which is guaranteed to be the right thing on !SMP configuration?

I can if I cast away the const. However I see a lot of:

    cpumask_copy(irq_data_get_affinity_mask(d), foo);

which I suppose is a great reason not to do what I am doing. The right solution
seems to be adding irq_data_update_affinity() to match
irq_data_update_effective_affinity(), and making both getters return a const
cpumask. Then I can use cpumask_of(0).

Regards,
Samuel
