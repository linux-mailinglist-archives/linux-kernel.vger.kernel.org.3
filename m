Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7F247736C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbhLPNpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237703AbhLPNpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:45:02 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E382C06173E;
        Thu, 16 Dec 2021 05:45:02 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v11so44263256wrw.10;
        Thu, 16 Dec 2021 05:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rb/+mXWhEG6S9EIOxh8qb2+7X3qo0XbenUvRxK42X4M=;
        b=HrWv8JnJnUWNpGfUfgoP28RV3plxvArdBwVrg7DrufSqxT585BnKuWYLc0D7Q5tYnX
         PdipKeyeKJIgY22MxO8r6aPupC4FmHiPWxpGfb/ugjS4c29ljsdZziGUCL/Aq30sHGhK
         LZvYUcwENb4uMBnrczV/5D4gW/KdLKLHpiMjfRl/rGTA5525YFLYz2U5Lu24ciz4v6i/
         b1SaHUBfggNNcVHPRCWnoQan3QaQ8FLrG8t730UWYq2ipC+eAL2pSWN6jjMec4UZox4L
         H7CtLz9Qzv94oEyIv6WHUxYOMSpDGZHyqYKgSYKUa11o6n/P4LHq3nJTOxOc9duv9KN5
         AzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rb/+mXWhEG6S9EIOxh8qb2+7X3qo0XbenUvRxK42X4M=;
        b=6ao1aD3D3Sk5iYF3gTcJ5fjfcF2l99yqPgSmKnqQSFH0UWxZBcGjxEfCtPoywVxOVB
         CnB+aMB988IzHU4OCgEk1uUaO2x4CZtt4YlldTU2svLydyJ9IjYMIKkssFdkjOI9G0mm
         FxZOIBm8jEg6SlDEiW002hP/iq6oX8q5ojg337BZ0AQ3Q4ls/SbctIqUp98yETAG4lj1
         01PL7KBqOpTEu5ykbuDJsW9GpM8UtAaduwLIhpmpXn4LeG4TMPjwDobURmE/I+sCEzSv
         uPYFf8eCeLxXil+qi8oYGsA2hWmDwECVjYJGYVXNyeb0bS+Nls5clkLyWUVPiLtFf7DB
         xTvw==
X-Gm-Message-State: AOAM530ulSZTzB5LfOzLiOXhNIZO+wgaRFsBCswGYFWYhSARMfTp4v0M
        9mw2bnCYIJae77crp/qQ8HM=
X-Google-Smtp-Source: ABdhPJy6hVlpxQM2rUPWydGYq7yKNFFkMicJChI8RDdCEN4VFcMwnhxLAszmafAbXMvfL64VfVPwTA==
X-Received: by 2002:a5d:47a1:: with SMTP id 1mr9182996wrb.436.1639662300835;
        Thu, 16 Dec 2021 05:45:00 -0800 (PST)
Received: from orome ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id p5sm5039109wrd.13.2021.12.16.05.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 05:44:59 -0800 (PST)
Date:   Thu, 16 Dec 2021 14:44:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        ~okias/devicetree@lists.sr.ht, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: sound: nvidia,tegra-audio: Convert
 multiple txt bindings to yaml
Message-ID: <YbtC2I49D0pdcyLY@orome>
References: <20211211224946.79875-1-david@ixit.cz>
 <a84213cb-272a-f1b2-338f-ed8ed0bf133d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VYhNuZYXPUbD/PRF"
Content-Disposition: inline
In-Reply-To: <a84213cb-272a-f1b2-338f-ed8ed0bf133d@gmail.com>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VYhNuZYXPUbD/PRF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 16, 2021 at 05:52:12AM +0300, Dmitry Osipenko wrote:
> 12.12.2021 01:49, David Heidelberg =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    sound {
> > +        compatible =3D "nvidia,tegra-audio-rt5677-ryu",
> > +                     "nvidia,tegra-audio-rt5677";
> > +        nvidia,model =3D "NVIDIA Tegra Ryu";
> > +
> > +        nvidia,audio-routing =3D
> > +                "Headphone", "LOUT2",
> > +                "Headphone", "LOUT1",
> > +                "Headset Mic", "MICBIAS1",
> > +                "IN1P", "Headset Mic",
> > +                "IN1N", "Headset Mic",
> > +                "DMIC L1", "Internal Mic 1",
> > +                "DMIC R1", "Internal Mic 1",
> > +                "DMIC L2", "Internal Mic 2",
> > +                "DMIC R2", "Internal Mic 2",
> > +                "Speaker", "PDM1L",
> > +                "Speaker", "PDM1R";
> > +
> > +        nvidia,i2s-controller =3D <&tegra_i2s1>;
> > +        nvidia,audio-codec =3D <&rt5677>;
> > +
> > +        nvidia,hp-det-gpios =3D <&gpio 143 0>;
> > +        nvidia,mic-present-gpios =3D <&gpio 132 1>;
> > +        nvidia,hp-en-gpios =3D <&rt5677 1 0>;
> > +        nvidia,dmic-clk-en-gpios =3D <&rt5677 2 1>;
>=20
> I spotted that nvidia,dmic-clk-en-gpios is undocumented, but DTs and
> binding are passing the validation. We will make another patch to fix it.
>=20
> Rob, could you please tell whether this is because unevaluatedProperties
> doesn't work yet or we're missing something?

If you update dt-schema.git to the latest "main" branch you should have
most of what's needed to make unevaluatedProperties work. However, there
seems to be an issue with some $referenced schemas setting
additionalProperties to true and then that gets propogated to the schema
that included it.

Rob came up with the patch below to fix that:

--- >8 ---
diff --git a/dtschema/lib.py b/dtschema/lib.py
index 3cc5e428b0eb..a0f22aab935a 100644
--- a/dtschema/lib.py
+++ b/dtschema/lib.py
@@ -367,6 +367,9 @@ def fixup_sub_schema(schema, is_prop):
     if not isinstance(schema, dict):
         return

+    if 'additionalProperties' in schema and schema['additionalProperties']=
 =3D=3D True:
+        schema.pop('additionalProperties', None)
+
     schema.pop('description', None)
     fixup_interrupts(schema)
     if is_prop:
--- >8 ---

I'm currently running the tools based on that and it's indeed been
flagging some properties as unevaluated that weren't there before.

Thierry

--VYhNuZYXPUbD/PRF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmG7QtUACgkQ3SOs138+
s6HjCxAAuTnbsKxAgxycX85cJbBSIHKr0b51aKNXDI71KKBxLN4QSgOtVa7ZyTyh
vj1eR6Ub2iMKQqd20prcPw2G/OyDMT4Ej3+UK14zAGfOPIgPHzTuTivT2yAmdZQY
qMC1rz2YpzLxUWMbiL7d5BUWH10feHqodEhEYyR5ai4dayw5h3uTaXU3zAg6nrxv
t3us4Am42PXfUKk8v7yEBoKCr9N6p45xI3oAjlzmcTcUmJ/znM4ExIUW/vNsXUYb
vehBTrfGWLwF/Zc8FXHrqa1ZWIUVuVdhJq8gBCKURp7Aq34eXQLyBKc2yzWzTr1U
u8Bd1Ui5bUOvqG+pijUaNnELUBNu042FSlj26UZsbbATxnvj/rT60477YfE7IjJg
0nBTUGR9tCeqJT7PNdQ2qrycFnwIDSokNldvCjxGO+dYf1mTC1F7GHYp1xN92qtK
wPNPqt97gnajhx0rUIvXBuFMDRhhz8dsSPZTPK0vuoo7r6Ot0k5MaweCT1B+SoKw
tYIKnXImguOGPXKX14DAmRdMO5mVUF2L4tnWlBiTMRaN0YjEESkdtfUKfOp2Drg5
P0GU9HyOB84/yfHnd23+osuqB1kWWIZ8DTLyf+GJ3K2KSL7gZA+IUsqawHGZTdvx
96U+hM8GBu77CfrjrHoUGftBOSz+vGdNRU4/fxJxTMEHpaVRTHc=
=FRv9
-----END PGP SIGNATURE-----

--VYhNuZYXPUbD/PRF--
