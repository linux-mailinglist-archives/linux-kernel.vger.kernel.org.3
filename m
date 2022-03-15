Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834EB4D978E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346556AbiCOJYV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Mar 2022 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346558AbiCOJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:24:18 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700A4264A;
        Tue, 15 Mar 2022 02:23:03 -0700 (PDT)
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MzQXu-1oGV8v2unY-00vPvu; Tue, 15 Mar 2022 10:23:01 +0100
Received: by mail-wr1-f51.google.com with SMTP id x15so27875178wru.13;
        Tue, 15 Mar 2022 02:23:01 -0700 (PDT)
X-Gm-Message-State: AOAM533GgKubDIOeUFc4cSTNMr+TWXR65vczvHMwJTVmBRSRSO0I4yNp
        tJZzCciwzzj0TMQOe+4wHxdpCWx/X6qUTv+/qyw=
X-Google-Smtp-Source: ABdhPJygglQplbdr500sbGmwBXDj1uLGritb/Gu8k0RWkp5vWXikTi4O2u6nzebi9AvdE//pYxymktEkOqy6D5LeCLE=
X-Received: by 2002:adf:f606:0:b0:203:8dff:f4ac with SMTP id
 t6-20020adff606000000b002038dfff4acmr17197414wrp.12.1647336181331; Tue, 15
 Mar 2022 02:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647095774.git.tonyhuang.sunplus@gmail.com>
 <07f507a84a9e39d3cd8393f41d1292c250e07642.1647095774.git.tonyhuang.sunplus@gmail.com>
 <00362767-080a-aa7f-672f-22b83ab35e61@kernel.org> <42f5f710077b40d7b6fde45789f46732@sphcmbx02.sunplus.com.tw>
 <e4ed4b50-c16f-5c46-7d64-f5b2f36f8f44@kernel.org> <58fd70a3fa3d44229edd849cab49eadf@sphcmbx02.sunplus.com.tw>
 <f3c7af9b-85a0-1148-6096-30345f1a1478@kernel.org> <0d615380aa85444c81e9b93f4a216232@sphcmbx02.sunplus.com.tw>
In-Reply-To: <0d615380aa85444c81e9b93f4a216232@sphcmbx02.sunplus.com.tw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 15 Mar 2022 10:22:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2K+TTP3a_jNsPi6Ea+8THrM31ecO_=bNEFqPP+XZCd9w@mail.gmail.com>
Message-ID: <CAK8P3a2K+TTP3a_jNsPi6Ea+8THrM31ecO_=bNEFqPP+XZCd9w@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] misc: Add iop driver for Sunplus SP7021
To:     =?UTF-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:K0Qy9rBfl+lGEN3fmr1LRggL2e8Wh9GoKADVQvdpgqPDEgDwDQg
 bffffrt1ZqV+nsvoSicAlQjPZ35+8MpaGEPlMb1qQ4CvPu0RlBhTEkYOvg8AQ5ZrRRyhVTe
 fnkSEjKoppC+aFsiEeXz4+9RUTqaWMfull/xiXsOYxmRnsVwgBD6Tklk2vVqg9lP+h0xF1c
 AYY6odH6E8fvkKhWDoAZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uBoElrGp64A=:LTqxNTQKRfCL/NQDZrSsx2
 e1bTR6hZLmSQAjG7jZUY5QfoIWV3t9jkl200fQR10z/LSxC3MHpRMUJqTxS3QQxIkGmwdBf05
 8bZuZCcHwqq8A8FOZ9OwKlQiIzs4Xj6GtcA5NkHR3aq7Vwqiehed2ScPZs11BPKLA8rfOj4tu
 q/21wPJffrgsCrLConkNLShm3RfxIumzrJ/mjJpkFQXH6BW78UqK0gVdy88oMtKFx8dfXArf7
 M4jXkAqktHh58mrbRWJGfx9TlOKk7uMBW9cvGxkXjajpcTM7Akc0ifVb1nRI0bO0bUhvyR54K
 uYTpheTviILJSqyVJhEjUkR5Lu3ewlBy5blghCdTfV8EqNQvJkXaP3NeJDreoG7nlCHZAxXYb
 hs1IoaK8OpRAVG8QPAT+pWrJa0BDs0EWACP5DoWyXNz1/nbE05VRmJ/Oh/3ZV7z/KGc3K65PB
 XB+G8yF5wfSXqWsb7QpDrZuOnvq7LMkiEtavKzC4X13nE9pZmY8foWn6VuiAMeQOfeu+rRtv2
 DJtNhwdfqtNtsyQ2sTK1BHCVn94GWI1zIBGHLBQTkJS/5ymi9EIKYkGy25OZXjZKMa+0x6tEw
 w6YWi+e5P3a6gc/6kL4dLuOzu7Gy83GCEgtrulQE97Zg6Lq6jMma2Qy+E4fi1wq3oR4/MvzYu
 XI4WSn8sGg0lF6Hws9IQD/6WbzB35whep74rlYyOkqCqezkbxTgJiz4psxfDCVoDSrJo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 9:24 AM Tony Huang 黃懷厚 <tony.huang@sunplus.com> wrote:
> > >>>> On 12/03/2022 17:16, Tony Huang wrote:

(note: please use normal quoting style, only quote the parts of the message
 that you actually reply to, reave the attributoons in place, etc)

> > > Can I put sp_iop_poweroff() here for now?
> > > When power off device driver is added in /driver/power/reset is complete,
> > we will move to it.
> >
> > Not really, because misc drivers is not a place for power off drivers.
> > The driver here looks now like responsible only for system power management
> > of a SoC, so most likely drivers/soc. However it has even less sense to add
> > some feature here and immediately move it somewhere more appropriate
> > (instead just add it to the appropriate place).
> >
> > Your moving of parts of it to drivers/power/reset is now confusing. What will
> > be left here? Please send entire set not just pieces.
> >
>
> I may not fully understand your requirements.
> You: What is your plan for this driver?
> < ----- reset driver? Misc driver?
> You: However keeping all in the same place would be ok, if you do not plan to add any more features.
> This would mean the driver will handle *only* reset and FW loading.
> < ------         Because system does not have a power off device driver.
>         sp_iop_poweroff() can be placed in iop driver?


It really depends on where you want this driver to head. If you don't
have any plans to add features beyond poweroff, having the whole
thing in drivers/power/reset/ is the easiest way. If you do have plans
to add other features, then explain exactly what those features are,
which subsystems they go into, and why you haven't already
implemented them in the previous 11 versions.

The common bits of the driver can go into drivers/soc or drivers/mfd,
partly depending on what abstraction you use between this
driver and its clients, so it's important to figure out the correct
abstraction layer first, and then decide where it should go.

One common way to do it is to use the multi-function-device
abstraction to automatically create child devices from the
hardware device node. Another option is to have high-level
functions exported from a soc driver. Or you could just have
a 'regmap' exposed from a 'syscon' driver to provide
individual registers to devices. Which one of those is best
for your system mostly depends on how you end up using
it, and we have no idea until you have more than one leaf
driver on it. The poweroff driver is not a great example either,
because it does not have an interesting interface and just
comes down to a single function call.

      Arnd
