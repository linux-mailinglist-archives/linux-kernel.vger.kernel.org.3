Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BA5473F10
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhLNJOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhLNJOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:14:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64A1C061574;
        Tue, 14 Dec 2021 01:14:35 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so13283348wms.3;
        Tue, 14 Dec 2021 01:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=qF8lBZ5iMDb3r4Amehwh7xdF2KQST4fK0CFeZuuJG5I=;
        b=VZuC9xr0XpasGrgwXvZqEraVGdAib+L0Swu7x5sE7PkNFajxirXqrkJ+bQ8u/Eb7bx
         7FwA78MSojsAOirwRXg45bVm+g3ZheTDtL3b8xFZh3MM9Og7L7x7jH3vgCqkOJn8NtZc
         SaDxh/ZUAGMatnnl+wYq+mP74Q7HLs9DRTB1QdyIlkVHzRWK8XjZqeVbMRUcb8csHjb/
         vQGKZbB1X8MdyWF48a+HQNrDZl8iz8oSIywmoyr7E+C+tKHvYTg++TBcxbNore9ItYkr
         jtRNgXandlY0bYqNdezsP+abuqLqBrUBSKM3qpDUUxxFy3GZvft/YPVJCh7chn1kwmpd
         DLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=qF8lBZ5iMDb3r4Amehwh7xdF2KQST4fK0CFeZuuJG5I=;
        b=nd1P/UVJ8XZxwF1Q9T9GjFr7Y5J+9yxLApgtu4CmCi8VlThHO2dITTG5/8lsEwfzRB
         ke1avE4EuVqn1P3BLa3n3vYmUZUM5odf3hBFufiXFblWr9x7ZxtCIreIsXjEVKZFEf1C
         /ckdZuZvH6SZ4skD/hCI1fxTiWaanhSDWfXTaMvKLMA9UKcJv0KVM26j0Y99XL2O57BK
         85YCgNzOpHf1PZlqDoHAQaxN6/6/+CM4RnZ0JjfuEOvEhnXwEWvfv/tQ+wjY9FMBhDCB
         9Jt/rgMqa5Tp3ml0L3F60Y7PREAkJHSDkl/IFdjzwTT5j/Bc5GHCw5VhGoVM/n9PQAhU
         CGGw==
X-Gm-Message-State: AOAM532AjaZYUsv19ifN+ou1ASVMYcYlNt+f6D0gwfwmLM+Of6CSvKRF
        vsOJgh+Sq9PEsXnS9KmTVP8+M8d15UUadi77UaoPJQ==
X-Google-Smtp-Source: ABdhPJzWFDwBx4XFxgxHALalG+dPZEAmV6YlN+V+dDdXvQCtaqRYMuQOBigjFuOxsIdBWcgltu7+OA==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr45947878wmc.187.1639473274154;
        Tue, 14 Dec 2021 01:14:34 -0800 (PST)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id n13sm13222560wrt.44.2021.12.14.01.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Dec 2021 01:14:33 -0800 (PST)
Message-ID: <a08653f5-338f-a233-fb0a-da8826844048@gmail.com>
Date:   Tue, 14 Dec 2021 09:14:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     linux-alpha@vger.kernel.org
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: kernel oops on malformed execve call on Alpha
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While testing 5.15 on Debian Alpha QEMU (5.15.0-1-alpha-generic) [1] 
with stress-ng's --sysbadaddr bad address system call stress test [2] I 
managed to trigger an oops.

The reproducer is as follows:

#include <unistd.h>
#include <string.h>

int main(void)
{
         long unsigned int x[32];
         char *ptr = (char *)x;

         memset(&x, 0x01, sizeof(x));
         return execve(ptr, (char **)(ptr+2), NULL);
}

The kernel splat is as follows:

debian-alpha:~$ ./a.out
[15601.552558] Unable to handle kernel paging request at virtual address 
0000000000000004
[15601.553535] a.out(1375934): Oops -1
[15601.553535] pc = [<0000000000000004>]  ra = [<fffffc0001218aa0>]  ps 
= 0000    Tainted: G      D     E
[15601.553535] pc is at 0x4
[15601.553535] ra is at count.constprop.0+0x80/0xf0
[15601.554512] v0 = 0101010101010101  t0 = 0000000000000000  t1 = 
fffffffffffffff2
[15601.554512] t2 = ffffffffffffffff  t3 = 0000000000000001  t4 = 
0000000000000000
[15601.554512] t5 = 0000000000000100  t6 = 0000000000200000  t7 = 
fffffc00056b4000
[15601.554512] s0 = 0000000000000000  s1 = 000000011fe2ba0a  s2 = 
000000007fffffff
[15601.554512] s3 = fffffffffffff000  s4 = 0000000000000000  s5 = 
0000000000000000
[15601.555488] s6 = fffffc0008a75000
[15601.555488] a0 = 000000011fe2ba0a  a1 = 000000011fe2ba0a  a2 = 
fffffc00011b9100
[15601.555488] a3 = fffffc0008ab2388  a4 = 0000000000000000  a5 = 
00000200000128b0
[15601.555488] t8 = 0000000000000000  t9 = fffffc00011f28e4  t10= 
0000000000003020
[15601.556465] t11= 0000000000001000  pv = fffffc00012179c0  at = 
0000000000000001
[15601.556465] gp = fffffc0002509840  sp = 00000000b4f2e8f0
[15601.556465] Trace:
[15601.556465] [<fffffc0001219d2c>] do_execveat_common+0xdc/0x250
[15601.556465] [<fffffc000121b15c>] sys_execve+0x4c/0x70
[15601.556465] [<fffffc000101149c>] entSys+0xac/0xc0
[15601.557441]
[15601.557441] Code:
[15601.557441]  00000000
[15601.557441]  00063301
[15601.557441]  000012c8
[15601.557441]  00001111
[15601.557441]  0000454a
[15601.557441]

While this segfaults the program, one can simply re-run the program in a 
script or with a SIGSEGV handler to spin on this malformed execve call 
to spam the kernel log.  On other architectures the system call returns 
with EFAULT, however, on Alpha it segfaults.

I've not been able to test this on earlier kernels, but I suspect it is 
a long standing bug.

Linus had some valuable insight into this:

"I suspect this is some alpha-specific bug, and not really all that
relevant for security and not worth keeping private, but who knows
what is going on.

And I suspect it's something really stupid.

In fact, I think it's just "unaligned user accesses are broken" on
alpha. This is all just plain "get_user()" as far as I can tell (with
some special cases for compat stuff and for "we have argv in kernel
space").


get_user() ends up doing __get_user_64(), which looks like this:

     #define __get_user_64(addr)                             \
         __asm__("1: ldq %0,%2\n"                        \
         "2:\n"                                          \
         EXC(1b,2b,%0,%1)                                \
                 : "=r"(__gu_val), "=r"(__gu_err)        \
                 : "m"(__m(addr)), "1"(__gu_err))

and that's going to do an unaligned access.

And my guess is that the unaligned trap handler that is supposed to
fix this up is broken, and branches to address 0 for some reason I
can't see.

The thing to do is to figure out what goes wrong in entUna(). I don't
see what's up, and the actual emulation part of it _looks_ ok to me:

         case 0x29: /* ldq */
                 __asm__ __volatile__(
                 "1:     ldq_u %1,0(%3)\n"
                 "2:     ldq_u %2,7(%3)\n"
                 "       extql %1,%3,%1\n"
                 "       extqh %2,%3,%2\n"
                 "3:\n"
                 EXC(1b,3b,%1,%0)
                 EXC(2b,3b,%2,%0)
                         : "=r"(error), "=&r"(tmp1), "=&r"(tmp2)
                         : "r"(va), "0"(0));
                 if (error)
                         goto got_exception;
                 una_reg(reg) = tmp1|tmp2;
                 return;

for that ldq emulation, but who knows.

The whole "taking an unaligned exception and then a possible page
fault inside the unaligned handler" is certainly a nightmare. We have
that whole "forward exception to the original instruction logic" in
got_exception() etc to handle this, so it all *should* work, but ...

Honestly, I'd move it to the alpha lists - I look at the code, I see
nothing obviously wrong, but I do see things being very complicated.

At a guess it's something incredibly simple and stupid. I'd look at
the special magic stack frame structure for entUna() first...

            Linus"


Hope this is enough info to help start debugging this issue. I'm not an 
Alpha expert and I don't have native hardware, so I'm not able to get 
much further on debugging this.

Regards,

Colin


References:
[1] Kernel: debian-alpha 5.15.0-1-alpha-generic #1 Debian 5.15.3-1 
(2021-11-18) alpha GNU/Linux
[2] stress-ng: https://github.com/ColinIanKing/stress-ng
