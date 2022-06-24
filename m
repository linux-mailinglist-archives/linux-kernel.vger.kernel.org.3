Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B733559E84
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiFXQ1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiFXQ07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:26:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6937960E2F;
        Fri, 24 Jun 2022 09:26:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s1so3790839wra.9;
        Fri, 24 Jun 2022 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AYBPwF7uWIloDNYt/QphPzAZXxTZcC03d+PPytnRwV4=;
        b=mimzjrl/A6qU0/5rr7lNYmMv2tJhodCuBM5NpFGwCSRaR86aqKpwv/A0E5I8XgTcbr
         fhRD7ZQQxqAgmClbXZnR54ZZNXThxu4ahODR30Fo1QO4NHbv2dHERxdhSVhvmP7m35Zx
         P3FBSvAZPUW+Xu5+e/0e3+Nl/Z9Mp7puaRCJ2+akNawws+wPa8d2h2I2A6tRT/u5C86B
         nOQHoVIaVhsVYEKKiSeuPsJiDhzXiP66Wbya9WkYGbe7m1+QNZkuqw9LYZlBeFll8URZ
         NWECCncB+oN6TRUgY/51UZJxR1kNhIRwOMHsWVbuhMdioWkyeMQ7SrZJW+UFh/IEuoW9
         ypzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AYBPwF7uWIloDNYt/QphPzAZXxTZcC03d+PPytnRwV4=;
        b=VihE0CuahbW3d2gwwFLSAX6/Uak+cJtJpWVjapXFHgiLbzgXUEHf+Dn0KzlT3cv/os
         EWQDWxMxLdiiUUvV5O1s3yW0rrTwE67BDH+HsCrJBHmSFL97ltxpDRtR7V5dw1cqF6X7
         4W1UNyf35oTLNqZ76QA3GfjIxsM4cr3Swt5WjUI6PurmVqboZLszybvsopFeUL1oyu9d
         UaPSVg6Y1Z+vM/VQbUGG6cLSMDNjmWjqRxZuZ1wDCB+aKLOU9conpqG9Z+CQ4WmZQgYp
         +s0zo9gk9rW0dYgJbLEOkEh6HAExb0W1p3sXATpfCZRRqWETMMhbaNdWci3s0M5OESdd
         ZJRA==
X-Gm-Message-State: AJIora/hEM4+zEi+wvreL25LxnfbL5eXhvhjByoTYcTqmVZm8wDnucEE
        FIRuifyrpDO/Oq4sUn44xF4=
X-Google-Smtp-Source: AGRyM1v+N3LKkbjjD/Y44CNLdhyBhCqakzmU8gne5rz8XZ5zNdfvBOpmiM3UKIygTyHT+0oIoj0PUQ==
X-Received: by 2002:a05:6000:1d98:b0:21b:aead:9b6c with SMTP id bk24-20020a0560001d9800b0021baead9b6cmr5798557wrb.531.1656088015980;
        Fri, 24 Jun 2022 09:26:55 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c28d200b003976fbfbf00sm3340148wmd.30.2022.06.24.09.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 09:26:55 -0700 (PDT)
Date:   Fri, 24 Jun 2022 18:26:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: rectify entry for NVIDIA TEGRA DRM and
 VIDEO DRIVER
Message-ID: <YrXlzY/tGl9CA170@orome>
References: <20220623095452.30745-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WXw1FbmeQU/+1/K2"
Content-Disposition: inline
In-Reply-To: <20220623095452.30745-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WXw1FbmeQU/+1/K2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2022 at 11:54:52AM +0200, Lukas Bulwahn wrote:
> Commit fd27de58b0ad ("dt-bindings: display: tegra: Convert to json-schema=
")
> converts nvidia,tegra20-host1x.txt to yaml, but missed to adjust its
> references in MAINTAINERS.
>=20
> Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about=
 a
> broken reference.
>=20
> Repair these file references in NVIDIA TEGRA DRM and VIDEO DRIVER.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Thierry, please pick this minor non-urgent clean-up on top of the commit =
above.
>=20
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

Thierry

--WXw1FbmeQU/+1/K2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmK15c0ACgkQ3SOs138+
s6EvHRAAj5Sn5POcAeo1gyPgf25OpMA4+Nq1XJ9gk8Zi0UKEtV5jh0ZwmhaDKizm
pcOi+xqYXm7QDe39q6P7BiQ8kUVlhGPjL/CKskcbYTYWIQbaYxdltwJKWtDa6Je8
xpsGwgtQMBXZ0DChn+pWky2mrjN5D1r6ZBUIGHdfcb0xFf2PPj9bIcsqxN05S/Oc
xZVb3MVMaGbYKK1HIOAlwIByk5/NFBoRYr1ygVFxovwMjddvg2wDwSPfx2Ed2CgQ
f+wZyJGloC98bMl25pa/PzYWdPOSA6c3DSwwt5jSCTXYjboo7TXfw84hfLe5bI4t
PahEzkik35FSjYTi0ZpOICKLRE2pGGSZvS76J/vRYySy4MOjHY/TJkcoBQy/5MVb
+jhGZTUlSAzoZ+gmeVBkylwKJJyIe/DpHGQ1bABsls2HMkkAjZPRA6lyxrnqB0vy
h4D+srDkbnAh6O35nw3Q80HvujztmPce+VW6W8vgRwKSOoWvLCQon615lfBbxUFR
SOVnIDq6Va7t+29tJwzikYstxRoNxC7EHzdhjwc2SQmD2i7nEJPhW5ByJXrr/y2b
Tlzuv6VUr5BqOAR/pP/g2lohdqFah6gVnBv/0CqD/8jGGnpMLXER+31H0HNzoKTS
EP2Hy2m6ihgTJ8VX9MWjjzqF+oEXbFF7Ziy6yjyl9CwJGpHCX3o=
=0k8q
-----END PGP SIGNATURE-----

--WXw1FbmeQU/+1/K2--
