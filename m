Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400D94FE46E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356902AbiDLPRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356915AbiDLPRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:17:10 -0400
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id A9E5345AC2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:14:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev; q=dns/txt;
 s=smtp; t=1649776485; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=5sXCut8TWVHUJUklXIfFZgNr0FAeWRkchT3uWz5fv5M=; b=LCUSzEWkNMX40iTn6NwMmxFcoHJz6U2NdsjBAnqDYlhfnei91rLtS8HWFwrLaQ4BQDmOHc51
 pZqskvV3KXHejWyl9cISr5OL/Q6oe67Di15xz0BHy3wOsC5EmEGPwSWmS4H98msRwh6XeWOO
 X4Edd4c60nfBllnH6fHtx7ZOwyag/21QiCYR1jAzDUtgX6gXLoEOwIXl7togZ4XqID0Q2q8c
 EtBSRsvo7H+Np/yeysQ+ydSJx9vrhF2QakJjuxPH4SCJ7BlKDpG3f3ql3d4dXotHAyhSM+8p
 HwTs+fWuYGn35pMdMTvLHb2g3ESCyu9EFLZB8j5nNdXBaKgXIhzkgg==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWM2ZCJd
Received: from AN5Bruno (177.75.142.178.mhnet.com.br [177.75.142.178]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 62559763c172fc506669698f (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Tue, 12 Apr 2022 15:14:43 GMT
Sender: codeagain@codeagain.dev
Date:   Tue, 12 Apr 2022 12:14:32 -0300
From:   Bruno Moreira-Guedes <codeagain@codeagain.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: vme: Adjusted VME_USER in Kconfig
Message-ID: <20220412151432.zsdxrag7myyzgv6o@AN5Bruno>
References: <20220401050045.3686663-1-codeagain@codeagain.dev>
 <YkaW0ThT8Ah3z0wW@kroah.com>
 <YkaXRpIElW1BwKGb@kroah.com>
 <37e5203d1efd310ea82cf91c18c6a07eea743ac7.camel@codeagain.dev>
 <Ykl/iBR+pDaaLImA@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uzroyt2mhu6e5h2z"
Content-Disposition: inline
In-Reply-To: <Ykl/iBR+pDaaLImA@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uzroyt2mhu6e5h2z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 03, 2022 at 01:05:44PM +0200, Greg Kroah-Hartman wrote:
>=20
>On Fri, Apr 01, 2022 at 03:21:50PM -0300, Bruno wrote:
>> With my tests in my, I have found two other things that I think are
>> remarkable to mention. First one is a missing `depends on` line for
>> `VME_BRIDGE` in drivers/staging/vme/devices/Kconfig, not visible
>> because they were in the same tree, but now unveiled. I'm fixing it,
>> do you think it's best to add it in the same patch?
>=20
> Make that a second patch, and resend it as part of a patch series since
> your first patch here is gone from my queue.

This patch is already sent, so I'll trim most of this message to avoid
duplicating the discussions. There's only one thing I'd like some input
first, if you don't mind.

>> Do you think it would be interesting for a future patch to provide
>> some output when drivers from the staging tree are present in the
>> running kernel image?
>=20
> If you can figure out how to do so, that would be interesting to see.
I think I might have figured out. In "include/modules.h" and
"include/init.h" I happened to notice the driver initialization is
handled by some macros. After some inspection through gcc -E and looking
how they are defined, I figured out a scenario (when MODULE is not
defined) where the module_init() macro is defined as (among other
things) an inline initcall function that wraps the driver initialization
function.

So I thought about implementing it by creating a -DSTAGING flag in=20
drivers/staging/Makefile, and then using this macro to make an #ifdef
STAGING to add a similar inline wrapping function, except that in this
case the function makes a pr_warning() before calling the initialization
function.

Do you think it would be a good way of solving that?

>=20
> thanks,
>=20
> greg k-h

Sincerely,
Bruno

--uzroyt2mhu6e5h2z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCYlWXWAAKCRAZtd3tyEY2
krH+AQCOA6xs+ZfEOtSqkDyDQo7guUekOMvEkl3nwrFWp7XxcwEA/U77ucSBvvUC
Pjapi3KlYMIytoVGNTDlwkBkCxQP6w4=
=Pzsg
-----END PGP SIGNATURE-----

--uzroyt2mhu6e5h2z--
