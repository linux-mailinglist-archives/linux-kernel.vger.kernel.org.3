Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB5E569B74
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbiGGHWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiGGHWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:22:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E60730F43;
        Thu,  7 Jul 2022 00:22:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a9so1125221ejf.6;
        Thu, 07 Jul 2022 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cDHDGLtxSydqFYBhl3txfOkIWwp8IL1b5jBeLJZfgD8=;
        b=iMa8MwC7X5c+xv+LkBDIRr2ifkNStpYQGwx8kN5YESP/5lZej2GkPyii4mlnl/p1oS
         eOgpiJGNZB6iyk7XGu3upbLG2ywKGQyqvW7qXjx9CeLrTQn6qJor4lwHISDN0uDAumJP
         Brg9IzfPr/KCXuD5RB3EtLf3DQoNPruLomjmhy/77EseuQcTlk0SSSNdM3rJKtN+c4v3
         grPr5r3HZbLsJta7gRQSEvN2j6S6gov/8/y4x24+DsUdST8//q7I4UbsGctmctv6uhhC
         f9RvJor3q1b/39dN9/mfe4+/JL0vo4G5xsQNTjIIJvwTuqqRfI7AeEwtddLVbtamMFQD
         1gSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cDHDGLtxSydqFYBhl3txfOkIWwp8IL1b5jBeLJZfgD8=;
        b=fSvLO9pKP+qtqB2OMzcxKBgBOaW9JHNyYXgeVyslBGq1bh/nt/wOy4upSTwkFLiZLS
         15GDjjVlsSdcSDon0RAvVX+BOqZmlIwdZg2YZ6uC5FM15DzbzplYYdx2mUjSDw5fKNgC
         0rz7BXHhTupRP+aM2jNIyN4rCCTC+F8A0HV75fP+weJ5aY4VPeCfXImd7VVQHkcS6/Il
         iaysaK2YVP5U9Aya4+v/Z/LRs8Smip+kk5ZZe9oiJsLP7aky4j23gFBU7oWKzevB1+lo
         ZRD1lRY/+zWpnXevMLEao4EO6IRDTVCi5Hp8EziYs10WMtYUM2zDGeBlsydrZaDZTtYB
         8RhQ==
X-Gm-Message-State: AJIora9tHKlfnle2pU5fSeJ6ts+OpgdHv7Tm3ku1HmC8C6O7galwkihC
        fk9pugyWW0QKnuJ0pKgoR+8=
X-Google-Smtp-Source: AGRyM1v55kd1wD2qY05YZpI7eIrBTQA6vTsDxTmOi3o5zGBQ0oygj0wFrHlVmWGUSqBlqQ0RtQrqhQ==
X-Received: by 2002:a17:906:9b94:b0:722:f2a1:efb9 with SMTP id dd20-20020a1709069b9400b00722f2a1efb9mr43561275ejc.42.1657178553645;
        Thu, 07 Jul 2022 00:22:33 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090646c900b00711d546f8a8sm18233348ejs.139.2022.07.07.00.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:22:32 -0700 (PDT)
Date:   Thu, 7 Jul 2022 09:22:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: nvidia,tegra20-pmc: Move fixed string
 property names under 'properties'
Message-ID: <YsaJtzvG7V1bfjGB@orome>
References: <20220706212034.568861-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yI+MNUdNl4WtNBvo"
Content-Disposition: inline
In-Reply-To: <20220706212034.568861-1-robh@kernel.org>
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


--yI+MNUdNl4WtNBvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 06, 2022 at 03:20:34PM -0600, Rob Herring wrote:
> Fixed string property names should be under 'properties' rather than
> 'patternProperties'. Additionally, without beginning and end of line
> anchors, any prefix or suffix is allowed on the specified property names.
>=20
> As all the nvidia,tegra20-pmc powergates child node properties are fixed
> strings, change 'patternProperties' to 'properties'.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This is part of a local patch that I have that cleans up other aspects
of this schema as well.

However, I don't know when I'll get around to send that out, so if you
want to apply this in the meantime:

Acked-by: Thierry Reding <treding@nvidia.com>

--yI+MNUdNl4WtNBvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmLGibQACgkQ3SOs138+
s6Fbdw/9F4whzx83xa3hxtsudWImR4P7iwas/9BwVlgDa4f3X4l6EyKPQNE5u1O9
f1TZNHDZhc1rnkPc4yL0Jl9AgTKMlvCUbYlvkVWMLZy2/PFg4Xw+PVwhJLzC+aNv
ls29839FcVtpmrwFdoWY/XQwxZAKKGVVuh8Ora/Is+6fLSyAfoRhZ4T5CwmvdVm6
JUE4ugTcq9W26NXF/mso2nJYJfWicuMt6xnspgvpoI6gBX2v2cMQ6iu+GPEOmfFN
vgh5vDF0kXpCAIvCU89r1jVoSaInkM/gxQWISdNhOCMQAKiNKI1tkrG+NPu8tkxd
rR4yKelMrJ/TvmXNFIEYJ3Q9CnYtmuYAkdX6zkob5Ulb1BAeosAq5oLDx3k9VpFg
JQyQ4/vx4mq2JvW7ocVSeJo6gM48CKu14ug4nlePzmXR3gNLAJJOOmNbknRC6lpz
x1iExu639LKJ2svMnGT//n1ppyk71DBM3dbqDwPa4iiwrb+2xevzgttE4XF8E1xs
3+DKNDqAfh5NNa7vOlh9QfyHy8vtqecVSdTwPhnVV+B+JTbjVeJf7kz/0Ghq/FDU
EhYZk2L3MFoZJ9Oal4q+z9MjcZBoeF9hsmPgGU7CmGw9YVApjmIPbOLRyCYt+SfC
j9AM+PrsXi0eSggalGpE6C893Ry53/DN2NWKYY5kcuDPNG6gy8g=
=2t8O
-----END PGP SIGNATURE-----

--yI+MNUdNl4WtNBvo--
