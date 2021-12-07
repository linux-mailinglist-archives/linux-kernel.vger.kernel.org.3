Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7320A46B5B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhLGI2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhLGI2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:28:34 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377C0C061746;
        Tue,  7 Dec 2021 00:25:04 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i5so27823843wrb.2;
        Tue, 07 Dec 2021 00:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4YlEfyGuTmDXWogHreM3HEOr8rkPGxqlzzFFm3Xfiy4=;
        b=ffvAuXb5kJHzfREehTKFvUUH09vCvdNH50SejEzrlyeectHx/A36dFNSykSxtll2xB
         XcKunvxaHKdpsTfe7e1hLc5jkoGWrICZc0xm3PI10gEtrrdVadfC1O1Q34cWmhjf5HAH
         yTvrXDWFKO7k7JK8cRv4ixVGK7xUIkx5qILEqTyCzfV0EH4iMpwxpqiUauXpgyAxcfFK
         J9KN0i6mVXbI2x3AZMYMYwPfQg1OFvsXv7zT9p9yYmfqrIJiasHBBBEGjWUSlONukmut
         HCufQltVSZW+FBKXPoLK82VJGpA68pdJ2gmD0+gXjVobj95BcmZTQ4FcThzeXfg2QC9r
         Axow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4YlEfyGuTmDXWogHreM3HEOr8rkPGxqlzzFFm3Xfiy4=;
        b=aJ6VrHDODy9w92ZgDCmuAZYCwhrzRsAH21Cm57lxY/Uw/droLK7Udd4SQqoEeZ9Zfc
         nl5zWYWe5D6A6T9fgTTjMrOejcHnETLdZDi7mVPggQ7XAbNXKkLdg8ccELBjOn2ZZ9e9
         mzcRWshxDHO5R45P5C8LTFQh6+2hR6+oa8EK+BelyF2Q/oSfejquLkZMymtFagFISqiU
         gW0J9IahMnks0+/DsUQonLrAk2KwVopAv7ibs9yw3pArmRZPwSATzsgQN2YUGIA+U6m5
         7CJghqatZD4KhRT4MyGxs1eipofDNsRlM2zf7SUF5Q9rVsIn39zFMUbHyxFNmhmS17vi
         6C5Q==
X-Gm-Message-State: AOAM5335l/vjviYi+m9uPRQthPkDDqfPjDIdCvr2agK70qeQQM/qjurp
        qSMPolp+st/6wdsjuHqe/6Y=
X-Google-Smtp-Source: ABdhPJwbUL0fTO99+HdWSJwsFoxTmvpq4owS4lYyH4cCQYndpxbqVysByZe3TJgd7AZv1/OnljTdkg==
X-Received: by 2002:a5d:64cc:: with SMTP id f12mr49167922wri.322.1638865502795;
        Tue, 07 Dec 2021 00:25:02 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id o4sm2081738wmq.31.2021.12.07.00.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:25:01 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:24:58 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        devicetree@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: Add missing 'reg' property
Message-ID: <Ya8aWrMb805uPGt4@orome.fritz.box>
References: <20211206174133.2296265-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j4zidih6AkAbzGvE"
Content-Disposition: inline
In-Reply-To: <20211206174133.2296265-1-robh@kernel.org>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j4zidih6AkAbzGvE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 11:41:33AM -0600, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the following warnings
> are generated in the nvmem examples:
>=20
> Documentation/devicetree/bindings/nvmem/st,stm32-romem.example.dt.yaml: e=
fuse@1fff7800: Unevaluated properties are not allowed ('reg' was unexpected)
> Documentation/devicetree/bindings/nvmem/rmem.example.dt.yaml: nvram@10000=
000: Unevaluated properties are not allowed ('reg' was unexpected)
> Documentation/devicetree/bindings/nvmem/brcm,nvram.example.dt.yaml: nvram=
@1eff0000: Unevaluated properties are not allowed ('reg' was unexpected)
>=20
> Add the missing 'reg' property definition.
>=20
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> Cc: Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml     | 3 +++
>  Documentation/devicetree/bindings/nvmem/rmem.yaml           | 3 +++
>  Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml | 3 +++
>  3 files changed, 9 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--j4zidih6AkAbzGvE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGvGloACgkQ3SOs138+
s6F0Hg//WQA8UyTwQry88qNWR9u3sktX7xIveJPuMNLvE7TLRbNIEHWutUHA4f1w
NuCeBlfpTWWlBC5g5LoGV2khS+TSI/amcdTQ3vvKAYyMy9tGByKfnGv0vXuz8ddM
0Q3opyzR+rp55TRdQoBqDWBWpUojYVeOpdfw9h8e5/H6eR3yVyx+CzpGZWDJWTi5
dyz5U0AX78TQeaWk2oo1lo1PMiG/Mn/hlaZMGm/seqeftGcrVXHPtn+jJcNlgSkK
m+ED7Fl604ryrPG8/HV2+UcgILWskHyVceCf7JEhBDocpLohubTXq53T1IixC+H5
r9uRb/AjzzIfaA+9ku/db2XOa0PkPizzY7DXAQSdBgsFa8TK7QAkX+5IXqqE0YAO
Qs4jf4EEMioMhB7g9as5YBf2jkNOuj/E2NcgEWvw2sybdyfb6QplwXMXAxImL1bH
1Hou+yCHGR6aVeJsXfLVe7ezBp6hF1FNspSOxYC72VmiMpg3kZKSxF9vavonj+CD
WOxjWQ/0wZzPNfv69Xd5PnviaHqY5ggJW6pl9VpZlyQjCiff2IUodDlUIUU3gR5I
C5YvipfJFFf2K4BsTae/Er7EIO2+3HId9swtVilMOwOnMm1S8Oh6aLZZkPHe4Pqg
SuVcQ19Yk0bR+PQ5zhlOIBv4Tn0H4omiRa9LQnRnEXXK5DukdVs=
=YdRa
-----END PGP SIGNATURE-----

--j4zidih6AkAbzGvE--
