Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0DF4F0670
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 23:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244465AbiDBVbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 17:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243844AbiDBVbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 17:31:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364571DA44;
        Sat,  2 Apr 2022 14:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648934951;
        bh=7yYtWMHnK6AVMZOBHrVxK81UGFtO3CpC0uUtw1WFFkw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hrVLRcJMX46o3hSrAMCOqLtAUECGQfibzskxQteSecownJnqZWbxJvKexs2G3kvU1
         0cD4uBQebnO8p0OYkZtwtxpEUPAjpVnQfYLnduQfjaywZA2oLjFI4a95vOz9gkKYo5
         PDOmXsHSZF7ND6lXvJnqFS+7J9RLwvuTAR5CNX5g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.149.42]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4s51-1nch722iE3-001xuL; Sat, 02
 Apr 2022 23:29:11 +0200
Message-ID: <ba21a1d3-26bb-cc80-57b5-6bd416de5e93@gmx.de>
Date:   Sat, 2 Apr 2022 23:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] parisc: Switch from GENERIC_CPU_DEVICES to
 GENERIC_ARCH_TOPOLOGY
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     James.Bottomley@hansenpartnership.com,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220401154137.GA3745625@roeck-us.net>
 <57e79014-25e6-62d3-27de-64797e43992b@gmx.de>
 <927a54f9-b413-0c71-461d-28ed9d5ece96@roeck-us.net> <YkdiDJZ/XHODymRk@p100>
 <6353bc69-901e-32e7-e736-00dd6a09a1ea@roeck-us.net>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <6353bc69-901e-32e7-e736-00dd6a09a1ea@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qzehXp0poiCdBkIlbE8WwHR4L7EsVNc/e7hthJeT5hHoT3XUu1l
 ep6AM+jlkPXd8gy2ONlcRwf2bGuWAcBGjLZPe0b7HPJ2vN+ADYSoVzMLPQtdsOOoBJpFvuX
 s2kec7+BK95oe0Q+2Cx+h0gzfEwaAmtGk5DzF3bkpHG2Liv4OZgcsMtqiU3hKpCT+cgnDx5
 KAq6nTLyfCcnEh0htZ3TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y2azOLBicSg=:U2aYiByJG1xJC3T/7WN0Ps
 mfgNpTAQWigMirN7EqtWTItQklPIcRNNQrggCfGZkaU6mNWnxqh5/BhdjfC6K2Ds19Bpp0Pbf
 G3aKNCvuuzzv8qFmqpujeJDy46vxNYbOFOKsrpVi+MDAc4KtLVma5uExdA/LvxRk62dAE8Ba9
 p6M3quuuHnF1ku58Bm7J0qsMyZsdupBhj9Hnj14V3AqEWo10c1FqPFw5/tR9GiFbvFny3tDea
 TIUaGyOc9STNr7c93A4mTlsqqZ9ua0iq33cujijEBf7yfdA59SMciHlqMch4q5dve2lDNY4Iy
 922vMLtWHetWHKQKquSGANPYh87CjOtDeUeMyI0+/yjRng/uUvtrWIjYlsLkaLXDFA0VpqpqV
 uOjs4qVWHCWDUgq3r7iPR3y1hcV4zTVbdAsP+l8+2kq+/zQnoKMzOoQdsDxcruxRl93h/pNUT
 mn4lk8Eb2EBpXbvqeF+ku7w2J+WMpBc1JlKBpQRYUWDfS/mJdxKp1s1crMavXH6RqMcZJOf/I
 wpJGDV8sHdPXAOlHbwZ2u6BRrxqraH+FX4ZNyV+3e16zlma9NZuG0Lx0o6vf2N5ZQ9W7BNFPv
 fwiz4j3jYdfR/yRcjcCoaKIqHzofeY/ueYcWWdN6uth4x9M4p941oSNuBOY+j2Zkoznxa0ecN
 v1kTW9PSD6PejXfbMg0YfDji7gT+Tiktpol5k5dSKWNHrD+w7dZLtOoZfvR1I4lh/3frik2FY
 zCCwAOMy+wOygbJYkQjpnJo7rP9G+HpvK5AHDCXDr4F9Jz9SOzza6kDBLUiimsarls68/dl8Y
 fHNTH/21OH0PfvlCS+YRPuxLfj8bfXDnTNqpw5BkLW+KG7Jpg9TEEu1bxbNFTKPTdHdofssmW
 vJPaeiriyjcyz9t+rKo70q1QBUdrevpAwcHkahjJo2Ui6psQtYHvidgo21/eB7jQoBLhzDcDZ
 KkZoWFrsqBfhg984+5dZu9VEw68+Q9vGEcf/5lQ7Y60rW++gfc1XsMp99X8iuXUEBxG+Sa1Vu
 qwG4FUGlZp1dACYi383JySzOR5QIxicTyH8OL54KjkJoe1XRGuPkciq8hquiKsM5p7++qrIsP
 zATu6ovfvBvZu4=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/22 23:27, Guenter Roeck wrote:
> On 4/1/22 13:35, Helge Deller wrote:
>> Hi G=C3=BCnter,
>>
>> * Guenter Roeck <linux@roeck-us.net>:
>>> On 4/1/22 09:47, Helge Deller wrote:
>>>> Hi G=C3=BCnter,
>>>>
>>>> On 4/1/22 17:41, Guenter Roeck wrote:
>>>>> On Thu, Mar 24, 2022 at 07:46:50PM +0100, Helge Deller wrote:
>>>>>> Switch away from the own cpu topology code to common code which is =
used
>>>>>> by ARM64 and RISCV. That will allow us to enable CPU hotplug later =
on.
>>>>>>
>>>>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>>>>
>>>>> This patch results in the following traceback when
>>>>> booting generic-32bit_defconfig - SMP in qemu.
>>>>
>>>> That's strange, because I just built this generic-32bit_defconfig mys=
elf and
>>>> it boots up nicely in qemu for me. The only thing missing is CONFIG_C=
GROUPS=3Dy so that
>>>> systemd can start.
>>>>
>>>
>>> Did you disable SMP (that is what - SMP was supposed to mean) ?
>>> Also, note that the system does boot fine, it just spits out the warni=
ng.
>>
>> The patch below fixes the warning for me.
>> Could you try?
>>
>
> I did, and it fixes the problem. I just sent a Tested-by: in response to
> your patch.

Thanks for testing !!
Helge


>
> Guenter
>
>> Helge
>>
>>
>> From: Helge Deller <deller@gmx.de>
>> Subject: [PATCH] parisc: Re-enable GENERIC_CPU_DEVICES for !SMP
>>
>> In commit 62773112acc5 ("parisc: Switch from GENERIC_CPU_DEVICES to
>> GENERIC_ARCH_TOPOLOGY") GENERIC_CPU_DEVICES was unconditionally turned
>> off, but this triggers a warning in topology_add_dev(). Turning it back
>> on for the !SMP case avoids this warning.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Fixes: 62773112acc5 ("parisc: Switch from GENERIC_CPU_DEVICES to GENERI=
C_ARCH_TOPOLOGY")
>> Signed-off-by: Helge Deller <deller@gmx.de>
>>
>> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
>> index 52e550b45692..bd22578859d0 100644
>> --- a/arch/parisc/Kconfig
>> +++ b/arch/parisc/Kconfig
>> @@ -38,6 +38,7 @@ config PARISC
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select ARCH_HAVE_NMI_SAFE_CMPXCHG
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GENERIC_SMP_IDLE_THREAD
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GENERIC_ARCH_TOPOLOGY if SMP
>> +=C2=A0=C2=A0=C2=A0 select GENERIC_CPU_DEVICES if !SMP
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select GENERIC_LIB_DEVMEM_IS_ALLOWED
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SYSCTL_ARCH_UNALIGN_ALLOW
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select SYSCTL_EXCEPTION_TRACE
>

