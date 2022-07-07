Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB3569D77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbiGGIbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiGGIbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:31:19 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222814D4D2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:31:18 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9773F3200645;
        Thu,  7 Jul 2022 04:31:14 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Thu, 07 Jul 2022 04:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1657182674; x=
        1657269074; bh=lID+xeUqMXtL0IhAsmdbChSx6RqMj0NKkfTfFacEB6U=; b=b
        n9kwemExt/Z4AexJfIHsATJZHH7UNHMtlBiVCDl97ZiEk8MAnSCvsMAmN6N12D1s
        vWjWXoGOhjKJi38WY7uzptADQj3Ac20lOLImsPiTuYmCSjKDeK/tIXyfYWgZzGeU
        75DavsPBDTyCf1t9zpe+wpdh30q0YpZWiqBhyVH4mlZnxhmgHGv3gFtHiUgZa7p9
        yikmnUUsbATlcMl6lEWHUmUvcGP/P5E1GSwhmv12YPo1hW1kgFaJp5ZaRhIz1nBL
        5oyNYVB3igA6x2wn86loEfT4E+zbSq2A7h1P3cbZOBQS1Z5OqZ6tuvJPc6KeHwzz
        Y+h/5IfjTK8Stwwya1K0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1657182674; x=
        1657269074; bh=lID+xeUqMXtL0IhAsmdbChSx6RqMj0NKkfTfFacEB6U=; b=K
        fF79fUJXNq0huGbM0lusG209u5WOvftqJCMXEg1eXHPLQWDQnF/iRxirSFPYzrdq
        qlCaFPQuwwu0FmxKNctdCud52FgVPfejvPY+q/5npa4Lz7YsK9fCf6Ecu9VTMZ6K
        np74NHi0GIimdFrcKkI3RmCoIUscbdScJF2Q9/rduBrwtf9V7V63mX6P7e6Iqqve
        5/rVM0ocN5f8Ppw9vJUM1KPgFESCR3uGUvoYKyWi+YT+SzYJC9q011W+OSCHdJ/a
        kLFBtrRAC+lESWzPJlcKSoM3k/Fo44VIqc7s9M+RUklVr0LyW+lcxRKzg9DIwHWe
        a6Gd9QWoVpLqhP4miu3/w==
X-ME-Sender: <xms:0ZnGYhGWkF1WgLcL3dYKvGMFX8c7DoLQNZHn3M1xeU9nWGMbplFttw>
    <xme:0ZnGYmVHBRsuPHPg7vwtjKe2eM0EgN5s9MypgaAH-bKiQL7SZstARyNe0WJZZje4Z
    msVXxmovdngpEVW44g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeihedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeefteeuieffudeuteejudffkeduleffhffhtdehvdeg
    vdeggefgjeetleegjeevhfenucffohhmrghinhepmhdurhgrtghlvghsrdgtohhmpdhfph
    hurdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:0ZnGYjJ84J1XB-QVVVCaNSWSxEfZYM4n63qdcUqy9obOcr111q0sGQ>
    <xmx:0ZnGYnE5JQdd3i__QwW52WyKuNpM-zzwBqDVwVrqJUKdMM3nQXoVnQ>
    <xmx:0ZnGYnW_5Kpef6Us3Z4yU6b0gjsjuxI78StAJy_h_OycbU-3UVQsdQ>
    <xmx:0pnGYkhmGi4GfZ1bFAaChcpMFxn3m6p07qPYjjcu7bMjwF5ENiadYQ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 72ADE36A0071; Thu,  7 Jul 2022 04:31:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-719-gc39a70fa89-fm-20220629.002-gc39a70fa
Mime-Version: 1.0
Message-Id: <2e0bb05b-cd85-4eb0-bf8f-f90156196a63@www.fastmail.com>
In-Reply-To: <8a9cd14a-54ed-cd2b-88ad-647a43b09d0e@loongson.cn>
References: <20220706112937.1218573-1-huqi@loongson.cn>
 <CAAhV-H6MHjzdwyZqk6a3sKByRofG1Th6QEk0Be5NBhiAsVNcTg@mail.gmail.com>
 <8a9cd14a-54ed-cd2b-88ad-647a43b09d0e@loongson.cn>
Date:   Thu, 07 Jul 2022 09:30:40 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Qi Hu" <huqi@loongson.cn>, "Huacai Chen" <chenhuacai@kernel.org>
Cc:     "Xuerui Wang" <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] LoongArch: Remove vcsr in loongarch_fpu
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E5=9C=A82022=E5=B9=B47=E6=9C=887=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8A=E5=
=8D=888:35=EF=BC=8CQi Hu=E5=86=99=E9=81=93=EF=BC=9A
> On 2022/7/7 14:45, Huacai Chen wrote:
>> Hi, all,
>>
>> I have rewritten the commit message. If no problem, this patch will be
>> queued for loongarch-fixes.
>> --
>> The `vcsr` only exists in the old hardware design, it isn't used in a=
ny
>> shipped hardware from Loongson-3A5000 on. FPU and LSX/LASX both use t=
he
>> `fcsr` as their control and status registers now. For example, the RM
>> control bit in fcsr0 is shared by FPU, LSX and LASX.
>>
>> Particularly, fcsr16 to fcsr31 are reserved for LSX/LASX now, access =
to
>> these registers has no visible effect if LSX/LASX is enabled, and will
>> cause SXD/ASXD exceptions if LSX/LASX is not enabled.
>>
>> So, mentions of vcsr are obsolete in the first place, let's remove th=
em.
>
> Or simply say this?
>
> Remove VCSR from "loongarch_fpu" which is used for debugging.

Then you it will be a cross talk vulnerability if you simply ignore it i=
n kernel.

Processes can create a covert channel for surreptitious data exchange ba=
sed on VCSR like m1racles[1] for apple m1.

Thanks
[1]: https://m1racles.com/

>> --
>> Huacai
>>
>> On Wed, Jul 6, 2022 at 7:29 PM huqi <huqi@loongson.cn> wrote:
>>> From: Qi Hu <huqi@loongson.cn>
>>>
>>> The `vcsr` is not used anymore. Remove this member from `loongarch_f=
pu`.
>>>
>>>  From 3A5000(LoongArch), `vcsr` is removed in hardware. FP and LSX/L=
ASX
>>> both use `fcsr` as their csr.
>>>
>>> Particularly, fcsr from $r16 to $r31 are reserved for LSX/LASX, an
>>> using the registers in this area will cause SXD/ASXD if LSX/LASX is
>>> not enabled.
>>>
>>> Signed-off-by: Qi Hu <huqi@loongson.cn>
>>> ---
>>> V3:
>>> - Modify commit message to conform to the format.
>>> V2:
>>> - Add more details in the commit message.
>>> ---
>>>   arch/loongarch/include/asm/fpregdef.h  |  1 -
>>>   arch/loongarch/include/asm/processor.h |  2 --
>>>   arch/loongarch/kernel/asm-offsets.c    |  1 -
>>>   arch/loongarch/kernel/fpu.S            | 10 ----------
>>>   4 files changed, 14 deletions(-)
>>>
>>> diff --git a/arch/loongarch/include/asm/fpregdef.h b/arch/loongarch/=
include/asm/fpregdef.h
>>> index adb16e4b43b0..b6be527831dd 100644
>>> --- a/arch/loongarch/include/asm/fpregdef.h
>>> +++ b/arch/loongarch/include/asm/fpregdef.h
>>> @@ -48,6 +48,5 @@
>>>   #define fcsr1  $r1
>>>   #define fcsr2  $r2
>>>   #define fcsr3  $r3
>>> -#define vcsr16 $r16
>>>
>>>   #endif /* _ASM_FPREGDEF_H */
>>> diff --git a/arch/loongarch/include/asm/processor.h b/arch/loongarch=
/include/asm/processor.h
>>> index 1d63c934b289..57ec45aa078e 100644
>>> --- a/arch/loongarch/include/asm/processor.h
>>> +++ b/arch/loongarch/include/asm/processor.h
>>> @@ -80,7 +80,6 @@ BUILD_FPR_ACCESS(64)
>>>
>>>   struct loongarch_fpu {
>>>          unsigned int    fcsr;
>>> -       unsigned int    vcsr;
>>>          uint64_t        fcc;    /* 8x8 */
>>>          union fpureg    fpr[NUM_FPU_REGS];
>>>   };
>>> @@ -161,7 +160,6 @@ struct thread_struct {
>>>           */                                                     \
>>>          .fpu                    =3D {                             \
>>>                  .fcsr           =3D 0,                            \
>>> -               .vcsr           =3D 0,                            \
>>>                  .fcc            =3D 0,                            \
>>>                  .fpr            =3D {{{0,},},},                   \
>>>          },                                                      \
>>> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/ke=
rnel/asm-offsets.c
>>> index bfb65eb2844f..20cd9e16a95a 100644
>>> --- a/arch/loongarch/kernel/asm-offsets.c
>>> +++ b/arch/loongarch/kernel/asm-offsets.c
>>> @@ -166,7 +166,6 @@ void output_thread_fpu_defines(void)
>>>
>>>          OFFSET(THREAD_FCSR, loongarch_fpu, fcsr);
>>>          OFFSET(THREAD_FCC,  loongarch_fpu, fcc);
>>> -       OFFSET(THREAD_VCSR, loongarch_fpu, vcsr);
>>>          BLANK();
>>>   }
>>>
>>> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu=
.S
>>> index 75c6ce0682a2..a631a7137667 100644
>>> --- a/arch/loongarch/kernel/fpu.S
>>> +++ b/arch/loongarch/kernel/fpu.S
>>> @@ -146,16 +146,6 @@
>>>          movgr2fcsr      fcsr0, \tmp0
>>>          .endm
>>>
>>> -       .macro sc_save_vcsr base, tmp0
>>> -       movfcsr2gr      \tmp0, vcsr16
>>> -       EX      st.w \tmp0, \base, 0
>>> -       .endm
>>> -
>>> -       .macro sc_restore_vcsr base, tmp0
>>> -       EX      ld.w \tmp0, \base, 0
>>> -       movgr2fcsr      vcsr16, \tmp0
>>> -       .endm
>>> -
>>>   /*
>>>    * Save a thread's fp context.
>>>    */
>>> --
>>> 2.36.1
>>>
>>>

--=20
- Jiaxun
