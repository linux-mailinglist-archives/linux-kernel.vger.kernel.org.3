Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F66E52EEA2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350572AbiETPEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiETPEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:04:35 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F8837A94
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:04:33 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D28B5C01BB;
        Fri, 20 May 2022 11:04:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 20 May 2022 11:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1653059071; x=
        1653145471; bh=xGnkinpP7LZAS+mAouYrvyB+X3ZjosXKsE8yvlfvH6o=; b=c
        S4WaPNFCWFBjEC0hwq5f1bdKuHS61dC0y6Jvt+dN0D6JxCeFfDTaTw9fFtqI/e08
        4+5P0Dr+SJ0zbYQbpKo1SaSoSk7GkyseNCIIix1xlW+eSavXfTivl/H99mJ8fRBo
        CLx0gbSSoMGQbVnsRKKOuLpy8BMPl6FxZrO8fzFyMQMEpNmT1IqeOULmnyxzshUL
        aEHe8bCw20Fp8Fz/dwuFgVCEM9LneiOpkL7DmddjVqwEuC7qqKYwF6NJnR4clZvd
        lWK8xK0a89TLT0wVTqPN8FkZCWEZXplCyJT5OaoLXd1BJ3zOpCpv1XmSxbNH4xUs
        q/XT//hjfWjJa/ZkhbIPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1653059071; x=
        1653145471; bh=xGnkinpP7LZAS+mAouYrvyB+X3ZjosXKsE8yvlfvH6o=; b=t
        rlgVVE8z/Ter5k1MqVbhXyQiJ04WHpOcScBAWGEBZpDhlRrPiPvY0puTlxBSUIhC
        dNpkax6QSFFXIandEkb3DkV6CPhBNWvIPm4Wi+frbWeAFT+UyuLhy3ud2FtDpnb3
        lrsC9zvZtXOZyhktbd7LDip75qaezUtDjO70MvSTluh2zmjQ7lx37vKOzEojLWRk
        iWCWpnXWmJjPTbfJrzqeTohm9JNnqz2+ZQXn9yDeqp6ywZR7dfL3uq24PSv1FfHY
        SKOWyr1HdqP7+pfLR3RuWejQIyhxJSfDzd2AmyVSKzW6xRbT7oq3FREkgZZCZy8X
        XCqoHtWDVHGkAcEh+CfXA==
X-ME-Sender: <xms:_q2HYkIkM_Wnkp6XJZykWiMmE-ZYykEY0gN4TJxYaZRC2GWmEjNqJA>
    <xme:_q2HYkLYJ0o3nwM_pE7U1hNaZl2Lof155hryVMpRGu9s44V6AAUPGcglNYv-DF1Xn
    WZFT0B6fezDatMe0u4>
X-ME-Received: <xmr:_q2HYku4eu8f6sruqedjxPw50-n-WpxgMt-H3SC43WJ2U8es7_fEBj5PeL5sqDU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrieefgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeduhfekvedvtdeukeeffefgteelgfeugeeuledttdeijeegieeh
    vefghefgvdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:_q2HYhZG22wA36ONaRwFdHYpGOW6xX1Ple2skBzSBJMHcgmO32Rajw>
    <xmx:_q2HYrZf4Eaigx8py9pEWzkbMoq3hSd-xxH4vkZk2YNit5BgWJEh0g>
    <xmx:_q2HYtDgNFTodMDjpyEISKiZowGc8OYov5khjAYfT6pl9tIeboAhig>
    <xmx:_62HYqWlpBxheDE6bu0dg5HPtCK3U5KzfMpp5OPjf4Dq5PhSbBFMDw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 May 2022 11:04:29 -0400 (EDT)
Message-ID: <f9bafd6c-0819-9046-e0dd-11e2dd98da38@flygoat.com>
Date:   Fri, 20 May 2022 16:04:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V11 00/10] irqchip: Add LoongArch-related irqchip drivers
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>
References: <20220430085344.3127346-1-chenhuacai@loongson.cn>
 <87v8uk6kfa.wl-maz@kernel.org>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <87v8uk6kfa.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/5 16:58, Marc Zyngier 写道:
>> LoongArch use ACPI, but ACPI tables cannot describe the hierarchy of
>> irqchips, so we initilize the irqchip subsystem in this way (from arch
>> code):
>>
>>    cpu_domain = loongarch_cpu_irq_init();
>>    liointc_domain = liointc_acpi_init(cpu_domain, acpi_liointc);
>>    eiointc_domain = eiointc_acpi_init(cpu_domain, acpi_eiointc);
>>    pch_pic_domain = pch_pic_acpi_init(eiointc_domain, acpi_pchpic);
>>    pch_msi_domain = pch_msi_acpi_init(eiointc_domain, acpi_pchmsi);
> I said no to this in the past, and I'm going to reiterate: this is
> *not* acceptable. This obviously doesn't scale and isn't manageable in
> the long run. Hardcoding the topology and the probing order in the
> kernel code has repeatedly proved to be a disaster, and yet you refuse
> to take any input from past experience. This is pretty worrying.
Just my two cents here.

Those drivers have such a topology just because this was my design to
handle irqchip differences between RS780E and LS7A for MIPS-era Loongson.

TBH, for LoongArch-era Loongson, they should be handled by the same driver,
cuz the topology behind them just looks like GIC PPI SPI and MSI for Arm 
GIC.

PCH PIC and eiointc in combination relays interrupts from peripherals 
just like SPI.
liointc is doing the PPI job. They are not separated modules in 
hardware, they are
interlocked.

The system should be treated as a whole, pretty much like how we see 
Arm's GIC. The
topology will last forever for every ACPI enabled LoongArch PC.

I see no reason they should be described separately. Adding complicities to
ACPI bindings brings no benefit. Changing ACPI binding which is already in
final draft stage can only leave us with chaos.

Disclaimer: I don't have any connections with Loongson currently. I'm 
standing
at contributor's approach to make statement above.

Thanks.
- Jiaxun
