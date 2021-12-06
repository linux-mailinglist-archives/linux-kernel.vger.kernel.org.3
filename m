Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836B4469209
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbhLFJNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:13:43 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:53113 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239987AbhLFJNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:13:42 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MLQgv-1nBxiA0nhL-00ISoJ; Mon, 06 Dec 2021 10:10:13 +0100
Received: by mail-wm1-f48.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso7079928wmr.5;
        Mon, 06 Dec 2021 01:10:13 -0800 (PST)
X-Gm-Message-State: AOAM5326jLZc6+fBuuiAvyXTKryO/ct4dTdiaGsnnVAVmQV2fP3Zmf9Q
        9mboogtbdOSvS75PXtfqOfyBDkOXhrQji6NSC0Q=
X-Google-Smtp-Source: ABdhPJwQALxSFGHAJpCTwYGyvqClDaiYYTas1sA1uWbg/iw2Yvzw12jV2HvaIzmKqWcSSqtnZmdh/GUH3epY4YRW3bY=
X-Received: by 2002:a1c:1c1:: with SMTP id 184mr37374459wmb.1.1638781812875;
 Mon, 06 Dec 2021 01:10:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638275062.git.quic_saipraka@quicinc.com> <99ecc64c6da3abb3ea2930082c40f1820655664c.1638275062.git.quic_saipraka@quicinc.com>
In-Reply-To: <99ecc64c6da3abb3ea2930082c40f1820655664c.1638275062.git.quic_saipraka@quicinc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Dec 2021 10:09:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1k-1_m7r-u0uO1nW1m43bt_hR9u+UeW=SqK40+Ltb+iA@mail.gmail.com>
Message-ID: <CAK8P3a1k-1_m7r-u0uO1nW1m43bt_hR9u+UeW=SqK40+Ltb+iA@mail.gmail.com>
Subject: Re: [PATCHv5 4/4] asm-generic/io: Add logging support for MMIO accessors
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        quic_psodagud@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IOcYAtM7qffkpP480HHpYO3u3xHTvLxGrBEB7tDrndi5EpC0Yml
 ilZWd+YWC6EuFHG6wK7wDJsnEOzbwJn9Ubv0/NUWW7/Je4xR/2mYI4Xu5IWNTU5TUkkWvg5
 sd7YtZ7Uu0H1EgdmPbRpNtk7Xs4I8eY/Gq6AUBMFyYjUSK50VO86wpAixsi/kZWZuw3ih42
 kY15jy1AeBPqfWf+n3Nuw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AQZt5Fu4oPQ=:G2RlFnMxnBQMjLx8aMro1p
 s3VabJHQgntvbl2WP/P2lnpd1DLFQJ6jZlS1sT9qX0+pASE83y/BuFUa7f8AQlvuIy1QZpJd0
 MjglrgbobS/wJzetxEBc/LmigyvDTKhKbhc0qAZnVcts2uyFE8OJkGPUbNGUOcBzCCIvojO+E
 dDy31w69KXj3QarkriMnslAZ9SUbZ//76SdStXSoq+Ysqw3zFrP9BaWmyw/XmFn6/+Uk0s5G7
 yarTE3fQhMAJqtmAOGCx+iis3iq8vBf/9gQpCM/4fVoxrSQYpq8NWgVgptA2eUENCplxKhtMx
 O14E2lxdEnRMi6EbM1IhKt/W+GWaC0DpkFpYq0FRqXFb72atRSg+ZWgi3n6hKU3qRFW9ts2NO
 Nbwm/HQbox8DtoQEBEv3xyKzftwFw2TZMtx0jw7fNwz5WpfsoJdfAtP7Hhh1raPO6CW4XhpVn
 HU+WnqyVnCC6pAfTtOfq6jp4/F1Mtq8XWi2XKpAlnav6m0w9HfkWYHHGRp8VBhG0F84uYZd2I
 b7kvDbzWboDQaenKLVRjfIx4UVycojX2CM6sSnrhDBRhS/KLw4dEWiS1bgZHDk980JsWiuvGN
 /KiTfb4CQ8Dy8dLF9mb9WG2TZl7kEyIMvRNvhj1NVwQWn1Xcq38smvpsHsqHo/FAYmJJrJce/
 0UvO/iqjIoTYDiclSYWMTgUFONpRy5NQUMoaPDKXdxoXxPPO+/eimxGkECeNqw6C84fmVhRfv
 yGqBX/2qCjRdjXNQvKKWw4WryHe1qZ+FqBYwVPGeaRchMIZ2f54Dkrg+X5CBQomucvt8vwtBM
 +qxGJnypTSF/OQXyLUw4N/KnrxbsBnEQGe62VQPoeqlfWIDbgY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 9:28 AM Sai Prakash Ranjan
<quic_saipraka@quicinc.com> wrote:
> +#if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_MMIO__))
> +#include <linux/tracepoint-defs.h>
> +
> +DECLARE_TRACEPOINT(rwmmio_write);
> +DECLARE_TRACEPOINT(rwmmio_read);
> +
> +#define rwmmio_tracepoint_active(t) tracepoint_enabled(t)
> +void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr);
> +void log_read_mmio(u8 width, const volatile void __iomem *addr);
> +
> +#else
> +
> +#define rwmmio_tracepoint_active(t) false
> +static inline void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr) {}
> +static inline void log_read_mmio(u8 width, const volatile void __iomem *addr) {}
> +
> +#endif /* CONFIG_TRACE_MMIO_ACCESS */
>
>  /*
>   * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
> @@ -149,6 +166,8 @@ static inline u8 readb(const volatile void __iomem *addr)
>  {
>         u8 val;
>
> +       if (rwmmio_tracepoint_active(rwmmio_read))
> +               log_read_mmio(8, addr);
>         __io_br();
>         val = __raw_readb(addr);
>         __io_ar(val);

For readability, it may be nicer to fold the two lines you add for each
helper into one, such as

void __log_write_mmio(u64 val, u8 width, volatile void __iomem *addr);
#define log_write_mmio(val, widtg, addr) do { \
     if (tracepoint_enabled(rwmmio_read)) \
               __log_write_mmio((val), (width), (addr)); \
} while (0)

I wonder if it may even be better to not check for tracepoint_active() in the
inline function at all but always enter the external function when built-in.
This means we do run into the branch, but it also reduces the i-cache footprint.

For general functionality, I think it would be better to trace the returned
value from the read, but I don't know if that defeats the purpose you
are interested in, since it requires the tracing to come after the __raw_read.

         Arnd
