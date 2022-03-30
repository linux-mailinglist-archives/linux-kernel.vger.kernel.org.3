Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233064EC5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346285AbiC3NrR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Mar 2022 09:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237381AbiC3NrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:47:13 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3BB9232A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:45:26 -0700 (PDT)
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mf0Jg-1oG0vX1VH8-00gXWT for <linux-kernel@vger.kernel.org>; Wed, 30 Mar
 2022 15:45:25 +0200
Received: by mail-wm1-f45.google.com with SMTP id n35so12275927wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 06:45:25 -0700 (PDT)
X-Gm-Message-State: AOAM533llxE8Ff4BHRZvCwKPc0qU1ULrPZKNUZSkkP9L4VYrlVEA7s5h
        fMQ3aTbEeEXUdwdzONd64wKMM3Y9J+msjdG6xIM=
X-Google-Smtp-Source: ABdhPJyFDtDMU88yCYrJWs8ilBs1qgSlTrY/zkuVFBVQD5a2e8HtDgObtvJMsCBEA8avtDQ005+YpydEfjPyDUO36sQ=
X-Received: by 2002:a7b:cd13:0:b0:38b:f39c:1181 with SMTP id
 f19-20020a7bcd13000000b0038bf39c1181mr4752181wmj.20.1648647915002; Wed, 30
 Mar 2022 06:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <87zglefhxd.fsf@mpe.ellerman.id.au> <CAHk-=whk4jihDM+zkhZPYRyNO0-YA1_-K9_NyC3EDsX+gkxC-w@mail.gmail.com>
 <87wngefnsu.fsf@mpe.ellerman.id.au> <20220330112733.GG163591@kunlun.suse.cz> <87k0cbfuf4.fsf@mpe.ellerman.id.au>
In-Reply-To: <87k0cbfuf4.fsf@mpe.ellerman.id.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Mar 2022 15:44:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2GCQd4SNpUvZrrEOgJ5OtOgj0PXtORnfe208n7tapzNQ@mail.gmail.com>
Message-ID: <CAK8P3a2GCQd4SNpUvZrrEOgJ5OtOgj0PXtORnfe208n7tapzNQ@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.18-1 tag
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, jniethe5@gmail.com,
        ganeshgr@linux.ibm.com, Jason Wang <wangborong@cdjrlc.com>,
        bigunclemax@gmail.com, Miroslav Benes <mbenes@suse.cz>,
        hbh25y@gmail.com, Michael Neuling <mikey@neuling.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, danielhb413@gmail.com,
        haren@linux.ibm.com, mamatha4@linux.vnet.ibm.com,
        Corentin Labbe <clabbe@baylibre.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Thierry Reding <treding@nvidia.com>,
        kernel.noureddine@gmail.com, Nathan Lynch <nathanl@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, guozhengkui@vivo.com,
        kjain@linux.ibm.com, chenjingwen6@huawei.com,
        Nick Piggin <npiggin@gmail.com>, Scott Wood <oss@buserror.net>,
        rmclure@linux.ibm.com, maddy@linux.ibm.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        psampat@linux.ibm.com, sachinp@linux.ibm.com,
        Anders Roxell <anders.roxell@linaro.org>,
        ldufour@linux.ibm.com, Hari Bathini <hbathini@linux.ibm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        farosas@linux.ibm.com, Geoff Levand <geoff@infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sourabhjain@linux.ibm.com, Julia Lawall <Julia.Lawall@inria.fr>,
        Ritesh Harjani <riteshh@linux.ibm.com>, cgel.zte@gmail.com,
        Vaibhav Jain <vaibhav@linux.ibm.com>, tobias@waldekranz.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakob Koschel <jakobkoschel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:aJfpSsmsCY0/TZONtBGkjjkdVa9dJdsNgcT+13VdPzSEP81N/+q
 49FBVN7TWVTGDM8eM5yUV5yvXng4hMO3TFFsw0zkBqvUbCIHiyckS69Xvt7AwFB2YGmwuU8
 mGsQLRo6NHxZOUIlKMnlJcn6KDS8N3R11ssGuFaPLHgzK9GRkgczp17p6cKCg7EHxVmGHgZ
 S2yyULvruQ+LIhWPUJmAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8ntCkkSA/zw=:QN7U91CGazWMQFgy4OTqIb
 pRXIK6RMZXjAYrih50Aji/LNbzcwoY4ZZ6oXuKr66h5VM5wO3qkcd5DzX27UaOJbCALPIWXz1
 0FA3wiGJ9X9e3vC6uuLEO1JPkPUZhUDKlfaFMBbmJA1h8KcRp288h7hqMcGV22iFMMJ9RK2sZ
 rVF/UzRLaIL7deW1TmKPtD19E1xAGM2UEpXx9vfXTIKrX5/HfJfYxwovddUydMAqNadHDQXhh
 rBeowqPNdf/yoCDMJNcwWY3YgUsm6XKlqeuxrxANZCHGi902nxXdks3OoP4WogqO5AVdkPCSh
 52L9KsvN4T/3G1ql0Z08SZ9XzQLFb5DE1lqeJBNCzm5NfvnBxQRbAZPvf/yvAXO1LQ8zEoxQ4
 vp5UQ3jUm7z6wsWturxQY1bqcnYNmnrVwNqmSij3YuWU4cQ500sn6k+LyWSp+zF/wn7ppeebx
 oCR8/VZee9y6ZXLOgLEkSEPLTtqNG5CnTkLGEbXb6gvjmmc9Za+4xAQglcgaPNy7iAEfTLrkt
 tDzq2xY35YouLlFJLFG7So5h1+FiD8NR7twOrYb/xVburWmINaASZspqqKOxT8mSvbB4uZWRq
 HuGQBGFDAOiB0vmROiGRtwdfHATp+nqdzz+T6isaOta7kB07tt/3Qrk/JAtkceGxnhSoVbwqC
 8F6jUb4o3wz7cY11GIwmMkRTBry1ljWvVDCHpwoS54s4no276JfT7DigVanjgkVArqYqsq+Vp
 IMyrpg13AGXjs+9gNHujoqMdzmgUEj2LVOiAnxr/PB7CCQObu3U8B4ufuHQLTa8dI9tel/jbH
 TXsOjFybsLqzxpeFaKKGGHTvAbxh6LrIiu+ewIXOKzhdO2D+0k=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 3:21 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Michal Suchánek <msuchanek@suse.de> writes:
> > On Mon, Mar 28, 2022 at 08:07:13PM +1100, Michael Ellerman wrote:
> >> No you're right, we have moved away from them, but not entirely.
> >>
> >> Functions descriptors are still used for 64-bit big endian, but they're
> >> not used for 64-bit little endian, or 32-bit.
> >
> > There was a patch to use ABIv2 for ppc64 big endian. I suppose that
> > would rid usof the gunction descriptors for good.
>
> It would be nice.
>
> The hesitation in the past was that the GNU toolchain developers don't
> officially support BE+ELFv2, though it is in use so it does work.

It clearly made sense to wait while BE+ELFv1 was commonly used and
well tested, but as that is getting less common each year, getting ELFv1
out of the picture would appear to make the setup less obscure, not more.

       Arnd
