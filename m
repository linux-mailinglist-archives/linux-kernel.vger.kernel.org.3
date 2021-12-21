Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE0F47BC9C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbhLUJLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:11:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:60041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232169AbhLUJLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640077840;
        bh=rLiprYYv/03YO8D2fVcHiRIDbo7NAT0ilK/7QutJtZM=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=cyczsnN22jBfrEZ77DibtEDk7NTN4lwzBxW4tkpk1tMKTdvBAmC6fA6kOUb1Z5X1o
         zC6uLccoRfqfVyk+zb+i4FhwErom//ntGU6qGXeeHDXWJ//fWo+xgP465DF5lQVded
         x4dIikaimIM7lmlnUs+LLjYPe7P/EAkvM2GngxPc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([217.61.155.223]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbVu-1nGesA1zYM-00H38W; Tue, 21
 Dec 2021 10:10:40 +0100
Date:   Tue, 21 Dec 2021 10:10:36 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <YcGU6pQqfEPBqjrO@google.com>
References: <20211220144654.926112-1-pgwipeout@gmail.com> <trinity-c54ecce4-7a39-4143-b136-f53c9b40ffd1-1640018026851@3c-app-gmx-bap45> <YcGU6pQqfEPBqjrO@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] mfd: rk808: add reboot support to rk808.c
Reply-to: frank-w@public-files.de
To:     Lee Jones <lee.jones@linaro.org>
CC:     Peter Geis <pgwipeout@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <4963E4A2-63B4-48A1-BDDD-5F9D07D71598@public-files.de>
X-Provags-ID: V03:K1:7t/9jNOk9g+p2ZLe1h4KOCf1RP8zvbqsrbso5ODfU/MZE7hJbkV
 I7XVm3w62C5rLb5tpzVSzAMpbdDfpdMJ1hZ6tYBCJslyOqvssHeDTBOs/1wcWZvLlYayQyU
 TUlwtfImqpeAYbMWzh9F0CTa5Jj8Hse/nLjEesOVFrGSPKuypY+5s6QMve5P/dwVK7whaOi
 ne3RqRQx8VkgJeB73iGqA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4e13MBbMUY0=:zqluPHGSICKswJ7zbRvFzq
 NMXJ60heTaSBCjNxzCClCn8B+Pekxmm3D7XlfE3JPYn3LWbAmXKqSs8JtKwm9uuRhTrsE9kU3
 mCUyCwkfmMhQ1uOm55Y6iy5SBnCUcVUTimXb/ujXnGkJoNoQJ7wKIfNWp1Y3/0gyIq2iPxjNh
 KYP7/eLIIB44HgT0MxjbTkbGk1+moDFbEZwO7bFjILhNMjH8UDWk+Gp/HD/C85Kz7ppzZGIyQ
 lGIZqBMxxWXj4tmB7zTB/n2mfjrVMuhbqqnR+Q9McTEHVG/W0VVFQWa421VJ46jNrkY7KP60z
 EDYGrPvIQuS40CiFpgRw1Gm1wBffNvWHx1gkbmLZLKNVQqWvna8FPAUHEqFLdzM4ScdAeoMD+
 Ulju+mIGmWlm+XUfCVn37e9VyhDFxzLgW8dKFELdNxG5i0FHVA711KRGteqzVfnlfl1lLbqmN
 9jAg1+bM/FKdFipTserXlt5/2Tv3YYV67Yr6ESc/N9UgB9ZMpxSMCmlyooOyvfoPmknAlZE/T
 8tj2RD0BbK7UoNfoWncCKcEjB5SxiXYlPeGHCICfgN7WUQCBBfp4l6tnGhJhuSob8wi2E4CPV
 NwQOSG9cx8Tb3wcW7Me+wud9n63oAilPuAjTEWoyc/qwuyXi4MIpYdYMH9gdoGqFmHE7Yme5H
 3AX/WLYdTEg9InN2GoXeZmfWa28RIEwd7+cujXsiH7q918MqrB6LNN4LXD9dyDfENoVquwEff
 SUcAIbjqDp+rebaUWbml0riMzX1BmPiqpuCpcEysWYAvSvSQx7a7JkKvc0mfs1xpwnv9kqHcP
 fBDuK2XtzWV99cVc+5C6kBVq28baegU/PBcWVC/EXkcLg9yZG51evcekFPI0RE11meyJ03Ml0
 dP8jsaeI4qQ5OaTXbgNTqf4JLo2LRwy3J9HWbNMlrSKppK2IAC/oqv8Dl5gJh7NPuW09YtDpe
 K+Pttg8yKzEft2Hde/WBLiWm6P/yx/bOMFBYffLl/FeCZCsLblxnwmzDHsRappsrtCnG4Hi9x
 cQupMWy/6qMgo9x0D9QsxAHhMWzlLPEdtHBCdJVOQf+HEKmj7YH/SLO34K08X3mvTI+jsDSI9
 FMhuoSm0JMXpn8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21=2E Dezember 2021 09:48:43 MEZ schrieb Lee Jones <lee=2Ejones@linaro=
=2Eorg>:
>On Mon, 20 Dec 2021, Frank Wunderlich wrote:
>
>> Hi
>>=20
>> > Gesendet: Montag, 20=2E Dezember 2021 um 15:46 Uhr
>> > Von: "Peter Geis" <pgwipeout@gmail=2Ecom>
>> > @@ -749,6 +791,9 @@ static int rk808_remove(struct i2c_client
>*client)
>> >  	if (pm_power_off =3D=3D rk808_pm_power_off)
>> >  		pm_power_off =3D NULL;
>> >
>> > +	if (of_property_read_bool(np,
>"rockchip,system-power-controller"))
>> > +		unregister_restart_handler(&rk808_restart_handler);
>> > +
>> >  	return 0;
>> >  }
>>=20
>> this change misses a declaration
>>=20
>> struct device_node *np =3D client->dev=2Eof_node;
>
>How did this compile when you tested it?

Here i have squashed the change in:

https://github=2Ecom/frank-w/BPI-R2-4=2E14/commit/06430ffcb6d58d33014fb940=
256de77807ed620f

With the change i can compile it=2E=2E=2E

But in v4 (patch is tagged as v3 too) the of_property_read_bool was droppe=
d completely=2E
regards Frank
