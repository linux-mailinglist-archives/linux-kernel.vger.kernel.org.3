Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D36E4E5F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348478AbiCXHW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348468AbiCXHWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:22:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799A95AA76;
        Thu, 24 Mar 2022 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648106429;
        bh=2/UvHzuUUyscf2fhqikJRxORuAXsxzHMymQM9y+btqc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EeE87+9t6u0n/nobY8zc/5TpmqUgA9m1/O41qdWYW1e1QkJrFeh5kDrHphLLcmjr+
         JYtZy95UqCt1ulKQHjU0rpeYBgU+ZG69XKOKY65cDMGJILSatE2lthbtar37nxsWuv
         yQTAMGUjyG39vJFf2yKiHtyqKuDXF9palrEQqJVM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.161.116]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHMP-1nvv8O2SLp-00kftT; Thu, 24
 Mar 2022 08:20:29 +0100
Message-ID: <af596db9-07c7-ca6a-46f6-546e9f39e471@gmx.de>
Date:   Thu, 24 Mar 2022 08:20:25 +0100
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
 <4d52b78d-ed39-102f-ba64-3ba9c17f58f9@gmx.de>
 <11063f42-6d3c-64d2-f3ed-9593be469fa5@roeck-us.net>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <11063f42-6d3c-64d2-f3ed-9593be469fa5@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0uCtjdns2xZ4gwRD0WXGfyXNB/1V/2qMQMYtaMPEXU4t6RGcvX5
 ENyzxA89FRXOdcXpbAhdy86FzFaDsYOuG/iRf3G29UZT3kF/7deRyDOwbUk7TzEr3DjQkRl
 oLN/9H4I1WpkYEyB9xgM3/UjKLlrpwWobJ0OosqtGe30jLXK3v0/+RSfwbYoBtSn39wc9iw
 wH8bAiLjwoSpw2KHRHOFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gd8qceJ6w88=:QMPNCrIrwCdbi4wLLU3iq1
 6EtzFrYt2x/K8ZCeTclOgtDG75jc0JQ8vYB5gzUhJGJ/gT2g14+Cx0WkKJLcXNRr40mFI0QHa
 fp91l+v0dZuxG/mRG6/f4hZn8pDk8fv+zVf/j7U2476wXz/BXkw7tBeyktYdOrsBMvM8rvefq
 EjEBqZniSjy1z8uEIsnotz2ONeKpiyQkdyyQAXadMK2Dd8prZ52HojeSp1MYes0oDTaQA91gw
 k5i2yI+FCcA90z8iPGbxkJC3KUD7hvn23308cv7ZqfAJTUtwiSDWnOaDxkvRMmsa9dlugO1e1
 O1rFgF1FtkLTmHkgAGmk4TV9Ww68/zbRyLrKBiIImTy1QbSrLcu5fu1Om4g9I3Vo6vPf8mU77
 oV28uW4PnLoalGXFbMbiVxayxje+l/Eh9oVPmiQcujGfLSbUOG5/3mSWM/JM6zIUENt0EOJjD
 /qgvUV95jL56KybVcp8TVEkERJzXVZotcgKqtotCwqaNv7fglDV4Q0ZqnNjT68X665KacZAd9
 dQKlSHu8m00jJ7w027j/g8cLAkUTGnwnBTeNf1Jm7rbED1Lt2DBV5TcOLUrzjr5YnZypnB3xB
 j21Ib0f9m3nomTQt39BlfRIgFggUjWIBe9rVBkUUubjVhk02AQVnDEMCNyKJisItLTLluTJnu
 +4GSTNj3BBVWrTQUIRfHvAZPn8FMGoHdmxvJ11KrpHoaxDT04zcV+SCPycJ/1y63oWoQxvGd3
 bFb+5kHR5MjqTqQBg5auNMP3TTz183ThajPZwv3SjeL5EjNNvceo6JjX401sX3Kzv61MiGYZj
 w1YsqdTPo3qkEsn3KZozXdrjNGgYy2qjFzCeSyU82B+82EgqTvzTRKkW+GScBoYy0pO1yLWp9
 vb3ShPlpwYcxq5Log/+rDi5zQCyvKkR3YBjogSgN1i45WJS6mCN0VS2OQEuhVWHx0R8axOUtE
 mr5/Q2XXRe7Qgonj9QoE/+GKWOxLoBYXHr9C2JtWtsmU6l0H+KQMQTKbHOEjGljYvec513EAO
 bskSSfV3+AG77BhX1WJo1DLRg/WbfK98/9n97UxBa7XZFV4I6ABOyAxElhMRR4dRJAWZT3O3L
 5Rls3K2xOoK0eA=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 18:50, Guenter Roeck wrote:
>>>>> Building parisc64:generic-64bit_defconfig ... failed
>>>>> --------------
>>>>> Error log:
>>>>> arch/parisc/kernel/vdso64/Makefile:30: FORCE prerequisite is missing
>>>>> arch/parisc/kernel/vdso32/sigtramp.S: Assembler messages:
>>>>> arch/parisc/kernel/vdso32/sigtramp.S:39: Error: unknown pseudo-op: `=
.proc'
>>>>> ...
>>>>> arch/parisc/kernel/vdso32/restart_syscall.S:32: Error: .cfi_endproc =
without corresponding .cfi_startproc
>>>>> make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/ker=
nel/vdso32/restart_syscall.o] Error 1
>>>>> make[2]: *** Waiting for unfinished jobs....
>>>>> make[2]: *** [arch/parisc/kernel/vdso32/Makefile:34: arch/parisc/ker=
nel/vdso32/sigtramp.o] Error 1
>>>>> make[1]: *** [arch/parisc/Makefile:177: vdso_prepare] Error 2
>>>>> make: *** [Makefile:219: __sub-make] Error 2

To recap - the solution was to add CROSS32_COMPILE=3Dhppa-linux-  , e.g.:

make ARCH=3Dparisc CROSS_COMPILE=3Dhppa64-linux- CROSS32_COMPILE=3Dhppa-li=
nux-

The better solution (for kernel >=3D v5.17) is to simply leave out the CRO=
SS_COMPILE/CROSS32_COMPILE
parameters and let the Makefile autodetect everything:

make ARCH=3Dparisc    -> 32bit kernel
make ARCH=3Dparisc64  -> 64bit kernel

It's now documented in the Wiki:
https://parisc.wiki.kernel.org/index.php/Cross_compiler_toolchain#How_to_b=
uild_the_kernel

Helge
