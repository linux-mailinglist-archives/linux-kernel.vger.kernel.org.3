Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC124E6366
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350217AbiCXMba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350215AbiCXMbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:31:24 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73FFA995A;
        Thu, 24 Mar 2022 05:29:52 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D99535C014D;
        Thu, 24 Mar 2022 08:29:51 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute1.internal (MEProxy); Thu, 24 Mar 2022 08:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=Up3dHTMXn3+4fL
        UoQJEi2QXNKuRNdeUTtoLiyFBrbHM=; b=y9MiYRW2H0kvGQzUrfOSK49obI2x2v
        k3hmCDgVcsW5ejjQwtxVh3M80/wXFTbFwm3zPmwDhCT5op4dLd5ic7ef0Q9oYJYA
        OsJhez+oHpUzG6LaOLRNiY3chK3U70ObYI6doFNbRdXGzdCfDKprBiCDX0+/VZBG
        lG9UYeBAkhot8/BdV7Jx8jDARk4dLluVXfMslc6HW+eLyQWlOtfAPsL2vvma/zDL
        crtY1YKRuEGHuB+XHMsYd/84K/3xiUFQejncBFMRyM3qrrUo1dILeoJHoVglGU6b
        sOL5hDSnOqngl+7/vc9jcjQf7d1Batro8RmhFyQDzXM9Wm3/WqZc/nAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Up3dHTMXn3+4fLUoQJEi2QXNKuRNdeUTtoLiyFBrb
        HM=; b=nM7p8Gqmnsgq/0LE2Ng99N0xuYBHq3UhCUY5NVZ32LQBa+BEgCb6pV31i
        tvJrgkWuHvwwWGU2ozl+T9tJk407AWgK6kSY+OxPh8NADs/oJsUKKmJl1UBmvtn3
        CzVLUQOisYtBp9oULeZ9grWvpQZkDHLva/CyFR/q4lGhmKAd4uxARx0uBW47nRmL
        J+eNQzmnmV6Bft8daqgJ24iHl7wrJYWdPI1mnOQPovg0338ppxeWmEu0fXpt86+G
        4DJx09AgKAoVpy0tz7GHbR1GxybRNGjZLy72BVwh0hR4ZLDKQSXtkLp7HMJ2sQGU
        b61c9FEbBMRe6h1Ykp9rP887L6Yvw==
X-ME-Sender: <xms:P2Q8Yoga1vwQXDV_yWxUJceE7hQs2YhJ60S9IKk3Q4EDYpFYPisCWg>
    <xme:P2Q8YhCYVbCU8Nm1JFW6aWNlE3A42O6jMOWpxgNdsX9zEGeY_y3vjH1tqQZ7qme11
    2uivyAs-Pw_MSpZL5I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepfeetgeekveeftefhgfduheegvdeuuddvieefvddvlefh
    feehkeetfeeukedtfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:P2Q8YgF3MAHlGghZfDECDNkBdDWMxDS5t4ezS_9p_rQ_cgx8vtxjow>
    <xmx:P2Q8YpT9XOQvEzForAQ2mE5p0KBbB0FBxU-vFIlzFOoaA-3ubYTh8A>
    <xmx:P2Q8Yly0HiBnMFzuQ_raMJ7kCKrrGi965YP1wq2ijWiggvu9Ub7t2Q>
    <xmx:P2Q8Yg9xEShgAe4Q1QmRJo_E91MtDXHlD9kwBo3rbHASRgwN9fYXMg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3F51FFA0AA6; Thu, 24 Mar 2022 08:29:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4911-g925b585eab-fm-20220323.003-g925b585e
Mime-Version: 1.0
Message-Id: <490570bf-0e91-471b-b081-5ebd35541522@www.fastmail.com>
In-Reply-To: <fb188614-0301-3255-c31c-3d443cf17b91@loongson.cn>
References: <1647615920-23103-1-git-send-email-yangtiezhu@loongson.cn>
 <1647615920-23103-4-git-send-email-yangtiezhu@loongson.cn>
 <33241bd3-2f12-954c-6701-56cf563060bb@flygoat.com>
 <fb188614-0301-3255-c31c-3d443cf17b91@loongson.cn>
Date:   Thu, 24 Mar 2022 12:29:28 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Tiezhu Yang" <yangtiezhu@loongson.cn>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc:     "Xuefeng Li" <lixuefeng@loongson.cn>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MIPS: Use memblock_add_node() in early_parse_mem() under
 CONFIG_NUMA
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82022=E5=B9=B43=E6=9C=8823=E6=97=A5=E4=B8=89=E6=9C=88 =E4=B8=8A=E5=
=8D=882:42=EF=BC=8CTiezhu Yang=E5=86=99=E9=81=93=EF=BC=9A
> On 03/22/2022 09:19 PM, Jiaxun Yang wrote:
>>
>>
>> =E5=9C=A8 2022/3/18 15:05, Tiezhu Yang =E5=86=99=E9=81=93:
>>> Use memblock_add_node to add new memblock region within a NUMA node
>>> in early_parse_mem() under CONFIG_NUMA, otherwise the mem parameter
>>> can not work well.
>>
>> Hi Tiezhu,
>>
>> pa_to_nid doesn't exist when CONFIG_NUME is disabled.
>> So probably you want #ifdef macro instead =EF=BC=9F
>
> Hi Jiaxun,
>
> Thank you for your reply.
>
> As far as I can tell, if CONFIG_NUMA is set, IS_ENABLED(CONFIG_NUMA)
> is 1, pa_to_nid() is defined in the platform dependent header file:

Yep you're right.
Apologies for the noise.

For the whole series:
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Thanks.

>
> 	arch/mips/include/asm/mach-ip27/mmzone.h
> 	arch/mips/include/asm/mach-loongson64/mmzone.h
>
> if CONFIG_NUMA is not set, IS_ENABLED(CONFIG_NUMA) is 0, pa_to_nid()
> is always 0 which is defined in arch/mips/include/asm/mmzone.h:
>
> 	#ifdef CONFIG_NUMA
> 	# include <mmzone.h>
> 	#endif
>
> 	#ifndef pa_to_nid
> 	#define pa_to_nid(addr) 0
> 	#endif
>
> So pa_to_nid() is defined under both CONFIG_NUMA and !CONFIG_NUMA,
> there is no build error.
>
> Additionally, use #ifdef CONFIG_NUMA is also OK, but I prefer to
> use IS_ENABLED(CONFIG_NUMA).
>
> If I am missing something, please let me know, thank you.
>
> Thanks,
> Tiezhu
>
>>
>> Thanks.
>> - Jiaxun
>>
>>>
>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>> ---
>>>   arch/mips/kernel/setup.c | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
>>> index c8c8f60..50cdc08 100644
>>> --- a/arch/mips/kernel/setup.c
>>> +++ b/arch/mips/kernel/setup.c
>>> @@ -37,6 +37,7 @@
>>>   #include <asm/cdmm.h>
>>>   #include <asm/cpu.h>
>>>   #include <asm/debug.h>
>>> +#include <asm/mmzone.h>
>>>   #include <asm/sections.h>
>>>   #include <asm/setup.h>
>>>   #include <asm/smp-ops.h>
>>> @@ -378,7 +379,10 @@ static int __init early_parse_mem(char *p)
>>>               memblock_end_of_DRAM() - memblock_start_of_DRAM());
>>>       }
>>>   -    memblock_add(start, size);
>>> +    if (IS_ENABLED(CONFIG_NUMA))
>>> +        memblock_add_node(start, size, pa_to_nid(start), MEMBLOCK_N=
ONE);
>>> +    else
>>> +        memblock_add(start, size);
>>>         return 0;
>>>   }

--=20
- Jiaxun
