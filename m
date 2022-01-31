Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DD54A499E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242006AbiAaOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:46:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:44771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240920AbiAaOqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643640351;
        bh=4k90G8jSzlvUKTaFczVLOa2pEefmYwVKvOCHiVXT8dY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=AXGpA61rs6zMAWrkzjsamVxqE9FZH9rJlTe0Tzvv4NQrCZ2GNmSLIBlIKj7pqcA6e
         6JnTwqPbZVo7StSxeHd/AnDbDm85hBGiTm/mFB2ZiTtskhtNkwCAnnCSKwM5EGwAOU
         ZTKBxFVylas6PN1g3vHaaIpqEvTit0QeRwqoK8/U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17UW-1mGMoW3lww-012YQs; Mon, 31
 Jan 2022 15:45:51 +0100
Date:   Mon, 31 Jan 2022 15:45:49 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     kernel test robot <lkp@intel.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/5] clk: mux: Declare u32 *table parameter as const
Message-ID: <Yff2HZ0tbO4nkvig@latitude>
References: <20220129095159.2202366-2-j.neuschaefer@gmx.net>
 <202201311102.kgy44sMD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XP1VM/Ugk75sAcB+"
Content-Disposition: inline
In-Reply-To: <202201311102.kgy44sMD-lkp@intel.com>
X-Provags-ID: V03:K1:hcabq17XEcX7zNbqlwfHkAj2/LkIuon6rXy8+fsotgIiSz/aIPp
 uQjAmg5wYurrOX+k15jqYSEFn1X+PJevYrNloSaMUCk9wGt7HK26pW/fHaDsj/qufu+4FbW
 eOgmQ8kcPtKXAYKM6d3m8o6H1N7YB+CXE6AsBCfT2TPsRPkcmcpxkPlBZpMcrHBUU0eouoX
 qGXb3xtjEPaZdsBOV0+bA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MxFMp34iGPs=:uA+Fyvr1lqnuZYWWQKrSz4
 /e5yJClYSr+JsMTz9eD5hdtiLSX8wEqWS0hevzTYJvtvLO2zcwecA9OXb9aGIgyvW6vZ1gkjJ
 zd+6H6OArMN7k9Z8LdVix0hdYmURpW2YFU4xHrQqFusvOhR2wlmHS5yimbbyhxCqzv13DErLC
 1pEZQQ0YDmldYAxnSTtgOzlRUlb1LmJ5E02mPzXK/+R2d0bZrC//VbZAvweLsy364AByXd9Mn
 jE5J3hPL2riMZ15295oWCJNNzewSSUjwE76D2Zi5XETeOA+DNMwaaibEi7pXCWe0+1kJY2r4q
 ybsbp0zAkxjqqgQsAE35dO238Hk1Hlb6q48XcrmvW3g2yIvEMyt4Y3oy+GiQxnfqYvA1TQ3xW
 9myovq1iBMmnDYHZH2jmmmkkPlQqQWx8tgpYihy//Lz9vvrK1RxK7r/pY7OAARJbgOVWuDwe6
 WYNTsy/qT3oKntxeaOAwFx34gpUL0vXsXsjXHzZN3XUKzCMMLVTY+SVlgT//0ieBvshKyagoT
 qItz1KawVpy/o7vOwP/4kKgfwDvYglf7aQlOTqyrYgkK5YG7buBNzPAy8NWc1muQPMtAxduxG
 jRkQ4XoD32mRkZ3R95t3I0AhV5pYnVaWPSlaOVRPVFjbtaW2j1h5AfN763wjKT2FD/3Y6YqJv
 Ua2eX0Dq2A8LmRKH2ZeTZH1ZY54H+kS1ZSgFsS1obnlICCo18Gz5SbmZtQHVEq5MB9FJfgWa5
 ABa/czsn5fdURrPzwJrDIYiJxSlBvVKttW8Xx458Tm0YLPekROYHjcRFBIW/i5qWa4BuOtIet
 EBz0sz9kJORA9UXbenjBkySMVQ3AihcE1E6B2t9GwdaK65xP9vZzNW26L6Yq/e/eF9ZCKjlIO
 O8ru6kayrmwPVFhr1PGphLlXfOeYWazeFDSNSOWXb/AVhHOKbSc15scdRJ3Xa/6jRQcchadO8
 edx1CC/IL9fydn22VDHiwWSAyw4xcFkC4jfBNZwLEUyjJF+U0nVo5XX3893OLN8G3TcIPyiUd
 UOi4k+aCrsKQkxLmn8bE8cv+QWlw9E/ZL4IrCnxkavKGkNhLKq54xqj61AJbXHyNfeI+8//W8
 Ajvvs0Eve9Ijuc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XP1VM/Ugk75sAcB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 31, 2022 at 11:44:25AM +0800, kernel test robot wrote:
> Hi "Jonathan,
>=20
> I love your patch! Perhaps something to improve:
>=20
[...]
>    drivers/clk/nxp/clk-lpc18xx-cgu.c: In function 'lpc18xx_pll1_recalc_ra=
te':
>    drivers/clk/nxp/clk-lpc18xx-cgu.c:460:13: warning: variable 'stat' set=
 but not used [-Wunused-but-set-variable]
>      460 |         u32 stat, ctrl;
>          |             ^~~~

This is unrelated to my changes, I'll leave it up to the LPC18xx developers.


>    drivers/clk/nxp/clk-lpc18xx-cgu.c: In function 'lpc18xx_cgu_register_d=
iv':
> >> drivers/clk/nxp/clk-lpc18xx-cgu.c:545:52: warning: passing argument 2 =
of 'lpc18xx_fill_parent_names' discards 'const' qualifier from pointer targ=
et type [-Wdiscarded-qualifiers]
>      545 |         lpc18xx_fill_parent_names(parents, clk->mux.table, clk=
->n_parents);
>          |                                            ~~~~~~~~^~~~~~

I'll fix this for v2.


Jonathan

--XP1VM/Ugk75sAcB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmH39foACgkQCDBEmo7z
X9sNKA//UAh5XDeoCe9F1AFVCieUV6braThSPDS315aq317E9rkOOqKUJc8G0LHu
evD8Fwy6I30LRAU5wBZRbHS4Sg7ZsdcuZ6Xwbka3BsaIQvaFVdjYUcUL3Owg2TpW
0F1nDrnuP/kwWKCGDcCzJ07Tj1ztfNkdtTamXIwdXV4Wc5fdSriWs+Soeglqz77l
5utG+gBHl71T0ONUcO7mR8Y9tbWeLoDd/9M4LSo9mXcTDEpYWGzUqilmwCinDPi1
EVxi8cqdNYQxisAQ2T2miRDc9VLaZB+DXAVs1oYwraItkW7cGqcv2ZDezzPFKUE3
p7RsZUxaY8QYumilpkpFdYcO92+U0U1+U/SmtBndIQDzjbX1NGDRHWxJ1hQSewFW
/Be/WKcqIYX3GexDWI5H0CUh4/H09bWNBF6qj58kDjx4Et5zHyK0g5gzqZN2IUVU
zXe8oXm37vFvisE/xCcAEKE/gZv66xZ9SINjaIFRX/7W9N5BLRHBtuIwg06jfmFk
dKxBY7I9VbchFxWQzS2+yDwqSazlqRDSLRO7ZxLRS5XEaXo76vPUpH/iOd+ZsI5i
MPHmBeQlOT05ipUAri/+mEdCSPFrWj0Z26CZx9iVNwTl8nWkQLuKrwuIOBAea9/t
5MACy5L27lNBjHYesVOlsJbNijCFoUXOrhhEAdvzr/ixBulhOZY=
=5Gny
-----END PGP SIGNATURE-----

--XP1VM/Ugk75sAcB+--
