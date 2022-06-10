Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4225254670E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbiFJNG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245626AbiFJNGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:06:25 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9D21DA76
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=guXsWRjw3azP6yjoR1bypXJFMB2r
        y+is8MqIQDds+nE=; b=i0mdWEVCJqNrc42PRxgKl2uoIpRMjjkemyWYidj+GCDV
        88zxqV23ZdAxZF1U+THS7ldyzhXmvKJcwFzi7t9M5ncY4GF9T17Myi4IYza/IA1g
        EXlEV91yPWDsBFzs9RwQbgP4pormegS0c+U0E4Voa1C/wV64Howeh88DHxq2fwM=
Received: (qmail 260231 invoked from network); 10 Jun 2022 15:06:18 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Jun 2022 15:06:18 +0200
X-UD-Smtp-Session: l3s3148p1@AsCfmhfhfU1ZD+yN
Date:   Fri, 10 Jun 2022 15:06:17 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     linux-renesas-soc@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal: rcar_gen3_thermal: improve logging during
 probe
Message-ID: <YqNBye5avNNQqQPm@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        linux-renesas-soc@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220609200709.4455-1-wsa+renesas@sang-engineering.com>
 <YqNAXofRPsDasXi4@oden.dyn.berto.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e1WimC/NmHD1fee/"
Content-Disposition: inline
In-Reply-To: <YqNAXofRPsDasXi4@oden.dyn.berto.se>
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


--e1WimC/NmHD1fee/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Bikeshedding, I'm not keen on this style as it makes it harder IMHO to=20
> grep for log strings in the code. But I don't dislike it enough to ask=20
> you to change it ;-) So if you and Geert are happy with this style,

Seems reasonable to me, Geert what do you think?


--e1WimC/NmHD1fee/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmKjQcUACgkQFA3kzBSg
KbZ30Q/9ETORoKNeSK7tQrNlYhoP1dMLOclwliBQUUVMGkBpLLgSSNj3qp0TkAdz
Ju0tNnhiAX+1lwKiYRkYztLOljI0JjARcYjvIEIMKZy4XABjQbZzuoWjpcL9g2QB
3iKmNPqV+CoOS3cCWvDobJ9hVbUX47+Q1m/p8XCLV3GCncMMlq6lILhpgbVwhxCt
JhQfxPtJX+3uG+wGX27pfwJQbMbgGVZTsrS+GLJUnMJupwM24E+EJIiCw4ODxOIc
/xafeY2Pfhxz3cyQ8UHnDF03I2g07M7UltNv/9MQ2LxYWOvsVQH4efY8vBs4WRqP
XVAnfQHq0J+dFg2WWK24dsdDUhz4xiMFoz0YukIXqi5ygCbH6sBqTJbw12/uglca
hpAhcDUofNkpsVtAdvVB8nquv9IxEUvVcTiKcSpOYrn6xnDGfpHN9Vd3+DkrZj+g
asEEIYZ5WSNNiM+lwlXfDE8AYw23Ehx7iutVZt9ULon0pgy93dVRdiHqoM0Rh/Hz
ejFxWFAs1bCBZXKn6qFHytAYVPVn8V+07WEWPpgR+d3FbRbx6X/3CtNt07Id5sui
WQP+oM07hGkVKd8DThwu+v1iB9f5gO0ZPL5o67YQp9PVyLxC99gUDdlH6Wyi0b3q
X5Dq8x0fbyf9H7UDZJvywmDngXiWezYMlQB0tf/uJleXuqUqwGs=
=eAci
-----END PGP SIGNATURE-----

--e1WimC/NmHD1fee/--
