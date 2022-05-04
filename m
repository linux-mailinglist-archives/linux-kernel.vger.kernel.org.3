Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FAA519EBF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349232AbiEDMDy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 May 2022 08:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349119AbiEDMDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:03:51 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD171D1
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:00:13 -0700 (PDT)
Received: from mail-wm1-f47.google.com ([209.85.128.47]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mspu2-1o64sF3C2q-00tDXf; Wed, 04 May 2022 14:00:11 +0200
Received: by mail-wm1-f47.google.com with SMTP id p7-20020a05600c358700b00393e80c59daso2530300wmq.0;
        Wed, 04 May 2022 05:00:11 -0700 (PDT)
X-Gm-Message-State: AOAM533SDCVqzQiAdKsV83vgiJE9VyJH9Jl2sQzi1xyjCxHP/8W/lFlE
        M/RrauBA2UJujaaNl1c8a9CIW84ywx7qwk6yP2E=
X-Google-Smtp-Source: ABdhPJxa91M6kOpYUD0iTKIgWao6CfWQbX+SRQAAcnEVkI7cNck+veUzwJT66OrSTBCPZk65kSjp++m9nNZ6refLZnU=
X-Received: by 2002:a7b:cc93:0:b0:394:2622:fcd9 with SMTP id
 p19-20020a7bcc93000000b003942622fcd9mr7695473wma.20.1651665611020; Wed, 04
 May 2022 05:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <2c8c96f-a12f-aadc-18ac-34c1d371929c@linux.intel.com>
 <CAK8P3a0hy8Ras7pwF9rJADtCAfeV49K7GWkftJnzqeGiQ6j-zA@mail.gmail.com> <ca39c741-8d15-33c0-7bd6-635778cc436@linux.intel.com>
In-Reply-To: <ca39c741-8d15-33c0-7bd6-635778cc436@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 May 2022 13:59:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a33b4KvsGayDV7fXte0+1FzCJp_J60d8LuZO3P+i1NUEg@mail.gmail.com>
Message-ID: <CAK8P3a33b4KvsGayDV7fXte0+1FzCJp_J60d8LuZO3P+i1NUEg@mail.gmail.com>
Subject: Re: [PATCH 1/1] termbits: Convert octal defines to hex
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:7CQbFrqW4cTrqLaKVG3j35bzBmKn+IuU4tx6h+ezN6PVZKgk+sz
 8qiTIxQWgKVg592Oz6fM8BuTAJRta1OJthsCcRFJWgMJrQl+8iOo18131rIlBhcQ167uw2s
 qAsXBkV140cw0H0Uw5CXNeANe/rq7NcMXdg9AUUoijd/XgP/QBj+C4gUWMGdBbcXYryCDEK
 fMwzJlPIbalz2Qph2RNqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eBxZwELfI7I=:wkZx4357UXVPRujOyLh5rO
 /9fkGXIM1OnrNk9FPhfGs+UphtdG31soYGVtJMCd9VWh7woe2Tyg5cWWm3VItekgDSCaszTG/
 uMXmHNVOfsWQphfEbeQVOEMcFbTLBJewUNcn+dEj4vZIDQkl8HoB/QhbBJrkyv7937dmGqcNZ
 zgKLf+cx9ZlmcTGGiQLb4VhZjO29h7I3aRQFR0UiN2QC3eUdZxGLS2wrUKHnxqTr2bvh/Zom0
 QkLcn+Tb0ZSOaweKRS13qGp67FczszbW4CR4jP2CtQB7SvBSY2l3UckHQ97QlYs55Wp6J9y8L
 RMXgFUSZ7VFpf6LjGy56e2zvJvgr6nzzXHytfBf7QRqNPb4gGd3h+NDSdneHaOraDmxCxPJiT
 FDLr8eb0Mch5hGGCoEf1VnJf5gfszGOM3kUHZTPXtI5/iUMPfXgWnS8mI+YSx4aG4LmiHIfSu
 oQv010fjx6JfJaOa2HoyZ7TP9GtEc5ZFMxG5asa6HFfWR1/Ztv8XtmOyS6NCJxh7mrOKbKpJG
 QnbvF6xywiZOg5fY2QvVUSkMeR+G28qFFGRlI/Nh8/KRCu2xplnaFln1J4yZxJuCkVbjfTxW6
 qwp/As7G8PHXoo/k4sIiNTZKTzqMQyZpn/OuHazms2ItlatG7CzPG37X+3Q2+oaItq3vvMJBH
 R//3zex0OYDQLLY7u4c98sZqHg5spQ9hlkpC8boVrdQKw9eX7DMcSg+kaw0EdBmdeolQZYnMl
 LfWz1eM5qPEsuqGD4+OqWF3xZ/aK0ZbSCtkcAm+MLJjemgknwEQLv46cCzjypTLrZ9vhWZXmA
 RMtovRJX5Z4ewYvej9Q+c4n3uaPmGYNKXbCajWFa4QjznBk/p4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 4, 2022 at 10:33 AM Ilpo Järvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> On Wed, 4 May 2022, Arnd Bergmann wrote:
> > On Wed, May 4, 2022 at 9:20 AM Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > After applying the patch locally, I still see a bunch of whitespace
> > differences in the
> > changed lines if I run
> >
> > vimdiff arch/*/include/uapi/asm/termbits.h include/uapi/asm-generic/termbits.h
> >
> > I think this mostly because you left the sparc version alone (it already
> > uses hex constants), but it may be nice to edit this a little more to
> > make the actual differences stick out more.
>
> I took a look on further harmonizing, however, it turned out to be not
> that simple. This is basically the pipeline I use to further cleanup the
> differences and remove comments if you want to play yourself, just remove
> stages from the tail to get the intermediate datas (gawk is required for
> --non-decimal-data):

I've played around with it some more to adjust the number of leading
zeroes and the type of whitespace. This is what I ended up with on top
of your patch: https://pastebin.com/raw/pkDPaKN1

Feel free to fold it into yours.

        Arnd
