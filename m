Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DBF544D9A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343683AbiFIN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238373AbiFIN0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:26:36 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F153E41FBF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=lfB8fOTqamQfwwSwlqY2SUMWaGvp
        E2sPIyV2x1j5F78=; b=HwGJKkmmp8Z6QmLx3Ef7Vrt6NdRjjdVRI4ApU+5Ho5i8
        fJIZedyG7vRXcanm4JFiWlmKbsvrNdZzCKHROSfswJvswbGk6UJrP6AJ2RqUcuPd
        Iytsr0pmI1Z6XAKc1/umlQ/aNnnuTiiodbMFWqzZT5u1j3ivPD7OP4ggWgbkK4U=
Received: (qmail 3336385 invoked from network); 9 Jun 2022 15:26:30 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Jun 2022 15:26:30 +0200
X-UD-Smtp-Session: l3s3148p1@DKvRxAPhMUdZD+4S
Date:   Thu, 9 Jun 2022 15:26:26 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] thermal: rcar_gen3_thermal: improve logging during
 probe
Message-ID: <YqH1AofgJVvSpW/x@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220525151216.24133-1-wsa+renesas@sang-engineering.com>
 <20220525151216.24133-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdWEzhE8aAfsDRpzpv=ZFLb7Cn0r-En0K6O7heT6OA1JEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UP7xXm/IwNERRwno"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWEzhE8aAfsDRpzpv=ZFLb7Cn0r-En0K6O7heT6OA1JEA@mail.gmail.com>
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


--UP7xXm/IwNERRwno
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> > -               dev_info(dev, "TSC%u: Loaded %d trip points\n", i, ret);
> > +               dev_info(dev, "Sensor %u: Trip points loaded: %u\n", i,=
 ret);
>=20
> I actually prefer the old wording (I'm undecided about "sensor" vs.
> "TSC", though, but consistency rules), as it makes it clear "ret"
> is the number of trip points, and not a success code.

I think "Sensor" is actually important. E.g. on Spider, Sensor 0 is TSC1
because there is no TSC0. So, the TSC numbering is confusing.

I'll try to reword it so that the number of points becomes clear again.


--UP7xXm/IwNERRwno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmKh9P4ACgkQFA3kzBSg
Kbb9RA/+L1KuetE7EfdL2e6FyQdsgMngXBI1yKp2ZhSyxFvWt3RMdk8wjjZWPoGJ
h7Mw2HGMnw2Q+W4O8XG0V3v0JaGOMxOdlKMMKa6uEXJnpEj9rehW4Bmb6FUqGr5K
WEN15mfBXeefoKXEUFuwYlfzzoepvPs91fcGa2kGtCGtpOi+gNfwwbZu4GS8/qbc
ezX1ie0yVgzLxXkQwJK7LShlkxqjQzCCqeVfUYiRkuzv+bnryEOkBndOynBSUatB
0cyKuKzQ03NlEB7pXhMLYavsUUORI034sNpR7l5kIRlPVgKOPdu/NRvN2CeuQkjh
yhHM9ZFVyV6ddcdJVArZVg4dkVd6maPVP0jcDoOcGrEBWmy2CrbgXa58Zl4neBxk
b/TrthdLc3lpphp1qOAxj90dg0lyROeowaKdxICfjdAd/7Sxsfm8es2p40P0cpYL
2UxDLXaDnLiqNpMtt8VD3GfV9p6oBm5LM6OtBdnoWNu6GOlDGrhO0lDq9COlOaGq
Hd9oM5HWgAiYuvTXKmKtVdcD/UsktjZ8VudarrqkkhgtmVRJT3qOk18yaC1gvT8h
QrQBvs6bsz7uib2fB4LNOuAg646STT4GTE2t7PhVZI0R2d7Zqxv16e65AcD4Bgtu
de5w8HTRTdp2kRxLscLhTeHZ2+FNKlp6+EU2fiIFKVehoh0iqTM=
=so9F
-----END PGP SIGNATURE-----

--UP7xXm/IwNERRwno--
