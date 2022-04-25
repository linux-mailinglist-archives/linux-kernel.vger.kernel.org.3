Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D74E50E49A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242971AbiDYPnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242949AbiDYPm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:42:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD463BB92A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:39:52 -0700 (PDT)
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N9cDF-1nvEig0Aqr-015ZFq for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022
 17:39:51 +0200
Received: by mail-wm1-f42.google.com with SMTP id k36-20020a05600c1ca400b00393f18c8fc5so64373wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:39:51 -0700 (PDT)
X-Gm-Message-State: AOAM533YaXjW3sm5CVz60m55vSSc1D7s/DEYhu/EwItLgosxTo1Rx79R
        m88kk5D89yqn0nwS919h0LMagiiLnxuhfWRZSl0=
X-Google-Smtp-Source: ABdhPJx3dRForqktI5tG6zc7Id5adoLrBcuwto/Tk7V3DlzIdPzsaznerWa1gJFwUvcdxfCzZVIFc9T72li7k+sp1GI=
X-Received: by 2002:a7b:ce15:0:b0:38e:b7b0:79be with SMTP id
 m21-20020a7bce15000000b0038eb7b079bemr16961733wmc.71.1650901190683; Mon, 25
 Apr 2022 08:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <YmX7z+BirkA3VAfW@zx2c4.com> <CAK8P3a3Af5FBx-OnedHPrf28ikX4DZK1d0ERLsV+oKyBHyCXiw@mail.gmail.com>
 <YmaJUvg6hmekvkXE@zx2c4.com> <CAK8P3a3FZeXzBJKyTEvmvw_DaHGQFf5rQKs=_wBW=GZ2+=rJ_Q@mail.gmail.com>
 <Yma8OQ3zY3PzY87T@zx2c4.com>
In-Reply-To: <Yma8OQ3zY3PzY87T@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Apr 2022 17:39:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Y3BFCkg8e-o5i6xPfb9WVQzOQOACXtrH1VmQJkSriDQ@mail.gmail.com>
Message-ID: <CAK8P3a0Y3BFCkg8e-o5i6xPfb9WVQzOQOACXtrH1VmQJkSriDQ@mail.gmail.com>
Subject: Re: odd endianness toolchains for crosstool
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9g6gubwe3RUQxydeeYrBzc9VI9NLg7FhrkVsd9G/g3z0aGg3Kc5
 8Fer3+1lhbgDqCr7ZhsCMofj3rpQpyYW7WhOnjwTkIQX4xJ4/TOCNBvfaFj4LQLXRiVe/gR
 LsGJnCq55phyJ26v6u9FnyL5k7dFqHvmdHaeaNdggnKeS7OjnsIH7fVQEJAKjMt3Wjq7BEp
 QYKBXDaTu4kgmRmFg8YQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b4eslfbJHds=:YwB9fAaxuEadN7Bxvggt4c
 aMMgOzazMHbVrPtQ5pJsFxgbwJhHuQGT/DilEn0IHLEoPFDv56tJKFRBBBBBX61VobxW4uCcA
 Um0E+o/1AefdwS36oSxlC4AbjG1LmnjO3RoTEoPzEYXCZC/65umykiyXb4Eyi7Y9+/S84HZ5H
 iJjSg2ZapUzqaQshkdT/al8jiGwr1/YJvRQ7M452GQuWZwFzD5J8wKBRTcPEwz6wcqh/nD1ah
 pk8QlP6ntiSgl9uqVFSknUKrs7Z9XGzDwnEAVKSGCvqwmQ9hX7BZUhIjSdVMXx0ol9hM+krvV
 0+OL95s0Tw6oOf/gSEGrFhrGlPqxsI0cBDRitO9IQyxWB1CicInQNXhjMTP4Q9aVpYGyL0PSh
 gjBa1BMC/dnpBO5fv9F92JEI/02bwhvLa0X4fROHiOrT+exzN4s58L4fY2F35ReLjeG+2yymZ
 85bGaMucNYqywW0KnTSGsc7NXh/MNz682pigr/iGDsFMsB9z54OgLDsVXpysiey8RVry7sTdk
 Dz6Nebn2ivkScbb/29HEGgR/w83Ja4SeTmAc6uEswUBocAX2cOzF1nIWzueuytRtr2Vzj1U7u
 z45xHtEfOrUNpalmqe9I69sQpqohuF8TF7Gjkd7c7k0lM/3kYaYvFdMZJkt8n3xksVoNoq3xV
 ObYreTsZ9pmYvL+smC9AqYw0y4CsxtRHdUJZqUXo06kUTj93D75th+jYrgorUpXY/oq5P7Rtd
 ZGqkLZ1et+MFjO3H7/8qxFOzrHHnLv2rgmaMW40nVn6svz7I9CLXgi/Xw2qVTOeVBU7U0WE+m
 9neKgpILJcDk6PJ46OkJnQ7mr8tz+TJG0qh5QMtXkhqGsRfaww=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 5:20 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:

> Right, exactly. So if you simply add little endian libgcc to ppc64, ppc,
> mips, and mips64, and add big endian libgcc to arm and arm64, then we'd
> be set.

I see that gcc-11.3 was just released, so I should probably try
building that in the
near future. I'll see if I can manage to come up with multiarch
configs for that,
and maybe even get those merged upstream so I don't have to carry patches
against the gcc source tree (all the other builds are for unmodified sources).

I can probably do that before migrating to the new machine, but I can't
promise how quickly I find time to start.

> (And also, build ppc32 with --enable-secureplt --with-long-double-64.)

Can you explain what those are about? Is this related to the ELFv1
vs ELFv2 difference or something else? Is this needed in both the
ppc32 and ppc64 compilers that each come with both targets?

      Arnd
