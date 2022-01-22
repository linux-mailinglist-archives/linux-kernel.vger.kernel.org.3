Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3BF496A22
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 06:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiAVFU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 00:20:57 -0500
Received: from mx2.supremebox.com ([198.23.53.42]:48921 "EHLO
        mx1.supremebox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230287AbiAVFU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 00:20:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jilayne.com
        ; s=default; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=5FYKB111pb8xtaFI9Q+oHKrMPS1x5Vtz4UWDNuEAXD0=; b=VNB+ryfQcVUN/qTlbD+h4NkKid
        taphaXvKEW+UctFaXgBvt8xRheHR4e3nIdtklmSykZj24c6d0yu8E2LfsrtZ/G9P+6mmCAI9Zi5hq
        zA5b/Imi5nbfZd8koFkmQ28DIKzyUyDWeV/F7Axz0ku9/djguV865WKarkOAMk3sblmI=;
Received: from 071-094-058-251.res.spectrum.com ([71.94.58.251] helo=smtpclient.apple)
        by mx1.supremebox.com with esmtpa (Exim 4.92)
        (envelope-from <opensource@jilayne.com>)
        id 1nB8pZ-0001O3-CS; Sat, 22 Jan 2022 05:20:53 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v3] powerpc: Add missing SPDX license identifiers
From:   J Lovejoy <opensource@jilayne.com>
In-Reply-To: <CAC1cPGypAKcAAia4ipgTWNu33HLW=fb0CSroqR=SK-umrOJb-Q@mail.gmail.com>
Date:   Fri, 21 Jan 2022 21:20:49 -0800
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E0A69FEE-9889-4DF2-AC39-3E8638E5BFEE@jilayne.com>
References: <d2c52284244d6dcb3472d2041abe43b456d116df.1642762977.git.christophe.leroy@csgroup.eu>
 <CAC1cPGypAKcAAia4ipgTWNu33HLW=fb0CSroqR=SK-umrOJb-Q@mail.gmail.com>
To:     Richard Fontana <rfontana@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-Sender-Ident-agJab5osgicCis: opensource@jilayne.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(trying this again, as first time, my message bounced)

I just saw this and have not followed the entire thread from the =
beginning, but if you are unsure if a given license text to something on =
the SPDX License List, I highly recommend using the SPDX License-diff =
browser extension / add-on (for Chrome or Firefox) - once you have that, =
you can simply highlight a text in your browser window and it will tell =
you if it matches or how far off it is if not.

If a license is NOT a match to anything on the SPDX License List, please =
submit it to the SPDX legal team here: =
https://tools.spdx.org/app/submit_new_license/ (and preferably then tag =
me in the Github issue, my Github ide is @jlovejoy ) Please make sure to =
include that it's in the LInux kernel and a link to where you found it.=20=


More about requesting a new license be added to the SPDX License List =
can be found here: =
https://github.com/spdx/license-list-XML/blob/master/DOCS/request-new-lice=
nse.md

Thanks!
Jilayne
SPDX legal team co-lead

> On Jan 21, 2022, at 10:17 AM, Richard Fontana <rfontana@redhat.com> =
wrote:
>=20
> On Fri, Jan 21, 2022 at 6:03 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>=20
>> Several files are missing SPDX license identifiers.
>>=20
>> Following files are given the following SPDX identifier based on the =
comments in the top of the file:
>>=20
>>        include/asm/ibmebus.h:/* SPDX-License-Identifier: GPL-2.0 OR =
OpenIB BSD */
> [...]
>>        platforms/pseries/ibmebus.c:// SPDX-License-Identifier: =
GPL-2.0 OR OpenIB BSD
>=20
> "OpenIB BSD" is not a defined SPDX identifier. There is an SPDX
> identifier "Linux-OpenIB"
> https://spdx.org/licenses/Linux-OpenIB.html
> but I believe that is not a match to what's in these files
> (specifically, the wording of the disclaimer), rather I believe what
> you want here is BSD-2-Clause, but you may want to check that.
>=20
> Richard
>=20

