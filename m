Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8D5553FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356636AbiFVTJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiFVTJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:09:38 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788C915806
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 12:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Oj8H7zsJ4ndt3MK4sIJED6AFUWOF
        E1yzy5hFgKjZV28=; b=jRgDKwJGfrTY38pfQNNKvIQfPb8DTrus3E0WJk5md+Le
        c9TarJXe/2O4u79AhQMGXsoXfWFIIJhV02eq6zC2LcTmf2vHgw5LmdFT5LGcZgLe
        2Pohd2kPsx5L5NpCEuiLaBcLTYqR9uTj1dpHi3WwufCBslOzIW8Psv2XAMPmsHU=
Received: (qmail 730482 invoked from network); 22 Jun 2022 21:09:31 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Jun 2022 21:09:31 +0200
X-UD-Smtp-Session: l3s3148p1@xLOEEw7i1JcgAwDtxwdRADDX0JnqoDnA
Date:   Wed, 22 Jun 2022 21:09:28 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 2/2] mmc: renesas_sdhi: Fix typo's
Message-ID: <YrNo6LLDixpZ16k/@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220622173614.12778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220622173614.12778-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdWbQ1VHH4ugQs2mamS2KGEj5AdWmNtmg=6eUJmyGRDTVw@mail.gmail.com>
 <CA+V-a8vDem8=QaSdJr5mjHC+qbGmUtTBWEsf9T8njMZMT3BGJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RQzW6Ax7wtYuMWw+"
Content-Disposition: inline
In-Reply-To: <CA+V-a8vDem8=QaSdJr5mjHC+qbGmUtTBWEsf9T8njMZMT3BGJw@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RQzW6Ax7wtYuMWw+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > > -       /* This DMAC cannot handle if buffer is not 128-bytes alignment */
> > > +       /* This DMAC cannot handle if buffer is not 128 byte aligned */
> >
> > 128-byte? ;-)
> >
> In the previous version of the patch Wolfram never came back on your
> reply, so I went with 128 byte instead.

I hoped for a native speaker to chime in. I don't care about the '-' but
maybe we should rephrase it to:

/* This DMAC needs buffers to be 128-byte aligned */

?


--RQzW6Ax7wtYuMWw+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmKzaOQACgkQFA3kzBSg
Kbbpew/+MQbQyIXLYfz6qKuhS5xIaU2T6054B+58JVY835yCxrowf0om5JfPQKpq
6rM61/AMQzJWLgfNRJIvAKgYvdJiVppd/t7HPCV/yD7tpAygWfciepusnF2P7fXf
IlfOeRwTzLSR4PwQcnq/FrWsoGvM4IrcPnyXLgPVIwBOmd9qJBYoGKwTYcoPUYVZ
cU3WtgXo9cgiszZIj1cgaBtr8Xg7u60BbgG2T1GYs+LlD9/pO/vK8H3vHJflnYE5
0lD5fOlnkJbqtMu9uSTPCHKEfoDUMb8bFPwhXPS6Uos+j8uG+A1sj0y4tlEcWuZw
7hLbXyn+vRMEdRTfb16XjplyXzOSOZcYiP+jOiczSMfkxI7obzsLpA5YyBbTrMYG
AW/Tdcq1jvL1mKWdyKO7bRRNgETalDjHex1YyEpWBohkhY/BjQjFAx0M4uzkpbu8
T/qRYyOh/KR4JDNtNnxWm2BRAbO+VIOh8IP+0g8M2AnHMHdElhFMu/mJsf0BCwDh
WgpZMBOqArDQ1UfFIupLkYdk6NW0iH+La1UK+mXBTGYWwoyA7hKhGfSCaPf6oEa5
lAqoDlhxtvIZJPM3YHl4VRvNwY5iLxY9jsziWknGg0vgSLTzMz1mj1sy4LqBbeW3
GRndizepa2B/eG+8gdaJHpHIKeC2P4lwx0z9IIhIYdadWmQrQDQ=
=Ryfs
-----END PGP SIGNATURE-----

--RQzW6Ax7wtYuMWw+--
