Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7DF4AA4C1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378471AbiBDX5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:57:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:37375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241379AbiBDX5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644019036;
        bh=1Kwp7/KAIFTkmXJSYkq3CZKgQvseK9UqHtzpJM2awG8=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Gsc2nTVAR6tJrqcmCrHJaqNL8pSC8PkENl2iOnfVeB0Xp/WUWa3NUI+yDSjGD8YJF
         BEvgNziaAJcTZ6FTIzjJ70zIDsBTobPipQrEInniP22+nMiBC+H0lMu3EzyCHg921e
         /6SkhNvkn4AaVIv/DdjnJLSBzeHkf7DtzM+gAlnE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPokN-1muSpU36YN-00MuYh; Sat, 05
 Feb 2022 00:57:15 +0100
Date:   Sat, 5 Feb 2022 00:57:14 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Parthiban Nallathambi <pn@denx.de>,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v2 1/4] clk: actions: Terminate clk_div_table with
 sentinel element
Message-ID: <Yf29Wt6DGYxDUlDj@latitude>
References: <20220203142153.260720-1-j.neuschaefer@gmx.net>
 <20220203142153.260720-2-j.neuschaefer@gmx.net>
 <20220203161210.GA138829@thinkpad>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rJDN8eL983l7maVq"
Content-Disposition: inline
In-Reply-To: <20220203161210.GA138829@thinkpad>
X-Provags-ID: V03:K1:qK3ksEUkC4NY6uQA9JGHANigRFTqspIpM3bfrw1t3TfmoxkEnDI
 xsBoY+yOee54IhFeJG6I0IFn9sBfFDEwbzJdf7reoUgQ5e7koC2AB+BuDkPOC5jw/nuQL2N
 nyedVTQnXfu/XI0sKaXhr/tPuSKw/M66Ef9yCGWt5Tajsfr9Ys7Pl+Pt7QGc7f4I2zLJtwO
 ZWbUYKWRBzxmFFP4CssXQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bKGC50lIqqM=:8FZ6ZutMvSeGn8vJnHPVMV
 RHgaIKaXc8YRAMmCmHSoKSO3yzf8VCDT1Rr68lqnu1fb96T1temqzH2otu2jvvgaS2EOBtLqz
 N9gjzAug2AMcOcAUgXs8qIVPodcBLAOhbes37nhkgNS3+LYpyzsTvMKLYgw+G0atXBCCTh3kj
 fmOzOHJA7AzkVP6WZCAYIHMSbkJxk/4xGKI6TwBrcyKMTLt99zF6A25ZcJzwFJkS6r10Iarq/
 8J2Z9YhOdSzeF102jNXy+9WldBOeC1ivZlUA396SdTZO9Kb8k/IpP76nKt/3FtSMQBajGN4kA
 i/K508HzjOpC8pEn8i2/x/m0578cg2pHDDW06/hu0yBBVKNx9yDv06GOZw1jGSikqrhq68+Z+
 FcuVJ37N1JvYTYxBQI3jOPnUKbdeMuqvMThuaOQTQu344gnA6+OBftpK6iHu+47LIl+KspLkP
 rxoo1Cxi0AGXouZpn2LIwUOSyC3z5cTiriKEMjPMQ9buoDSIEVKWKZV1O7zh/L3fnX3k8Bvyz
 wDR/wcgFrXgMT24O/h9JysnWEfqjRTvBIuY90uXaWk8WFZc5KCkIAxzcTooyzZ9jpIRvpMb05
 MWteaKSWlWkKCxuomCax1z+Ij/5l70LIQ5BkCLkQ9P1MSg0OnL98cCY+jz4mzxfi1oEofyRvD
 sEF+YYnfafsxaQibpTrB6HUpEZLNGlxJpygyEK2HA8vRhni244yVQ6m057RXqz1oj12J+ecGr
 XeRBdAAjY8sw1ecZ3ljMDldoENQ10s6mAQyYCclbfwpOeeUANWnzTwWIHspIWHYsFHcL40oHP
 Zvc7sj86pnt5sVyoxPI4RgxHo/I9MGWsZTA/QIY34QQe0D5f4lkYvt0xLoZruFPaXBe9zH0jA
 hyN9lvXnvtUuxOOrkmj7LLuc/DqKl0qRVYeccsL3s8rIh6aWpq6EDtTrf0CFzockXWd3i7sJa
 SPu7vFe3sOnjV+o5u/jFVKnBUhcPQbKqroeqLTxXN7x36IGqsRJfvDsQYyu4ZdVrzEMzdM6kL
 0+t1+S9A3ClQEgUqeSGjWtBgboBY4lGiW8DoftpciYRH5LFrwODZTcDoeTdEh4OapuvSnpci2
 g5eMutVCqY3SPg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rJDN8eL983l7maVq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2022 at 09:42:10PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Feb 03, 2022 at 03:21:50PM +0100, Jonathan Neusch=C3=A4fer wrote:
> > In order that the end of a clk_div_table can be detected, it must be
> > terminated with a sentinel element (.div =3D 0).
> >=20
> > Fixes: d47317ca4ade1 ("clk: actions: Add S700 SoC clock support")
> > Fixes: d85d20053e195 ("clk: actions: Add S900 SoC clock support")
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >=20
> > I'm not so sure about usb3_mac_div_table. Maybe the { 0, 8 } element was
> > meant to be { 0, 0 }? I'd appreciate if someone with access to the
> > datasheet or hardware could verify what's correct.
>=20
> USB3 factor table is not documented in the datasheet I have access to. Bu=
t by
> looking at the value, it looks to be a typo. So please change the last en=
try.

Okay.

> With that,
>=20
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks!

Jonathan

--rJDN8eL983l7maVq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmH9vSwACgkQCDBEmo7z
X9uuyg/413Iw4xZ5o1Tp/qcRiH6I1L+O4tPXbZJS1Oe/YbA96rMszKsKbFuKD93/
XTGS1UEZBO8QRIT1hHF92JLWIDkCQIofhgsqyKFz7tTGxJ2yj23xszPF8GZvZSl1
NXnL2CUNcUGq049M3eLJ7tW2x40b2r7ceK+IcsOGeKuCMqqaLFQcCe8yR7PH3Xar
BkqVP22gj1zcVXfjDKFk9kio9c+uLTTg4r9xH+7ut6F5mXdSt9KW+54UfWcXWEHO
8fO/NNhHwJ8kl7m3uhcVotEAwcdY4UYUq87qmEAbvB2TdBIgjw2RHP2T4gvUyG26
HqywQf2oImnrFKGmeCSTkfuHshiRP0C9p5ayz6J2R535sqV7M3t9pOP/QmjdtDfM
984lc5YNd22V4+rHc7k35UndhL5O6gEF9pMnWDTjxwamRKSehAhDQpNxY9F8JiBi
UAgv+6Iw51qnI8D3Sugbnr7yAcLhVqUzXAORpUvusZRlaBXSUWWmpVR8Ac+D1yD/
XYYT4ZdtIDnVPHlpxyU8vA6jmcVMueXBWN89umR/D3eIU25i+gvunf440evHm1PK
CWaNNl8uxv4u380+BX3GDpgam4mAF2nxnb5z1rnyg1HJSYA4xJVGwyoxacfSoRb4
9IeQMt76GNfWcxlpmeZWKmWmZQR7TrEBpFj1OqVGasJ52C+RBQ==
=WP+E
-----END PGP SIGNATURE-----

--rJDN8eL983l7maVq--
