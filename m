Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52115494D36
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiATLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:41:03 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58997 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiATLlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:41:01 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MIdS1-1n6ziY22gH-00Ehg1; Thu, 20 Jan 2022 12:40:59 +0100
Received: by mail-lf1-f41.google.com with SMTP id x22so20451050lfd.10;
        Thu, 20 Jan 2022 03:40:59 -0800 (PST)
X-Gm-Message-State: AOAM533qix8zh0S8JYOIk4A0J7JjhnSvFp9JUezj9sRosgXQqc+8ycFd
        C6mr0H48tOs4Q4U8wGH3ZW0R+WnsSoZOph9K4AA=
X-Google-Smtp-Source: ABdhPJyF4dvXk+FcL9rU+G/uYHJOqasQkkfireul5EseychvyhuLX81WEAdVmBsalytJouvYJnpcpue784HKoQtJs8Q=
X-Received: by 2002:adf:d21b:: with SMTP id j27mr1322485wrh.192.1642671701080;
 Thu, 20 Jan 2022 01:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-17-guoren@kernel.org>
In-Reply-To: <20220120073911.99857-17-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Jan 2022 10:41:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1nUcYjhEE5eyFAE_QqfjhRsZZ81ni8jyR8cPaP5QKJDg@mail.gmail.com>
Message-ID: <CAK8P3a1nUcYjhEE5eyFAE_QqfjhRsZZ81ni8jyR8cPaP5QKJDg@mail.gmail.com>
Subject: Re: [PATCH V3 16/17] riscv: compat: Add COMPAT Kbuild skeletal support
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QRPg0m11FXIX35ZpDKJO45FQQrsA48Tp9zAq+fcv4cwVZduUDO6
 igDfvInpvFkyMnF9+AWuLRjicRiTTZ9YG8OCkkpV9vvwpMvikaS5AnEB5sV3CHh0OqfsMyl
 jSohEPYoV4gbekjj9cwbRE0RH8YrTVUGF/qMcGF/1FpdwXBF8PloJtTTjga0r7W8tyDUmwz
 eNM6T6rwCAM6mFfYtX1FA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OOGCh8eo6RI=:Opa7Vr2sotNfgTsSlPC6N+
 KQXjpo4MqWmXDTiHa6fk/X4UivpSmMOryzjq30DmpXZzaYhqjndLmWyUFgReFH79nsPqf4n0f
 pIrGygPXkZaxMqctIZnQ4aUiT/yWXDuWlfNxgexzX0bF5ArQJxXe296rRwbWZg1Kw1ctqg4JY
 0b1lD41arqwEyJW+WvbIkdYXmelaY7F6GmMWB/jmZuvbfHkHZQXVvw6t0nGMwfn+Cq5A2hRxT
 gClQ92BSzMRM5YJbCM3UdXrmCxS4jOfQk5D+Ot2Zg1n2NN5Vk2tQfmr4Ao0vH6zRy565k+Jfe
 LZKigaC8nf/yx0EAxRrJJRIh7gTGEsK2XJ5dAxKElxIRSZa7hmLkXIup+V8HPsjlynRARxS51
 FDqBFJ8GQAnMqhJV1FO7f+gtTyyX6sBuqI/6xhV5OR5EPy1Z2kgPq8cpUOGXN9eDrqS96s0Ib
 Q/5iLRdXRWqy4Ma3IC2sapHIi6LP3U5WcTwky9PBH+6TRWM0nL79xhxy1lUSyPf59I58YJb3u
 8kFVTcLWF9ePDh9IxHslr+vY6SyBrbA1UgeTNzvEG2wdmFWhkdVeD5eoOJk1vX7XC/RzwEZqh
 HWXUKrkrpNcHAz7sHMm1djyE0ucOm7dsHAXZ6BBpEEFiZBWSYR+j97ZKGGmvkaxiP9mx5M5YV
 RMSx7M+1MwkcADO1MsEQFPnMlGZAE4BFhWvY9bCsZej7KB7qbwNPwAIgwrUDx6WomwwddcIkK
 xuBnMiwrAjd4M5Kv60EtjYmiUmvb5yjVjPFpeKwMFO1Bya2m6yS0zqIrQBn83hYBpFJxyivsh
 m2GrvKf/TY8Kmpzlqmqps+XrucJ4u37TzMNUkgpx76cBSjX1DtDCaiFjmCkuQQUtL2cOXK7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Adds initial skeletal COMPAT Kbuild (Runing 32bit U-mode on 64bit
> S-mode) support.
>  - Setup kconfig & dummy functions for compiling.
>  - Implement compat_start_thread by the way.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
