Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3FB4E3BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiCVJoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiCVJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:44:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2837EA27;
        Tue, 22 Mar 2022 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647942156;
        bh=1wN67HX2N9TL5KJKzjVuC341Ns0Ydj5PenlLPykx6fA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Iw0tcIFDp8ZFlHuBGdWx3EjC9swr6x3VB9RaiWMQ92tx8AsAxp4u0lQ29NgGwBUPZ
         CDK7e0wieOuFbrxu4C2g/rHAd4g7SKNS50QIboas9QmvKk+uJclJX7OxV9rXcJrLha
         ihqEHRZPGTJZThJ9EAvepxEt+qjEFbyqAVVq3R5o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.191.132]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7i8O-1oAguH34Og-014iL1; Tue, 22
 Mar 2022 10:42:35 +0100
Message-ID: <812d4a38-8cb1-a7be-c504-87d095aea883@gmx.de>
Date:   Tue, 22 Mar 2022 10:42:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: hppa vDSO and compiler (non-)support
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-parisc@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <d2713ae1-0ca5-9e5a-b7d2-b7d0f1f5614a@kernel.org>
 <2e1f3e41-7097-e68d-d312-9319ad62565c@gmx.de>
 <d2a09bf3-9bd3-588a-99a1-598281d08678@kernel.org>
 <dd4e55aa-0b3e-6e18-7ec2-3bec02cafde0@kernel.org> <YjjJNb0D/b+ZXBVZ@ls3530>
 <28696c20-21ad-b0ac-8093-4ce07225fcd8@kernel.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <28696c20-21ad-b0ac-8093-4ce07225fcd8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xIPTjJcE1zkdbS5QqNnxY9gM7vcXO8QMTyYcuZIoo6jY+519Rkv
 RzTRUnAg2b7xZ0a81TWkC2eT+5KBFVrrOtCTghQWRyPmp0Ae0DoajjJGQri00OrpeuLVzuS
 bRZ5nUj6K096f5KSPOoC21r3xvDBEjXGpBX5Jg8lgmznYq6Vx8nw9Ao04YzO9iz6zaKaTJt
 Du+muGIpDO4gWg4LjdSrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y7cSqoiIvow=:7XhylXVu4mxZTqhRFev+XE
 KwOqAUXMrcJOblLrve2S4GKFclnW87Fb90GDkWz6EY5NK5dk7Dg0bcR1tBcttEMRAOSgLEMxF
 MnoTL971GvkQV78eQJgLiuq4d0t0VzhF5GTFWvFoLRgamOITkqcuaEYeK3K9mmOJOlawUVfLB
 LOMVN41srzDwZ1IzL5xOQKYnJfeO5ZlreOFIB9JEHvagxxdUhAIEfKnFm9xWDvUMfjUE07Nhp
 gz0Ez6LwQDSMyeaSKnBSHuxc2EqEfrgOWaw2fqfKkM7SsgYWH3CkJfGT8bPBPc8bkMwQ4TxLx
 MR5fOiiZyJiyxXOszJM55/8tWOeQj1IWQCo2LvCX6VUF14FqVCLe8FW/96uAE624PGsN70POy
 6caeB1hKNzxfth2nD9WPbQBdZtuz6efjNouO9j3Rm97oDqFyDy+VM+v2GgdZPx6nmOPNYEGhc
 S9BkiamdUifGHLxV9r+Yn4qQ3CV8GKX3zptEeFJkCtHmX81sNN0hwhEGcMOE1VN/CyccB1U4a
 AvkYrWkxufMFf0yYXAH3GESuh9u+ientJPWFOrRGKxeZLqiDamzbvnd0JFNxOnYjBK6Z3o+/J
 Ivxun/D3DQ2V+YhFInE9v1/fWOwpxeQgkLwSDxprGKdfwq4/yXnAa9FxVVLzAs43Tswlxxtjn
 fsvwuei8IVhVJKlHqiBMM/CvKIikDQER/g6RQ/O/RtoAm30cbN6l75hukawldiTQj1TfWbe4w
 lRNEYbqbAKInS/gUss387+HZFLKAnkxg7O7iAlQBk4Etdoiu3lP962phXtsuNE/Dm8IY5SEcF
 ehELXIkGE4WbigBsKQ76P7EG305jTgsI2GaFZZjqqPnq6aqggEAhgE+poR/Y39LA0CRqEjkOD
 Sd/oyYT/pICSyDV1tYna+hCAHUYasnj+LUC3LUnu7r23ocDImB9A9S3RfltxZTJ1GIml4ZLif
 lVSk2NQUVQnjSlV64BpF1ZEMMICdNj0M5BM0sL2J2SBiMAd+mEQh05pG0ziy+mC3B+22cwys4
 xebQ9jwb1kk6WVuY97ecIEPqiKVgkStnjlwycsISqS63lof7Fz6mew5Jg2+2jgCXG5gi01Xv1
 l1hhDQTAnLUyvs=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 10:19, Jiri Slaby wrote:
> Hello,
>
> On 21. 03. 22, 19:51, Helge Deller wrote:
>> * Jiri Slaby <jirislaby@kernel.org>:
>>> On 09. 03. 22, 6:48, Jiri Slaby wrote:
>>>> On 08. 03. 22, 15:51, Helge Deller wrote:
>>>>> On 3/8/22 12:06, Jiri Slaby wrote:
>>>>>> since the "parisc: Add vDSO support" commit, I can no longer
>>>>>> cross-build a hppa kernel. I see two issues:
>>>>>>
>>>>>> 1) CROSS32_COMPILE detection doesn't work here, as openSUSE
>>>>>> provides hppa-suse-linux-* binaries. It's easy to overcome by
>>>>>> "CROSS32_COMPILE=3Dhppa-suse-linux-"
>>>>>
>>>> ...
>>>>> Would it make sense to add the detection for SUSE too?
>>>
>>> So, could 1) be fixed on the Kconfig side? Or should I (people running=
 SUSE)
>>> use "CROSS32_COMPILE=3Dhppa-suse-linux-"?
>>
>> Could you please try if this patch fixes it for you?
>
> Works like a charm:
> $ make V=3D1 O=3D../a/arch/parisc/ ARCH=3Dparisc -j6 drivers/tty/serial/=
mux.o
> ...
>>=C2=A0 hppa-suse-linux-gcc <flags deleted> -o drivers/tty/serial/mux.o /=
home/latest/linux/drivers/tty/serial/mux.c
>>=C2=A0 if hppa-suse-linux-objdump -h drivers/tty/serial/mux.o | ...; fi
>
> Thanks.

Great!
I've queued up a patch in for-next...

Helge


>
>> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
>> index 2a9387a93592..7583fc39ab2d 100644
>> --- a/arch/parisc/Makefile
>> +++ b/arch/parisc/Makefile
>> @@ -42,7 +42,7 @@ export LD_BFD
>>
>> =C2=A0 # Set default 32 bits cross compilers for vdso
>> =C2=A0 CC_ARCHES_32 =3D hppa hppa2.0 hppa1.1
>> -CC_SUFFIXES=C2=A0 =3D linux linux-gnu unknown-linux-gnu
>> +CC_SUFFIXES=C2=A0 =3D linux linux-gnu unknown-linux-gnu suse-linux
>> =C2=A0 CROSS32_COMPILE :=3D $(call cc-cross-prefix, \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(foreach a,$(CC_ARCHES_32), \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(foreach s,$(CC_SUFFIXES),$(a)-$(s)-)))
>> @@ -52,7 +52,7 @@ export CROSS32CC
>> =C2=A0 # Set default cross compiler for kernel build
>> =C2=A0 ifdef cross_compiling
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ifeq ($(CROSS_COMPILE),)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC_SUFFIXES =3D linux linux=
-gnu unknown-linux-gnu
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CC_SUFFIXES =3D linux linux=
-gnu unknown-linux-gnu suse-linux
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CROSS_COMPILE :=
=3D $(call cc-cross-prefix, \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 $(foreach a,$(CC_ARCHES), \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 $(foreach s,$(CC_SUFFIXES),$(a)-$(s)-)))
>

