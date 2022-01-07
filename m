Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534CE486E8C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbiAGASF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiAGASD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:18:03 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72C1C061245;
        Thu,  6 Jan 2022 16:18:02 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JVP202fwYz4xnF;
        Fri,  7 Jan 2022 11:17:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641514681;
        bh=gkbDodgK6FMeEY46FSXHJH/Yi/b/XtlC2hyXcdtVT18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gpIm1U7Guou2hwfM0GC1xKDRGABV0vAs/Ypbg92i2C0knt1pAl63geGFJAEahAQbK
         0PAKeVn3fzWnPWG4cabxu9eYascVS0IHIVdrtdTS1CimdC+jdIwJrC602D6L984vKt
         Tfs1pTfYypdhD7RIMEu3mNmdtL/VyfnYMVipRZJ7CbbPu6ho2LME0fx89j47tgbZpb
         SSsqBdZrsgJ9BQsZd81Bqh12Mqucg0ZEFAtSp8Nlk3iNRta/SClD2lgnIEmXESxhZp
         yetir8ydxvEcpd5CDIxwfhfq+tPeSbyVW71RbmMyi86L1Dui++XEPp51Ca3WGFLQ7U
         qwT7NpaqUIaYA==
Date:   Fri, 7 Jan 2022 11:17:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the libata tree
Message-ID: <20220107111759.57d0d377@canb.auug.org.au>
In-Reply-To: <92b2ca94-6a72-7ec5-6a0f-d45f776f7a74@opensource.wdc.com>
References: <20220107010832.42c93c30@canb.auug.org.au>
        <92b2ca94-6a72-7ec5-6a0f-d45f776f7a74@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7xw6oCo4L+DNrcpp_QnNt5Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7xw6oCo4L+DNrcpp_QnNt5Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Damien,

On Fri, 7 Jan 2022 08:58:48 +0900 Damien Le Moal <damien.lemoal@opensource.=
wdc.com> wrote:
>
> I fixed that yesterday afternoon my time (Japan), so before your morning =
in the
> US (assuming you are based there).

No, Australia (so +1100) at the moment (see my email headers :-)).

I do fetch trees regularly during the day, but I merged your tree at
about 13:28 yesterday (11:28 your time), but the build failure did not
happen until I did the powerpc allyesconfig build at about 1am this
morning.

Thanks for fixing this, it will be in today's release.
--=20
Cheers,
Stephen Rothwell

--Sig_/7xw6oCo4L+DNrcpp_QnNt5Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHXhrcACgkQAVBC80lX
0GwxAggAl4nRuzEegUqz+uWovs/u1sgWaCgzyk6nv6c5uW6uzZKnfS+01jEizTja
hQ6hKuMtR1rRj8zB/Go6iUDu0cFOZsW8CzyrgJne8m1LNwjL2gDoqCf+2tElOg+1
IdEFUaFlhngQs7EjNWzDcWY+VeUeKmWSwZjrYn1CiSpGTvLTIkQs1FJg6EMohHHx
LrB/GQ61/rbS4cltJONBPmdJyc3SY1nHBuu8aN8uOhlHrVzq33mxBKOjJT3H8z9f
oGzAmYZ90UTYQvKIdhMU/a09DvWX9H9ze0+EpFJTCEzKZ6a2ktEhlyAIH90KPh33
/mJa/ugWC1uE8a0Rr1oO2oUUjNl1fg==
=m0Jv
-----END PGP SIGNATURE-----

--Sig_/7xw6oCo4L+DNrcpp_QnNt5Q--
