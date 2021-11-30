Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360DD4630DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhK3KVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:21:07 -0500
Received: from mout.gmx.net ([212.227.17.20]:51245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229729AbhK3KVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638267460;
        bh=axlQgmPmHpysZyf887u13cmx6tmECclmmde5H7/SPQQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=i4lpnjk6e0dnLdiv3WbQxslrzm19dYUwD8KCpO5N9+3wtwvjjyv2U9hddobAQLtT7
         wBCUvHWHgrb6jCLa1yqI/IosnskF7TSnF+iV434OZnwaCXc1CW2hRTiSj+k8ppaiDc
         4SDt4F1q2YAMZxXZatFesN/Bb3RJnL4hqAyv+ORU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.145.109]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGNC-1n8z5e1j6c-00JJf6; Tue, 30
 Nov 2021 11:17:40 +0100
Message-ID: <55d4f046-fe7a-aa06-ae36-b7dd342a96a3@gmx.de>
Date:   Tue, 30 Nov 2021 11:17:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/7] agp: Various minor fixes
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel.vetter@ffwll.ch, arnd@arndb.de, gregkh@linuxfoundation.org,
        James.Bottomley@HansenPartnership.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211112141628.12904-1-tzimmermann@suse.de>
 <f84bc3ce-5a9e-6f3a-0e23-eb8adc05b13f@suse.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <f84bc3ce-5a9e-6f3a-0e23-eb8adc05b13f@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HU2dw3Dxou26Ie13FzlnuvNQw9/wtn1FxtYaNxvdYUM2aDwOgVe
 MUKjfgwGCZkmHj+pDt3KAEzRuMkGi6SXqFYo92SZBZFg74uP7FMLCQpspIpRdwM+FkGts0X
 G3sl34T8oTJc5559knafMIwoBUFGa1jbvFm0hzHhLy7gfybdUsoFJBnAlRGj3UVoP/bI7nZ
 c8O/TP4oy5WgrVFM8SewA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LcQGofuJr+M=:T+/og8g2iXv/n+lXpWKPLA
 Lk/05dOfywmFYX1mUYD+udiG0N0csk3JgMJZNzdIjCuhArS0ArM6WuQSYD3yQT2HWd6aBpyjR
 TXspu1P6DAmK9QV3MFo2jrmVqHDEJOVcn/idnVPovVz3QFzKNklyOy7PNvIbNRDv2OxeLSUQV
 AD+024Z4Pi/KmRIYiOlxKO2Tyv/aPXSoUnjVuaKZgjvSbHxTOK6agjF1/U/Vx3UG2sZTgvL8L
 iqmj0ghPn+1rXsfA8LcPejLXDU5e/6DwnZqMxYY0gNI9S5y/y3clIvlghFZNXlIpebv4HLM8j
 NFGWq7daXoB/UxLdVHSXJqB+IgKTF0O2VogVie5/qJY6n5LE2v4MpBhzXpx4Cf3RpwZ83Sodk
 NBZz1vGHQXNiZEWNZoED1nYXhiSD7HQ8UpFASSDxU02N2PDdKZs9p9XDsKPSHlCVo5xruN20S
 /12IEUxEOcV7aMEjnmB87HfbnER1vs2eaHc4rGqYolCmSniYot0b1rqEOuns3e7Oahb3e/qXu
 vZGg3VKCXLozHWR/gy2qbD1eMC4ONpkXGw6oZDxIg/19ZR2WNbVCv5jfQxrtJE0DjKP9D9BCD
 1QmSsXfxtjoSb9FK0e5P4rAzBB+31CeuLUH4kkI2ytIMw9N/2JeY246SRy8Roje8Aeh2Ikw//
 SsjJAjqRns+fT/JgZF7CvVnNWH73XbOv4SjGABLp3tKARYiJ/XdzDV419lZMzTDjt3pzEwLuA
 sz+P/hfXHvmc2oZfYPcZZVV3Fb5wu6ySprscFf6Pj7z/LZToYSP/EnojpknVJQKYn7+vT3qZZ
 HfAFSHHQdioVCOkuPcvDF/wYw0Gy6zQVNJ4KQSuazq911Z57b/DImtzysDDMlGq4cgpaIoYXD
 odgHNAGkuhWi8VW9jeQSBxDzPLYxg1QCxA4qS62spJVd6FdmNrL85z3oB93uc+rPSggwbqtIE
 CupSfve1oUHyLy9Copp7SGw29ySmR9XdT/3O65huJDqsk/LPmGDddIT96igekGy1rP3/8MDNA
 ndBnlZmkEbPOqlgJwqykXdTW+UMdLBDZ3FhOTNDp0IchQLPiDXv4SKW21OhkP1rz8BTn4q9+F
 fYQuaOfS/V2Ae4=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 11:03, Thomas Zimmermann wrote:
> Ping! Any feedback on these patches?

I just reviewed those patches, and sent some feedback.
The others are:
Acked-by: Helge Deller <deller@gmx.de>

Helge

> Am 12.11.21 um 15:16 schrieb Thomas Zimmermann:
>> Fix a number of compiler warnings in the AGP drivers. No functional
>> changes.
>>
>> Thomas Zimmermann (7):
>> =C2=A0=C2=A0 agp: Remove trailing whitespaces
>> =C2=A0=C2=A0 agp: Include "compat_ioctl.h" where necessary
>> =C2=A0=C2=A0 agp: Documentation fixes
>> =C2=A0=C2=A0 agp/ati: Return error from ati_create_page_map()
>> =C2=A0=C2=A0 agp/nvidia: Ignore value returned by readl()
>> =C2=A0=C2=A0 agp/sworks: Remove unused variable 'current_size'
>> =C2=A0=C2=A0 agp/via: Remove unused variable 'current_size'
>>
>> =C2=A0 drivers/char/agp/ati-agp.c=C2=A0=C2=A0=C2=A0 | 10 ++++++++--
>> =C2=A0 drivers/char/agp/backend.c=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
>> =C2=A0 drivers/char/agp/frontend.c=C2=A0=C2=A0 |=C2=A0 4 +++-
>> =C2=A0 drivers/char/agp/nvidia-agp.c |=C2=A0 6 +++---
>> =C2=A0 drivers/char/agp/sworks-agp.c |=C2=A0 5 +----
>> =C2=A0 drivers/char/agp/via-agp.c=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ---
>> =C2=A0 6 files changed, 17 insertions(+), 13 deletions(-)
>>
>> --
>> 2.33.1
>>
>

