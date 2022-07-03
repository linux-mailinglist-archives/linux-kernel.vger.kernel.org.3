Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31A65646EB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 12:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiGCK6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 06:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiGCK6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 06:58:11 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D75264FF;
        Sun,  3 Jul 2022 03:58:10 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10bf634bc50so429582fac.3;
        Sun, 03 Jul 2022 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=GoNG7zHSWaiK4YiYtFaJ1XBJk7dfEVvQzy2LW0G54hY=;
        b=gxjB6Bnj/PxD6yj41uHtm91guV9ntEkr1hf1q3esnGLJuQwfo1qnQAOZQgsgbc6x4l
         nga2H7gESm2cttYKEk7A85gy6Gg9mslBUeb3IgxGQ0cB98BGa97SOTlzrfYCFqlUbQew
         /qQOKPeqIthbjCfPPqAtyiBQeJH0J09OJUJGAsGj+Gc4O3YjniYBPoID0vnJ0zG0SHSs
         eHCAzU96mbnCeReutg2uSJr3YQD8IqGKZ7aykrjQXB+JR5925+cBCZW+N/+gKqKHzl/P
         f6ziMixJA64GT69u2DicHFVQfnFcb1JJEyITJLMvl/P4ahoRPWW/USW0rU4WMuRUNysB
         YBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=GoNG7zHSWaiK4YiYtFaJ1XBJk7dfEVvQzy2LW0G54hY=;
        b=x5oIGktmW7jlS5eUHR75TO4bgk5DPK88pHiLiEbzCoZju3s/m8t4sNF8sCoZ5rMuuS
         dNvMRxjUhhiJf5MwUVMDK91QLeldNhwUKXH3AdDv5GuNLY9uhtmA34V4nGP1TzuRttEO
         RlQicxgbC50ny7TW9UPN+EzP+XbiOE+pNeeHTsFbujLne3oelazHkjzD4zYTC8KqkFVe
         8Z43Mwmm08GGXBnf/K0QQZxaUUvw2bG0gPJtgRAY8kGkihwleuiOHOpM4nw8ZPeWvRWr
         uDBqe4okg8JmKm6KA4S3wn0ke8h0PJAAg12uJbw49EY/Icu4JHW9d5++4TTUYiEXpmBO
         zuTA==
X-Gm-Message-State: AJIora9jqJ90xQIXtSjMqnRZtARHD1HWmDTXLqA1i9uTxXrao078eeC4
        FaQpL/KHzlAK1fu8nov24gF58zettl/PRTJvjgU=
X-Google-Smtp-Source: AGRyM1uQK/R8KybbkvEo5md0Wd4T8yb1VM/Be9qB1kA1pWvLkwbtBlZ4hBko5DtaysmGDHvDtQph6sR+y64XyKqQgeg=
X-Received: by 2002:a05:6870:709f:b0:fe:2006:a858 with SMTP id
 v31-20020a056870709f00b000fe2006a858mr14724618oae.128.1656845889109; Sun, 03
 Jul 2022 03:58:09 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 3 Jul 2022 12:57:33 +0200
Message-ID: <CA+icZUVVXq0Mh8=QuopF0tMZyZ0Tn8AiKEZoA3jfP47Q8B=x2A@mail.gmail.com>
Subject: [perf-tools] Build-error in tools/perf/util/annotate.c with LLVM-14
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ab501105e2e47ed2"
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,OBFU_TEXT_ATTACH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ab501105e2e47ed2
Content-Type: text/plain; charset="UTF-8"

Hi,

I already reported this build-error (see [1]).

Today, I had time to look closer to it.
I build with `make -j1` to see more details.

This is with Linux v5.19-rc4-208-g69cb6c6556ad.

[ BUILD-ERROR ]
[ ... ]
clang -Wp,-MD,util/.annotate.o.d -Wp,-MT,util/annotate.o
-Wbad-function-cast -Wdeclaration-after-statement -Wformat-security
-Wformat-y2k -Winit-self -Wmissing-d
eclarations -Wmissing-prototypes -Wno-system-headers
-Wold-style-definition -Wpacked -Wredundant-decls -Wstrict-prototypes
-Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat
-Wno-type-limits -Wshadow -DHAVE_SYSCALL_TABLE_SUPPORT
-DHAVE_ARCH_X86_64_SUPPORT -Iarch/x86/include/generated
-DHAVE_PERF_REGS_SUPPORT -DHAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
-Werror -O3 -fno-omit-frame-pointer -ggdb3 -funwind-tables -Wall
-Wextra -std=gnu99 -fstack-protector-all -D_FORTIFY_SOURCE=2
-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
-I/home/dileks/src/linux/git/tools/lib/perf/include
-I/home/dileks/src/linux/git/tools/perf/util/include
-I/home/dileks/src/linux/git/tools/perf/arch/x86/include
-I/home/dileks/src/linux/git/tools/include/
-I/home/dileks/src/linux/git/tools/arch/x86/include/uapi
-I/home/dileks/src/linux/git/tools/include/uapi
-I/home/dileks/src/linux/git/tools/arch/x86/include/
-I/home/dileks/src/linux/git/tools/arch/x86/
-I/home/dileks/src/linux/git/tools/perf/util
-I/home/dileks/src/linux/git/tools/perf
-I/home/dileks/src/linux/git/tools/lib/
-DHAVE_PTHREAD_ATTR_SETAFFINITY_NP -DHAVE_PTHREAD_BARRIER
-DHAVE_EVENTFD_SUPPORT -DHAVE_
GET_CURRENT_DIR_NAME -DHAVE_GETTID -DHAVE_FILE_HANDLE
-DHAVE_DWARF_GETLOCATIONS_SUPPORT -DHAVE_GLIBC_SUPPORT
-DHAVE_AIO_SUPPORT -DHAVE_SCHED_GETCPU_SUPPORT -DHAVE_SETNS_SUPPORT
-DHAVE_LIBELF_SUPPORT -DHAVE_ELF_GETPHDRNUM_SUPPORT
-DHAVE_GELF_GETNOTE_SUPPORT -DHAVE_ELF_GETSHDRSTRNDX_SUPPORT
-DHAVE_DWARF_SUPPORT -DHAVE_LIBBPF_SUPPORT -
DHAVE_LIBBPF_BTF__LOAD_FROM_KERNEL_BY_ID -DHAVE_LIBBPF_BPF_PROG_LOAD
-DHAVE_LIBBPF_BPF_OBJECT__NEXT_PROGRAM
-DHAVE_LIBBPF_BPF_OBJECT__NEXT_MAP -DHAVE_LIBBPF_BTF__RAW_D
ATA -DHAVE_LIBBPF_BPF_MAP_CREATE -DHAVE_BPF_PROLOGUE -DHAVE_SDT_EVENT
-DHAVE_JITDUMP -DHAVE_DWARF_UNWIND_SUPPORT -DNO_LIBUNWIND_DEBUG_FRAME
-DHAVE_LIBUNWIND_SUPPORT -D
HAVE_SLANG_SUPPORT -DHAVE_LIBPERL_SUPPORT
-Wno-compound-token-split-by-macro -DHAVE_TIMERFD_SUPPORT
-DHAVE_LIBPYTHON_SUPPORT -DHAVE_LIBBFD_BUILDID_SUPPORT -DHAVE_CPLUS
_DEMANGLE_SUPPORT -DHAVE_LIBBFD_SUPPORT -DHAVE_ZLIB_SUPPORT
-DHAVE_LZMA_SUPPORT -DHAVE_ZSTD_SUPPORT -DHAVE_LIBCAP_SUPPORT
-DHAVE_BACKTRACE_SUPPORT -DHAVE_LIBNUMA_SUPPO
RT -DHAVE_KVM_STAT_SUPPORT -DDISASM_FOUR_ARGS_SIGNATURE
-DHAVE_PERF_READ_VDSO32 -DHAVE_PERF_READ_VDSOX32
-DHAVE_LIBBABELTRACE_SUPPORT -DHAVE_AUXTRACE_SUPPORT -D"BUILD_
STR(s)=#s" -c -o util/annotate.o util/annotate.c
[ ... ]
util/annotate.c:1766:33: error: too few arguments to function call,
expected 4, have 3
                             (fprintf_ftype) fprintf);
                                                    ^
/usr/include/dis-asm.h:472:13: note: 'init_disassemble_info' declared here
extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
           ^
1 error generated.
make[4]: *** [/home/dileks/src/linux/git/tools/build/Makefile.build:97:
util/annotate.o] Error 1

[ REPRODUCER ]

LLVM_MVER="14"

##LLVM_TOOLCHAIN_PATH="/usr/lib/llvm-${LLVM_MVER}/bin"
LLVM_TOOLCHAIN_PATH="/opt/llvm/bin"
if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
   export PATH="${LLVM_TOOLCHAIN_PATH}:${PATH}"
fi

PYTHON_VER="3.10"
MAKE="make"
MAKE_OPTS="V=1 -j1 HOSTCC=clang HOSTLD=ld.lld HOSTAR=llvm-ar CC=clang
LD=ld.lld AR=llvm-ar STRIP=llvm-strip"

echo "LLVM MVER ........ $LLVM_MVER"
echo "Path settings .... $PATH"
echo "Python version ... $PYTHON_VER"
echo "make line ........ $MAKE $MAKE_OPTS"

LANG=C LC_ALL=C make -C tools/perf clean 2>&1 | tee ../make-log_perf-clean.txt

LANG=C LC_ALL=C $MAKE $MAKE_OPTS -C tools/perf
PYTHON=python${PYTHON_VER} install-bin 2>&1 | tee
../make-log_perf-python${PYTHON_VER}-install_bin.txt

Attached is the build-log as Gmail might have truncated the lines above.

If you need further information, please let me know.

Thanks.

Regards,
-Sedat-

[1] https://lore.kernel.org/all/CA+icZUXYZiVsj8Bw7Yz+m93-trpVA3omPTUdrwWqHQMnaUdxjw@mail.gmail.com/

--000000000000ab501105e2e47ed2
Content-Type: application/zstd; 
	name="make-log_perf-python3.10-install_bin.txt.zst"
Content-Disposition: attachment; 
	filename="make-log_perf-python3.10-install_bin.txt.zst"
Content-Transfer-Encoding: base64
Content-ID: <f_l5574n5e0>
X-Attachment-Id: f_l5574n5e0

KLUv/aRi3gUAPLoAGp0QHTKQTFXRA7a2z0poE1IrNX645tJ1lef6IckKVY8W3FTwIx7HS/XKw7Lk
KGIwIhEAGGZEgbkBtwHjARnPdl7NeYUYc3nW667FXDuouMYXY79wjidVVgWqI1njtT2EHpWOGEQs
UNBoZDB0eLuYw9X/Zf4Ld0JMu2C9QC84lyHtzLBbJFKpDfZmuUN/0+Kb/1d7D9bNYtQ1GOV0Ersy
D+Ol2TPPgW57qwMDHYFhmCEbgqBGxDveMnSsq+fvfL55kxoN1wCCADU4uIEYzeAgOCgDeTNMmBLw
DNTEbL1qtzUSo0FDA/aNS0f/rWu3/aFTrRlydAyXN7b0nCdGv9MLPoO028Vu1jo4XpP2pXQEhAMO
iMhMzN7YsPNylML8DQ8LNVWQRHqrmstZZr7jG7s31w1756bze4a068VYP3YMm7KfDPqM41cfRlOD
W+Ryo9HO6AGiZhHDpzNs7BJ61pIJqalb7BM6wmJ40WjY6TClkKSN2Nd1bMcP8GDwCyrr8hyT62aw
JHQhKIIYJgvHoF04SGP3A+O6DT0gzCLCNJeciU2TflwopEkE0g1xDUnndjV1SiGGWj+VgQAeMFx1
4ICBAPq5U3dHTBMJZqK78WDYtejpvTnKMxNxNjtpFPFHr3E6ZeT1ZtHTHXxzdDxlZ+zEni3VEa6B
NR+1t8HSfhSn+5xlJn7/HiN8r+MaTROnlu12a4T+PT7/uZEQezne+SqWUSdv0K+oPoxkS+jnaaif
7CF65acUxqiDo4NZzMxNNSCD3t6W0Nljt56BGhJCPHgAESGuGAEiAz1EDEVogB70o1+HEy+l8EJT
KApHqUguFUXBRSrKEnX2kZ1X1JCQ9kZnN+xw/qd5rduleTrzlunE8k8KgXadhI6z/BE3hq5uKG0C
CGjMdcUNz0AtgiD8Xma7XL62XZyJWYbai9QzWDftH4Oixx67butSzuxB5zV/brCtG5L4Y6i5KMF0
IMYQiiQWM66EWZ71PcPrZj3TDWYxz4zPcWYLpd2kY8dcOqed/E7S6zjupOd361on33cZO/9nxei0
U+PQ6eSJt+jvMqz4YtarZ+gZgxC7zA+jk/CSOIjE4iQWQehxLmrQADmgqgokenAAPYioczTCv0WT
i/NT/SAgcKjr6By/luGCY6AX7unn6WdnZqNaR9n6xj225hpPqXFgKBQPEI+LJZl4FnV5DxDURBKh
KCpp4vCgIBWmcnkWIhKrqkTe5PLFmtNEmD9ChM1mHq4hzpwLl90lMwHP87R0LUAz0NgE4FoL45Oe
xW/oCHWjocGhAYRNBj3m8lHPMOdcdzQoXvk+axPHb7x0DLN3XQEjSRUcHFQuEwUKhSTyLC7SRTJZ
kkVhAkSqrAkQacIiQayLZLHAAtTE4oKZWCASSqXCsjBZSKyLI6yuc7k8qfbOuuZuV6s3Tigo0oQC
M0FNFQpFckHBWJIErOmCoahMKsiTLGl6F1JlkSwspMqqQFHesyBUAhMVikplmSTPwsSbUJSKmvAs
KpVUmbwXsSYsExUmyoWyKhQLDKWaKiyRCYWxQCaqAnKpSCATksnFkiCVSaSSLqbJRJEqJolFWUiU
96oKA6GYIhaFokBVlKSqpAkL5VmwJBRJJCK9yrKkN0lUVWFVlHWRWKgojAIXCqqSVHgVkEqyqorF
gplMSNabTCTIxcLlURSkiimL1i9nZ95sXkPowZmYY60ryWRdqMnCWCxMBYBGA+0eFgvM9C5UhbEk
KtIRpl3vNHaiy7jZxzg1rMHG5ffsohufyufOZzOf6lXDiXVmnNUKOcgLw97HgKL7cuP6toOD2ngM
t1UNP+xF23netRi7V2gdyxsf1qqLBf66eRDg+Y9tXF6/4ecbx/0ZSLGH79zAzK96Z8Zz8/LfbIOl
hHXTXBPv5mk1agIwQ6mJF9Imlr85vvFd6lfCS5/1TPbfrrrJB7OowZo9zJ7znPcLexlN9pyvLd4J
Upm0mS0Sa8I5Q2pjlPhGx187TynUSOjtvzUD3eStj+HmveyZzvhqdfZ3HqoXY+8biz1TOPOFaAtl
6fbHNOTQlrazKdzc6ph+SwtbuuyfL9szKzrWfOqIh4aIRnQfKuC1FiUyx19nnxsEznU0SNuy/2Pn
9TzRQ1NhmvTT7dAcj4mqpIrLNGlEzyKMbq9U0FBf2RLt3LXOXdt3dAwsrBezsxKhSBi4eGX0qLAk
y5tYWBUT5kCAhIZmUG1LeDW+7cBtt7cbe5Yn5U9dnBXajmwJzUBigpaYwCHhcFDgyA04WoKBgwJH
MzgKgBBwLLi2b4kngmfBox0KHC3xQMb3bQMXTz+d8TTOjovOaIyjbxa9P4Mh55mgQUFnO7EWQTdI
iFCe1mTAlqAn19U+8KD3qp3//39syv/fbDQf/z9jmP/a7ovmzUdIg7U9XmzpiAwW51vncDxLIkBw
qEDRY1w3zqgbyvI3Cu2jrnkJHT8Lp7T+mud0Isw4ffnqhweIrhITa4kHDw7o6qxnuSUc6IZzqKOa
JYxKZ0pERJIkSWtjcCBIqEgwlwmI6R5UD4NxAXFkDIbFgLA5BMYQBkJAhEEQiOEIiCGEEEOQMUgb
KjodT7w4daNAIor15/ST8gQa9fc5SN7WuA3SDJP0wsSjT4z5IINAfzbNnS6OjCX6NUklzWeb3sc+
k1mJ3TGfs8hY4+XSxCaoRUbEVY+ZZKM1RYo0ErvgM3/n4S/qGrMMG5oO2E3nW4SZgQADdjb58SkM
uCSwkKqCB+sEU94QqJGbgKjKCt0CT9h5UajmkZIUBVMKYJ6SBJBUCl1VJZEvsVCYfkvC25ZLGSIk
QUfhrmlwBJ5b5FZrRpo0ewleeYPyAtX7zx/KX+NIpcFoWOdrNrpS9NeKSk6t9bRzJRlHm55Dglt3
fYms9vO0c/VHroc4tWrenCNArOlOUbNc5jnFflcJDXINyX4DupVrn66ukJIuTTWBT1tnmlSGexJE
E0f4hLHNuoFPh2Uv1WqgbAp+x7RFqt/MUwj7ThUFT4xSxAfNDKJkgUzKq0/mJFZZ9OTdC5TepruS
OMyrHGlG0o7QdSyUGY4XKmzrjKdENDvyWVBvm1St7bQ0/HFL5ag7Dp2aM6ZIm6cPWcgZkTnXAg4Y
LG5I9dWrOj5x6wZZvFeaCTwWcZ4m5GUdayIUJdTFgAHg3ZyKumuoCpgn2FB56ilZM4/TSNegpDdk
tYgnLq9fZBOyVbPcqPbOrkWTVwaPwjiGCNUVoBbi0O9l1HhTU0ytGZukAQqwyxOLpuuHbBMEzJQv
9iktT/6wQt8iIVpESSY/G8sALB1U6yVq7kzyMZzMr9piIoTLVM54Dwc+n3DMM+jgpako36mD9d8p
NTGa+zc0JpimjAnqGhWt0kbRFSy6UTc6es1oSONFoDwP8lPmPgXBt6a9qNGAeCECDQ1NJ+2a2IwE
zsQMiIL5DKsD3q1jg7qIdXYAtLMhFSL2UzrqAGtelLj+bDHapoAHMWtwuJ7q72/pZBVX5iy0QSOA
0FJnFtVLs5Uvu3dZYPoJ90eLKb1jg4ZE3sOKnCBjm3lZv3YXrnEwwLU1KW6prmdc1oN2tVtlkQI5
3gN/WN8QheN1qP2Hfw0NswwLDlwIqEED84DUA8Qt1fZk1FYEI7NDgYD4ZkvpLrrIUlp0UF3zxy8w
m/EPMAiyPiPituK2KRNpFlu8zOHPrsTtbFURqYwtyXrGkoz7yOdK5enlrjWG2T4uP3/+kQPX9gZ6
3rn5E/kwI845GzZj3YZ+hUa8t1b2MmACn+lok2Up3HU5T53CG9REEx/tBOUaU82rRZ8kZrq8NsE7
jS7aJzWJFhEVkANtKLsYv7j7f45cgtRwlGLWril+NHLkarw8NXN8cXga4ueiccmn0Vxeuv2QAdyL
F1JSphWhFBCq6IeX+Ro0xzL76cUUTYYN/x9fZH/NoEgz9YE9959OA62pqy81Wl9TwdG0k/UOljJP
d5JOafwpF4X3ifU8H4tZLGb0JvcZmqBovYvUx8/vVAjGHT/4z8NTb1D41i3tWA7Mu1rd6pq+cqot
ERsos1NA9ymtMaSUusivIBIXFIv3x3l6C/976iJlHNowHuA9DU9uaV3D1P3uKVyg5EXEKhUu8MW+
mA6GwguuGIRYspyz/XJObNtld4PkaHabd9GZi1hzcsV3lZ9c0wpyq1GLKpKEvTVZjwYrdGFCFmz4
G1eIlNGmarDfZUguaA1N+k2X37mw8YOe5OdFR451nLrWaab8JlvEIRbextHtNUSNBuOZ8vuVUDLE
8WSnAwl8zhDqqWVHsiQIax4wPiOTBP/XVVpE1PH7a8MPBmT0B8bhZABA9febiF5DXP4ItFpB2/PW
poENka1c288TNKzBuotsE78WmN5eiRitpI0t0Sp8q2toI49lICMBmUGSdggNp52Daa8iCkDS5P5f
GxVh2alaWz86yNGJIejh8OQIK6a4SeqvCnjdid4hugs8/CAQb9T21kfDr9rnP8m8FkAWjr/8DBZe
tjzrXjqW7jy+LIfOQv6zUMU0TmXOlqEAr/m5oZJGy5NR/iyWzPQJPkxHjONkKXGLm0+r83dlgs/g
dtK3o5XB8gVdMcLOED7KznxtDY0Jiee8esEQMj/Q0O2J9tAfbK0o55UxN8jh7ZMg9wGpdYeC6djf
neBnRHHo53y0DXO09Qa9zarkuPT4Mav/Y7ITNL5vicTPuqK8Ok+kISYmJM2egeLpXflyq3aGWx+G
ohyAxkfwT9u1hngMumrU2Sovai6SBWj32Mx8NFQeDVxhXzlwN3KyzHQphH6eMxjf40+pFqmr79eZ
+QHeo4Bh3nE8vVkSfnFlDt1qRXlF5j5lYxIpUQfVVFOpugCk8KA/L6rJxUqmhwX/RFzGrp+xQS03
pXeEd+RRHGRrCtL6x/hG3DkiPjTpH55IHuYDrgHMzUlDYnb9Qe0PUYa1YmnFYF3TJFIVewGzo1HU
T4CHrDhuIS6IGH+exh3GnaPrNqehYNRayqMwnUuhpQ+hAPUapXKYa2VtlSYl0PS1cFqW9D3Tc6D0
SuWZ50BJ5UKVpnruZYtyap/6kk44JBjehABUQdUbb5QxaC9xTUg4jpXZgM3bNJsnAueqbhCNb+1g
DrWjQFjCmSAEqo4JpuhBK+rh4WkaiuI36WS6J3bv50vGNxlCM1r6bjHgAREiTCOx5BnquAm1Nr8h
NwJtfth3yBO922+uAFXJJcW9lIbj5Pd7ZoEF8RZ9bpSaCmlmqNnkHmEgUbbjBS6sSbT5+D02fte9
lgivRZ2p+EQgMs1zr+XFfDZw1iB9pGZmOpehqG7cbyG7nsxkuN1VuHq4BLK/gFifoWf778oFL8Lf
Vj8OtNzd8Avx1v9qT+crFHAGbFX9CD58+ESuP7XrUby+qR/+yGhXr7SZbgd2y3zlZ4ADmAHzz7py
W7x16n6cab5zkLv8FupXI8KYEPA2JkxE+CB1pzl90nnJj0ovyar7tOSCON5lr66dlA1Ll5Q4CxUi
WozYrSIOYk22daTFXdToCf6PeP09b6mxPl3IUa3R5TR8g+7So5Vyhsa9DkpdpxwSjN0SZCMLg5kz
bZSin9d8JJjUDMQAuM45Y3DlxII7QFasMAg7j/UpxTq4wkhIZPalXFNvaRa0fncyu+63rXvtuZkO
bSqvzOAWFiG5t8GWOJzHQs2uZoUwRSZeA3PPO1w942tOWtHGwXdOeRFjH/5EMFykW90owQ0Kxkc0
+wzmHu3Cc2xiHyTqVPsrsU+5Y4RU8gjED0P4VNkmsVW0aFo9rW+PAFDHtsa6PgMSiWqIU4wm4u7x
pj2rsU5TB39Aq9xGesw6S8RWmLJlqyzROQR3jOk8Wb/18RQUuyavZBcCQFBiG6UE0BQtvcwkIt9/
p+ztOmtqDE1SyUP7HFPGWAcpWViyBp+wEvBCipHXV8LIysIr9e0zEdjjLgEd3t9MjKCguCX9HQyu
ahGDHRjHxO9Hdgmj/W2iYZN1l6zVccFGWZd0ACmgrLqbRuW93XjHX4JtGtNq6xv6u68NvINAiWLv
J88TCvyTtCh21FKXEprkYLvq9slhcuFnPncrMc4jOlXWTCShQl0Q/ekAqQstSZUZwaHvYDytrz9s
yTiw7n7RdcJAQ3sfeyJh6LtWx301dtsrqzD6acSVH6R+peGGgX1AYcZECXvnXgRmoJxTbKOLjtJV
qSYObV7VfeYKxFzsvj6beJnrcy3+h3mphdk78vWfwUBI5FwHTljlDzwleaTLVQIKIQ7/b0YmZiho
vMMCAPuFnEo+3B/ADror+pp0lJjEeFFNEotr4j+5x5pKiplaQKFeVC81i1WqQn8fg6dMDFRUG0BM
0RFIJI3zUUFWmQxRELVdAwsUPEdDoTwB+qXaAHvbMyaTQi/UpheP8e6I3L65jBFJ8jxQ72zI5h6s
EgBndlCHk4uiQ7nJFDREGZwZ0Dr6BAxRPskzBrSZNcrEYc9Jtgd/tM1XrHsN3foevrkhc5zDFA9N
pwPJDGcDmHobu+3zq0nequtythKLinIMPgG8HGKmMNhig3luD/83jBiYlQElL7h1SUJD30XqG6WE
Or37T76CRoIPAbEXcR1+eS5fhz376zivrEni/LHRDSLxckSKZJLvcqZEYqBstgByRZPeZYp3UMUF
CeddEozHptnqm3SGUC+MPityMbv6548cPggVfFiRC1063CjR/NWFDR4m5d2IScRCZFSveXAF35qQ
00iyul1et+1Ws7EkJ+9iMbk8Yu6GCZ0qBXkDBqZuBzG2aedKgwg3/CUuf2TrHwWTageRoyrvj8YH
yOujW4PMr5VuZyOWhgJk6d++1Io7VXdJA0BVHs2mLSWnG1yRIqiuSnWRse6M4QObD6PXMeogGJqB
swDWfikJDsifIVCDKHigYMWdXLdScUTVTOAysYb/QDb8WnFmtSZQxjA9Kg9Kw/eKW/tqZjac2b68
WlaL7C1irG6yD6XDbBeF5rlhLPIb6V/FAxF3YQaJvtdwYcd6GZPcjRToiH+BZgDXS5LjwJ4oOwry
euXk7aS7scGVbr+PTozdhryyiPr72/ulmiu9zYQGVk+AMlDAJ2fQkcsHpKkXvPRkuNXEFJFJolwF
TAbbxk52Dgua9Eqr4Fyser3BXJZTt/VSKRDfRF451IxQJUA40c8qfk6RHR9U7vVShNdXZ0OnBg1W
sC9hq2o9JliauX/5inHkcFhnHRBX2bYckzvdreY+ElGOzBBokn1TnnDkkh9r8ncvP4hx6ZoFU+il
1H3enNId7lJjvwRV1674I8F9wfzAf2JFw9i7e6kONdvSBlsf0zCqLlTo1ZZ5fDssGEZQ/ccSg3WG
JuY+SZwyV1BL8MQMTAnY/eKUIPXeE980UzabW0qKd0mly0nxKB3eNkTRGeBr6BmkqE5ZH3YgbbvA
I1FGzKZycEbrRmJo0TNIGDSy8AbFspwUoPmbbLQmcInbuDXOyddp4Y7qlBeGtz3Tek2y3hcJxfaw
9SFzyvEKT0d6nhbjP0vHsEp8U59HaQEX8tcxlbA72JnSDARYrDisVajJUiJ7hgmatdPiuW7+6kH4
h94yifyKISI8Zu3eh7jvVF385XtELwizCl3dkRKiDQHDelBim7zYyFGqf2DoPCgb7pKFGbHPuT1l
CkyZBBe+ObNPcxs42aXAFi4X2kYIrRaDt7G2i4ZNLDKo6/kOVZ7IYFILxQJgNEAirXQotg8LGU8n
6Ve2OWnZEObSE6iioks/gklNgzxVFCtlUwKLlArS/VvgPYiNQ0h+7DyJRFcRP/3NWc6ljv5pGx5J
vjyjuk9BYtltwUyYPzpg8u4UYRmtouAPjU9ZcPawLeKhApgeXRPAULviJQrma7GWAgqcQD9ke8Kx
JLtN+VNFxMdjsy3CxwHH5LBMxiXuUOJcoK3voEnB+0jJllf1DjcpuJGzHzGkeGazX597glPqodXH
+xO1JTihlWbIw/wmcW9DlyWjwOIHkJxTXP15Wdp9yyHkEe0tnJtjEPB1BXwuAPZYTSUQj7gBW9iK
ekjG4GvYyZT/mZ1sp4MkMD3BGmC1yHOEiAAAqvQGQgBEAEYA6tNCrV460hhfmbJIhE0mlAdjePak
aIqXnL4cR0/spZ1ayQ4btnSS/b3fMjnLujdcrSV2x8HuT2WhQYHhoFIAmyEcjwbcbhqt0edJvQeo
NhcrbaaplropQIwm9zwAyvrBIBQJkxzou9w1yqeDiVBmgKGM6ImiAGUi2tVK2pBwy4rWxnvL+gFr
WUie2KYgWDEmByUgEBTEx2tqGdd6B0VvF85b+uk9v9vLei/KdvE5DkUJbS35NCP3bh0gApGHgUIw
igB70KZplEFIHhwN04zMe4kvorqKz9vJ4vyR79nn6t834fwpf0YnTdgi+Q13WpJar71qdr7Qkgth
e+2iJX9KXut3v70CfZdkEoG0qMHWzEiSJIUOMRBCJEgIIUQkkuIDYjggyDEQhjAcgoAYAUcikhCk
DHFESAIJRCIRyekBRCn75gDbXBi1SnTcbXIDq2ZCdlC9QUFigBaxWwhsjjijXpLj68+ElGmtylYY
GcBn3SPcjjUEL4G+l7fSl1bzp0sHnewlQqSjBPXw4vfbjmTsCZiCzNmAm85/ID7d5V67stOKqmTg
v/+PQnyjdygZrn8eEr+puTeiq6XU3jW1YQaxezQAWITqAkwiKoStS21o9sxJ0FJyuQ/61REkhe9s
aIhGY1FU7AJZDcpFsNkYCdpzGbFa0HKPWDH3NhXIYdSxETnzWk7atBD15I6qBpkiNRtlz8RX0onn
gd5wKfw3yLxA0YaMjSZqCtzJAV7HSg/OXFFNJDTxGU1A1EfzO6gwjq55CU0J5TbHZ4XKTukVWqi/
Nv/QYPX5mgHFRET18duiEcDdTV2cgcqXqIwhIacaS645/Ceox6myoUQ0xyTq0oloxCQq/CxxgXBN
F5szZ4KzooEsfFG5Hhkklb8xxGZH27kN1JFscrQZl3yj5AwhPaLtMD+uR3tMFTJQpDaaRSNGD0q3
hJAtOl/GHNYyqQj31VDtzE6RTpkOovk8wEQo+HmjcDa4y+gIKotR/LAEb2Sd+XZiXdMAoe/34zzj
AxhMY1PF5iPRqJJbgZo4J03ov494nuP725CT5rtbbuoJk90tCYaZA0g4wfLPj3HVNiR/d8UafSFQ
fc1DXcdY5oNymbIj7LHz/iCBvnFD6WhyEA5nE6EN0kr7V1SF7JWujUhn9FZ5ZDua1swOsCEoKtSu
TG00imb6jJrEC8Jxy2BjvedVIms0v4YWaKTUfA/80QRKHWl1+1zvteFF0yB7p4tZgJLEoF36pgBb
xyZ/NGeF7GCTIVQ6tmzfVAuwoSaaSAr0DCDQb4EQmxqbp51RsXoD8uegyhzafbJoo8ppcMMQCLOJ
/MwjswdPXzdjOTnPomIeYNfkxlJOlBDgBOSTcn2tY/hXUbzMFFgHUw7VzT3KhVitjrO1MBKBPpdZ
WiXvOFFTyUwfdWFWmwms58ZTiyjIQeEua8+OUU/1DDLcRmFhSF4GDzLtJUtaCEt+SJfIe3L8/wFH
fIiWk6KNYtRco+4BS6RG0D8ocVZcQzUadgMVjv1u4GP/kI48pxtt0XTzogQvfOkRozykGmvpfdqj
yBEWaqQZ2xSiycWRsDNFt0GIQglsWWKPLsTynLFr3rxPojPG9osNHdFUSBCwrSEWKMRoYqPrTBo7
K7CDQWnSjfjDJAWxQQm8zoYqGo1ZSbE7IOyYHeJNIOH80YayM+Alco59/nPgkb9m5Gc+uq6ZovkP
wlYE9EUu31OgzeaJzcfOFHseqHxxRDpsR19InY3aGVcrEpNHb5oK4opdOosDQ5qJTeHF2kbujKIc
haeZrJtKBaKR+OvOeCmChdBaKA/PNX/SuCmk2s0FZKTbXdP1t4y0M8UN1b9HSmilpAL0RyYpp46G
6NsRlJuZA9zy/U8LcbxGWZr4YeA6Rn7yO+/HQLHGH81+hpaF/5Ee0HLxYKNSCPD63tQQ5ScAhlAw
HHC17YCG7mq3uU0zrJNIZq7LaWj4UFE8uFVVOAEmACcAJgBmlJvqIlQPf22H106i9p7hYdOISpJS
Mafel8KsZmzxTKApfr/0EpmWwnz4PFKqPjzPQYQWYnbULaoTjptvp9fxCVdjMzKsqFbCqqAfEkn6
G7+ddInMpHpctEj3DB/iCAx18XBa9ulm3+FESMaPQyGyKx0fiEMBI6AoDEOWDwyAAqEYGAWDwRgg
LOo/vri9qP9z1TOWpFQk3bAgN79PfYGDqEHPSJJkawwhCAGCcgJCCAHJkOENQiAYBkMQDGFgCOEY
BGMRmAAZigwkMiISSiCRxD0j8a4jvmpAqF3d873lsiP9X/harEl5Fu6OeBDtqs8Bu6qZBr0x+RWV
U6DwwJTd8Ji+GIncwCtpRbL1c0RNiS/Ornz1ZEqEYSnybWSzKGpAymufIlcAhC6E2dx6jYOXjtU1
delgmv43dofgXsTBTTGJTsDcbugwdxAlA07/7F/xRfmy17SSrjuN/3iDEwO2kxd5EzA+jS3HviLv
8imgxUF22ddS43zW2oMa+WdtAxZRDfx3XCVOIVR+VkzEEaPxg4WPxLVcCsuci0fdDN82HOetHp6H
J+Sw3xG5SAnmrHUeK/DWtd8yxaiUAOceQtZznuKHQNP9+zKRQHLxyoAaJ8q4fH7Ms7kmZTSD+lUz
uWa8HuibE08butMscdSOLA0pyJWp75ApfN8mOZocF5Sh0lDjIsdBxr4Y48SkDXU0C4eR0N0IERgs
YcW+aOdttU28mkkl0wodkVQS4w6eQXw21KNpm8EmFph8SFBnE9GtqnGpaLYcEHIi0u8SSf+hG+U1
J4JP6IeJtJRo6mFusk0z4GJEkgzg6mle1pCwWvNpaGi5DQxWn1QJtyaBaB7QNF/PH2jdhThD8d23
jcc0Jh7fl9YjHtO+kw5Vj39ekFlNWtFMoDm9JjPQsz8Jur/GJZoL1UUPHT8kNQUCiBj3hkA02Yuq
YEzjhVaNhyfiQ4qINRHSXJlXLwZAFGwV6GxHbNKKpoKPFpCELPgmcnbpCaU19EgDx81oAfKrcZFf
cmOZJh8RF9FId0Rp8M7v06P8rarxAtHk6h+aQ8iRRUjUQd+N7mjyhayiCNYfW58Yyzf97PMhwnI1
tmjecRBSwBDQNUGot2RjFc3RJIYAYAyyoEFzDGaTIs01hLUEk2VDyL8O9gn/atzPwMV9szxyce/6
9JFXa1KkqdDY8s3I0JLSBCVyA9UYnnnH9p/TGL5z0JxQX0MXzcdLngt6vIguMnS5x3DcG6jG4Ez3
939zblrlcRr099RN1DMdp7SJPCJJoZgxIZp2KG6yztDsGx6ivEKiD/g/GdK11TZ5nKHztBd0QlKo
tJpchKDMaRPvjJKivcFj9jG2Zw8ZVpPRzqyacp//WQrUbSE2n6IZhfJB0XDQSIN9PcDG5wz7PmiP
bVH00RcaPcH2RvEM+gPdjKoDN6TSV6GgabwPVkxt/qV58aMh7UH6rZuX+BivYn42WdKEkLQEASH1
jSryIxTMY9p41VQI6CCXL+QsQ0u32ibvmf8CeigE5EOieTwI0Ww3uElEs2hb8QQkEpcxDSpZCcpb
oj++c5NUNP0tFSK72ls0d/wmcgf8Uu01ic/kL1HrsQ8l7pe8BQhPZbBJdMb9yuWvEfMZKI+d2Jca
o3FmSsxf7A9foKHVYpOBK2RfuIVC9Rs=
--000000000000ab501105e2e47ed2
Content-Type: application/octet-stream; 
	name="make-log_perf-python3.10-install_bin.txt.zst.sha256"
Content-Disposition: attachment; 
	filename="make-log_perf-python3.10-install_bin.txt.zst.sha256"
Content-Transfer-Encoding: base64
Content-ID: <f_l5574qf61>
X-Attachment-Id: f_l5574qf61

NzBhY2M3NGU0NWMzNjYzODg2MDExZjY2YzE4ODY3MDNlYTZkZDFhMWNhZTE1OTA0ZDUyNGVkMjlm
MjRlYTNiZSAgbWFrZS1sb2dfcGVyZi1weXRob24zLjEwLWluc3RhbGxfYmluLnR4dC56c3QK
--000000000000ab501105e2e47ed2--
