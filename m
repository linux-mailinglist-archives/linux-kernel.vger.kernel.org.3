Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344BF4E44AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbiCVRIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiCVRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:08:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FA86AA7C;
        Tue, 22 Mar 2022 10:06:38 -0700 (PDT)
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MdwRi-1o6b0t0Zra-00b7Oq; Tue, 22 Mar 2022 18:06:37 +0100
Received: by mail-wr1-f49.google.com with SMTP id v22so10423937wra.2;
        Tue, 22 Mar 2022 10:06:37 -0700 (PDT)
X-Gm-Message-State: AOAM531HT4Ch/uG5ZhcbR5kuU8Q7NyPTyYn5C+Sb8OwItukgQ1dSXfgG
        E8UeBjs/tpn4VTPLX44eAwEUuc1w3CWTo6FWLQo=
X-Google-Smtp-Source: ABdhPJzYB6ox3wweLxkaJdVg1CSTqhO684+KAFRluL7iV1tWdFcF/ONdn4ZX1CPYE6vDSSNrGQ2IMjZPkjDxTSOkd/Q=
X-Received: by 2002:a5d:66ca:0:b0:203:fb72:a223 with SMTP id
 k10-20020a5d66ca000000b00203fb72a223mr15794201wrw.12.1647968796788; Tue, 22
 Mar 2022 10:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220228114523.03b2f921@canb.auug.org.au> <20220322110925.7b295e54@canb.auug.org.au>
 <8ce9d045-c3c9-c839-7b82-9f5ccdae2d52@gmx.de>
In-Reply-To: <8ce9d045-c3c9-c839-7b82-9f5ccdae2d52@gmx.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Mar 2022 18:06:20 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3hR0JP-coRBNDytC1onPUfYCUn_q148kMO5-FWvxwgOg@mail.gmail.com>
Message-ID: <CAK8P3a3hR0JP-coRBNDytC1onPUfYCUn_q148kMO5-FWvxwgOg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the parisc-hd tree with the
 asm-generic tree
To:     Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:b7arbufAWiTYFolXORfGQsCYX9SiUGAUTONI9A2Nlj4TyoOF0zf
 ND1U9hnsMYobhHze2QgiYShUwv/Wm8RpBjdIYUZ+NlCJDZ60PBmMojx8mwSSF0z1EEt58HG
 LadnFRWmvoVv3pPhbnulDnWZkzw1V0Ejibmy8kC5rvC/LJwGyBn1/V4lEfrtQIivqY/YBfy
 gqnv8UBCCQLgq5Dd9ofEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O1EZIwAfhLY=:ShQmAeFA9GihY9zCn8wNuu
 p10TnwrPoQKQri0fKPeeTFH5OOMKoLD0VWVSsH/ptvt/ZmDzLqRGLQZASdr0w/uR9dTsVLZfR
 xfqtqYFo2ff3ruEPeptyeOA0loBk9V+2d4QCDf/2zVQLhzSxuczV3TO2IzlySU9iUhO3Q1LmK
 qC4U7+hdK8JwT8XklftGKfeA0p2E6RsecRPCk3mg1ka0sURspZ+jH6h/GQZv560J7hxe8pS0O
 qQpajIdFbgEkpEjB9rDNo5MUMiEhQLa3/C2Gd/oYPFKYM0FOVLBs5U0/3vGBMZ6p88hqFDY4t
 u3xGEU98Ru7i0wswik1ZokDfGE27rr/q4QqW9LIg++BF0Dbr/X27skTL0Brp+or1o9JPERjP4
 MPEOFNwG4L/xY5pqV06T/1A5Kffh3kYxxsBYwmKrSPHBlyZZbubdiIjBxPSKzzBZGKK9lHYzq
 0a4s+pBMCyq/QqD2mY7sC+U9RK2f50GKyQ/QKdlpYFh9jqzVjn9BrlZ1uEv48PHYefnL5gQIU
 dD7oz/kowuGAWXhV6zmJOanH88nYH2UbFK+BfpXMhMWZooV9VevBlYJMSEQRqY2ae8nSWVEqg
 cA7Wn7UYm/y9dg/du/lal/ZDpkWAsyR21/UauX/IRs842LO+hkQTXacn3WPQ1nfDC5TIfFCM1
 PNELxvhBdZ0bRA/q2vSer/ajszcTJMsd4nhVSuNWahg6UxEJQ9hof3CE6kkUjRitAMxI=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 8:34 AM Helge Deller <deller@gmx.de> wrote:
>
> On 3/22/22 01:09, Stephen Rothwell wrote:
> > Hi all,
> >
> > On Mon, 28 Feb 2022 11:45:23 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >>
> >> Today's linux-next merge of the parisc-hd tree got a conflict in:
> >>
> >>   arch/parisc/lib/memcpy.c
> >>
> >> between commit:
> >>
> >>   967747bbc084 ("uaccess: remove CONFIG_SET_FS")
> >>
> >> from the asm-generic tree and commit:
> >>
> >>   d4a767ea8b0e ("parisc: Use constants to encode the space registers like SR_KERNEL")
> >>
> >> from the parisc-hd tree.
> >
> > This is now a conflict between the asm-generic tree and commit
> >
> >   360bd6c65807 ("parisc: Use constants to encode the space registers like SR_KERNEL")
> >
> > in Linus' tree.
>
>
> Arnd,
> can you please drop the changes in your asm-generic tree for
> arch/parisc/lib/memcpy.c
> They are not needed any more.
>

Sorry I missed that earlier when the conflict happened originally.

I can't really rebase my changes on top of your tree now, and just dropping
the change without a rebase would break mine. I'll make sure to mention
the conflict in the pull request then and have Linus resolve it.

       Arnd
