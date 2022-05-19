Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C2952D0E3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbiESKyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiESKyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:54:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FED5AEE2D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:54:14 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N1PLB-1nkwmt1TIZ-012pEo for <linux-kernel@vger.kernel.org>; Thu, 19 May
 2022 12:54:12 +0200
Received: by mail-yb1-f175.google.com with SMTP id i187so6119316ybg.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:54:12 -0700 (PDT)
X-Gm-Message-State: AOAM531WW2EVVB5H5/6EXSpV/6qQUv6hfEv02a0j0a0w7+fThg6DO34X
        OlMI03tQiVE7U6PVL8QGCfoa8vt+EoXDZK4Uglk=
X-Google-Smtp-Source: ABdhPJwjmmfucUyRJLnkiUQUJCU0/cQPFqbnF106r1L1oh8lyoZV1cbnjW2MmK9RXYYq3F1iTcX3iqT9DtlLLB+HQOw=
X-Received: by 2002:a05:6902:52d:b0:64e:64b:fc10 with SMTP id
 y13-20020a056902052d00b0064e064bfc10mr3709287ybs.134.1652957651194; Thu, 19
 May 2022 03:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220517062929.3109873-1-anshuman.khandual@arm.com>
 <CAK8P3a3eR-eiY4Y8TNbyQNZiFXoEA8rk5EObZXg-D=JmxjnGCA@mail.gmail.com> <f8b83f8e-eb99-16e4-4e9a-dca58971b437@arm.com>
In-Reply-To: <f8b83f8e-eb99-16e4-4e9a-dca58971b437@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 May 2022 11:53:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0EGC-sBBdW_84WOoehbKAa39oX6gv4gqwkSK8p64PrYg@mail.gmail.com>
Message-ID: <CAK8P3a0EGC-sBBdW_84WOoehbKAa39oX6gv4gqwkSK8p64PrYg@mail.gmail.com>
Subject: Re: [PATCH] amba: Drop builtin_amba_driver()
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dcwvQdGl22TVeKQC7H5rOn5rstijAC7zpOWqTZ63JXTLnMsnAMI
 NBpIZLAkhK9OYJ3jwMC5BvcEdCFMYyGvVGY8fof3HaKU/LilN95cAUOnYL10OetWah8q3xt
 uNJ5lynyrfGtXlW494GyC8YZAo3CT/qDp10bFpRdn424VlhWOfA1fVaa5KnWrnHV8PALeFp
 7kEkVToS97ne6K/RTY6Uw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1DgB+WogRaI=:3gE6QXmEQo0iQBruf8lx//
 jr94IN1so9EgAn2kf8zUsW6eKKtE76nyekVM8lskAUd2lf29n08wxolZS9I8tdMjp4YzHpWur
 lOIyPOa6lxQXNasiF2xbYCduenFXYThueL+SzabfNo5SwmVaEHTRxJj16GT9o4v1OEw6gfpPu
 oPakyh5Xoz1Kflpeu09tpCrQMS/8vtTq8Iu05VFTFWPggLwoVJdS4hlKN9DmoYilxziZMEG3L
 1Ni21vlEX00M1PPz9nCgEEmDpI2Q2TIxm/AXzOditqgotylO/zgo/Eeh1H9kkr9P+jciK75oi
 kXcN09h5uov3uYbQL06Zrj4BvlUz1xgm4Y2m5ybtslmzSIfj8RICIIIfiO94q94BuhFNLP70v
 DkUkDt4cjNDRXGaiqNh+8t0HbKDgfW01ynKO6BFFI8var3uQps2EJ2hEyPkiMxiWGnG2TrlQ8
 3zFRlzklxdu3eTyt85O7dcSKq14U+Fbe6WpGS3818we3XtfNXLg2Rt9Hy7tH+y8dZvurbSpB5
 EF1sJKHno4UnDSIJH6JzEfN2l8Qq6DdpdfWiGUFdySVv7YFzFMKhNg+v7PoNPRacLImVNPocB
 VExHLqAQdkVRAXsQAxtoHrPt426N2huXg/681Sghddlm+25jVVi2UJVlJlGbwMIjjST8ze6tL
 qaBHpgX8Ca52lqQj4CLeo5J1e6Mvw8TrPQ2Y+gkyDK3u/Mt3eAmmmXxjEwY0HHQiT6iLrvxVW
 rCagpa7Jrzo7gFb2SkzNeO4k6sxCU0Li3erqdg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 4:08 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> On 5/18/22 17:50, Arnd Bergmann wrote:
> > On Tue, May 17, 2022 at 7:29 AM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >> Drop builtin_amba_driver() which is not used anymore.
> >
> > The patch looks correct, but I don't see the purpose. Are you trying
> > to discourage
> > having amba drivers as built-in? Otherwise the next time we get an amba
> > driver that cannot be a loadable module, someone might want to add back the
> > same macro.
>
> Right, then it should be added back. But for now this is just dead code
> and not being used, hence why keep it ?

I don't care if the function is there or not, the interface does exactly what
one expects it to do, and it uses no space in the binary, but most likely
nobody would miss it if it's gone.

However, neither adding nor removing the function by itself to me hits the
threshold of doing a meaningful change that is an overall improvement, so
why send a patch?

The original patch that added the function was similar: the coresight drivers
were written to be loadable modules but Kconfig forced them to be built-in,
so Paul's cleanup to remove the module bits felt like completely pointless
churn that just made it harder for Kim to make them modular again.

If you want to remove the macro out of spite for the original change,
I'm sympathetic with that, but then put this in the patch description ;-)

        Arnd
