Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DA54F5CF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiDFL63 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Apr 2022 07:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiDFL5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:57:35 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45023709F9;
        Wed,  6 Apr 2022 00:25:00 -0700 (PDT)
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MadC8-1o9hDu41F4-00c5U0; Wed, 06 Apr 2022 09:24:57 +0200
Received: by mail-wm1-f42.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso1043042wmn.1;
        Wed, 06 Apr 2022 00:24:56 -0700 (PDT)
X-Gm-Message-State: AOAM533CI/PKZm8wa6ZzCWiJZvRVVj9pNqVSm9+IVTqNtjAr3UoMvJxF
        J+QKINwty/RDjsW5hTQhv/zBoMQF9BsUEcHQ8Pk=
X-Google-Smtp-Source: ABdhPJwu5LvNECmW4HyBVpv2Cer4xxd1JvOZpZs+VR8+dhKNlRWp+EIRBOEzkloFndgC0TmlXfWSyv+rVVHS3rSKUo4=
X-Received: by 2002:a7b:cd13:0:b0:38b:f39c:1181 with SMTP id
 f19-20020a7bcd13000000b0038bf39c1181mr6437333wmj.20.1649229896617; Wed, 06
 Apr 2022 00:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220310195229.109477-1-nick.hawkins@hpe.com> <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com> <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com> <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com> <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
 <PH0PR84MB17181C316E55073EBC28C386881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <PH0PR84MB17185ADBA824F9CC9EB3E022881F9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1080yz9jggOrwz2iQ1sAB2Xe2Emh22uCuqRok60BQSiA@mail.gmail.com>
 <PH0PR84MB17186189F5025374AA39584D88E19@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a2b+ESAAkc=_2hqx0kOxwYVS6mNjMGBKhhipaSj_5jV9g@mail.gmail.com>
 <PH0PR84MB17182115D57EF6032782659C88E09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1Cc+2oY9djdp11PuOW+TBQ0zf+p8QaDY3aerk1QqaG-g@mail.gmail.com>
 <PH0PR84MB1718925AA3C8FA998C486D7C88E59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a3RSST6yvv8Oy13RFd6eZ6cS5yX9TOuK6wxXKUO-qdQ=Q@mail.gmail.com> <PH0PR84MB1718C7447207BF210FBB477788E49@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH0PR84MB1718C7447207BF210FBB477788E49@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Apr 2022 09:24:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3jr-FkyxLff2cK4=X-4AShnKkeYMRKsvUg=2W0bTviiQ@mail.gmail.com>
Message-ID: <CAK8P3a3jr-FkyxLff2cK4=X-4AShnKkeYMRKsvUg=2W0bTviiQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device tree
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:hcnm1TFtV4LkuQMWF8cELx0T4BhQx6EAhi4quU+/u9iF33hJC55
 /76vtVx5gh05jtCDOGw7V63xRWEjDcDYj2pikjspANGs5Nx7mXEI/cdg7KZpwi+VRCgN991
 Ju+lDuMrZTGDSG8iWaRnT9uXnsSr0XLeJEP/u0jn2FiI5dGghRIw7lkR/sRc/lJU4yafPZp
 9VKyxeJ48jncHyNj6UJ3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hYT6ewNd+/w=:6moe45jsoTjDgHVLcBepkT
 mLDsDSrNCUWq7iuP/pi/3LkhDI/a9CbpFXDLc0qvGvpMBmLR7EPUDQi9kLPBvX8uwzHgpcAeB
 F+AYChYT6Z+Du0y1dT7KJhcE3XtCfISFbTuSXuqaG/7QNa2lRBlOnbGKlswGrkghyKU+jmi5Q
 ILYGgPB+dXBz9lELRJHgAqk/sBpA/AhBLRS0c7VcFqfB8OQpOmfXKh2AE0vLLSgTYBBRpBsWa
 zMYsAkCea1PYAzRg1/Jr+iPeUziLfSjwHtX6lyfqgFZD+p8GEqitmN5H8afb3eEyobA0MdrHd
 nuKTn2m+jshReX2VG25Ox/7WM9XxEQecLqqmZBihxm//P3mGqX5JfsP/LFn3YyUJRd51YHy99
 fttMHwDRQ/iO81FQVK/5TrFhwQ98azrSwKJX1vZNaPiMpH4n98XmMx8GbKGGjinJ68uvkYUg9
 U35Dhy8ALt3zKR9kIKEChVSrWheo0MuHZcjhYLdbiUeRL8GFIv41Izmbq6nPkOV67N6ghUzRD
 OMW2+eZwnXlkjXVb3rK9SKgdoX3EU+Kckah2yKmGR/aqeCbe2nnEPDGKbXo+/0oA0Oh+WizyN
 2qLt3kHzCQlXHBJgE3o9nqgYaqppV1vEWrJzUXH2qSNSO/0cmWzGq3oXoZouq+dVES2OrGKhP
 bK5n5Z1xFDpoib8URfmArKvIKEw1pPiBeirPObwal7gmdSUPnVKc8HfwZUBAsaBmmcrA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 11:21 PM Hawkins, Nick <nick.hawkins@hpe.com> wrote:
>
> > Right, it is possible to make this work, but it's not recommended, and you have to work around the sanity checks in the code that try to keep you from doing it wrong, as well as any tooling that tries to check for these in the DT.
>
> I found an example in the kernel where the timer creates a child watchdog device and passes it the base address when creating it. I used this to model the gxp-timer and gxp-wdt. The following files were what I have referenced:
> drivers/watchdog/ixp4xx_wdt.c
> drivers/clocksource/timer-ixp4xx.c

Yes, I think that is a good example.

> This seems very similar to what you suggested previously except I do not see a private interface in there between the parent and the child device. Is it mandatory to have the private interface between the two? If it is, what would you recommend that interface be? So far without the private interface I am not seeing any issues accessing the registers.

I would count passing a register address to the child device as a
private interface.
It's a minimalistic one, but that is not a bad thing here.

         Arnd
