Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37CF496A62
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 06:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiAVF6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 00:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiAVF6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 00:58:18 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510ECC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 21:58:17 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id x12so1331889qts.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 21:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=IG2uYbeAw0J8no4s9+Rii+S0/l/uuRucFzJMibxwnfI=;
        b=j5DXGs9tZ8lab48TS5g3l9waeEUrlK7x7D97mNx4UQ1j9IoAxv0EBlKGOjuhIrw4ii
         p1PbA8n3ROk/ulzkoYNmO5Xn7I4suV+IzeAd4heDMyAkybHTa3xYSYGHlNcPcWgpGiK6
         fJOKzY+QfL+1DOZ9f4zx0vxbQb/F8ZCRtUBWJfJVbOEwFkv76N3z9UNxANXS+UvX0JBg
         Mdc0E4AspZ1IwmlMKIQ79wC9kcnEKf4spFWsnphutdK7BpakilplFQJjKcqb/zwaVRz3
         WHCsd2f7OM5o5rb78osfKupS/YsWbzTLKe8fWWw+q5Y+pPoVWuM+o0LDLZ7HvwnlEVT0
         7gYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=IG2uYbeAw0J8no4s9+Rii+S0/l/uuRucFzJMibxwnfI=;
        b=uT16tYOe0QeYu9M3/+fQLDYFlsKA1K/38OCxFQo9vWKyOgc1Cp0iXcIlMW5Meu7D/B
         C8hrA0eOfg0qqF7fMWKzauYX22l3h2IXpPzV6uyHkIxa+djl3b8uRtksefixw9hWHY31
         mrZsPwicdxhCDONq1lsJIldj2prGHueXBxmTDgDsa9x5xeRf8Dp1bWBC3tsVjnGnFMYc
         yzVlSolbSM9LeUirU2q1buS6f7+LoyAR/wBqFcA4l3BoscroPBdSjzxUBLgXcTEdihKp
         UKii9M1RkY1BAntCEyeBSNCMLiqbvUcIkIaHC+XRxFakEZpra4rI3P/aavRYGrTiOQSW
         iK9g==
X-Gm-Message-State: AOAM5316F1wrL8dh3JM6LeObV9QVQIX/wJnBlk93NuqXBqAiMuvgtPVZ
        /dsRR/AIiDSk4zZVTxrjRfA=
X-Google-Smtp-Source: ABdhPJygrerBkN8vdQz7GfBqP31GXGwMPPsz8nIEO3Ycj1bP62HKFFELrWs9ws6uNIzBcrFMK2jJbw==
X-Received: by 2002:ac8:7f15:: with SMTP id f21mr5795034qtk.603.1642831096025;
        Fri, 21 Jan 2022 21:58:16 -0800 (PST)
Received: from Gentoo ([37.19.198.230])
        by smtp.gmail.com with ESMTPSA id s11sm4361923qtw.2.2022.01.21.21.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 21:58:15 -0800 (PST)
Date:   Sat, 22 Jan 2022 11:28:00 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: lore certificate error in browsers for past 2 days
Message-ID: <Yeuc6Lc7gLXqrRVX@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <YeuXV0Qv0NUZ0l84@Gentoo>
 <bda6130a-8e19-0e8a-fbfe-c6e6fd962411@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9GIfRdm4EvTZOyBi"
Content-Disposition: inline
In-Reply-To: <bda6130a-8e19-0e8a-fbfe-c6e6fd962411@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9GIfRdm4EvTZOyBi
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21:39 Fri 21 Jan 2022, Randy Dunlap wrote:
>
>
>On 1/21/22 21:34, Bhaskar Chowdhury wrote:
>> =C2=A0Hey,
>>
>> =C2=A0Not sure who needs to fix the damn thing ...but I am seeing the ce=
rtificate
>> =C2=A0expiration on various browsers ....namely, Firefox, Vimb, Nyxt
>>
>>
>> =C2=A0Can someone kindly look in?
>>
>> =C2=A0~Bhaskar
>
>
>Hi,
>
>Have you read/tried any of these?
>
>https://letsencrypt.org/2019/04/15/transitioning-to-isrg-root.html
>
>https://letsencrypt.org/docs/dst-root-ca-x3-expiration-september-2021/
>
>https://www.openssl.org/blog/blog/2021/09/13/LetsEncryptRootCertExpire/
>
>
>cheers.
>--
>~Randy

Thanks , Randy. Nope, I didn't ,but now I can.

~Bhaskar

--9GIfRdm4EvTZOyBi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmHrnOQACgkQsjqdtxFL
KRWkTwf+OEtceVDH/btLPqOOCf8SIPv0G3ZuXyBx/L9cOqWNrL14O0GXFYaJbnZG
yQAuo+6OeeC8GPPFfGKuy8eKxxBaRVUvYMFqNFRzL/QQJruoRn40jB/LN9BBromU
Za4oOKRzGAuCVOyp/EMCWoFFxUJ4Aw2G2SUNCQydk9w7LllkPeV7TeFfwbMzlSlA
xv0O7v4Q9BDcTsrCwZSvRzu36LjRqeGs7mJnerBHNg7CBDOkh2deR9ySPBsd/j0h
xWRGMIzpRdoo4JLd9/f3jbPggFDMvRYKyr6MS8PkP6VBi49pEYgPyRnihfqdqdcA
B46L45VRxUEkHzWkDmv+2RUZdR8qoA==
=sKAV
-----END PGP SIGNATURE-----

--9GIfRdm4EvTZOyBi--
