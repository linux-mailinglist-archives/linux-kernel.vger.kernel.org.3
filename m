Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABA0523E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347582AbiEKUHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345072AbiEKUHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:07:18 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F0562D7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:07:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so5895119pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IZ67w/mh933XiD19vlG6O7B4SYRWnOVzoIExpzyMUE0=;
        b=g7UmHFS/LA2KGK9m6aKmUe1JQl60PJ06dQ7r5CAX7xMSNCw9tpdOpx9Aig9fcTU+ug
         7UK1Vg0N16rhaYBNrQ5vduoDtmOGZt/5yTUpmJpgIiMHSNqEqwipINdxP55PgDfBPt+U
         1Tu1J14t6o8MKU59QeIm4Z9FJXYzWJv0yRRyn5kFIWNXcPSbIFz3Fza/PEFfV5GfI8wk
         +c26A0nbMt5Wn7GANVzEm6kO8JNNRDaAltFn9ty0MX5eJ98syDFSWy66Z2aF1W6IX3PT
         +RGUNvIawY5r9hQS01eArNokDJCkKiH/hOi6J0r9F9zyt4OM4fUCCeDshuq+DogvxrTs
         Io2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IZ67w/mh933XiD19vlG6O7B4SYRWnOVzoIExpzyMUE0=;
        b=LyEPF6RhnDEjE/Kebnux7cqnhcRUQwGBrs9QdoArKZmuLLR80ynrGabEQIzsL3NDxa
         Bp5k1q/TbDW9Yc8qVwpf9ENyd7MYhpkuTEXHB6DQQAnNtfi5wWllI52GSuul1gpNWdeC
         LNltKFI1nnqild1ujZFiEHetBs++ws61sLdU1EY6br/TnNR5vBFMqdkyvbIRFy9VxNSp
         50K+FcXWU0SjIcFIge63jwvy4853Cs+u60j++tL6OwxNVVizGgJEc6oM4R0DNdrslI06
         JZW6sFtxFiNV+vCB96ptLa5exVIGkGc2wyjUX6M9gVJcqicKMTU8R6YowB4sDLE42JWo
         3K2g==
X-Gm-Message-State: AOAM532/m1Rer34Cs09rASOr6HxVXTlQnvPyor1iuLfGqZx/8MYOACXt
        uhed4QRzDUuITzRGv5LwBGkNBA==
X-Google-Smtp-Source: ABdhPJxLJe31QIcOOnwIRWdz+kNjZVtljkSMtGxZxRiKYxf+nhdigC4qKSGw0NxEWOvUa5CU+0D0rA==
X-Received: by 2002:a17:90b:3843:b0:1dc:3da2:7fd8 with SMTP id nl3-20020a17090b384300b001dc3da27fd8mr7016266pjb.219.1652299636416;
        Wed, 11 May 2022 13:07:16 -0700 (PDT)
Received: from smtpclient.apple ([50.39.129.137])
        by smtp.gmail.com with ESMTPSA id n3-20020a622703000000b0050e0a43712esm2176777pfn.63.2022.05.11.13.07.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 13:07:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: riscv: llvm-compiler: calling convention violation: temporary
 register $t2 is used to pass the ninth function parameter
From:   Craig Topper <craig.topper@sifive.com>
In-Reply-To: <CAKwvOd=OnJ=ZhsbX+epzbhg3sWg9yOaR=zQ4jF_Deo=B8Nx9Og@mail.gmail.com>
Date:   Wed, 11 May 2022 13:07:14 -0700
Cc:     Changbin Du <changbin.du@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Steven Rostedt <rostedt@goodmis.org>, hw.huiwang@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, codegen-riscv@discourse.llvm.org,
        llvmproject@discourse.llvm.org, asb@asbradbury.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <10BD31AB-C9F3-45FD-9A4A-EF7DC07C94D5@sifive.com>
References: <20220510065336.hlfjrc25ajed5zj4@M910t>
 <CAKwvOd=OnJ=ZhsbX+epzbhg3sWg9yOaR=zQ4jF_Deo=B8Nx9Og@mail.gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I=E2=80=99m guessing that because the function is static, the calling =
convention was changed to fastcall which allows us to ignore the ABI.

> On May 11, 2022, at 11:39 AM, Nick Desaulniers =
<ndesaulniers@google.com> wrote:
>=20
> On Mon, May 9, 2022 at 11:54 PM Changbin Du <changbin.du@huawei.com> =
wrote:
>>=20
>> [This is a resent to correct llvm mailist.]
>>=20
>> Hello, folks,
>>=20
>> Recently I encountered a kernel crash problem when using ftrace with =
'perf ftrace'
>> command on risc-v kernel built with llvm.
>>=20
>> This crash only exists on llvm build, not reproducable with GCC. So I =
hope llvm
>> guys can take a look :)
>>=20
>> The llvm versions I have tried are llvm-13.0.0 and mainline (commit =
102bc634cb
>> ("[runtime] Build compiler-rt with --unwindlib=3Dnone")).
>>=20
>> [  612.947887][  T496] Unable to handle kernel NULL pointer =
dereference at virtual address 0000000000000001
>> [  613.050789][  T496] Hardware name: riscv-virtio,qemu (DT)
>> [  613.087976][  T496] epc : __find_rr_leaf+0x128/0x220
>> [  613.107493][  T496]  ra : return_to_handler+0x22/0x24
>> [  613.125322][  T496] epc : ffffffff80a1915a ra : ffffffff80009506 =
sp : ff20000011e43860
>> [  613.150124][  T496]  gp : ffffffff81812f40 tp : ff6000008bb01580 =
t0 : ff600000806cf0f0
>> [  613.173657][  T496]  t1 : 000000000001b29a t2 : 0000000000000001 =
s0 : ff20000011e43920
>> [  613.187311][  T496]  s1 : ff600000848c2a00 a0 : 0000000000000002 =
a1 : 0000000000000002
>> [  613.202731][  T496]  a2 : fffffffffffffffd a3 : ff6000009d287000 =
a4 : 00000000000002c0
>> [  613.213723][  T496]  a5 : ff6000009d259b40 a6 : ffffffffffffff9c =
a7 : ffffffffffffffff
>> [  613.226648][  T496]  s2 : 0000000000000001 s3 : ff20000011e439d8 =
s4 : ffffffff8160d140
>> [  613.246571][  T496]  s5 : 0000000000000002 s6 : 0000000000000000 =
s7 : 0000000000000000
>> [  613.264681][  T496]  s8 : 0000000000000064 s9 : 0000000000000000 =
s10: 0000000000400000
>> [  613.277999][  T496]  s11: ff600000848c2aa8 t3 : 0000000000000290 =
t4 : 00000000004002c0
>> [  613.303729][  T496]  t5 : 00000000ffffffff t6 : ff6000009d2872d0
>> [  613.322145][  T496] status: 0000000200000120 badaddr: =
0000000000000001 cause: 000000000000000d
>> [  613.346228][  T496] [<ffffffff80a12526>] ip6_pol_route+0xb6/0x602
>> [  613.365722][  T496] [<ffffffff80a1321a>] =
ip6_pol_route_output+0x2c/0x34
>> [  613.386374][  T496] [<ffffffff80a1c028>] =
fib6_rule_lookup+0x36/0xa0
>> [  613.401865][  T496] [<ffffffff80a131da>] =
ip6_route_output_flags_noref+0xd6/0xea
>> [  613.412776][  T496] [<ffffffff80a13274>] =
ip6_route_output_flags+0x52/0xd4
>> [  613.432013][  T496] [<ffffffff809ffb3a>] =
ip6_dst_lookup_tail+0x68/0x23a
>> [  613.456198][  T496] [<ffffffff809ffec6>] =
ip6_sk_dst_lookup_flow+0x132/0x1cc
>> [  613.513174][  T496] [<ffffffff80003cd8>] ret_from_syscall+0x0/0x2
>> [  613.518973][  T496] [<ffffffff800094e4>] =
return_to_handler+0x0/0x24
>> [  613.563961][  T496] Kernel panic - not syncing: Fatal exception
>> [  613.572278][  T496] SMP: stopping secondary CPUs
>> [  613.587449][  T496] ---[ end Kernel panic - not syncing: Fatal =
exception ]---
>>=20
>> The crash happened when dereferencing the point 'mpri' at =
route.c:758.
>>=20
>> (gdb) l *__find_rr_leaf+0x128
>> 0xffffffff809da9c4 is in __find_rr_leaf (net/ipv6/route.c:758).
>> 753
>> 754             if (strict & RT6_LOOKUP_F_REACHABLE)
>> 755                     rt6_probe(nh);
>> 756
>> 757             /* note that m can be RT6_NUD_FAIL_PROBE at this =
point */
>> 758             if (m > *mpri) {
>> 759                     *do_rr =3D match_do_rr;
>> 760                     *mpri =3D m;
>> 761                     rc =3D true;
>> 762             }
>>=20
>> Adding some logs, I found the problem. The ninth passed parameter of =
function
>> __find_rr_leaf() which is the address of local variable 'mpri', is =
changed to
>> value '0x1' when inside the function __find_rr_leaf.
>> Here is the code snippet and full link
>> =
https://github.com/torvalds/linux/blob/9cb7c013420f98fa6fd12fc6a5dc055170c=
108db/net/ipv6/route.c.
>>=20
>> static void find_rr_leaf(struct fib6_node *fn, struct fib6_info =
*leaf,
>>                         struct fib6_info *rr_head, int oif, int =
strict,
>>                         bool *do_rr, struct fib6_result *res)
>> {
>>        u32 metric =3D rr_head->fib6_metric;
>>        struct fib6_info *cont =3D NULL;
>>        int mpri =3D -1;
>>=20
>>        __find_rr_leaf(rr_head, NULL, metric, res, &cont,
>>                       oif, strict, do_rr, &mpri);
>>        ...
>> }
>>=20
>> Then debugging with gdb, I found this probably is a compiler bug. We =
can see the
>> local function __find_rr_leaf() is not optimized out and the compiler =
generates
>> a local symbol for it. The find_rr_leaf() (inlined by =
fib6_table_lookup) invokes
>> this function with 'jalr' instruction.
>>=20
>> (gdb) disassemble fib6_table_lookup
>> Dump of assembler code for function fib6_table_lookup:
>>   [snip]
>>   0xffffffff80a1240e <+412>:   beqz    a1,0xffffffff80a12436 =
<fib6_table_lookup+452>
>>   0xffffffff80a12410 <+414>:   slli    a1,s9,0x20
>>   0xffffffff80a12414 <+418>:   srli    a1,a1,0x20
>>   0xffffffff80a12416 <+420>:   sext.w  a2,a1
>>   0xffffffff80a1241a <+424>:   addi    a7,s0,-125
>>   0xffffffff80a1241e <+428>:   addi    t2,s0,-124
>>   0xffffffff80a12422 <+432>:   li      a1,0
>>   0xffffffff80a12424 <+434>:   mv      a3,s10
>>   0xffffffff80a12426 <+436>:   li      a4,0
>>   0xffffffff80a12428 <+438>:   ld      a5,-152(s0)
>>   0xffffffff80a1242c <+442>:   mv      a6,s8
>>   0xffffffff80a1242e <+444>:   auipc   ra,0x7
>>   0xffffffff80a12432 <+448>:   jalr    -686(ra) # 0xffffffff80a19180 =
<__find_rr_leaf>
>>   [snip]
>>=20
>> And at line route.c:758, the value of point 'mpri' is stored in =
temporary register
>> $t2 and $s3 (copied from $t2).
>>=20
>> (gdb) info scope __find_rr_leaf
>> [snip]
>> Symbol mpri is multi-location:
>>  Base address 0xffffffff80a10564  Range =
0xffffffff80a19190-0xffffffff80a191ae: a variable in $t2
>>  Range 0xffffffff80a191c0-0xffffffff80a191d6: a variable in $s3
>>  Range 0xffffffff80a19200-0xffffffff80a19208: a variable in $s3
>>  Range 0xffffffff80a1921e-0xffffffff80a192fe: a variable in $s3
>>  Range 0xffffffff80a1930a-0xffffffff80a19356: a variable in $s3
>>=20
>> Let's see when register $t2 is corrupted with single-step mode. =
Obviously, register
>> $t2 is changed by mcount function ftrace_caller(). This is why the =
bug happens
>> to ftrace.
>>=20
>> Dump of assembler code for function __find_rr_leaf:
>>   0xffffffff80a19180 <+0>:     sd      ra,-8(sp)   #  $t2 =3D =
0xff200000120db7b4
>>   0xffffffff80a19184 <+4>:     auipc   ra,0xff5f1
>>   0xffffffff80a19188 <+8>:     jalr    -1744(ra) # 0xffffffff80009ab4 =
<ftrace_caller> #  $t2 =3D 0xff200000120db7b4
>> =3D> 0xffffffff80a1918c <+12>:    ld      ra,-8(sp)    #  $t2 =3D =
0x1, bug, $t2 is corrupted!!
>>   0xffffffff80a19190 <+16>:    addi    sp,sp,-176
>>   [snip]
>>=20
>> So now we can come to a conclusion. The generated local function =
__find_rr_leaf()
>> violates the risc-v calling convention and leads to the panic. It =
should use stack
>> but *not* temporary register $t2 to pass the ninth parameter! It's =
okay if the
>> callsite can take care of local symbol callees, but the Function =
Instrumentation
>> features should be considerated carefully.
>>=20
>> For comparison, here is the result from gcc (9.2.0):
>> (gdb) info scope __find_rr_leaf
>> [snip]
>> Symbol mpri is a complex DWARF expression:
>>     0: DW_OP_fbreg 0, length 8.
>>=20
>> I also built a simple test function with 9 parameters by clang and =
same cflags,
>> but cannot reproduce it. Maybe it is conditional?
>>=20
>> Simple test code:
>> __attribute__ ((noinline))
>> void test_func(int *a, int *b, int *c, int *d, int *e, int *f, int =
*g, int *h, int *i)
>> {
>>        printf("__find_rr_leaf: %d\n", *i);
>> }
>>=20
>> int main(void)
>> {
>>        int a,b,c,d,e,f,g,h,i =3D 100;
>>=20
>>        test_func(&a,&b,&c,&d,&e,&f,&g,&h,&i);
>>        return 0;
>> }
>=20
> Hmm...any chance you could come up with a more concise test case then
> using creduce [0] or cvise [1]?
> [0] https://embed.cs.utah.edu/creduce/
> [1] https://github.com/marxin/cvise
>=20
>=20
>>=20
>> --
>> Cheers,
>> Changbin Du
>>=20
>=20
>=20
> --=20
> Thanks,
> ~Nick Desaulniers

