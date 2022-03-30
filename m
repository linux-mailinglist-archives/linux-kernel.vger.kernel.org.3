Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8FA4EBF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245565AbiC3KuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245554AbiC3KuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:50:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91CF659C;
        Wed, 30 Mar 2022 03:48:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id p15so40635400ejc.7;
        Wed, 30 Mar 2022 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YDced89Td8RXRs8Pp4UdANu0oM9AhCKT24Er0QSiO3s=;
        b=CZSeLsWgOyzWSNLitc+tCHS07NF3mWrXfOxiJxzqQJyuUwMMIjqP6VugTKYf7Ait/Q
         j7trEMxfsg/1ibOw/ubwxuB/s2lGslcvE3GoeyX7dKG0BW30kB/VvVtjxLk2X6hzl2l1
         S1ilQIE53fj3PMEncdLeqCsXkJO1h+n/sDhsxDuP5DHKgW+PgLuJPlTPEzL2tz7xSfZM
         HGNPV1UecS5xKLobydKBr6J2b8X6aHFGGMnMmgf5uwDZnA+/Ieg2VgDK6CqbKwCtbjQ5
         JPqSOfoJjhEgNCyDVCy8kEOOSJsxGKfvRNuWaj93xwxoKjokspDUAa+Zg5NypiUGZ7mL
         uAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YDced89Td8RXRs8Pp4UdANu0oM9AhCKT24Er0QSiO3s=;
        b=HFqr7/ukOVtI6DSPWHs0oWPSSPYzp13ftScZCCvtk3AzH0zv31i+9D34DvF010b/+Q
         jpYHLSDTftmpJx5szbOXVu3VeWg9kxCugLq4c3KNl2/5RtXjTQqi24dwKhEapUPtssAp
         0egkAt07d3caS+rLIIOO+XeQ6e83eUELUL6l+kP/eKP0kICMmSj6f/bg7WUUdYYr9juu
         lrmJkSwiSTM0cM2Ibfhhml3q5/MySscV8KpJByDfNdbitH9oko1/kJyezA/u7g6UYex8
         +kFiHSl+zGi64LsWfSJj2eH+78fUQZe87DC/CmrgPsE89xDu8lME+YIaAmxNZ/C7DVYG
         dA3w==
X-Gm-Message-State: AOAM531ptCTjQ6xav7FlEyClyZ+5syEDZ36qzZW05NXk2nLwNePdbGjv
        VV+//5kWKwWYPtaB0ZLxmLc=
X-Google-Smtp-Source: ABdhPJzfVq1eRWVeBa+t13AQfY5ytmrsFFVZhWC/P/uM/muAR2S5u69OmktjrsTLBMZ6U0KMnQzsog==
X-Received: by 2002:a17:906:3ad3:b0:6cd:382b:86e5 with SMTP id z19-20020a1709063ad300b006cd382b86e5mr37501643ejd.145.1648637296399;
        Wed, 30 Mar 2022 03:48:16 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id by4-20020a0564021b0400b00418fc410299sm9513118edb.62.2022.03.30.03.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 03:48:15 -0700 (PDT)
Date:   Wed, 30 Mar 2022 12:48:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mohan Kumar D <mkumard@nvidia.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com
Subject: Re: [PATCH] arm64: tegra: Enable hda node for P3737 + P3701
Message-ID: <YkQ1bWg00BSRV8W0@orome>
References: <20220325072141.28597-1-mkumard@nvidia.com>
 <f35537de-6352-e6db-b4a6-17b1ab96deda@kernel.org>
 <32e425be-5d78-e1e0-6ec4-70ea21895e15@nvidia.com>
 <ca18fa50-f63b-8131-07a2-8c44daed9f26@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NWAujopaZLN2XilU"
Content-Disposition: inline
In-Reply-To: <ca18fa50-f63b-8131-07a2-8c44daed9f26@kernel.org>
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


--NWAujopaZLN2XilU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 25, 2022 at 10:42:17AM +0100, Krzysztof Kozlowski wrote:
> On 25/03/2022 10:31, Mohan Kumar D wrote:
> >=20
> > On 3/25/2022 12:56 PM, Krzysztof Kozlowski wrote:
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> On 25/03/2022 08:21, Mohan Kumar wrote:
> >>> Add iommus property for hda and enable the node for P3737 + P3701
> >>> platform.
> >>>
> >>> Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> >>> ---
> >>>   arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts | 1 +
> >>>   arch/arm64/boot/dts/nvidia/tegra234.dtsi                      | 1 +
> >>>   2 files changed, 2 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-000=
0.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> >>> index 34d6a01ee1c6..156d5d95fde7 100644
> >>> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> >>> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> >>> @@ -1751,6 +1751,7 @@
> >>>
> >>>                hda@3510000 {
> >>>                        nvidia,model =3D "NVIDIA Jetson AGX Orin HDA";
> >>> +                     status =3D "okay";
> >> Nodes are enabled by default. Why do you need this?
> > hda node status is set to "disabled" by default in soc dts file=20
> > tegra234.dtsi. The enable is controlled by platform specific dts files.
>=20
> Oh, surprise... why do you override nodes with full path? This is
> error-prone and makes any changes (like node name fixing) difficult.
> This should be overridden by label.

I disagree, though I admit that this is probably very subjective. In my
experience label references lead to completely unreadable DTS files.
We've had bad experiences with these kinds of references early on, so at
some point we decided to discontinue that method on Tegra.

Reflecting the tree hierarchy in board-level DTS files on the other hand
makes it very clear what you're changing and keeps the board-level DTS
quite readable.

Fixing node names hasn't been a big problem for us and any potential
remaining issues are entirely gone now that we can validate DTS files
using dt-schema.

Thierry

--NWAujopaZLN2XilU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJENWoACgkQ3SOs138+
s6FfqxAAvx8RKOX8UrSmBNVLPEi9U5eGWSADof9pOxLubHzxMG9bFnJYazTUFEwH
TjxTzJVuUppJ5R9hXC2WlaTdu9q8McJhroEDIt5JFy0mkcolBgLNEY2m5KHY6pfM
j3Dn64dEgwyyFUq1OMyKuzKbJB7Qs1Iytfjga6vjP4646WLAi0t7Y0BZOa7mHzYN
EC3H3qGYOu25s0X9nrz0cQyWjrdxZfxr/MPLFc9dui4s9fNZ8dHLcKuzxDQmp/Gu
AZEvoHqtuSG3bAWGn5t1/KcUe966p92vKScLSTKZfjDb8VJmsa9WFatt/PbmGlXH
J4IwOpew/NM9vFjnrhrmPROyfcm4PPA6t8GHk0s9NOUSK5oFx76h1xQEk4b0lU3q
uixAvHHEUKYC29llaGqf67X3ko+BeCfo+edx9dz+jkRXgQoDxYuiGtuLco9n/8KY
4G/VzbNMC5Ct3a5wPNgjDxkr0717ygLyjWijClG5Zpxd01wPlV1CZAnCp3CVaUTm
gua6VJPUy7f4lXpUqUS51Wn2KUcLlKgU2GgggwwW/MWDc6yX4HFmhWO1bDGf46Z6
jzYW4VHvWtGODUnoHDRuh1dnOqswNs3IPtZK+mtluiN0p/m5GKXC9/txg7p5NZsb
5MBJIEmrPMpUZ4O5k/jsi6GXLnVBpFr3BPDHAZd7KeSVAwFJ/Fc=
=0Gj6
-----END PGP SIGNATURE-----

--NWAujopaZLN2XilU--
