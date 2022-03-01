Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F011E4C8936
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiCAK03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbiCAK0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:26:19 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081C28F9B9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:25:13 -0800 (PST)
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MRBac-1nb0Gq0oEe-00NDwf for <linux-kernel@vger.kernel.org>; Tue, 01 Mar
 2022 11:25:12 +0100
Received: by mail-wr1-f47.google.com with SMTP id r10so19727157wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:25:12 -0800 (PST)
X-Gm-Message-State: AOAM5319vBF/ZCHmlv5e7l5fi2vEd9mZ1oBUl7KRsnMKCmL+zVs0TCQ/
        hcogtF7MpjozHdnEtVZigB4gdtl6ygakX7+Tf3Y=
X-Google-Smtp-Source: ABdhPJxLaNC6EDIwvuQMWwK/O85PaM4FVnW8bY0GLWT4fI3URHk+AjQgHbGOLC4C8j+hJGP0l63wX1puSwc9q1wViCk=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr10586618wrh.407.1646130311732; Tue, 01
 Mar 2022 02:25:11 -0800 (PST)
MIME-Version: 1.0
References: <20220217224648.113767-1-jrdr.linux@gmail.com>
In-Reply-To: <20220217224648.113767-1-jrdr.linux@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Mar 2022 11:24:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2S70wWZZDNKqvxEsiU2_x1cYezR4zbddRebtyO+1ePpg@mail.gmail.com>
Message-ID: <CAK8P3a2S70wWZZDNKqvxEsiU2_x1cYezR4zbddRebtyO+1ePpg@mail.gmail.com>
Subject: Re: [PATCH] ARM: iop32x: add prototype for iop_enable_cp6()
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6IOn6z8nDzzoPeV5Kdd+yha0cv/sC+NJXavbanlJlvfbmOXkrnU
 07i502bcZm5dmXP3MNPzNc8tCvw0aUT7T+Xyza0l/2qHNXcQcJMJGvxh58di+z1vn7J+2GP
 VHODkWYQNhE/FrlEBmA3LKDZS/2SwOR9DEpBT9/NjtCc5d1zc9TPWZIF8zBJsV9fr63GMhL
 9aj3fnfCQNPQ4Qap8BF5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nq37gPh3NWw=:MpmpUtUHyypMtWtY1mrKDp
 dG0zWviD6a50kmvyg84vXjhkVtFd8jKbOmXcVnzrsHQKKZR04qWh8G0OHucX1MGgkgQ81Weus
 io/v58/x36h/TZ9CQgbaI0EuP0OIXtEq0bxi3lINHyssMYETQ3/4qXrHPUbTdyLFvP3At7I+L
 1NZp1Bkz6FanfLsKV6G5vYyL3AcfmaSvpGMtjT3qRIDuelrCSA4SeBHAI4xGwPI3+gYq10vEv
 jrJ9wtwSHnaGijkuKt7G4SNZMBYvILYJnFn8HNLyB9hGDIVZj2z0Lz5BN8+6INf741W/0UoxK
 0Y8UGGVcB7bJxQSg29mF6eohOPDt9xC+D3g/LoNTXscht9EoYUmwMWQqpJgsUpBl7u7/mTkm6
 udt2k/9hm5XO6CG60+PsGR2Nm0pWwQCHRPY6lS4KPKW/wIvnlhDWjbVEEk2khxo6gVjB/G22Q
 UVOkzZHR2WDB9z6Ga1BfmmkoCN4jp+/HNqWAT9raYXZ9hN3vRMUB+ne+oKjwSRRM8ammnMDce
 HRGUMviX7LFxM/zkP4NVguSKk4CA9HsnmxNxvJwdldtMs2GOGabqD/VMMSbbuZhszODl6fuFS
 4EshUgS2EUn9wX99s62zcfnF4J2ifU4G20KwKed+i97I+2bdM+109u1qFzshaWbWHgPPV55lr
 Db3VQvuTPHMDAnbup/h8WZ3WGYrp2SQFK5w3H6kNyqSkT9nkiIwEwAF7q2PKsdlwRk5g4XeaB
 C4+nFGOPlKulrYVa+UKaL3a4Ft7AJVfXcwrlAX6B7FAams2e7xL47eqbTpoddwIOIetbwSOj9
 k9Cefchn6bIf+ch/j6FK25OwyKOus0JszDyhTsoputQJmDxqi4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:46 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
>
> Kernel test robot throws warning ->
> arch/arm/mach-iop32x/cp6.c:10:6: warning: no previous prototype
> for function 'iop_enable_cp6' [-Wmissing-prototypes]
>
> Adding prototype by including header.

It may be worth mentioning that this only happens with W=1 or V=1 but
not with the
normal build options.

> Fixes:  6f5d248d05db ("ARM: iop32x: use GENERIC_IRQ_MULTI_HANDLER")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Russell, please apply this on top of the arm-vmap-stacks-v6 that contains my
original patch withthe W=1 warning.

        Arnd
