Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343B64C2BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 13:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiBXMi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 07:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiBXMix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:38:53 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E7B19E71C;
        Thu, 24 Feb 2022 04:38:23 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id f11so2602801ljq.11;
        Thu, 24 Feb 2022 04:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YTBia43ww2BpFzmoJ0cJeExRHMVTq6qsE5DA8fpwhGk=;
        b=bZnSSWo0O6ywYIPw3PSgJNmqA1t4zCw88y+wSC1loGKWU4l0MJLOAAaAScezJw2Gz3
         T4dQzU3rlLniO0pqxNoy7i4iDvipOrXW7/9f/8mLGbYWgTI0MoeGw/j1PGx76kwHY8ec
         KnWrkWf5YetKqrOm/Zr08ZI1/re8sklh9hqslg16ZGdqLr5L/x6FfnbJyVO525YFC/2w
         4nRql6wGBGxEI6a67at+3ztbEHTkCd5xpK1TRqduBMWFaf+TLZUx0wwcr8WfL7a0pVFq
         ZqPr5guZQufLJHQd0NUIq/vUieLHfiuk4IOXW+N4j/0I9mb6ohmfJm1e2GwFudcXjyMm
         kpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YTBia43ww2BpFzmoJ0cJeExRHMVTq6qsE5DA8fpwhGk=;
        b=Ck5pLPwUqEaPF+72lwWND++O6EQ0gylEymTAmg09CbHA6L4xoMHaN5V2cdcgwhE+mD
         mlCrvRVN9BJa/Je6l0BdfN6g4+hqGiHH+1wAvFU1SmlV6NyouS6IoRgnO6/IzU1qhelb
         xP6OJ4zb803nIOTfZpHEvjRwynqngUw0qt4kwaGfA1l2sGOUh0Xln/3W0P0U6ai6GdQZ
         PoJmgQcdjzK/0y9d7ZdvbNCBt0+kvmXEyiiDf5fFmWwtVyxYw97aFjZCb/yiQR15PLng
         r6g1aBsOJDeQZ1EcfLKPidxuihr4nRemKfkqyZ2aKZt6WA5UjuJA11oT+nkg0z+6wQEv
         YcrA==
X-Gm-Message-State: AOAM530MPQJHHjbpu/NE7vjqMZ1/6GVRakLRh4IhPbPKFBbuRUXEb7s8
        mqA3h2yk7pVhMFs8yy6V4BE=
X-Google-Smtp-Source: ABdhPJwignEIbwikb1ZfQLmHLENOGH+okHSbzNNPd7lMH3hjRuVM2pjvj+0FJN+uZYnba4DecqC0Zw==
X-Received: by 2002:a2e:9c82:0:b0:246:20c:d62d with SMTP id x2-20020a2e9c82000000b00246020cd62dmr1769885lji.39.1645706301325;
        Thu, 24 Feb 2022 04:38:21 -0800 (PST)
Received: from orome (p200300e41f0a6900000000000000043a.dip0.t-ipconnect.de. [2003:e4:1f0a:6900::43a])
        by smtp.gmail.com with ESMTPSA id 25sm341778lju.70.2022.02.24.04.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 04:38:20 -0800 (PST)
Date:   Thu, 24 Feb 2022 13:38:18 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Julius Werner <jwerner@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 3/3] ARM: dts: Update jedec,lpddr2 revision-id binding
Message-ID: <Yhd8OoJQer86kTZ8@orome>
References: <20220224003421.3440124-1-jwerner@chromium.org>
 <20220224003421.3440124-4-jwerner@chromium.org>
 <ec0c90b9-58a9-669f-fe4a-73e60df335d5@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WI3zOMv/g7nKQzbJ"
Content-Disposition: inline
In-Reply-To: <ec0c90b9-58a9-669f-fe4a-73e60df335d5@canonical.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WI3zOMv/g7nKQzbJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 08:29:27AM +0100, Krzysztof Kozlowski wrote:
> On 24/02/2022 01:34, Julius Werner wrote:
> > This patch updates the tegra20-asus-tf101 device tree to replace the
> > deprecated `revision-id1` binding with the new `revision-id` binding in
> > its "jedec,lpddr2"-compatible node. This was the only DTS in the tree
> > using this binding.
> >=20
> > The revision-id2 (mode register 7) of this memory chip was not given in
> > the existing device tree, so let's assume 0 for now until it becomes
> > relevant.
> >=20
> > Signed-off-by: Julius Werner <jwerner@chromium.org>
> > ---
> >  arch/arm/boot/dts/tegra20-asus-tf101.dts | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Please use scripts/get_maintainer.pl to get the list of people/lists to
> CC. You skipped here Tegra maintainers, so no one would pick up this patc=
h.
>=20
> I bounced the mail to Jonathan, Thierry and linux-tegra (+Cc), so
> hopefully they will get it. If not, series might need resend with proper
> addresses.

Thanks for the bounce. Applied.

Thierry

--WI3zOMv/g7nKQzbJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXfDkACgkQ3SOs138+
s6G+ORAAg/sBMMlJ0fFhz4VQL1VHXYPddtDio0E2a0Fxz1brLxvze1tEIhtar5FE
YLxPRjHrqCHovvmnvwLcp3daPAV/V9vD3t+YUMwn/ivLyBtWm9YoVXs+adB0zewE
S3/8SQZp7/OUjNLyKDYTRkYdytYbKBS1qivB9Ar6fnZcBeGBv/IC4xTiA3uNV8iT
GZdflbyjjHwhrQYdJPJZdh4gWFk7SMTjw33U7TtvfFyim1Iw4bYUBK0KpH5W2Rdk
OcNdC98r3JI1YQuwcTG8ODGAXA+86a+qF254/+ImVo11N9aSJoxepXrBxRx2SuPJ
p8+rYSwSK0BSO7P7gc6qMh9BFovWBwOWfjLcAWQrBXtAWnwLVa55eZJpV1oT138X
/uyMxjr9387K+7zzx5QXYJH5KVjLCBfVmjNHB6GYr3VFUsJAcU35cOySPjrUbCkr
QRQc6VxUzth5KcxNUzAtesswUfiaoRsabBxe8wkbqdJpd5jV2tDwCp0muDT5xtdI
dSfh3wk14xitPzs4FGVt77ZLRzaWqPA4jc6UYE89H1A7TCDFeT1G/4601Z2lBjn0
sXqh+zNNZmGMbVAk34G/ysMQZD8hBGJlKiCDtoqNv4bDZc4ol96RgD/zDN7TAR5W
MmPXSiCwUAOtlhUu0PMnOIAgzUGLVmdYyBzB6RWHGUqCWGmuRqo=
=foIM
-----END PGP SIGNATURE-----

--WI3zOMv/g7nKQzbJ--
