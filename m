Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8581E49F6A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347730AbiA1JsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:48:00 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:38531 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbiA1Jry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:47:54 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N4i7l-1mDxa439SJ-011lZn for <linux-kernel@vger.kernel.org>; Fri, 28 Jan
 2022 10:47:51 +0100
Received: by mail-ot1-f50.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so5212514otf.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:47:51 -0800 (PST)
X-Gm-Message-State: AOAM532nlG+2m9noW03doFBUhBE4LrbsaHU+Z8fQlp+kIirttZ906/lE
        0ntWwcrNnsOQhjPG6NtbC5Fu0ZtjVa6T+WWu3QY=
X-Google-Smtp-Source: ABdhPJzp5Htqdb3JCf1jG/gt+ko6hgo2qDAGRuEKahvQHJAf7ZWXKFdwm35JJI8P+vzIjl+GoGQzBeTuVTRQ8fiY8Bc=
X-Received: by 2002:a9d:654f:: with SMTP id q15mr4360244otl.119.1643363270457;
 Fri, 28 Jan 2022 01:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20220127083545.1020423-1-skyostil@chromium.org>
 <20220127083545.1020423-3-skyostil@chromium.org> <YfJovN7clqBZ8NDr@kroah.com> <CAPuLczsLSnojXG8zyWBq6P50S8dVN3LcTi+2L0j-zLbwC_cJ0g@mail.gmail.com>
In-Reply-To: <CAPuLczsLSnojXG8zyWBq6P50S8dVN3LcTi+2L0j-zLbwC_cJ0g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 28 Jan 2022 10:47:33 +0100
X-Gmail-Original-Message-ID: <CAK8P3a09twTx-UFGw9u_b0CtJJGbwbyO3Z_aL+Tr3iHrvgv_kA@mail.gmail.com>
Message-ID: <CAK8P3a09twTx-UFGw9u_b0CtJJGbwbyO3Z_aL+Tr3iHrvgv_kA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers/misc: add transfer ioctl for HPS
To:     Sami Kyostila <skyostil@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>, evanbenn@chromium.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PTH2ElbtVe3/KL0i681dJ4wG/ei1nUVFyFWgx+HzTvBvh7TIdIe
 P0zPaCmZGyrCcQKo6Tdhh5Zxn9phm6uENOBYCxSb65JllAYsBED35vZhdArLW/AcGQZjIGO
 PMjeSGRYjpU9sAowKsZFxX+Is5OjDBWyEnqZ+fB0EBwP4q9KOvjpp+UI2CBxJkBWaDHef7/
 sWWl9FUsWbnjmWCI1/HGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8CRc2LhxDQs=:pwe1vLDL0M79nbl+KBxzcd
 AIfwLRjXPcBYvkH7JmiQV/1tUsJJSXMwPSbBR+5OKueuK19IKHvygA5YSQgk+acgBOZ9tePG3
 sql2togQ6WVJQV3D4VzWLzNv8JTN4PlHYoDYKx3SGDoN85an+rTt+iOcsLKgM6Rd+JQxJld3G
 HEZvGuqVs+O2aNi0Fn5HcMbTT57ZUb2y6Joc3oASGVSZYhXll0b93B01mL76+fKGDGeiLIf+6
 ok/VXziZvk98oRJmWYM7BcgS129ycEVtLGRngRZ7ds+NcR1edWoK1vYk2lxUUYHTk5FsaxDdX
 0CM6jWq777T4sljv5Kyy80USV0XuJug+Ll+gin8Dlr9nkjuBoG+MVyNxgw2xfvSpnQBR+iNGj
 8mSvINL6oucYTdB34DNSGTupO9khhUe+zZSCWnZTqEc3WAIy/09vJKoVosaRHTWDWYFI2k/cK
 amXFcZX+GZaJuTQpsuGQ1RY4YhFqW4ZPKi3Ar6mVoc/wwZj+NVSTzdygvHNCcAPs9aQzC2vPX
 D4EvD9pIcSQiUvXACxf+cvzudj+21xeg9QANCC2siKS5cW8hv4GUs0+Yssyp5jL487eF/4jg8
 PTE88yVIZzMtSPKHHEsG6xS0Se+zaHj2AqVz+eoq3/2jqULZ3EEgu+9jViymKOeWFo7fOTEVY
 vsef77mVAC0bVEH7pZvBdk9dQXEw+KkvL9UDacDLoJirmp1XTA9CdPKQ5qIUyKZXSoro=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 8:42 AM Sami Kyostila <skyostil@chromium.org> wrote:
> to 27. tammik. 2022 klo 20.41 Greg KH (gregkh@linuxfoundation.org) kirjoitti:

> >
> > Why can't you just do normal i2c transfers to/from userspace instead of
> > requring a custom ioctl?
>
> The main reason is security: without this driver, in order to talk to
> HPS the userspace daemon needs read/write access to the entire I2C
> controller (e.g., /dev/i2c-0). This means the daemon can also control
> any other I2C device which happens to be on the same bus. With a
> separate ioctl we can limit access to just HPS.
>
> As far as I can tell, there's no way to restrict access on a
> per-device level with normal i2c, but I'd be happy to be proven wrong
> :)

I don't know if is correct, but I trust your research on that. However,
I would still argue that instead of adding a custom low-level interface to
give user access to a single raw i2c device, we would be better off doing
one of two other approaches:

a) add the generic interface you are missing -- it seems unlikely that you
are the only user that has come across this issue, and adding a generic
per-device interface to complement the per-controller one would likely
help avoid others coming up with the same thing elsewhere, using yet
another set of custom ioctls.

b) move part of your application into the kernel, and provide a high-level
abstraction for your device in place of the low-level i2c access.

          Arnd
