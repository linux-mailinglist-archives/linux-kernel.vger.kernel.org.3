Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9510855DE87
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236536AbiF0OOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiF0OOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:14:34 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB2E13EAF;
        Mon, 27 Jun 2022 07:14:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4AFD65C012B;
        Mon, 27 Jun 2022 10:14:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 27 Jun 2022 10:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656339265; x=
        1656425665; bh=MHflSRrcauCzkIXmYSgam5C/L3iBtC50UPlW/v0FWYA=; b=V
        B/PQQmw9gCv0XiwlL9s/nRC7zRmYVsSdf8Mwod/Z/HFN4J9oTwIV+rHh9YEzEKS2
        mN5z3/vWFWIJbiRhCjSn/8Dr0m0YSN6DgxErkkgF0cv1kdvLPJNgIYYZ2vTupK9+
        Ot+SkVEVkB5wJ/LrfKdQD8r8eh8t70GN0Cggd+P6c+Fl7kxEzXG46bj8msyNhIQb
        F4Dmu7DKjXyi1gdRFi8095w5WKMb0zY5zc3TZEMQbVO9uqWpDtgYjPhvdpkLkgrI
        EGD9wHDskSrmuyBya1MqJIuvPVc3Nbg7DJbI1AZ0M/YdVlYVeS7fEXAuQCvji/Fa
        r3LahnJHOJPz/bAqSzXFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656339265; x=
        1656425665; bh=MHflSRrcauCzkIXmYSgam5C/L3iBtC50UPlW/v0FWYA=; b=b
        OI4teyjgv/oKaHSoDbClKUY4+NnYAHlPcejUWzYt416mdhtZvB0blJwo82JCfzNC
        7Pigjfn2MeAf0EuSCa5V2udjJ77eADv537wGSI8CcfJe1hoKMBmxaiZo7fmH256f
        riqEWQ0Q1vxzfrU1CsC++aUAQ1GYMdvpob5lzVfj+aaO1JMMuWcDSHGv0sHKczA2
        v23xIpbQQRd7YWHwq8SZMXjct1rnCy44/EhDO32nChq2OvPDvPndCKQLYyQ37eIh
        paBRnbSMdr0JPM/UsSyMiZ0jQ/JZX6UCoDP47CwIpQTXkQjI3EijZ+yy25pP7HV6
        ZN8w++8xkieCNRM+yyhwQ==
X-ME-Sender: <xms:QLu5YmFFSHpJA4_LkECTb54itB94i4sR0xVm9fmxODUddMRKr7NqEg>
    <xme:QLu5YnXMfFoaZPkjxhSDIWLzLpUc-_aEJars6StFadJBBFmbf5yiOAu6sc2GyjanC
    BcO117bpooo2OjnRA>
X-ME-Received: <xmr:QLu5YgKEEJBy4rVNmDJfRJCWwSL6ZfGXHzeLl4Jg3G6D07hI578rRREFhwuyjs21Rtp6aBp2Dt_04bWci5jMIvPytWcRGElLydw-ELJ7v9U0Q_WCKSHCO6AWgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeghedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvddvudelveeuleegveduiefggeegheffgefhjeduhfeigfei
    vedthfduleegueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:QLu5YgFtXeAj4IDlNxTMHiYFI7Cn_lfILYHYgJdnZHCp-pcr6wJm-A>
    <xmx:QLu5YsUT5g6PP6hQ6PV4czzMO3Hu1IseTIYIBafGHdc44zQryH6Vrw>
    <xmx:QLu5YjMFPJ7kxa5b-e1qbnuol9Kb2QEqVBU7QvNTk7sYsaR2xNAeQA>
    <xmx:Qbu5YhXXjVAXOL0m94D1DrZvqDq7wjNOF4deCYi8ckWf2tSYjUG4Mg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jun 2022 10:14:24 -0400 (EDT)
Subject: Re: [PATCH v1 1/3] dt-bindings: interrupt-controller: Require trigger
 type for T-HEAD PLIC
To:     Guo Ren <guoren@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <20220627051257.38543-1-samuel@sholland.org>
 <20220627051257.38543-2-samuel@sholland.org>
 <CAJF2gTSq1NsBWRCg+kpTbJRwSeE30P9NVB5di6vzi7m2CFRzHw@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <ab5b4722-8219-ab1c-e9d8-2c00e52040da@sholland.org>
Date:   Mon, 27 Jun 2022 09:14:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTSq1NsBWRCg+kpTbJRwSeE30P9NVB5di6vzi7m2CFRzHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 2:40 AM, Guo Ren wrote:
> On Mon, Jun 27, 2022 at 1:13 PM Samuel Holland <samuel@sholland.org> wrote:
>>
>> The RISC-V PLIC specification unfortunately allows PLIC implementations
>> to ignore edges seen while an edge-triggered interrupt is being handled:
>>
>>   Depending on the design of the device and the interrupt handler,
>>   in between sending an interrupt request and receiving notice of its
>>   handler’s completion, the gateway might either ignore additional
>>   matching edges or increment a counter of pending interrupts.
>>
>> For PLICs with that misfeature, software needs to know the trigger type
>> of each interrupt. This allows it to work around the issue by completing
>> edge-triggered interrupts before handling them. Such a workaround is
>> required to avoid missing any edges.
>>
>> The T-HEAD C9xx PLIC is an example of a PLIC with this behavior.
> Actually, C9xx support pulse signals which configed by
> pad_plic_int_cfg_x for SoC vendor:
> 
> https://github.com/T-head-Semi/openc906/blob/main/C906_RTL_FACTORY/gen_rtl/plic/rtl/plic_int_kid.v
> 104: assign int_new_pending = pad_plic_int_cfg_x ? int_pulse
> 105:
>         : level_int_pending;
> 
> They could put pad_plic_int_cfg_x into the SoC software config
> registers region or bind them to constant values.

The issue here is the "!int_active" condition for int_new_set_pending,
regardless of that configuration input.

For interrupt sources that send pulses, those pulses will be lost if they are
received while int_active is true. So the driver has to make sure int_active is
false _before_ servicing an interrupt, or it may miss the next one. This means
the driver needs to know which interrupt _sources_ send pulses and which ones
assert levels.

For level interrupts, pad_plic_int_cfg_x had better be 0, but that is a
hardware/firmware configuration concern. The driver should not have to care
about that.

(On the Allwinner D1, those inputs are memory mapped, which was the reason for
the stacked interrupt controller mentioned in my other reply. But while
pad_plic_int_cfg_x == 1 only works with edge interrupts, the pad_plic_int_cfg_x
== 0 choice works with either kind of interrupt source, so the stacked driver is
not really needed.)

Regards,
Samuel
