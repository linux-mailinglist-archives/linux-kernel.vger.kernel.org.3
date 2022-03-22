Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C2D4E440B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbiCVQSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbiCVQSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:18:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3027EB1E;
        Tue, 22 Mar 2022 09:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647965793;
        bh=F6WLBIO9AkZhj7l3Wrau4KMhfoblbH6OC/1yWXtZnBI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=DNr2RE1WJai2WZSr5wCSSKn5Ik7riDf0SZuC6IQknVkoiRWHPpI12UbT5b2E9CPS1
         27vaoLM1wKTnlpVitz6MCYhWZo4UzpSIDrL8RgVZJ/jLNv7VkzaXZkxbgXTehS9z/P
         VRVv6ar2+Qb3UCNnU40BP3/odFEYCiYuLdspGiTo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.191.132]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryTF-1ntKLs2hs5-00nwzV; Tue, 22
 Mar 2022 17:16:33 +0100
Message-ID: <4d52b78d-ed39-102f-ba64-3ba9c17f58f9@gmx.de>
Date:   Tue, 22 Mar 2022 17:16:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: hppa vDSO and compiler (non-)support
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-parisc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
 <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
 <d2a09bf3-9bd3-588a-99a1-598281d08678@kernel.org>
 <dd4e55aa-0b3e-6e18-7ec2-3bec02cafde0@kernel.org> <YjjJNb0D/b+ZXBVZ@ls3530>
 <28696c20-21ad-b0ac-8093-4ce07225fcd8@kernel.org>
 <812d4a38-8cb1-a7be-c504-87d095aea883@gmx.de>
 <20220322130516.GA724287@roeck-us.net>
 <ccc25312-890a-a534-1681-5ecde56328d0@gmx.de>
 <78abe69b-7914-1b38-c94e-7143f61f4909@roeck-us.net>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <78abe69b-7914-1b38-c94e-7143f61f4909@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:b2DAvetGLdxAO6CU/aDnMkQ1MLIIKAHZtTcU+nmyjTOKeaCT3sN
 gHA6BtuLBzl5cd6p35WpxbfelzpJ4/oxY94+M7aAFA6ES8vSwgECm/FCl9VBH5SAHv4hewu
 zO1XVYta8wUKweTvBI8isWYRF1remEiFXrtdwicEy9hpf5Zz/2aPN5oSkQO2S5x2B/ejdGE
 Vb54p4kqcYZtvA/kIcE+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n35AoG1nhyc=:FMmG0DSD5fVY8VhySAE8TB
 050KayzVY58zdD4jLXfZgz8KCNsJwAl1OdTDkhCeZ5zQnvoFLtPxQ0/znN0ZsXZ6oUy0DI3jO
 G8Z7no+qkRR9CAPNFF16F0FwNY0m+g2s1xko5MUSWT3z+mZJ29n5lh7kRdbgsdcxz3pb4z2J8
 37igv6no8x17d67vFNJ2LEY1yRkFbOWqg7Yzz2UgzRld3C/8/xNbn/vFvOkIAZZ7vI2n5R2gh
 VdRBV5DxzPxfZOKksGp6l2pisAb4acYQD5JsiNtbszlAI/nHCMIQs2ZKj+YbQwmZAcg4jEgZ9
 cf25LCSZAHr/fwJTGeDsrTjcO3c58CRsRcD5Kaxsf2zm5BiI985FohB6Yefh2ceStPPWB/v7n
 9AzKFRCAd1An4B+ulNGqe9u0Ayj0SJsMgqjcs/ab2G7Vxc8b+iDj5VdZwYnu5yvrl85gHftUa
 ptdWYUemG6O+mb76AgecH/CgW9j0t6DAPCwPnb05q56vUPMIiZJ8zLabikjKdConzZw+GBSdm
 +IeCq6DD9jH+ZAfwlFVAIaY/L7/uefxXDBXVm7YgaER0OdS3gRKZZZvqEKvyUDqo9soI9yDsU
 b6f0KVFpj+172WLkIl19tS7kJVU0oFkKH9cCSokhB6iQUsK7zl30/G2PRXXImlwIdJQaX+zuN
 BC3ctFW1oEzVEaKN6BHjb58qotPeh8NG2SNSVGyC/EPO6JGYBiNuZHA0H+D4g6Q2tVNSjUFBr
 Iq2LRrG3HGDghRETzgL70PzlQHkQo7GvhzgUH/u9RyNRquDD4ir9/GEHXQZG/yPMhJnk9XbU5
 XXgAO2SIHyv96KQW/LI+GLzDzWd453f0PY58cUK4cPlx4nX2GIoHyfStG8A1nn2EanEPutueP
 Ds8JqSLJhMwVr5jvjDJnYMUt52IUGdq+fUzFav6+BnIOTg7y8KfjzquDOXeC0rPFFbfwH4Zin
 iHHp2vlSCX1FW0tGdSxoI26F/+g0NLQp7E+YXtzL/Ex49ranfEsxEsTiCQg+RXduKeJQELxXL
 2zwp4kdja+PFuwpJJWub0jTLCpDJSapMTjRjnHcIyupOGoEh1erkI1hHLbldEsVItwE21hWd9
 ZCSvSGn7JD1Uns=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 16:19, Guenter Roeck wrote:
> On 3/22/22 07:25, Helge Deller wrote:
>> On 3/22/22 14:05, Guenter Roeck wrote:
>>> Does that also fix the build problems now seen in mainline ?
>>
>> No.
>>
>>> Building parisc64:generic-64bit_defconfig ... failed
>>> --------------
>>> Error log:
>>> arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
>>> arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
>>> arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `.p=
roc'
>>> ...
>>> arch/parisc/kernel/vdso32/restart_syscall.S:32: Error: .cfi_endproc wi=
thout corresponding .cfi_startproc
>>> make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kerne=
l/vdso32/restart_syscall.o] Error 1
>>> make[2]: *** Waiting for unfinished jobs....
>>> make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/kerne=
l/vdso32/sigtramp.o] Error 1
>>> make[1]: *** [arch/parisc/Makefile:177: vdso_prepare] Error 2
>>> make: *** [Makefile:219: __sub-make] Error 2
>>>
>>> This is with hppa64-linux-gcc (GCC) 11.2.0.
>>
>> Can you check if you have the 32-bit compiler (hppa-linux-gcc) installe=
d too?
>> The errors above happen when building the 32-bit vDSO, for which you ne=
ed the 32-bit compiler.
>>
>
> Yes, I do, but that doesn't help much if I want to build a 64-bit target=
 such
> as generic-64bit_defconfig. Am I missing something ?

The 64-bit PA-RISC kernel now includes a built-in a 32-bit and a 64-bit vD=
SO for userspace.
To build the 32-bit vDSO (vdso32) you need the 32-bit hppa compiler instal=
led.
That's what's being done above - see the path: arch/parisc/kernel/vdso32/
Can you try "make V=3D1" to see the command line?

Helge
