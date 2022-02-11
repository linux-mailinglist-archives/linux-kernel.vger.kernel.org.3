Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0A4B224F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348706AbiBKJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:41:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiBKJlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:41:44 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B00010A3;
        Fri, 11 Feb 2022 01:41:44 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id y5so15270628pfe.4;
        Fri, 11 Feb 2022 01:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XrEai599YxaamrkRq48SWPy93iIT1IIuRy8NI79Zo+Y=;
        b=LsTNIEuvqPTGl3ix7wTQCjwLYF5imHGU4tSEOIY7ZRR2H+doCaFKNKRM/CLry+jcqW
         DWri0FV6vs0ac5BUohuHUBgR7/+MuMfk+eAixaj7hJVgLqDq0vuNYTgEqPAY0e6B4Zwe
         akfex4GhCMrEnmjTFPBDcgCidOAkTsvNy90qJLFOsbksNcm6+uqtMN+Ni6TDuyU/nQeY
         Z4urRPnNGgWtEzwU9zDzZV1IrU/53fGdlE3SU7yPa6LGQ35sJRJ5Kydi1dnPMBVu0ad0
         +XucxUYq8/mdzHGr/SXSA1nxcth/yG28XwHtr0K7cud4HCX5vahAg2xt0zavht3iAu/v
         VqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XrEai599YxaamrkRq48SWPy93iIT1IIuRy8NI79Zo+Y=;
        b=4Dg+RGfq/tdCxKnmqdIeMoMg/suWFvtQRz1IdiOSAUCs/ZdiU6yNDHOYsE8qyok5Lb
         pcC4Dx1540QTH70jVKyj3tzOB0OD8mlm+WLiTUZUlMMus82G0aGG6wfmHL7Mb7bsuglB
         Sm3kN3TVLRBYdMdw3g7o8fC7XEoeCj0GhOI/tYF/Gdd7VUPRclf16YQqXa35gQAN296z
         cx3mVf1UioK9P/APijXD1mUezajK20M7rw/nlcUGZFR1tHdhupxUhP9ko4WnRQK+pGoA
         gFrSo79siEpy8T7sdGwfO47yFGWIGwXSGNHOc+oeYP+G2L1j5fXGXvbqgeWgew2U1KKp
         qFWg==
X-Gm-Message-State: AOAM533zwwifGegElZR39KyIUpvzWaGpwHxvW575FMP99spap+1e7gB/
        aG+0vypm7N4Itu7gzPUsLaw=
X-Google-Smtp-Source: ABdhPJwk54lydLL2kA70IfDAxCRcJE/q6L2tNckyTDbGML9zeATouDwO/q0bIaXlLlZJ1b+kk7i/mw==
X-Received: by 2002:a05:6a00:b50:: with SMTP id p16mr897170pfo.22.1644572503799;
        Fri, 11 Feb 2022 01:41:43 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id t138sm7525193pfc.66.2022.02.11.01.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:41:43 -0800 (PST)
Date:   Fri, 11 Feb 2022 18:41:37 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 0/2] counter: push event on every pulse
Message-ID: <YgYvUdgkkWixDir4@shinobu>
References: <20220203135727.2374052-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ospNvinesCUFwJ6X"
Content-Disposition: inline
In-Reply-To: <20220203135727.2374052-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ospNvinesCUFwJ6X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2022 at 02:57:25PM +0100, Oleksij Rempel wrote:
> changes v2
> - rebase against latest kernel and fix some regressions
> - add COUNTER_EVENT_CHANGE_OF_STATE event
>=20
> Add support of push even on every pulse.
>=20
> Oleksij Rempel (2):
>   counter: add new COUNTER_EVENT_CHANGE_OF_STATE
>   counter: interrupt-cnt: add counter_push_event()
>=20
>  drivers/counter/interrupt-cnt.c | 7 +++++--
>  include/uapi/linux/counter.h    | 2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.30.2

Thank you Oleksij, I'm picking this up now and I'll submit it with the
rest of the Counter patches for this cycle.

William Breathitt Gray

--ospNvinesCUFwJ6X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmIGL1EACgkQhvpINdm7
VJLwOBAAsvgnVSxZWHuHqL8JXvacII6IVcSzvO5YEIsy8Gz2Qprj6Dyev6rqQWhe
8UsJElw0hLI9NLt68S6NA4O+ZHFP4PTdU7Qx86jngwcMCqPrfVd7oq4EgNtTBW1Y
CHdGZUN8yV9KkpmS7kCyRBo1rQJiOfuVkyw1w/8C1Sb94bmjaK35V4NOmXl59wMs
Jj7PSZyBIdtOO2ar1IHT9tnhxyA5NuPaWCf0qyG9ztCiAGmSSWZR4jXPGWDHyYB6
ps9N54AllrCpY6hEP3Y9KZdTFnCUB3L16zTCNBilwLSuhVy9utpAdjxj1HIVCd1N
KoqDeIU+SqqY6DE4nrRXz1Rwk+HrcihzKUkRreLVfhuTWZJiNIBs1j2befx5h3QJ
IaXtzmpI5B95KOIAHL0CwwFzAsydkNr8Bhc+ihsiFaBnoI5xY6TMtT03p7kKxxsv
0eUjP3tBhRjh/3rlzDpIJ+PD2scKjCypIBfp18jxALzkkkA87yjn6BZZMA4zTBmc
+WDaTK1YFfzeF1JVPhxxkEtX2X2DVtdceh8OO+XlSmMGUF+BfG1mv2HxhXiArtIM
ZP2490zZuv4I+sIV5WmIaZf7zutVP8WyRJpDQ6/JrujXhOSZuONtihP2Fe0W3ZDE
1gCnChRZrqlCTinBud0Q3wFbTGWBEWb3AnJ8Xb/rXo2mk1h44JQ=
=loYF
-----END PGP SIGNATURE-----

--ospNvinesCUFwJ6X--
