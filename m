Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D546583A1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 10:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiG1IOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 04:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiG1IOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 04:14:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBDF558FF;
        Thu, 28 Jul 2022 01:14:30 -0700 (PDT)
Received: from mail-ej1-f43.google.com ([209.85.218.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MEVBa-1oEI2B08TK-00FyVa; Thu, 28 Jul 2022 10:14:29 +0200
Received: by mail-ej1-f43.google.com with SMTP id os14so1856711ejb.4;
        Thu, 28 Jul 2022 01:14:28 -0700 (PDT)
X-Gm-Message-State: AJIora9FPvL0gR1l+S5VNN3cqXFpOp0yWMu5fX6bjk3bGY8fuUCUbKgs
        6pC+P/MFr0TV6PIMJxat5RKUfENeurgrx/YpqmY=
X-Google-Smtp-Source: AGRyM1uZnW6rr1bCPNxIQUdrp0kM6xPGCPcbhZeXfyDuLh9ISG16R0mxcxin51/wlw+v1h4OcmNKLuYUaimGsuAUJj0=
X-Received: by 2002:a17:907:75d3:b0:72b:48de:e540 with SMTP id
 jl19-20020a17090775d300b0072b48dee540mr21044634ejc.547.1658996068658; Thu, 28
 Jul 2022 01:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220724122517.1019187-8-guoren@kernel.org> <202207280822.VHS6qieH-lkp@intel.com>
 <CAJF2gTQRV+6CZVkvhtsY19zv6XVbyDeRY-SdLPhkF0akHqvBWA@mail.gmail.com>
In-Reply-To: <CAJF2gTQRV+6CZVkvhtsY19zv6XVbyDeRY-SdLPhkF0akHqvBWA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Jul 2022 10:14:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2X3R40S5F2fDzUz+ZoxJLEjO8iaGGk7zBDaiRwJ_oGLg@mail.gmail.com>
Message-ID: <CAK8P3a2X3R40S5F2fDzUz+ZoxJLEjO8iaGGk7zBDaiRwJ_oGLg@mail.gmail.com>
Subject: Re: [PATCH V8 07/10] riscv: Add qspinlock support
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Muellner <cmuellner@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        kbuild-all@lists.01.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:EPBBFF7tTppyqzLu4oHUzrvsecdQ7sck/LVZjFIycqDphCGT1j6
 AoDVeMD2kk4uIcP0AqwUYf435ddB9vE9qvcJMUshYioowCLtxGmxgjvK8TzDVUq/sYjBNK/
 YJVtmPGMW1JXwORRcG1nATBka19JOpfN16a4mbJylRuMUNy8CXzF0+Jf3tQJJAB32JyF552
 NYkoerylFJdleHCiZ+luA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nc+duWjHVdk=:nJHnEqN2av3CH1uE0jvaTI
 Nl6kbhTUCEXzA+Kud5JscJkxOQFzsSf0m3Ye5/MKFm2glHDGOtrFUWdL45GQIlvYljACvDDzw
 YozoOxrB9bRu0zO5bmEruZ+85g/S71AfifXk3MPaCaDpRiwTw4Gj8AfmYwJtUqMGrasQwtAIQ
 6rqAjdoHxw+atN8KaG3B+3S5ZMzrvjNXkjgHMOQm/x7BtzR2C7qkgkY7Tzu1NuIYjqIO8DpY6
 TsVZaJE2qMtQchWSozE9HGYR4/iDuz0BVR6Qf9Fi5gumpPPaDPmmzYcqK2wHB1RPJEzAje7KR
 tkj2oQH1+QnIaRZBK7CvDTuHU/OdlKrCpinfnYuz5i5GJdfCkQNt7+uwfI8pHYvKc5YCh21y/
 fShciMrX/8ceIOOgNTJ0BLJ0ayvKSH9UHkGWBK8hlLEARIa/SJsX3k4rak6xDEJq3vGJ0rChL
 n2SPEusuCA7f787juYxLfp5hzSo8WYGe+i751wevb5uqmO7FoJIEXZxYUJpQjNNChb1LLnqKE
 LWyb7Gq6y4LEPKL/Qqd87k/fhB+tNDdWhNhYAgM2an2h9UkV7ZyTUHnweB+8TgKNA1NRU55ME
 a9+ePLxpQqrzv4LqIl5XCOKHxGkzap0RpA4Gi1Y2uyhZJ4D0Tb9nfkoMh4KoM3getfopb6JGv
 py31AxnLFucuQdRyhI6FyP4PtkgOrh5Lz0HrpBhCpiFG4swNw/+msotCr2AyHlkv1uHtYnsMN
 szm8kuhUyiqu/0hI9g9mdXNlDVU5Q9E5ylZNMw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 5:35 AM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Palmer,
>
> The warning is from a clang problem.
>
> drivers/net/wireguard/queueing.c:
> static void __wg_prev_queue_enqueue(struct prev_queue *queue, struct
> sk_buff *skb)
> {
>         WRITE_ONCE(NEXT(skb), NULL);
>         WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);
> }
>
> The queue->head is 64bit pointer size.
>
> #define __xchg_relaxed(ptr, new, size)                                  \
> ({                                                                      \
>         __typeof__(ptr) __ptr = (ptr);                                  \
>         __typeof__(new) __new = (new);                                  \
>         __typeof__(*(ptr)) __ret;                                       \
>         switch (size) {                                                 \
>         case 2: {                                                       \
> ... Clang shouldn't give warning from here, because code won't enter the path.
>                 break;                                                  \
>         }                                                               \
>         case 4:                                                         \
> ...
>                 break;                                                  \
>         case 8:                                                         \
> ... The case would enter this path.
>                 break;                                                  \
>         default:                                                        \
>                 BUILD_BUG();                                            \
>         }                                                               \
>         __ret;                                                          \
> })

I assume it's this warning you are referring to?

>> drivers/net/wireguard/queueing.c:68:18: warning: cast to 'typeof (*((__ai_ptr)))' (aka 'struct sk_buff *') from smaller integer type 'unsigned int' [-Wint-to-pointer-cast]
           WRITE_ONCE(NEXT(xchg_release(&queue->head, skb)), skb);

I don't consider this a bug in clang, it just performs the normal type checking
before dead code elimination and complains about code that clearly violates
the type rules.

I would suggest you split out the 16-bit xchg() into a properly typed inline
function and add type casts when calling it. In fact, I would love to
completely eliminate the 8-bit and 16-bit cases from the regular xchg()
and cmpxchg() interface and require all callers to explicitly call the
xchg16()/cmpxchg16() instead, as we require for cmpxchg64() on 32-bit
architectures already. This is something to do for another time though.

> >    include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >            val = __raw_readb(PCI_IOBASE + addr);
> >                              ~~~~~~~~~~ ^
> >    include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >            val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));

Not your bug, but I see that CONFIG_MMU=n risc-v has the same bug that s390 has
with missing I/O space support.  The correct workaround for this is to mark all
drivers using PCI I/O space as 'depends on HAS_IO_PORT' or similar and then
leaving out the definitions from the asm-generic header. Niklas Schnelle has
spent a lot of time working on patches for this, but they are somewhat stuck
in review. If RISC-V has the same problem, I hope we can get more people
interested in it. I think OpenRISC and C-Sky have this as well, but I'm not
sure if there is any plan to upstream clang support for those.

        Arnd
