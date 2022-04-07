Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803BC4F8907
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiDGUif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiDGUiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:38:01 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F36D34DDFE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=ZmhjGD4Gf+IUqcQgcceHzoQg2ebz
        QxX4zv7YKh1hyrQ=; b=adP7AhzdfYkfR+8nzw2XgKUxL7b7W7xmaIlQS2dOMPxx
        /3EF2fWkk/0lVMrQWz2a3AILhGDEdM5Yge/c1uvZVvzQXTJrxIdutlx7SdXTRV3o
        YJP/UCaJHzwK/ja018ZQWyJm7802llwOsx/PMLozlqFAT58A0N+iFfPWfg0N7Bk=
Received: (qmail 3330740 invoked from network); 7 Apr 2022 22:24:42 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Apr 2022 22:24:42 +0200
X-UD-Smtp-Session: l3s3148p1@7/eaRBbcCNAgAQnoAEUrAF1rv4rSPqUC
Date:   Thu, 7 Apr 2022 22:24:41 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/10] mmc: core: improve API to make clear
 mmc_hw_reset is for cards
Message-ID: <Yk9IiQYpVBYfQPtT@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220321115059.21803-1-wsa+renesas@sang-engineering.com>
 <20220321115059.21803-2-wsa+renesas@sang-engineering.com>
 <CAPDyKFqt8UUfGVHvpSX5ciP7qJReTYed=sffCGWPP9psS3vC_w@mail.gmail.com>
 <Yk1INkxW/i5p8yxf@ninjato>
 <CAPDyKFo5aO-s13sP4MyjZgP-w+1Bmd59a-o+t3pVA+NgKoCHGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QSTKF3Skeos30Uyc"
Content-Disposition: inline
In-Reply-To: <CAPDyKFo5aO-s13sP4MyjZgP-w+1Bmd59a-o+t3pVA+NgKoCHGg@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QSTKF3Skeos30Uyc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I understand your point, however I don't think it makes much sense to
> try to clarify the names on mmc_hw|sw_reset() alone. There are simply
> lots of other functions that then would need to be changed too.
> Otherwise we would just end up with having even more in-consistency in
> function namings. To me, that's even worse.

OK, I will follow your suggestions.


--QSTKF3Skeos30Uyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJPSIkACgkQFA3kzBSg
KbaUwg/+POQE5BHRJVEdPSepuOFKkMbaCMSnwj5L4B/3ZnSmiA5rNe4eDxk/uNMj
QLJ1jRBRJO2AK0auAStNV8JljiTFaXMLtfmLUWo/ByX92fRJHWn8xz+0XAl6I4Ep
d6gQnaA7Zzz1CRYAcIX4rHRJYOET4QQapw3nBCvfKrlZ26IhuquyXP331T3p+DSC
j5l9Y1MHvOs2YCbHpYmCy27NV25EEkq4FRLFtZR/aIQn3mNm1A+TEZR86709BmTJ
fPgxQv3z7X9DpXeE3ZSsB3nUD3NEsUeDBFuiuEOANjj6iM3jzn9i6ogEfFaIL7UL
pcJtPk+LGd3Qm6cyDXeg3P3f5XixCHe8lN/O3wmZM0l5blbQkxRfu2snzo7zv66I
iecynTqwJwZdZm0Mqha2M2HskQqRfR3GS7I6n29j1G3S8eO9lvIw2kbQyTHodymu
Jh87Gt7UInB9n4BHK7SqkD8OySM0cEWGHzXJJd3ZEGLEpztEjXcMIQFw7A5jYWVB
jyyI6RqavJjwi1/6vzW7ntfIXhGcoLd1rKP+SuNVYjZMcPA003wBMlU20QDCQxs5
x+ZrtJsFLkikvtipYHd2B0c4tzhwtooUkSlBVIr+QVsn2FwR1viwZlSSEIlNobQ0
MDhnekx411gxzRrGczdgXeVFEDE8HwkT2IUagYofAtU0NJBttdw=
=Lsnd
-----END PGP SIGNATURE-----

--QSTKF3Skeos30Uyc--
