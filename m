Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0564A48DC23
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbiAMQoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:44:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:48803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236855AbiAMQoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642092244;
        bh=+GT3R0iprMihU+thXl1YC3ClEpv0BXdo+4Olk8WRQdE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PGdCnM39NUfx1conBvPAesCqWWZo3zpNdo5Rp64SlNVX/q5cZ+T1XOFGmHct/t9MD
         u/Xz5pXUN+lG67aSzcoJvl76WdiGbM2azuBXblZtd2MZgMmoiYXBdbH+9siY8xs40/
         HrSv8RC2gRQUBy0yjKbjaa505doB5uNrX7AaPM3c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.168.79]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9yc-1mqvlG05D8-00IF42; Thu, 13
 Jan 2022 17:44:04 +0100
Message-ID: <078e9d59-d6b5-797b-5701-6292fc588bef@gmx.de>
Date:   Thu, 13 Jan 2022 17:42:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 0/7] agp: Various minor fixes
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel.vetter@ffwll.ch, arnd@arndb.de, gregkh@linuxfoundation.org,
        James.Bottomley@HansenPartnership.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211201114645.15384-1-tzimmermann@suse.de>
 <aba1a416-cfec-dadb-fff6-48b95346173d@suse.de>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <aba1a416-cfec-dadb-fff6-48b95346173d@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XW0GanP14yP4WB70CLBZJK+JNRUnOz4GIsF5A+XX1QUATxOpwK0
 21NOOiqaSFWKHqRgIZEddksnyG2cfBrkqO3oKqxQ1PXtunv71V09QxxabzPNH/yKco/sOlW
 wYVoyRNgIZAaPZIvsYnSN8U2MErKsALvchez1duUDT0ozftVPDr3aGwHpMKJsEtwFsIJOio
 CE6E1cAUn4lw+U0bF+1Xg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZLdOMzogqXo=:pWkaW+F50Qi7ZjRCHoOR4D
 BVpQUAzWkcMZHMLFI0byrl3sJMJnFiL00N8TkHQ9rK9De11u89biMo8NylPbdmhLJuw9RuB86
 T4pBM6we/SiD9+L7/2t4TwCIEGdBDwh9WgJ/qakzVxPBuW6d4Kt93QHNjWv+nuo1VSHgeBDBZ
 wt1AoftD893zZDORawTT3M0AJCncfd7goP/P7PHuGpvIeMM+FV/1fnqkMODdkhKtBMdbi009n
 SWeLltMKf5rNCKTJOknZwp0t494fFNQUXElw4uOOI9qgvDgdwsCQHBvdi/M5cF4Zf7XRwV1pd
 pX3cVkxWvsiMHNJ18vmfEQy4FwSIsJbZ3Iun0eBqquUTMGm1KWv1POKTbUtfAdo9+pbbTXZCb
 YEjZKpSVSbTN9jil3kLg8YKen/jD7Jb3NIxd/4eDJoh25vw/EtwbxlNH8AoxiWV5cI9QI+fiv
 uQC1ZdYTLVK58nDJkBemH/9Ad/1DESQrbw3YPUqoBRQlVdaUcw69o9UfHXYmJNqa/9GL5lRCw
 5EIKo3srWonabIqolQhRWf6mlL9NsW3ptJh5by3TxNmj8hZsFSWNIMbLTpke6J2+vjLNAVvU5
 Rgdm3B+jL7clKufhmQgJ/7vUd99LpYPhp01ho2DneRVSaus4GuJf32g6HGqDe1f+3lfpapXj0
 Y6RXjnK2CQabN8o5EjoUCERosb0PnHxB3Y1Z8GJUODb1FnMSywbIeyRCJxcprPzPtGoI1mEXe
 BzTOkES+//DmOvQxHa2f+m95neFFS6uUWfziaFwfjwJ6d9jBcson2VBSCDFbdWqBFVf7pfjL8
 nd2IW7Z3OV7gDGKyf+9BTWOt1KaMbR3ZXi3jTGjErh5I1302fhKojvlGDW3NEiScBSxuEqveo
 Vy9cycQbGqMJHaFhXWHQCTUBFk6QJIJ4fai2xE3go58iXO+MuV9zDbe9ASbxLJe8o+fUvRdsb
 5lfUpb7ZfKL4l0bwHtryNBl1roVXZJ0bpBi9yiQAmJ8gAne0u4lggL+KMz9NGAc1xO5EbnEyr
 +mmiqtGAEKNsWGTh1aQmrujT6qvMUqCY9t9rGwD2T3cdjOUgDjqfI2GGFOcta+nO9uNIxM2Ds
 zy5BgfZh0QQcxI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/22 09:51, Thomas Zimmermann wrote:
> ping!
>
> This patchset got lost. Patches 4 and 5 still need a review.

for patches 4 & 5:
Acked-by: Helge Deller <deller@gmx.de>

Helge

>
> Am 01.12.21 um 12:46 schrieb Thomas Zimmermann:
>> Fix a number of compiler warnings in the AGP drivers. No functional
>> changes.
>>
>> v2:
>> =C2=A0=C2=A0=C2=A0=C2=A0* ati-agp: free page in error branch (Helge)
>> =C2=A0=C2=A0=C2=A0=C2=A0* nvidia-agp: Mark temp as __maybe_unused (Helg=
e)
>>
>> Thomas Zimmermann (7):
>> =C2=A0=C2=A0 agp: Remove trailing whitespaces
>> =C2=A0=C2=A0 agp: Include "compat_ioctl.h" where necessary
>> =C2=A0=C2=A0 agp: Documentation fixes
>> =C2=A0=C2=A0 agp/ati: Return error from ati_create_page_map()
>> =C2=A0=C2=A0 agp/nvidia: Declare value returned by readl() as unused
>> =C2=A0=C2=A0 agp/sworks: Remove unused variable 'current_size'
>> =C2=A0=C2=A0 agp/via: Remove unused variable 'current_size'
>>
>> =C2=A0 drivers/char/agp/ati-agp.c=C2=A0=C2=A0=C2=A0 | 8 ++++++--
>> =C2=A0 drivers/char/agp/backend.c=C2=A0=C2=A0=C2=A0 | 2 ++
>> =C2=A0 drivers/char/agp/frontend.c=C2=A0=C2=A0 | 4 +++-
>> =C2=A0 drivers/char/agp/nvidia-agp.c | 3 ++-
>> =C2=A0 drivers/char/agp/sworks-agp.c | 5 +----
>> =C2=A0 drivers/char/agp/via-agp.c=C2=A0=C2=A0=C2=A0 | 3 ---
>> =C2=A0 6 files changed, 14 insertions(+), 11 deletions(-)
>>
>>
>> base-commit: 6a8f90ec433e2f5de5fc16d7a4839771b7027cc0
>> --
>> 2.34.0
>>
>

