Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5E54C1DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbiBWVj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbiBWVjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:39:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DC645AC1;
        Wed, 23 Feb 2022 13:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645652343;
        bh=+NQyixM3RzLbqPeag9mkx+AWwnpl0NSQKSfnDE07iys=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Vy0sBcWVlu189IPaRYEUT3rePVUGoq3zjnuMH7OrAboW+KOJXTbKKyx1LLFOy/HYm
         k6X4R/TRnVvDwZ4h2G6PF5KUnLabTSWv+jHUrpdDkXqLnSsbrDFPIqFPtOkeU8h1L3
         1/qa8NFwkVe3+vAqgf+GnncuXcl79cGJ9R86yFyg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1oGjHk0zzz-0169k8; Wed, 23
 Feb 2022 22:39:03 +0100
Subject: Re: [PATCH v4] hwmon: (dell-smm) Improve assembly code
To:     David Laight <David.Laight@ACULAB.COM>,
        =?UTF-8?B?J1BhbGkgUm9ow6FyJw==?= <pali@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-assembly@vger.kernel.org" <linux-assembly@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220220190851.17965-1-W_Armin@gmx.de>
 <20220222165432.GA255373@roeck-us.net> <20220222175150.qs32v4outislnqj6@pali>
 <b3cecea1376f4080929f47da2529685c@AcuMS.aculab.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <4b5ca065-06a4-c1ff-ed16-3bbb038ee6e0@gmx.de>
Date:   Wed, 23 Feb 2022 22:39:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b3cecea1376f4080929f47da2529685c@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:7rIcpZjA2Su4QaoPr1aU1N7wlDbARz9HY5SPcA9huuY3vdxEftZ
 93g91hTfbAuuJZz1YTWh32EH8NBwB+KKcAdfWNpvyymPoaKieyEoghdAGUUzmZOwZD2DqAR
 9KKYCKBxNFAAt1/PPYSp49CwiSOansDd+JwP1acGrftRTiHL+mqvS7kZy7koDRg0tI/PYL8
 0+SM6PdvkReLeSBzXSPfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q4c4KPbqVcI=:rF6o49jbBAtTuBS89OpyIc
 LoczH6xyMYuxcg2eqol4AAbRleXu7Hgel29pXVREUTervwEuZwEIA6my52TcqIpnVvetw1sUo
 wrjf4HaRrTEGbXBszOjIW5zjvRao7IKZY06VnRwL9yxcz0t8u2sMphvU1+ayqqz+Ex12BEeqh
 eQWHT3n8IFo7HlqOUu6m+wflorkHy4XjQBXJY6MuUA1yztk6aYUqQnKneXO1RIWpqV1cBX3Hf
 ga073NBCXyrUdhkLEwzu1XiPo+CxvCjLhO5YHpFbGzfR4WLGVZV6cRETVnKfokSFTUG28KUO6
 TalDa8FRdpFylsmAeVPlvlxibOZLGwLwGodm/ZqpYIxKlJPQ01aJaRnz4IJHOdq7JojxxaSQJ
 V6PGlQBJpIAabB3PZuZR17YVAAbf6hQ0oB+BsJe7XnWj0EqQgN3nIwLe12+lA2RCDkGnnqvKw
 FWy9CGiayIbriHUZV9vxEFNimuyAoUyoXchY4vYCiRZQKUFWxa16A6x+QMNVHCkWzYKt989rb
 C29D3ZbgDHnWLFFWchienDgPeMn6bGKS2Zf4VkOmHkwrYWAo9bZukzRsYndHu8SMlvHw+t4pJ
 2QCdsyPD1Ogweo5jgv7WaYy2mBQqZeXwfunpBOCXmtBGPLfpmjm+QpnhESLieuNOe8w6+kwzX
 kXUK9EcoK1wip4xr33tytrHIRyqTZe/D+ORdc4r6FEGKgbvyRKUc4uo3dtSakRahxbQAdZGFV
 bdrfQaJFs50uiV9mCyxWuTrkQ5hNfMbavqUg9QoS4AagKLQMCtBYoISBvk6kCagy7nLsAvaq6
 DRzGUmBdksbWC4NVMnopXuHXiYvugH+b6yCcqTANg0mdzKC7dm3C5U1cjYHTFSe06Sp4i/WwM
 Ls9SmXMEleT8Btx3tcd6ZyQ7kIF1C/WhVZakHD62ThU8vgWIG4fYDK6qyH0Mu5wSQW0bKbUty
 7u24Lqsvf0tL2Rvt1Nm1EFFhySFkCxjYcGqupK6s2f7bqQAzBsibWdhp6VjWDU75JzHZI6Hc3
 fjJCEpLqgJCNJSgOnBbPzzgZStPDQt7d+5demtfcs/yj0EK8B8rqcGAHSpCmzH4fNvUct4gDL
 KhavmfxI0Ko6eM=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.02.22 um 20:46 schrieb David Laight:

> From: Pali Roh=C3=A1r
>> Sent: 22 February 2022 17:52
>>
>> On Tuesday 22 February 2022 08:54:32 Guenter Roeck wrote:
>>> On Sun, Feb 20, 2022 at 08:08:51PM +0100, Armin Wolf wrote:
>>>> The new assembly code works on both 32 bit and 64 bit
>>>> cpus and allows for more compiler optimisations.
>>>> Since clang runs out of registers on 32 bit x86 when
>>>> using CC_OUT, we need to execute "setc" ourself.
>>>> Also modify the debug message so we can still see
>>>> the result (eax) when the carry flag was set.
>>>>
>>>> Tested with 32 bit and 64 bit kernels on a Dell Inspiron 3505.
>>>>
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> It would be great if I can get some Tested-by/Acked-by/Reviewed-by
>>> tags for this patch.
>> Well, I know about this driver asm code for a long time and it since
>> beginning it was suspicious for me, why there is such huge code with
>> stack and registers manipulation and why it cannot be implemented easil=
y
>> via just two "out" instructions. This patch is exactly doing it.
>> But question reminds why it was written in this simple way since
>> beginning.
>>
>> If this change is correct then I have no problem with it.
>>
>> But I would rather see review of this asm change by skilled x86 asm
>> developer. We are dealing here with CPU 0, SMM x86 mode, I/O ports and
>> stack manipulation in inline gcc asm which sounds like a trap. And I'm
>> not feeling skilled for reviewing this change.
>>
>> May I ask somebody to review this change? Is there some linux x86 ML?
> On the face of it the new asm code is basically the same as the old
> asm code - and both are probably equivalent to the reverse engineered
> windows code.
>
> The real problem isn't the new code, it is more 'WTF is actually going o=
n'.
> Somehow the pair of outb are generating a synchronous (or synchronous
> enough) trap that the trap handler (in the smm code in the bios)
> can change the registers before the code following the outb saves
> them back to memory.
>
> SMM mode is a semi-hidden cpu mode usually entered by an interrupt.
> It is horrid and nasty because it has access to the cpu memory and
> registers, but is hidden and unknown (I think in the bios).
>
> Normal bios calls can (usually) be executed using a cpu emulator
> (especially useful for doing real-mode call from 64bit mode) so
> the kernel can limit what they can do.
>
> But SMM mode is nearly as bad as the ME processor on newer systems.
> If you worry about security you really want it disabled - but you can't.
>
> As far as this patch goes I think I'd add a 'stc' (set carry)
> instruction before the first 'outb'.
> Then if the 'something magic happens here' doesn't happen (because
> you aren't on the right kind of motherboard) the action fails.
>
> 	David

We already check for such scenarios by checking if eax changed.
I would not set the carry flag before doing a SMM call since im
not sure if the firmware code always clears the carry flag when
the call was successful.
If for example the firmware code only sets the carry flag on
error and otherwise ignores the carry flag, we might create some
false negatives when a successful SMM call leaves the carry flag set.

>>> Thanks,
>>> Guenter
>>>
>>>> ---
>>>> Changes in v4:
>>>> - reword commit message
>>>>
>>>> Changes in v3:
>>>> - make carry an unsigned char
>>>> - use "+a", ... for output registers
>>>> - drop "cc" from clobbered list
>>>>
>>>> Changes in v2:
>>>> - fix clang running out of registers on 32 bit x86
>>>> - modify debug message
>>>> ---
>>>>   drivers/hwmon/dell-smm-hwmon.c | 78 ++++++++-----------------------=
---
>>>>   1 file changed, 18 insertions(+), 60 deletions(-)
>>>>
>>>> --
>>>> 2.30.2
>>>>
>>>> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-=
hwmon.c
>>>> index c5939e68586d..38d23a8e83f2 100644
>>>> --- a/drivers/hwmon/dell-smm-hwmon.c
>>>> +++ b/drivers/hwmon/dell-smm-hwmon.c
>>>> @@ -119,7 +119,7 @@ struct smm_regs {
>>>>   	unsigned int edx;
>>>>   	unsigned int esi;
>>>>   	unsigned int edi;
>>>> -} __packed;
>>>> +};
>>>>
>>>>   static const char * const temp_labels[] =3D {
>>>>   	"CPU",
>>>> @@ -164,74 +164,32 @@ static int i8k_smm_func(void *par)
>>>>   	struct smm_regs *regs =3D par;
>>>>   	int eax =3D regs->eax;
>>>>   	int ebx =3D regs->ebx;
>>>> +	unsigned char carry;
>>>>   	long long duration;
>>>> -	int rc;
>>>>
>>>>   	/* SMM requires CPU 0 */
>>>>   	if (smp_processor_id() !=3D 0)
>>>>   		return -EBUSY;
>>>>
>>>> -#if defined(CONFIG_X86_64)
>>>> -	asm volatile("pushq %%rax\n\t"
>>>> -		"movl 0(%%rax),%%edx\n\t"
>>>> -		"pushq %%rdx\n\t"
>>>> -		"movl 4(%%rax),%%ebx\n\t"
>>>> -		"movl 8(%%rax),%%ecx\n\t"
>>>> -		"movl 12(%%rax),%%edx\n\t"
>>>> -		"movl 16(%%rax),%%esi\n\t"
>>>> -		"movl 20(%%rax),%%edi\n\t"
>>>> -		"popq %%rax\n\t"
>>>> -		"out %%al,$0xb2\n\t"
>>>> -		"out %%al,$0x84\n\t"
>>>> -		"xchgq %%rax,(%%rsp)\n\t"
>>>> -		"movl %%ebx,4(%%rax)\n\t"
>>>> -		"movl %%ecx,8(%%rax)\n\t"
>>>> -		"movl %%edx,12(%%rax)\n\t"
>>>> -		"movl %%esi,16(%%rax)\n\t"
>>>> -		"movl %%edi,20(%%rax)\n\t"
>>>> -		"popq %%rdx\n\t"
>>>> -		"movl %%edx,0(%%rax)\n\t"
>>>> -		"pushfq\n\t"
>>>> -		"popq %%rax\n\t"
>>>> -		"andl $1,%%eax\n"
>>>> -		: "=3Da"(rc)
>>>> -		:    "a"(regs)
>>>> -		:    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
>>>> -#else
>>>> -	asm volatile("pushl %%eax\n\t"
>>>> -	    "movl 0(%%eax),%%edx\n\t"
>>>> -	    "push %%edx\n\t"
>>>> -	    "movl 4(%%eax),%%ebx\n\t"
>>>> -	    "movl 8(%%eax),%%ecx\n\t"
>>>> -	    "movl 12(%%eax),%%edx\n\t"
>>>> -	    "movl 16(%%eax),%%esi\n\t"
>>>> -	    "movl 20(%%eax),%%edi\n\t"
>>>> -	    "popl %%eax\n\t"
>>>> -	    "out %%al,$0xb2\n\t"
>>>> -	    "out %%al,$0x84\n\t"
>>>> -	    "xchgl %%eax,(%%esp)\n\t"
>>>> -	    "movl %%ebx,4(%%eax)\n\t"
>>>> -	    "movl %%ecx,8(%%eax)\n\t"
>>>> -	    "movl %%edx,12(%%eax)\n\t"
>>>> -	    "movl %%esi,16(%%eax)\n\t"
>>>> -	    "movl %%edi,20(%%eax)\n\t"
>>>> -	    "popl %%edx\n\t"
>>>> -	    "movl %%edx,0(%%eax)\n\t"
>>>> -	    "lahf\n\t"
>>>> -	    "shrl $8,%%eax\n\t"
>>>> -	    "andl $1,%%eax\n"
>>>> -	    : "=3Da"(rc)
>>>> -	    :    "a"(regs)
>>>> -	    :    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
>>>> -#endif
>>>> -	if (rc !=3D 0 || (regs->eax & 0xffff) =3D=3D 0xffff || regs->eax =
=3D=3D eax)
>>>> -		rc =3D -EINVAL;
>>>> +	asm volatile("out %%al,$0xb2\n\t"
>>>> +		     "out %%al,$0x84\n\t"
>>>> +		     "setc %0\n"
>>>> +		     : "=3Dmr" (carry),
>>>> +		       "+a" (regs->eax),
>>>> +		       "+b" (regs->ebx),
>>>> +		       "+c" (regs->ecx),
>>>> +		       "+d" (regs->edx),
>>>> +		       "+S" (regs->esi),
>>>> +		       "+D" (regs->edi));
>>>>
>>>>   	duration =3D ktime_us_delta(ktime_get(), calltime);
>>>> -	pr_debug("smm(0x%.4x 0x%.4x) =3D 0x%.4x  (took %7lld usecs)\n", eax=
, ebx,
>>>> -		 (rc ? 0xffff : regs->eax & 0xffff), duration);
>>>> +	pr_debug("smm(0x%.4x 0x%.4x) =3D 0x%.4x carry: %d (took %7lld usecs=
)\n",
>>>> +		 eax, ebx, regs->eax & 0xffff, carry, duration);
>>>>
>>>> -	return rc;
>>>> +	if (carry || (regs->eax & 0xffff) =3D=3D 0xffff || regs->eax =3D=3D=
 eax)
>>>> +		return -EINVAL;
>>>> +
>>>> +	return 0;
>>>>   }
>>>>
>>>>   /*
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK=
1 1PT, UK
> Registration No: 1397386 (Wales)
>
