Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91AC47CDC8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243159AbhLVIAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 03:00:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:43659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231532AbhLVIAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640160045;
        bh=cDCxJ7D6OcTeink8cACztaS6/QTvI098dNi6ywdZyjs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fjnH9j9zydjsbR+3vajt9BYL9pIKexdmC30sC4DwW1K4VS4p0M7M4YjdLg/lq61Fx
         vVahQx/pxnz2KprBzk72H87HmD5VS4784Ql8OZj5/7BLqX5Y3ct1YsTY0/L8pXK6aa
         QrbrOeCxfuGjLwFOvsSyPUIKSm1tbpTfRojrloJU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.131.34]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59C2-1n130r1Dee-001Dk0; Wed, 22
 Dec 2021 09:00:45 +0100
Message-ID: <45329e1b-3ec7-ee39-f576-2ca585992c4d@gmx.de>
Date:   Wed, 22 Dec 2021 09:00:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] parisc: remove ARCH_DEFCONFIG
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
References: <20211213024044.1165969-1-masahiroy@kernel.org>
 <2fa1f8fb-2a30-1445-758c-4aa2e7fc5ec0@gmx.de>
 <CAK7LNASgPjnRer_y=QRqUVHikU2ut7MQzy+P=XEcBxk-o+2vGQ@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <CAK7LNASgPjnRer_y=QRqUVHikU2ut7MQzy+P=XEcBxk-o+2vGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B0RsgmUnDBVaTwGSzgl///IxK1XhsrJpcGFFcAj964k4tNiGhRe
 mY8hwJyMgjZVHD/9DwxMzWbbSNOmksoXh1TJfub06sSh1+ep34Sx/q29391SOrX7ld/ND+r
 xOa6eOrNuGIA703c2O0ZLaisYr7rr3p+Rd7rXh7iHWEmPOgI6szcvKgWoPpTQaV2FhDGKmi
 Lw6veRg4Im1i9/V27vRIw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:teKIACMbeQg=:aZCIF7LlxCPIXgs/SL3azu
 07bPWIdqgpTUA0UOOo5Bpgce0x6TboLYFt1lLD6HbTRdh1c0FGOivqqRWA4drg6pHl/hSuxxj
 +LKM40IWw6zr6lHeWXSx/3qFm0bUR/AlR/aR66TqsNqyEnaJzT+Rqwk6zvbPZXCKCLE3gRpEQ
 9IyIXA7ChKcN70qtS1ucXgOWTM3iujR+m6uKkhFNhfir46zwzyq21zzkEVkdy8dsesdC74ggf
 ZEOXdkj5zaTqWXMujQp9pdBkmqIqKbNzi549UIcayAiOzMFrf+kuP3NIE+bs/AOIqO7C2h3yT
 v3ggz8sC2MBXUtRM1DcaK01Z8JbLKe15OdtBelMEKoO96U4gTbj/sXYFI8bxSVBv/n91Y4ki8
 Xo53Ce/EBou71okbVQumIonCWqionjXyyK6EhyCctCtc+p/J/aQf2bgoKmlMJG0loMTzIyKYG
 ykFOfynoJKPtQ7ZG+hoLa4Pf+kTmwNsFqigtfZ4pulwR7U22JRE+YwcGlhQVLSBuo0K55+Xib
 2Z5VMhxXwS8NDqyLdhmQRlglnp6V4y2wAJ/9upKDal8yxYsPgHY1C57nPuUBAu/3axi4W6vYw
 sHAwVa5Ok+scvzLX2l0uO21CwdnBfeznXffKBjdZBR78vmZ2FYGb4joVF/9L+AbcNARkNap3h
 5xKRGNUK0zbw2DZu3Ju7+Ivifyy2gZTLVlyHiJKTkVOV/n9uSYhiRpx3YlYJ1r0Np1reZnRBU
 yaR4Nd16vL+2RE1p/Es9Rjlxwqa3FLvZ47jKGyEQimgSnVTzogopBRdBbqwpVLPflViMDoFUO
 d7u/TtUkmunnOlWx8d2GJDuJiZPF94C2wT9h4JNeWMgHixwMIWafV/wN/Pqfo/MftkhdOTOa1
 q36OIRru4ExbkR1ahQqbRoFAkqDwxc7MkkYuXu0lW4DVOBP43labvw+3IGGA0pEr/HABC9m1x
 hv0tFSDsb+RjfGSfV2VcXAXZQkuUOUEjdQfV/pgBhmseT8y9FJBTIBTtmPuIegEMAUxq7dXsQ
 Uu7EHEkJDqZbYOMWaZwPaP4C440o7gp8KPnQgEw6cNRD0OZoHSgd2V3dLuCgodsQWcDwf9gJj
 FluD+PiqH9iP6k=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/21 00:54, Masahiro Yamada wrote:
> On Tue, Dec 14, 2021 at 7:45 PM Helge Deller <deller@gmx.de> wrote:
>>
>> On 12/13/21 03:40, Masahiro Yamada wrote:
>>> Commit 2a86f6612164 ("kbuild: use KBUILD_DEFCONFIG as the fallback for
>>> DEFCONFIG_LIST") removed ARCH_DEFCONFIG because it does not make much
>>> sense.
>>>
>>> In the same development cycle, Commit ededa081ed20 ("parisc: Fix
>>> defconfig selection") added ARCH_DEFCONFIG for parisc.
>>>
>>> Please use KBUILD_DEFCONFIG in arch/*/Makefile for defconfig selection=
.
>>>
>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>
>> Acked-by: Helge Deller <deller@gmx.de>
>
> Can you apply it to your tree?
> Thanks.

Sure, I'll do.

Helge


>
>
>> Thanks!
>> Helge
>>
>>> ---
>>>
>>>  arch/parisc/Kconfig | 5 -----
>>>  1 file changed, 5 deletions(-)
>>>
>>> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
>>> index b2188da09c73..011dc32fdb4d 100644
>>> --- a/arch/parisc/Kconfig
>>> +++ b/arch/parisc/Kconfig
>>> @@ -85,11 +85,6 @@ config MMU
>>>  config STACK_GROWSUP
>>>       def_bool y
>>>
>>> -config ARCH_DEFCONFIG
>>> -     string
>>> -     default "arch/parisc/configs/generic-32bit_defconfig" if !64BIT
>>> -     default "arch/parisc/configs/generic-64bit_defconfig" if 64BIT
>>> -
>>>  config GENERIC_LOCKBREAK
>>>       bool
>>>       default y
>>>
>>
>
>

