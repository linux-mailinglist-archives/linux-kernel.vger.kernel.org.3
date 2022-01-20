Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3617E494AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359178AbiATJ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:26:40 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:35575 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiATJ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:26:38 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MqbDs-1mX06m2Ey0-00mfPd; Thu, 20 Jan 2022 10:26:36 +0100
Received: by mail-oi1-f170.google.com with SMTP id q186so8478481oih.8;
        Thu, 20 Jan 2022 01:26:35 -0800 (PST)
X-Gm-Message-State: AOAM530IS6cMCdv3arv1VITiCM41IZlTFYKedU3XPQQraoDSFQvHiYtB
        lrVraWDG10iuGZ2ZJMFWfUsF1JRzoAeo78l1PK8=
X-Google-Smtp-Source: ABdhPJwUHTIEKGF9B/deLoD+NLX/BPhPwhEAEkpKqsuu70hdzaWxQnSHkYBLqgySPz6euydrj/73VVU+G7+wmpaPV1k=
X-Received: by 2002:a05:6808:2206:: with SMTP id bd6mr6829962oib.11.1642670794688;
 Thu, 20 Jan 2022 01:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-5-guoren@kernel.org>
In-Reply-To: <20220120073911.99857-5-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Jan 2022 10:26:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3ixShQBKmdXWxf8QdB_aLeWr7TQB+7MqQBSgh0-shSSQ@mail.gmail.com>
Message-ID: <CAK8P3a3ixShQBKmdXWxf8QdB_aLeWr7TQB+7MqQBSgh0-shSSQ@mail.gmail.com>
Subject: Re: [PATCH V3 04/17] syscalls: compat: Fix the missing part for __SYSCALL_COMPAT
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
X-Provags-ID: V03:K1:9+M0fmdb5HxFeLZX9pIqezr+U7soQTbqk+JjtRs2FIL6hfst5O4
 2BQfFrTCSQVRnaR/fgEHUJOO70yHaGyLxtJj4EYgVaqfAN5xJTyCv/VoAJcfB7BOoxCvwS3
 MYW00xSfV4tr14+j8/NYptBPa/Ix+5VygRkmhO2iqPTyB03zQLV5vryYNqFPR2w5k4x02Y6
 TsZpLJc0Xmc1lJsPQZRZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nUtO5XneSiM=:Dg12rz9J3w1TQnxrs/E87G
 iesAAgSk2cZqLybrx9KAQoiYkbu8unUjK1VJXdruvwBXb1OyXQoDIfLZsAx0aTt0YXKAa0A/H
 AOyz1OVRRpVA6uLccCRnnlUoqHceRjCBDgFyH9oWc3Az3c0OXlhJEycCggpc1NDn1t/XBg1Me
 y4mZNvF3ItCXVn8G2bkjcjRAB2rY64oE/2YNCAGld6AQppFrkRMLtM8gbc1bZgJO2Qdl4/+kX
 ob38D6pruMcguRg80vHYA+Jq32WcmYbY4LS/8l5l+zfsGcJxhYrjRvtmadwk3qasckMn4iJTV
 pxpWoWzAPDvrpwGb09ijS0uCUztqlBGZJawiizg10VZQsgtfqELHpw+lhibeUpGzMrlCy5ZK1
 3EJDvtMx186UF8Ih7VZRpb2HVKXxry+rF0LdOuVwpsz36Aztw5StTL8I6sqVvpiZkG+syTS5L
 rvOruz6CL6Qz8wWyrQFKTZda1IwxALpBpan8aHexjjE+yvdbmme6ZAEq/gh57B5cL8ObHte/f
 rkXz4586yb0YgEBF5V2fX3BzUWrQHpnR13Xga/gVkQy2x4q2MPsdVNlWESuUkZxmZ11YDWL7T
 a5UQywC02JzoRKEti73luxoQ1K8rwExYfyUaBtzN46VajCjZ2iLa+5DZleXTz0b1CJyNIxDIh
 XugEsiMi8P1dH8pEa39CHcbWmQgDH8ixCYrx0eOm6xc+HMiKG5QB1HGf1uGLHJyUIqUZV2FKd
 w99m5jj8ake0mC8UFOr3AjYJsG/rwK2EC4t6lrdKPGrjRlduZQpg97LrkjJrHPD1CJxsdpjgA
 tivxNThey85wjJQBGsTjaQpN03Y8rBDs/vczTRjQDoJ396CASY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 8:38 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Make "uapi asm unistd.h" could be used for architectures' COMPAT
> mode. The __SYSCALL_COMPAT is first used in riscv.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
