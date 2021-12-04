Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEFB4683BD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384506AbhLDJvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:51:38 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:9075 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245192AbhLDJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:51:37 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A2sU1p6oQswglGD/Wvy0elwf6fQReBmI8ZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmIXXz2AP/yPZmH3co9xOd+zo0NX65PUnINqTgptryxkQiMRo?=
 =?us-ascii?q?6IpJ/zJdxaqZ3v6wu7rFR88sZ1GMrEsFC2FJ5Pljk/F3oPJ8D8sislkepKmULS?=
 =?us-ascii?q?dY3opGVc+IMscoUkLd9AR09cAbeeRU1vlVePa+6UzCXf9s9JGGjp8B5Gr9HuDi?=
 =?us-ascii?q?M/PVAYw5TTSUxzkUGj2zBH5BLpHTU24wuCRroN8RoZWTM6bpF21E/+wwvsjNj+?=
 =?us-ascii?q?luu6TnkwiceeIbU7f0TwPC/Dk20UYk0Te0I5ibqpaOBwR0mXR2Ykskr2htrTpI?=
 =?us-ascii?q?estFofWme8QFTZfHCV/O4VH/qXGKD6xq6R/ymWWKCu2mKw1ZK0xFchCkgptOkl?=
 =?us-ascii?q?P7/sXJSoWRh+EgO2yzfSwTewErtgmNsjgPJ83vnBm0CGfDPwjB5vERs3i4dJem?=
 =?us-ascii?q?j0qgd9INffYe8cdLzFoaXzoYRpJM0sXAZR4l+6ti2P4dRVYtVuKqKtx6G/WpCR?=
 =?us-ascii?q?10b7wIJ/Wd8aMSMF9gEmVvCTF8n7/DxVcM8aQoRKM8WqpruvOmz7rHYwVCbu0/?=
 =?us-ascii?q?+Jrh1vVwXYcYDUMXFWyrP2RiUOkXd9bbUsO9UIGtaUu+Va5Ztj7UQexrHONslg?=
 =?us-ascii?q?bQdU4O+0x4SmJy6zJ80CYDG1CRTlEAPQprsI5RjwC0l6PgsPnAiFpvLSJSHWbs?=
 =?us-ascii?q?LCOoluaIi8TIikIbChCTRYMy9niu4A3jxnISJBoF6vdszFfMVkc2BiBqDR73u9?=
 =?us-ascii?q?DyJ9QkvzrpRWe3mjquIDPCA8z/ATeGGy/hj6VrbWNP+SAgWU3J94aRGpBcmS8g?=
 =?us-ascii?q?Q=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AaJyoKa8BzjPsR97p08Zuk+DmI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCY0TiX8rauTdZsguCMc9wxhP03I9ertBED4ewK+yXcX2+gs1NWZLW3bUT?=
 =?us-ascii?q?CTXeNfBOLZqlXd8kbFmNK1u50OT0EvMrfNJGk/sNj7/RS1CJIL4PTvytHMudvj?=
X-IronPort-AV: E=Sophos;i="5.87,287,1631570400"; 
   d="scan'208";a="8382313"
Received: from clt-128-93-180-152.vpn.inria.fr (HELO [128.93.180.152]) ([128.93.180.152])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2021 10:48:12 +0100
Subject: Re: [PATCH v2 0/3] topology/sysfs: only export used sysfs attributes
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Len Brown <len.brown@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ian Rogers <irogers@google.com>
References: <20211129130309.3256168-1-hca@linux.ibm.com>
 <YaTdpsVCDQMlscON@hirez.programming.kicks-ass.net> <YajWjasdqnibSRJm@osiris>
 <YajXnjVGEWeUmEqA@kroah.com> <60d13e6233df4aa78494bb51a2792bbe@hisilicon.com>
From:   Brice Goglin <Brice.Goglin@inria.fr>
Message-ID: <63384337-ba36-9b2a-c9ae-75e3f5ac02d7@inria.fr>
Date:   Sat, 4 Dec 2021 10:48:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <60d13e6233df4aa78494bb51a2792bbe@hisilicon.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Y5C3IJQNSjYBTH3jFttcPF1ZnmLBgUjqd"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y5C3IJQNSjYBTH3jFttcPF1ZnmLBgUjqd
Content-Type: multipart/mixed; boundary="o1iT760ICFik431n9xKFirdLjrEKMQr6t";
 protected-headers="v1"
From: Brice Goglin <Brice.Goglin@inria.fr>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiko Carstens <hca@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Len Brown <len.brown@intel.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Ian Rogers <irogers@google.com>
Message-ID: <63384337-ba36-9b2a-c9ae-75e3f5ac02d7@inria.fr>
Subject: Re: [PATCH v2 0/3] topology/sysfs: only export used sysfs attributes
References: <20211129130309.3256168-1-hca@linux.ibm.com>
 <YaTdpsVCDQMlscON@hirez.programming.kicks-ass.net> <YajWjasdqnibSRJm@osiris>
 <YajXnjVGEWeUmEqA@kroah.com> <60d13e6233df4aa78494bb51a2792bbe@hisilicon.com>
In-Reply-To: <60d13e6233df4aa78494bb51a2792bbe@hisilicon.com>

--o1iT760ICFik431n9xKFirdLjrEKMQr6t
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Le 04/12/2021 =C3=A0 10:07, Song Bao Hua (Barry Song) a =C3=A9crit=C2=A0:=

>
> Could you give me one minute?
>
> +Brice
>
> I'd like to hear some feedbacks from hwloc if there
> is a chance to break userspace and if userspace depends
> on the existence of sysfs even though the topology
> doesn't exist.
>
> If no, I feel it is safe to take.
>

Hello

If the question is whether hwloc *requires* cluster/die/book/drawer=20
sysfs files to exist, then the answer is no. We have to support old=20
kernels without those files anyway.

Brice




--o1iT760ICFik431n9xKFirdLjrEKMQr6t--

--Y5C3IJQNSjYBTH3jFttcPF1ZnmLBgUjqd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEelpOgOQAl7r26tY4RJGQ8yNavTsFAmGrOVoFAwAAAAAACgkQRJGQ8yNavTtF
sg//RA3OKI+ZgqqSFHQoOb1fBi/W5brllIl2UUEcPHCo6T1us4JAtPzX2LppOLZVk8qYWPue6E00
e1Wk+u0kuePN5QrpD9krWyQJqO0RotCVWUssqfwpr0htyRskxEPiHmFOiOHAtpaTcJsYC6NG1vqL
LXhJjaMqHzI13CtF5NiD/iCz9zy6ePhA1oxwBcNfvOgjhzzrvQqIztolQrEUFQ980W8W09aJEsnE
XUleq+poTr5vaqHFTMCuB84jOWTMH73aJ3Oh/qDUw/oqsBPdgnGcIhWnWMBRRhQZToDyn+UK6q7n
YXjLgjSU8hj4OuDHZIo9/MhWZ0Gi/mZDbXmH3o0mqv9W3bmWPoP+jqZiHynYhIF0yxZyU8UzzWPV
H53Rr4PzSDxzWT2HgGy8kPHp8Kz2TtH9XyBwYwpoX7tqgtYFqLPape76xcep6NbY5E3nxgww/W8T
s8DPJuDuh1LMa+TLajnIrvSgGzoCxnIhzjeZC0+2T8Y76uPldU71gFZZgRhVrIzlDEG8nycj1Q3j
OhIfqhC39tJUwOdwDBRVCW+w2bnOtgTzhe87dGrfzHU34gZdvRzMW5KoJJiKnVShdbA3Rl9G6t/R
3csQEk3pLIdh1P172h4J/n0FZ8/1u3X/TuYLXFFgRGoiEf1OBHTEbtY8Q6iBcyqX6L5r8pgFawxo
5EQ=
=H4gY
-----END PGP SIGNATURE-----

--Y5C3IJQNSjYBTH3jFttcPF1ZnmLBgUjqd--
