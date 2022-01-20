Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB9A494D41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbiATLly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:41:54 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:49665 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiATLlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:41:53 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M5fUy-1nDGhp1Zu6-007BIW; Thu, 20 Jan 2022 12:41:51 +0100
Received: by mail-lf1-f44.google.com with SMTP id y15so12271320lfa.9;
        Thu, 20 Jan 2022 03:41:51 -0800 (PST)
X-Gm-Message-State: AOAM530tvyQ5T4JV3gkrqe9AhUSyTnugciTj7DiHbp+8zbWWFJ9J3QcL
        04n5wA1NFJmsAlHDfi7PJrwtL9MMOo2yncro9VY=
X-Google-Smtp-Source: ABdhPJym7KyRCSRXKMerVMcQ/VMRiOiyKpoCP7tEcDc9DhkSEEWwSJxd9o5Jl5QZLGZ5wnpG9DwFk+lKhhVFjaoKItk=
X-Received: by 2002:a5d:6488:: with SMTP id o8mr12004975wri.219.1642671600998;
 Thu, 20 Jan 2022 01:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-16-guoren@kernel.org>
In-Reply-To: <20220120073911.99857-16-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Jan 2022 10:39:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Mr2m2dVoVss59cN-9X7GVBD29VQLo3m4xswRznk_WUQ@mail.gmail.com>
Message-ID: <CAK8P3a0Mr2m2dVoVss59cN-9X7GVBD29VQLo3m4xswRznk_WUQ@mail.gmail.com>
Subject: Re: [PATCH V3 15/17] riscv: compat: Add UXL_32 support in start_thread
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
X-Provags-ID: V03:K1:Jnd6tXvVheyrbbh+xeAuIttBPYzIGn2pO6Pyy8MGiT7g0+tHTYg
 ppNX/NZb5qBasQ62aCGAhwBL+KVQ3j55clV2VBrd3V7EfaWg99achBw8Fs+nw6eqKCj6sb6
 Z0pBdcJ/OTLz+hwGXxFN1cZNSxla+WitNBAupt4x22wcNWGOv8qfEZ4LylMsFF/ugnh80Q3
 sybg53kul8jJBGqrQl8jw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uopUgF9nUW8=:DzrAYNFvXtQnHD9gAQ62SZ
 KDQrMUgKEJ3r8Gloo19zs/kHAS8ArUSOCjvLzo4kYqAuWXzoh/Qx+2OfOPZFggQVX62C/6tfq
 7jC82Yjx+G9qjLVSo+fwksf/4XEDFPhPZsFU+tL9jgVx8xis2uS/FcvbD8hzRT15vBDzTi21j
 upGJyywC5RUB/z+gn/vOPmqym2BVQm7QhhFTEl9DoTiGYtum/7jjbP6le9v4ikC5aVqRRVIk8
 iqraqxSSHe69jfpKd7nwgXEEpJMLKq/vdF41u+Kr66X2Hj3VTpL/xvviv8SaYv+Iw04jpN4zw
 jKzSWeRQB7XPN2pjaWFV/WAhYJLmt/bwejY35v3exoNGsqxTbHpYc8hSddymWqU06GNQcKDha
 vNwH5Bz3QZC39Jv3bJd9PKYkT4c6DAlL1baTUfx7K2QH5+myoymmVXjRvBVDYAwFfYW5/Rg4V
 jbkQrGdilj4ccMATwBjp0XQagMyUByj5fmSBAlDUqaFwsYjJopR49yDUeJlpS4gXH8IBdjCMA
 nuxKrt9QVVDtgcHpVfY/F52nnHFqQfxvAdiRnFvlC7+PN40rAWmX1OofCeVBhUD8fQdf6kV4f
 lrA3353o+P/rXCYAjEESSUp+hHv7UUmaQsxjZaxjh6UaV6YsdFPrfwHcm1T4b8TY4GXakTmoP
 zQFQ52g6g+0KJMG2nCqOAZX1beilt8MCDzbHiMig81k7PrPWRrMFhyACyyIftYGqX++ssRNNG
 mWQpi7C3vm1O57Zt6PYmGEpUpDxqNX6uhsZMpYYb7+31boN3Z5ShNN7Cw5COmJd0y7lSoIH8n
 xHDVo/1L7a2oS1wf3nqZH9s3QIvxFTp9rUS+xs2mz7VhLn9U2GzyWnuQnWjH6Yow+qFgoD7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:
> +
> +#ifdef CONFIG_COMPAT
> +       if (is_compat_task())
> +               regs->status |= SR_UXL_32;
> +#endif


You should not need that #ifdef, as the is_compat_task() definition is
meant to drop the code at compile time, unless the SR_UXL_32
definition is not visible here.

         Arnd
