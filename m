Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58AF49A0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1847792AbiAXXUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1584593AbiAXWV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:21:29 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD5FC0424E6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:52:01 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so347589pja.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=azp4drUBdsJbeJB1b3ReE50K/yU1xXzlMUUK30yNnBM=;
        b=F3gryvXeekRjImadwhDQY4Obb+eJStO5e0tpTTJZt9j4ImBvFYCLicw/x99Xm0SBI0
         v6NjLXjHROLZNeFvR99vUIBpZPUZzgGdh2i+u7kY7pUooz4Z7PrBNbMlwDsVbGv3GQtI
         rRUIKMbN0FxgmE4CQyi6NWuZcIzwnnpQPuoISWNoex/9vCay++J2qrkgGmBCCals7WlB
         TtgjoH4gxqB8vZgeUZ+f6URgGZARGSWXJihccCjshkf9m0Oes5qWsshKMMO5fb5923tb
         zhV+/y9enMEKa4KQ/diaGgY/8z4wa3zCv35+Fr+7Pzl6lr6nSDJ0bPPT2hh6iqNoU6EL
         rltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=azp4drUBdsJbeJB1b3ReE50K/yU1xXzlMUUK30yNnBM=;
        b=FJaIx9USFn7dhCU3aBuA+tkXmddiXHNQAtXL1zqQ9QeutLKnFK9j18cxqEYZ5KYIPk
         00o8TakeOnZxAwha2Dc80tcC6D4BIRNd/bErXHeVRV7sr4dwvRWMr9CQ4NygKkoXp1EW
         jVBzfrclprd7Ww/Ah5UzP8RxEGo47Ya/qgNceIMDmiZltrj4d7zhFPLk6c+ce0a0dMpw
         y3sENUR2YSB3SMZz3tUa3tyLaa63sib5Oaevm/T11DZVNCwLO0KgASO32E2MhqhSgwbb
         RuObsHIlef1GNGRuY5MkWe+isFr38u98qjyACeFihs2fYTtaokRELdQwJOoeag18GN7Z
         IZzQ==
X-Gm-Message-State: AOAM5339EE2TuZB9WS43rVTBOhi3G4jzYoGCU/+gI6/Auzov1YM8jUeg
        FABGOLDKfcyQ/gdZ13AEml9xyy7QJK9ueQ==
X-Google-Smtp-Source: ABdhPJxRSKpl34+ADkOyTL0oF0DQ+fVEvCLMRH1hZ84FdQZOa6FtRXIqo7qdgaw6fZ0jndD2x6C+zA==
X-Received: by 2002:a17:902:8208:b0:14a:c442:8ca2 with SMTP id x8-20020a170902820800b0014ac4428ca2mr16248516pln.12.1643057520606;
        Mon, 24 Jan 2022 12:52:00 -0800 (PST)
Received: from google.com ([2620:15c:202:201:90e5:c14:112c:6b8f])
        by smtp.gmail.com with ESMTPSA id d12sm16755034pfl.24.2022.01.24.12.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 12:51:59 -0800 (PST)
Date:   Mon, 24 Jan 2022 12:51:53 -0800
From:   Benson Leung <bleung@google.com>
To:     "Dustin L. Howett" <dustin@howett.net>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, tzungbi@google.com
Subject: Re: [PATCH 0/2] platform/chrome: Add support for the Framework Laptop
Message-ID: <Ye8RaQcIuR6kpaYj@google.com>
References: <20220105031242.287751-1-dustin@howett.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p4q7HqB6Z26mUEsK"
Content-Disposition: inline
In-Reply-To: <20220105031242.287751-1-dustin@howett.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4q7HqB6Z26mUEsK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dustin,

On Tue, Jan 04, 2022 at 09:12:40PM -0600, Dustin L. Howett wrote:
> This patch series adds support for the Framework Laptop to the cros_ec
> LPC driver.
>=20
> The Framework Laptop is a non-Chromebook laptop that uses the ChromeOS
> Embedded Controller. Since the machine was designed to present a more
> normal device profile, it does not report all 512 I/O ports that are
> typically used by cros_ec_lpcs. Because of this, changes to the driver's
> port reservation scheme were required.
>=20
> Dustin L. Howett (2):
>   platform/chrome: cros-ec: detect the Framework Laptop
>   platform/chrome: reserve only the I/O ports required for the MEC EC
>=20
>  drivers/platform/chrome/cros_ec_lpc.c          |   47 ++++++++++-----
>  include/linux/platform_data/cros_ec_commands.h |    4 +
>  2 files changed, 38 insertions(+), 13 deletions(-)
>=20

Thanks for sending this! I saw that Framework also posted their embedded
controller source code as well, so we've got both sides of this process
in the open now!

I'd like to have someone else at Google ramp up on reviewing chrome/platform
patches.

Tzung-Bi, could you help take a look at Dustin's series?

Thanks,
Benson

> --=20
> 2.34.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--p4q7HqB6Z26mUEsK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYe8RaQAKCRBzbaomhzOw
wlmtAQD2bG15FEjsW9X594WUGiqSLIucKvGBKPj2hTunATXepwD/VxcenjhdfddM
RjakdKFt5RaDyKPOKJSz6CYPmDr5XgA=
=rgBd
-----END PGP SIGNATURE-----

--p4q7HqB6Z26mUEsK--
