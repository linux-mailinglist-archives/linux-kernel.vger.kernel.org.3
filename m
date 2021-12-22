Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40F647D344
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245549AbhLVN4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:56:36 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:42237 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245500AbhLVN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:56:34 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MWBC8-1mxKAd1Vrm-00Xf5B; Wed, 22 Dec 2021 14:56:33 +0100
Received: by mail-wm1-f51.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso2345269wmi.0;
        Wed, 22 Dec 2021 05:56:33 -0800 (PST)
X-Gm-Message-State: AOAM533JNhWpGmeRcXqOoOCADiHIBByeCy8O4cTuOkZ0pssBO7ZfEdah
        uMBjfyinhg1v+J7xiDnyMNqG0e0PkFAvFnNi84o=
X-Google-Smtp-Source: ABdhPJxHZHEwLAEwqHridYfJm7TlWCGLjIEDeHHUir8Cs1kP3HuMbH2jN9G4hTgoKteiOAzPC+bhvI86kuxZaYPixlc=
X-Received: by 2002:a7b:c198:: with SMTP id y24mr961837wmi.1.1640179840757;
 Wed, 22 Dec 2021 05:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-3-guoren@kernel.org>
 <CAK8P3a3dS=Ne0Pd2qZc8vB2whM7AUcJ1BNbhtf6EEboWAPpSug@mail.gmail.com>
 <CAJF2gTTN1HZeycK-WOFH0EjmjtBB4T=9de6Qrjs=uhAsLoOFaQ@mail.gmail.com>
 <CAK8P3a3m2Mz4Tvu+3cdji6iq_wvFZsYoyKvnaNKTEjE+ivex6A@mail.gmail.com> <CAJF2gTQEp0hEousuEyp5cPCa5Remb_8HMZ-BXZ393_z7hbne7g@mail.gmail.com>
In-Reply-To: <CAJF2gTQEp0hEousuEyp5cPCa5Remb_8HMZ-BXZ393_z7hbne7g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Dec 2021 14:30:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a165oWeGOgsM=U3F54e4HFvhJxr2sG0qoGLOe_WK8qAtw@mail.gmail.com>
Message-ID: <CAK8P3a165oWeGOgsM=U3F54e4HFvhJxr2sG0qoGLOe_WK8qAtw@mail.gmail.com>
Subject: Re: [PATCH 02/13] riscv: Fixup difference with defconfig
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:V+ui7Qfh5UJ5wbdFKKqnkMcn70JhiC8cXqClgW8RetvDqfobO2L
 nJNBiUoYiMSgGcBgIoFbvNzV4iyvOwJoCHSfUysVAcS0qOlYaqSn5iPStgLG6K5fwoFYIWB
 7ZksIhUT1ZOFaZ6REI17gMhvZA48aZRFXVXtlTP8swf3ozv4wqOCtitSQBZxcM90wj1KuYc
 ebkyGDtDMSRDNyXD6+CWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DHOosCbS8YU=:Egea1T/Zw6a6fxhPsEta8x
 IaumnO5BQwpM0o6upnzhacoNM4/qTKod0UGv0YzxsLS1UgCFs0IPRtwvXxoUnj7vNs30OJh02
 ZwrjLh+tSsi44/3L7LpaXIM9NEhRbpBpomokY/uVzYU0i0lo+P78Q6z81pTDhIEl0cm7PrIE9
 bbUWY0o8z66aQPUFnMuXaxTqiZM2Pjl++WEjIn7JCDbJ9pyfUHpyOouxk760dTDJciFuBAzSZ
 LROUsB2+Lbil6TLTxi/DqeFsM66r5j+9/8LIVdmO7I6XF1AHMn2lttqEAnviYPqqCjB6ZFJde
 IqKoi6CQWDYVXAaDq/8VolA1hIEeGFtdx+W+CSyjn3XvnLPL80qYa6Fo0Ims6pjIHfwRzQkfQ
 9udGcJwEaMNbiNDEO03iVpQX55CkZ4NnUfOSLCeAukOgKHlXmwt915Z3RLVluaa2Yn0O2eoas
 J0dfzTaCPB/ri4HeZqVJS0iNu8mK4g6AO6zqzC2FmqDf02wxIwvP1857ht4h9jhz3G4rzkIhd
 U8Hu98VRS1ENfVsdbpdwmgw26mwvd0Yvxj6W9qhWQiKHk7exStgCCvU7WMgpu7NiDzLppduxi
 1fBAhGuNn53MjyEwquE005h62lVzGePtMrQebKMf3ejjnYcrYWK5hOEM97ftgdPY6VgwvmCjB
 3urzxwB5wCDx5nzfq8XO5RWdR6mbYd97kXGugxubRVnOKZC/LtBrc3RwHebPIbWRvfR+yzkJ4
 lK8g13Ohq+oXmo3ExSpzrTXGUPlMXK3mmO6BMKNmE2qNYjaFAj133fpLL/eaevxbgKv/AozCa
 7Jh3LQ+ilRqqwFgm627kgtyidDeUWIFbk4tdqdhgBEm6K8rJQU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 2:06 PM Guo Ren <guoren@kernel.org> wrote:
> On Wed, Dec 22, 2021 at 8:51 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Dec 22, 2021 at 12:34 PM Guo Ren <guoren@kernel.org> wrote:
> > Given that there are no specific rv32 SoC implementations supported
> > by the kernel today (other than SOC_VIRT), the number of users
> > would be close to zero anyway.
> I really agree with you, but we still need the rv32 user mode
> ecosystem for memory footprint.

Sure, I just meant there are few users that would have to relearn typing
"make defconfig 32-bit.config" instead of "make rv32_defconfig" even
without the added Makefile target.

         Arnd
