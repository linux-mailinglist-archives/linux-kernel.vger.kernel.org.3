Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9D947C4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbhLURJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:09:49 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:53619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbhLURJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:09:48 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MZTyo-1mvzXY45Ic-00WYpO; Tue, 21 Dec 2021 18:09:47 +0100
Received: by mail-wm1-f46.google.com with SMTP id z4-20020a1c7e04000000b0032fb900951eso2179626wmc.4;
        Tue, 21 Dec 2021 09:09:46 -0800 (PST)
X-Gm-Message-State: AOAM5326zEgzOjqCXQd8gJgkAAhXoQ2+ZYf16vCMQuVMlNaNlTyofrbk
        +ZFVKqPh2KNRjYJGBKef9GWVfj4y6wb50kS633w=
X-Google-Smtp-Source: ABdhPJzaqpqJNCbIa99dFVCtyNIizr9whaZNUWhkKim9JOkhaY5AWVisxu8w7rdXDuXyxS5+Qd3gQL/iBewf18GWlZ8=
X-Received: by 2002:a7b:c007:: with SMTP id c7mr3639851wmb.82.1640106586666;
 Tue, 21 Dec 2021 09:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-3-guoren@kernel.org>
In-Reply-To: <20211221163532.2636028-3-guoren@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Dec 2021 18:09:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3dS=Ne0Pd2qZc8vB2whM7AUcJ1BNbhtf6EEboWAPpSug@mail.gmail.com>
Message-ID: <CAK8P3a3dS=Ne0Pd2qZc8vB2whM7AUcJ1BNbhtf6EEboWAPpSug@mail.gmail.com>
Subject: Re: [PATCH 02/13] riscv: Fixup difference with defconfig
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, wefu@redhat.com,
        Drew Fustini <drew@beagleboard.org>, wangjunqiang@iscas.ac.cn,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lOmQL97/XHO8MyIAgwAHai3sRy97dYaav87m/8hm75iCrmiaL2k
 zkGy3YWgCJy9Pd3r6PWXhAClolwF0+Xp2MF8TjRCwsExjVoBsL94PMvI8pZDRWk8XJzJKhC
 XdRs9/qSY4v1dH3R+/OSM06gH1MQ1iOxdS0c11gYvffrx3pvqlBSv7JpeTSsH2bKyz+HLcy
 6yRNS/E0a5CxMUOzYbLdg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O7M2kMbiGaU=:M6p/sgsl8uAPmSE+s+nNn8
 EE7HjqhT9sNazYO/fhAVexgoGw+6g+Pybo+Rwe+FPsuhSeWANgmjrmAqzApIwhRNykS+EaHhA
 5eS0h6zNyk4fhyC0Vtczks9nV/CN99RAa/ONByquKSUQA3ecWXQV5mzWeag4SkNSV2s7u1/AQ
 oh91nhJGcRsKkby51r2hCCvZkE6dLJDmqea/+GRygPLZgMTj9D/IIvcdFEI2dFBGzb4hFo77f
 NI10AfA/3M9vwbYWUd35/2/SLrFQnt4mJtEcj+ZMNEZHiNxewxczhYvoiRcOLNvuE2XXMo0QL
 he7uuNyAyH9Mdl/L/rzPL5ekBBPAlswZTuPGEf//Rm0/h2SnQShk2GZgFHoCqlKjdifESzwR6
 DFxxNau9/tgPDS5vx4+m1eby5rtleHboqdlpgEspAG0jxNuQO+1qPAJNeueKS3WWE/sgkKoUZ
 RKyJkTZMvtz3IdyOccD/5BixppUeoze/AI0mxZSxen5pe14PWGHnEZMrCMAOY5iDXjFmjkTk4
 sSCzih6DV5APtUlhyt5PYyqWOyqgPWVYwBmiRYhsjum4y5zknZGUnLqG67WAVRMHP8MNHbtRd
 dwZ9bE0eCzqsyEnm3HlgvE+jSn+xNM6ijYVHaQKXPYibILx0rCdDQSg6FBOHL05XPjyNyCtfK
 IA0a8M9XspQsF6IBhlwmJ4k55Oxc7qMMKWZaNj/L6EsHDOFHgYuz9Lp4unjjYp1XdIz3Ukkga
 UXgbSiAN1Tiv2nniPuOJf4R7zNC7BbkSItT/VLdWToSQ6EsCFkOpLrDnNpGSQ5hHLFbgXG2Xw
 YbIwYmTEsONzYLq9JLZauoYP2BjmKQoX9bqK21Ypp4XMDZJhIs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Let's follow the origin patch's spirit.
>
> The only difference between rv32_defconfig and defconfig is that
> rv32_defconfig has  CONFIG_ARCH_RV32I=y.
>
> This is helpful to compare rv64-compat-rv32 v.s. rv32-linux.
>

If the intention is to keep them in sync, maybe use a fragment for 32-bit
mode, like powerpc or mips do.

      Arnd
