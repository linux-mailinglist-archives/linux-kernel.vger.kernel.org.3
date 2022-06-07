Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31ED54184A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379523AbiFGVKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359588AbiFGUMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:12:16 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AC2396BA;
        Tue,  7 Jun 2022 11:27:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C19CE5C00E0;
        Tue,  7 Jun 2022 14:27:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 07 Jun 2022 14:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1654626459; x=
        1654712859; bh=ie1VBpDc60mNPyKhPTfEMsPzeVNv6xxlIjutSd/3wxk=; b=J
        8mQBcAXvI2l0rIAtmrCwCQ6uidHm9+7l1mbxzaWA16v8+mvBtUB/Tqibs4l4iGTH
        zr5Hpa9NoZohYtwM7gBFwI8L4RRD0DsMNAlrSP9osm3o70k8L7KtbSdgZPYqyGIg
        +n7V8tuKJhTPCktZhpNAMLjoGqsW4CTycp4Fc77HTn3wEx5iogMJXRhtaxUdr3TW
        3V3hSPlogNirpnrZzFiin1zUjY5cAxETwtv6hByYrzZ15zVa3xggXaEq6SCUeKsQ
        cVoGhHbbzTyxVe1IxfTXIlBbzNZO4n/dIeEqjICzclrF8bEcci8SOTHUu9wDog4J
        vuDr7CN7iM/JP406J8Lrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1654626459; x=
        1654712859; bh=ie1VBpDc60mNPyKhPTfEMsPzeVNv6xxlIjutSd/3wxk=; b=k
        XfZqI/UMtKkFJGhhpkg2gLlB56uW8wdx1tuj7LWZRl9rHNSTle1o299/ZRsPSXXJ
        ERmZmkX7mc3m/629vqpXSye1MbjWMsnCPx5xuvnx7T0qGSdx7cageVlbIaG7dPki
        DtqnfCzwlqtX9vMiLgh0WCcfiwcMhLCZiKR6IPe0QjbCc1ekBnDLIrQtr5yJjQCa
        Ps/As+c0cIbB9dxKaahs1RMVXPrs4NVIwK1UCbpXPhbkv9LdT5z4l4rmsePvm+rf
        A5U/LWGzXaE8CUE8pfcj5nTaKDYkvUu/uAs4Zz+VY0ItSnZNwKmpYirbVzDVMmAV
        EJrSbemszC3CJvQMMb9lw==
X-ME-Sender: <xms:m5ifYm8Oa0BYTvKyLxcQgjpEPkhPfBJuwsNOQc2vho0EY1WItPs5zA>
    <xme:m5ifYmv71nSaQ9hxvmik4cJSWCppWOwYlidKCFYKnBE-9Ej19MWGXDSrmXLvc8ysT
    z6mnzA6qvbGIvYSFlE>
X-ME-Received: <xmr:m5ifYsCGb22Ke9qjuc56Wz6iaTMj3iGSy3TNcz2oeHeZYwdO0bS0IUbUqzHzBgiqoPA-o9gMc4wPWps_3P1mUPJtRtaN0sIoNWx4_zfAd0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomheplfhi
    rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
    enucggtffrrghtthgvrhhnpeduhfekvedvtdeukeeffefgteelgfeugeeuledttdeijeeg
    ieehvefghefgvdefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:m5ifYudLcMkbSMiwtoboKt241o5TBFWnwbl2FAmCSTfGh84WlnDrmw>
    <xmx:m5ifYrOfOTCP-4pYQRCXTxUyZrZT8LGHBPHrnd99D33rlOxAwdaghA>
    <xmx:m5ifYolt7kFLPEWI3CPL-zdwSS_LrfWJ3oIUe17mdI0O5_KAfNFe_A>
    <xmx:m5ifYikTPgaZd1bqNHXE3ueJ9gQCt8TN-SW3k3G2c_x_2hKGi9aAJw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jun 2022 14:27:37 -0400 (EDT)
Message-ID: <bf97d10b-d5c9-46d6-c440-fc7de09c3abf@flygoat.com>
Date:   Tue, 7 Jun 2022 19:27:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 11/12] MIPS: Report cluster in /proc/cpuinfo
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>,
        Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
 <20220525121030.16054-12-Dragan.Mladjenovic@syrmia.com>
 <87sfoi3pek.wl-maz@kernel.org>
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <87sfoi3pek.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/6/6 14:14, Marc Zyngier 写道:
> On Wed, 25 May 2022 13:10:29 +0100,
> Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com> wrote:
>> From: Paul Burton <paulburton@kernel.org>
>>
>> When >= CM3.5 output cluster number.
>>
>> Signed-off-by: Paul Burton <paulburton@kernel.org>
>> Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
>>
>> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
>> index bb43bf850314..a66e7705315d 100644
>> --- a/arch/mips/kernel/proc.c
>> +++ b/arch/mips/kernel/proc.c
>> @@ -12,6 +12,7 @@
>>   #include <asm/cpu.h>
>>   #include <asm/cpu-features.h>
>>   #include <asm/idle.h>
>> +#include <asm/mips-cps.h>
>>   #include <asm/mipsregs.h>
>>   #include <asm/processor.h>
>>   #include <asm/prom.h>
>> @@ -282,6 +283,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>>   	seq_printf(m, "kscratch registers\t: %d\n",
>>   		      hweight8(cpu_data[n].kscratch_mask));
>>   	seq_printf(m, "package\t\t\t: %d\n", cpu_data[n].package);
>> +	if (mips_cm_revision() >= CM_REV_CM3_5)
>> +		seq_printf(m, "cluster\t\t\t: %d\n", cpu_cluster(&cpu_data[n]));
>>   	seq_printf(m, "core\t\t\t: %d\n", cpu_core(&cpu_data[n]));
>>   
>>   #if defined(CONFIG_MIPS_MT_SMP) || defined(CONFIG_CPU_MIPSR6)
> This will break userspace. Please don't do that.
Hmm, userspace always parse cpuinfo line by line so I guess it won't be
a problem if we add a new line here.

We accumulated some new additions to cpuinfo in past years and there
was never a single complain for that.

Though I don't like the idea of using CM version to switch on the cluster
display....

Thanks
- Jiaxun

>
> 	M.
>

