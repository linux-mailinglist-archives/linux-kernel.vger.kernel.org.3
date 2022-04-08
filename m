Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24E4F989E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiDHOv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbiDHOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:51:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBD210077E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:49:50 -0700 (PDT)
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MT7ip-1nY7Wd1dzL-00UYdI; Fri, 08 Apr 2022 16:49:48 +0200
Received: by mail-wr1-f53.google.com with SMTP id d3so13210960wrb.7;
        Fri, 08 Apr 2022 07:49:48 -0700 (PDT)
X-Gm-Message-State: AOAM5314q0WqgwudkYj1VSsf0mFE1X2Cqg4IBsQyi1m8/hEIRhSljyrQ
        MqjfG1vUu0u9eI+thrcSA/Fx7La61uyd5BxOaKw=
X-Google-Smtp-Source: ABdhPJwVNzAUvp4q5y9Xv8Pl9NcevPGw56Av/8fDlBAo0sYujt7tAUw/HOtRrfZixqKYu184m37g27gifqdWtdVR4Vc=
X-Received: by 2002:a05:6000:178c:b0:204:648:b4c4 with SMTP id
 e12-20020a056000178c00b002040648b4c4mr14628640wrg.219.1649429387994; Fri, 08
 Apr 2022 07:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220331092235.3000787-1-hasegawa-hitomi@fujitsu.com>
 <20220331092235.3000787-2-hasegawa-hitomi@fujitsu.com> <YkWVTEG5oFO82GPL@kroah.com>
 <CAK8P3a0jnzse4sG58taO5+Yd5vCgh1uddqbtAuim_z9r15Q3BA@mail.gmail.com>
 <20220408133246.fyw5554lgli4olvg@maple.lan> <CAK8P3a0u2xa9BFmakG+f4kyLsqNZQbE6KQ6jz2356Fyen=1EHw@mail.gmail.com>
 <YlBE6hZHmLo9/wrU@kroah.com>
In-Reply-To: <YlBE6hZHmLo9/wrU@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Apr 2022 16:49:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3v4+AO5avGoxeZSyNTOWqk8YS95xQLWSBZ=yV_3DKggg@mail.gmail.com>
Message-ID: <CAK8P3a3v4+AO5avGoxeZSyNTOWqk8YS95xQLWSBZ=yV_3DKggg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] soc: fujitsu: Add A64FX diagnostic interrupt driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Doug Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Travis <mike.travis@hpe.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yacM5vXlZ9M/b5opAPcDYsI9bcnrr5azz1UO9ROET8AV68QYf76
 GDDX5aJpyXCn52nPH4I7bT78OWiwreWlfHYGDjHS4SXXeFXBVxA/7Qeb/ZgL+srBYo9n4Jl
 7TXkWuKDyZ+6ENe3ZbsKCp1asyYtn01gIDf68HhdLuRSCMOHmrmk9ehEefRgFpWxp9lv4NC
 jgjjus0mN7qR9cifrY0KQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M4Mzo/znBWo=:HC9J1XHoLde9DdKvDCUTEA
 vgPi89E76clvefrEP4NTt4Zp1Ea7+0UOiNsJjRt096kgbanNS5dDePv2HAd8uNYZaEjBLdRKf
 FhR2bkTMNZAtQNithR2TuaT8z+sEFarvDrFwheeowESpW+7O+nXqRCBkWWVTDBrbd0/9tvox1
 v4xXFsJ2cwKKpYgAGc1lPDNZI2+YbgS4MxHDdT3jM9AR5y8ysyIMKvAG/VyskJcTRwPbRIbkd
 PW8QG4EubOJxjWL5zrzlZXy/4da3mL4AP+2McVEJ3GRsdAZtlgpo8/uvCkIMd9FLR3ZP+40kv
 dK5M94PhW9CC1Kn6j828w8vsOWNcbpgtuQyzNdU0e85Hop7VB+2bZinN7NBMpfap4JlQibcSd
 HXOD0VnHStt9ZZd4AjTL5y1jYzHXPcKHx9/qbJcjvx7FiW2u5u6U6U8WsvTWw2YALhnElIX/C
 E5lvHdLzk1IF5CdNDTF4u/8Bf7VNJFZ7V0AFiZKxKzEAxsmUtigL7Muh8WjZbBpts8PwoW/oX
 dqdkp9RMJ7FwsQnRZPKJTak2WlbEdP1aYchpcFsNU950s63OaM5ysxGecg2Un4aDwtNpt1eph
 jCRtNWc9WMqe1BA75uFIDIAtHGFpgrIcwyfP+EmWN5DGUZnQPNGY1HrxICEeeocbZmRGHg7wB
 aNJkP6Fw3GCoIpZ31QYYQvGciWCj/csRoYw/Z+J0LC/RVCR3XefF6s9u7ohv/Q0bA8BPwP5fH
 7Zsne6WvfDz2Kyc6Nj1UqVLbe2+2wjcLhf8q4+Ju1r31XOcFmT6n5soa+4jjU+TvCuc1Dpd7I
 xhqjzC80CK9bIwf043ihyh3FnHMOv0gEC7+EDSZZ1iChXD9e3E=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 4:21 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Apr 08, 2022 at 04:17:16PM +0200, Arnd Bergmann wrote:
> > On Fri, Apr 8, 2022 at 3:32 PM Daniel Thompson
> > <daniel.thompson@linaro.org> wrote:
> > > On Thu, Mar 31, 2022 at 05:44:55PM +0200, Arnd Bergmann wrote:
> > >
> > > There is some prior art for this sort of feature. AFAICT SGI UV has a
> > > similar mechanism that can send an NMI-with-no-side-channel to the
> > > kernel. The corresponding driver offers a range of actions using a
> > > module parameter:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/platform/uv/uv_nmi.c#n180
> > >
> > > I don't think a hardcoded 'c' makes any sense. With a hardcoded argument
> > > it is just obfuscation. However it is certainly seems attractive to be
> > > able to reuse handle_sysrq() to provide a more powerful set of actions.
> >
> > How about a module parameter that allows picking a sysrq character then?
>
> Module parameters are so 1990, as this is a platform device, why not get
> it from DT?

This machine doesn't use DT. I suppose the same could be done with an EFI
variable, but with a module parameter you get the added benefit of having both
a boot time kernel command line argument, and the option to override it at
run time.

         Arnd
