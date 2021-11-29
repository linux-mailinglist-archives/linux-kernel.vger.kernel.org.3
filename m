Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5234623BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhK2VxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:53:18 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43766 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhK2VvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:51:17 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20211129214757euoutp011c0dff507111ecc88279576a85ef558b~8Iqnh3Juf2799527995euoutp01G;
        Mon, 29 Nov 2021 21:47:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20211129214757euoutp011c0dff507111ecc88279576a85ef558b~8Iqnh3Juf2799527995euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1638222477;
        bh=m9bFCdPptMIMhbE0U3urrOgTgryCpAE6VmEGSPGEbXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XNg/CClHBoy+7bHX5pp/8zLNySEAO7l5pUwvRScG2YzqQZoPZEMwKKK9L4UzCEa4p
         oj93YC5cyClv7ZXrRQPu2c5gEfL2RhE8SztHiLMdAbOM7SjGmxB6zZqRTfVXm2O39O
         y8h3wy3zwcoYA9W5kmC+vVzGgFGMFzx0JMYOHrv0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211129214756eucas1p175847e7f94d9190de4dbee31f11f7d90~8Iqmg8M8p2313723137eucas1p12;
        Mon, 29 Nov 2021 21:47:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 62.77.09887.C8A45A16; Mon, 29
        Nov 2021 21:47:56 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211129214755eucas1p1c5ded52cda8d495d23dae59a871b9276~8IqlVbSB22314523145eucas1p1x;
        Mon, 29 Nov 2021 21:47:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211129214755eusmtrp17b71c7c1811d9bdb7951498c4996b567~8IqlU3AQ33219232192eusmtrp1O;
        Mon, 29 Nov 2021 21:47:55 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-d7-61a54a8cdd05
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4C.38.09522.A8A45A16; Mon, 29
        Nov 2021 21:47:55 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20211129214754eusmtip2556365bf3b38e1f4b2adad978f915365~8IqlHeVIE2288022880eusmtip2G;
        Mon, 29 Nov 2021 21:47:54 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Joe Perches <joe@perches.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] get_maintainer: ignore "my" e-mail address
Date:   Mon, 29 Nov 2021 22:47:40 +0100
In-Reply-To: <7a56a2431825bb71b76bb3e90d3ce0897596bd48.camel@perches.com>
        (Joe Perches's message of "Thu, 25 Nov 2021 09:01:30 -0800")
Message-ID: <dleftjwnkqab2b.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7o9XksTDc7vErSYff8xi8XlXXPY
        LNYeucvuwOzxZdU1Zo++LasYPT5vkgtgjuKySUnNySxLLdK3S+DK+LB+NWPBbYmKD1Na2RsY
        O0S6GDk5JARMJG6838LUxcjFISSwglFiwqXr7CAJIYEvjBJrNttB2J8ZJfbPdoFpaP77jQWi
        YTmjROf3yWwQznNGiS9blzN2MXJwsAnoSaxdGwFiiggoStzdwg/SyyzgL7H03gY2kLCwgLPE
        nV5ZkDCLgKrEwtd7wG7gFOhglGh9OIkNJMErYC5x4fETMFtUwFLiz7OP7BBxQYmTM5+wQMzM
        lZh5/g0jSLOEwAkOiek3H7FBHOoisWvWUXYIW1ji1fEtULaMxOnJPSwgR0gI1EtMnmQG0dvD
        KLFtzg8WiBpriTvnfkHNcZRYs/EYI0Q9n8SNt4IQe/kkJm2bzgwR5pXoaBOCqFaRWNe/B2qK
        lETvqxWMELaHxKTHM6HBNodR4sX0LtYJjAqzkLwzC8k7s4DGMgtoSqzfpQ8R1pZYtvA1M4Rt
        K7Fu3XuWBYysqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQJTy+l/x7/sYFz+6qPeIUYm
        DsZDjCpAzY82rL7AKMWSl5+XqiTC631mcaIQb0piZVVqUX58UWlOavEhRmkOFiVxXpE/DYlC
        AumJJanZqakFqUUwWSYOTqkGJt6IhbumXV/nblkS4dJ1rOuA3mTtHM13d685vV7/ZmbVi55Z
        4R5vpzBoCLMulN2TavVs4xqLmR4ZXUXujoX/0jz1HE1qjNnCP2zMyHkkySp7JjjzbJLAN2/G
        7eYG//ZdU5o033DF7RbRMMmwFY97fc3U+M8uSbD/cXPuYoUjn6+cntCgcHK7091c39lRxy8+
        ndN9QWFTwovSdv/tgd2LeHJlq2Meqy/905UdzLr+0uubK2OL3n2zjtW4zvFS/Etc682QRT+6
        8m0nHKm7Ed1YE8jjYheyLH+C9zzLU0m9H+329Em+6lyVdWb6RVHlDZN/tnJ3eOvsCJ+zJELe
        jXnTUUHduGm6ARdjPReJXbzQqsRSnJFoqMVcVJwIAAy8TG6oAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42I5/e/4Pd1ur6WJBhs+MlrMvv+YxeLyrjls
        FmuP3GV3YPb4suoas0ffllWMHp83yQUwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehlfFi/mrHgtkTFhymt7A2MHSJdjJwcEgImEs1/v7F0MXJx
        CAksZZSY0bOOtYuRAyghJbFybjpEjbDEn2tdbBA1TxklHs07A1bDJqAnsXZtBIgpIqAocXcL
        P0g5s4CfxJ1Nk8AqhAWcJe70yoKEhQQ8JE5eamYDsVkEVCUWvt7DBDKRU6CDUeJiSzcLSIJX
        wFziwuMnYEWiApYSf559ZIeIC0qcnPmEBWJ+tsTX1c+ZJzAKzEKSmoUkNQtoNbOApsT6XfoQ
        YW2JZQtfM0PYthLr1r1nWcDIuopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwMrYd+7l5B+O8
        Vx/1DjEycTAeYlQB6ny0YfUFRimWvPy8VCURXu8zixOFeFMSK6tSi/Lji0pzUosPMZoC/TaR
        WUo0OR8Ys3kl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUwZbY3z
        JotsD7ZQU1rjeCJut/mKtdJv5C6+VQ17eIdLObbP6+S0t+6pqS42nzbfN9QUXf62t39LxDQP
        zbLKpLzu02JB3EUz14Rdes689dHjr+vZrtya/KNMja/bsLOoJF3zP0+34IHoI023/NwllzzJ
        PHq42Xr5w538JyJzeSW0iiIPtp6dzP46IjJ9m8XED18XvVI/MU/5VMuXTu+dtQ8KHn90Sd+Z
        Gn7/+bUdze5Xp3aUXDAJPaC4nPVo7JmjDEFiqgskLCVX5gW+fvq18dicM9/jXP/uzCn/p8e8
        oWfL5IOzb3b8b3WYuXyu25ZlalMPVt/0+z9naWy72u5LrDPL18q9vZSba2SpLc+itW+JEktx
        RqKhFnNRcSIAEbW2PiEDAAA=
X-CMS-MailID: 20211129214755eucas1p1c5ded52cda8d495d23dae59a871b9276
X-Msg-Generator: CA
X-RootMTR: 20211129214755eucas1p1c5ded52cda8d495d23dae59a871b9276
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211129214755eucas1p1c5ded52cda8d495d23dae59a871b9276
References: <7a56a2431825bb71b76bb3e90d3ce0897596bd48.camel@perches.com>
        <CGME20211129214755eucas1p1c5ded52cda8d495d23dae59a871b9276@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2021-11-25 czw 09:01>, when Joe Perches wrote:
> On Thu, 2021-11-25 at 17:14 +0100, Lukasz Stelmach wrote:
>> It was <2021-11-16 wto 15:14>, when Joe Perches wrote:
>> > On Tue, 2021-11-16 at 22:34 +0100, =C5=81ukasz Stelmach wrote:
>> > > Ignore one's own e-mail address given as a parameter to --ignore-me
>> > > or in the EMAIL environment variable.
>> >=20
>> > Why is this useful?
>> >=20
>> > git send-email already supports this.
>> >=20
>> >        --suppress-cc=3D<category>
>> >            Specify an additional category of recipients to suppress
>> >            the auto-cc of:
>> >=20
>> >            =E2=80=A2   author will avoid including the patch author
>> >=20
>> >            =E2=80=A2   self will avoid including the sender
>> >=20
>> >       --[no-]suppress-from
>> >            If this is set, do not add the From: address to the cc:
>> >            list. Default is the value of sendemail.suppressFrom
>> >            configuration value; if that is unspecified, default to
>> >            --no-suppress-from.
>> >=20
>>=20
>> Not really, git send-email does not support --suppress-to, and with
>> get_maintainers.pl coupled with git send-email as follows
>>=20
>> --8<---------------cut here---------------start------------->8---
>> [sendemail]
>>         tocmd =3D "`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallb=
ack --norolestats --nol --"
>>         cccmd =3D "`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallb=
ack --norolestats --nom --nor --nofixes --"
>> --8<---------------cut here---------------end--------------->8---
>>=20
>> my address is added to To: if I am a maintainer of the patched files.
>> To avoid this the --ignore-me options can be added to tocmd.
>
> Rather than add complexity to the original get_maintainer script, is
> it possible to add a pipe like " | grep -v '<your_address>'" to tocmd ?
>
> I think it better to have these cmds use scripts ala:
>
> https://lore.kernel.org/all/1473862411.32273.25.camel@perches.com/

A thin wrapper is never a bad thing (-;

> And if not a script and the complexity is warranted (though I think not)
> I'd rather have something like --suppress-addresss "<addr>" added to
> get_maintainer.pl to allow one or more addresses to be suppressed.

Indeed, that sound a lot more reasonable. I'll probably go with wrappers
for now.

Thanks.
=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmGlSnwACgkQsK4enJil
gBB32Qf/VWGwsulq+TNDBQyzYoPZJTBC8RpI/V8LjTjesfwgnzDL339+gqT7tGHS
4NIjfmP8nJ9T8kupzDSVWbyqPm/77/Sr796FTkcSIJZhTGFQB/1Xpg0S1tCR3xuA
zNYEe3ibOsf+ta8yl1QLcKyu4eyicUuxIV1vIIGG3MwKBcOQ+AeTlY8Ni6Mc+EWO
FGoCc2PyKtzlciHNYk/HvV0W4figRnnCOsD9sr4SoOIlf/741mh/R7xsU9LzCDog
06ai6jIOTmSZEQjsWGo1lf96k6I7TOE6v9pfbpQdjqGc1chdUcqd+NNkeVPyxvAn
rPTiSdLtwt03kZwV5FefORRpmLAz1g==
=9ReM
-----END PGP SIGNATURE-----
--=-=-=--
