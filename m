Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BACA50E65B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243681AbiDYRAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241573AbiDYRAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:00:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FA838DB1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650905845;
        bh=+w1XGlae5PPeOjjw+gr6PD9JurCdainpAoyyeVkgGwQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XWubnlnoPqhvUduh4OmbZXKnazoqg6lvGdlmoDXN6T4F3uwsaUkO/Pbg5NOCkFi/r
         HLVCkZPLco6hlV+j6spOqu429OlVkqIfbVR74lDwxGv7KP2vu0285yvUWeFoI9Eh/M
         Tah1EBQoMPmnQ2tMmM284nrX+2UVWjWcxpeKWfhs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHEJ-1oOPFe1RHP-00glRq; Mon, 25
 Apr 2022 18:57:25 +0200
Date:   Mon, 25 Apr 2022 18:57:22 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] docs/zh_CN: sync with original text
 Documentation/vm/page_owner.rst
Message-ID: <YmbS8ll0LP1Axrm5@latitude>
References: <1650871931-10015-1-git-send-email-baihaowen@meizu.com>
 <1650871931-10015-2-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ui6ZlquGFn8+P/LI"
Content-Disposition: inline
In-Reply-To: <1650871931-10015-2-git-send-email-baihaowen@meizu.com>
X-Provags-ID: V03:K1:7Y7qOBbviNTHDNQPJBSajnhP3mmdC+G+yoJ/FJ3WpQN6+dN+Han
 MElmcs8zKAa+EJ8VGG/qtXr/WKh7H6/mkBZdaZmNleRUEdIQmbc/8Ri9N2bDqkTYkXAzQHC
 U4Vaaqm3Zsg7MrNdH7ZXqK3DN6hHU9zrVk7Y7eACI2PYI4OpnvRQcrIsnZhC31Tx3vXvu6I
 PR+8TujXO2Is6Kpr71/rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aVM8qTfbfm4=:T6GO+QWg25Y8pv8pT2MAsa
 3OIxsqL5dtphrR0PRD3Xan5OlJfER0Z+tHWYWvJEYHAi85TAHDOOEf2x6E7rolXeJT+nz0/Gy
 mEKFouE/uZ2eMtv4u0qOH0YQkuaQoKzigeqIrHarDG2AMIc6cCn9Z6hidWFqw/K+jof/+Bj9H
 AyQUrhwfqSCOeVs2PE0hfVq4xny+J4Pi2svBFQXo0RgB6joYRl3WYhsHlM0hHskhGmgTjnUka
 fu/ccIPSuVpSO2F+AyfzPp/VOR+rp59oHSt5hwUOh3mg6L0kWZiUmq0fk77Wb1p72HibV63fl
 GH6E4sZxAQ/13x+qUm5kraNA4ESXO9FeTX00E1QYYqM0fcygPgc1qVAYH+Et8S4ub6JB9XR9M
 uyfjgCeDVMGbjqajmRI50li6ZqtLKvJ7sKuXzWQvTzjlKg+ZH9rsWNZAPi4hY40sjCRuszuwV
 V7wtXueFGJ446ep8Q0ImMrRWN54vYqN4GYb21UvxJw2/JgOEk8mmKrhpudo6+0LgdXTYTU5Yn
 KKzdvDVDGdqB5KnL6hGa88ZejiFTLwD0fA7eBDavRgFykLtG+bEyIKYw9K6WKiW3uJfOIh/0H
 lsy5ewx4EhBexR3/P8fawPzTW8Qiy95VZ5m7Wxdz0OCq6WgiiQdsAXNxA2MteMMYb801PP5P4
 G8SEKet8IjYtR9RemBXHcNIw3iskeFnB+17nCp6uFahAT+LVU5wn4mhvM/Trk0OCEW+0cG5sN
 t4abGIGhNlSXb45v9YJaFEpsEhT0y5iL+hClf9y4c2JQMHs7IuY6GtVwKGpUWchUEVMf8UOlf
 AVhydVySnfvCB6eApPIxCD5pAsykvQc29JZ2g0V6ymPCvdkb/ZEsUFtqMi98Oan/Z2nGkuflc
 ieOiMLbqOA47viFz468rgtJaMpMn17OYywT9hNadXNiIdFhHkePdDE1Fgg4WxkzIDMyKssvD/
 dNcGmkjcTdFOM2jZHNyEihSczpP85fDgOqiBtb//UNdIMvB9UHcAum2hSQ+FtkdJE7Rkn8Xzk
 0+VZJW18FAW6GoRyAEyz07NW+9QDKfsEiY2vxPLyCQf1UoHTbk5x9wZME1n88zQ9ppujleuby
 99ypkjTKqKzpas=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ui6ZlquGFn8+P/LI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2022 at 03:32:10PM +0800, Haowen Bai wrote:
[...]
> +--curl =E9=80=89=E9=A1=B9:

This should be --cull, not --curl.


Jonathan

--Ui6ZlquGFn8+P/LI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmJm0tEACgkQCDBEmo7z
X9s5Ow//YJ2S0SEHGsNn/lVAKYrdWRv2FRjgF95wE+XJgmHovA2weCQnfGw+gcml
O73+r5sY2Ppov7VpVhstX8bSgHewevS0f1p4udu45vqK9LwnMwJLiq/peXtySS+6
D4ErAVdpssZRm2cZhv01q4duIe21fJcDK7BfZAH2mV/9Ev6EeZJ0ah8tLOKJTwGA
VB0coNV0j1t7pzI/3Bh/LeKLY8j0ykeR7N/0gGJqB7EZb0V49RjBJweq+IaPypyt
yk495wMsIhEvCO77KUveh9Y1VQKg3Wgk6/XAVjhbyUschPOveyatGV47lZOGFyhj
huuteJi1DYlNBZxmosxnkc/l1ryQ9k1XVZLoqMofd6atB2lLfayZH21ZphAtDcKE
02ymCy82hxSj5htm7qmm6L8Vyz9WLU8TPT4MGwIDcOq7PHshmdQm2HTJsBBgPLAf
+Rdm0oOgMfCklOQJdlbDDJtvcCy6PiJn2axxLSv5w4SBsXJ6n5oiKAaz4y+7ZscJ
pOa6BnOzGgllgD4rOdfjytUrNiZWCeg7KaFl6p3+jnhVptTsvw24EPBKeCBEzg7w
kfIh+XoH4FobRWsXPIyPQeapTrm237wJAy6vrnKA83J7zeFNJm3jo5DGyDQ7jrjT
WAnQUeU/xC4wirrgR/XtvREkefGeSiVLegdp0qFgnux8+nuU1Fk=
=DPcX
-----END PGP SIGNATURE-----

--Ui6ZlquGFn8+P/LI--
