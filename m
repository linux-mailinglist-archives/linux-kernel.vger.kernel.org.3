Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9FF46B624
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 09:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhLGIkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 03:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhLGIkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 03:40:18 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793BDC061D5E;
        Tue,  7 Dec 2021 00:36:48 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so1167099wme.0;
        Tue, 07 Dec 2021 00:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hS4s0cfHaFB1mjZApAyxsxaBhzGf1CZ85k4YcjUrKs0=;
        b=ms2wDCeIABLZLNwTqJQlb4IogiGzKSjBjlsRJgIhXJQnsNiogd61pWnFME+eTqBUAa
         q6pkwktlkZPY8tEcqJiQL/hA0Hht/Hxq8KKqGlnMFfuWTK0ZLUEaKvnQwlB07xXK9zBU
         TxmXYx3v6JAYEvRYaMfAxg3fQcD+Yd4qcwbic02yHjdyEUYkL0dvjy/OK14edSu9CESC
         s5A8BbOhYqWvtCZvI4NsBYQDMWfKBu/NPFuCPNfiuEWb+GiNcbaJr2W6/CQqaWZVMxkn
         5KKgg0KkRdVQILQ55sqCtbXSBC0vrqk08QHT1SPIxnXNZuE53/uztdxlsxYy0dnsMMVu
         08Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hS4s0cfHaFB1mjZApAyxsxaBhzGf1CZ85k4YcjUrKs0=;
        b=cD+CVKeT4ExK3ckOtNjCu2CvGl8JTKns3E0DEVjq6FB5CJppHmpwE8ZRSWaT5IT5H4
         hyk3dhmIUWF3EPJoKgvBgONHweqiFgRn+S7gTdIr+Fp36Fd2yjOGEaAeSi/YLr5LD3b6
         M9r0pgWQgrFB/piO+LsZGPZfO+bPo0AOe+et0P4nGFL63PcHOg8KaSA1Jx/UcvzHs4eR
         DdDlBZUIRVG05QEkp25Zaf+GomEuII4iaeqYzcXwCPKwEISMdntD4+EwIwpNPLyy/CrG
         QxC0P5mFimdjHRbwR8gLAtC+12ZVoINqbfjRrRPhtbyPM0wUbz/hkUcGv2k7ga0PGn3q
         72Yg==
X-Gm-Message-State: AOAM5315DnjADc9LFriPa52x4DzSsjnL1fBbS8ja8w/K/gpqklK9kPq/
        IbT4Uepnsum9L+zB6MsFsYw=
X-Google-Smtp-Source: ABdhPJwuCLqlycQzc8KhUT03MVCeXx/CaVFjpUJOwncm8ovBvTb1sAgznte1boCvq0BCgbYhk6LWIQ==
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr5173853wmr.55.1638866207094;
        Tue, 07 Dec 2021 00:36:47 -0800 (PST)
Received: from orome.fritz.box ([193.209.96.43])
        by smtp.gmail.com with ESMTPSA id k8sm13651056wrn.91.2021.12.07.00.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:36:46 -0800 (PST)
Date:   Tue, 7 Dec 2021 09:36:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Roger Quadros <rogerq@kernel.org>, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: ti,gpmc-nand: Add missing 'rb-gpios'
Message-ID: <Ya8dG/pQ67XFacdO@orome.fritz.box>
References: <20211206174209.2297565-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OdofmF9j5haQfHF0"
Content-Disposition: inline
In-Reply-To: <20211206174209.2297565-1-robh@kernel.org>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OdofmF9j5haQfHF0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 06, 2021 at 11:42:09AM -0600, Rob Herring wrote:
> With 'unevaluatedProperties' support implemented, the TI GPMC example
> has a warning:
>=20
> Documentation/devicetree/bindings/memory-controllers/ti,gpmc.example.dt.y=
aml: nand@0,0: Unevaluated properties are not allowed ('rb-gpios' was unexp=
ected)
>=20
> Add the missing definition for 'rb-gpios'.
>=20
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--OdofmF9j5haQfHF0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmGvHRsACgkQ3SOs138+
s6EDahAApZ1NZlUaEmFdyjj8cjfwcm+jHarWYeJ+oLuebb2NEoaOeQX+PufHH2H7
D9f9rm/khm6NTEDhpm8xaoKqHx1FoHpSoc7eJZ+LrK7v/X2IMQK4/TDIcdsko8rt
qkwKr0KecdUQ84R0enDC8VS9Rh3RjS5BxVOOqL1cXt0HkAWwu/PDCeLJ/pugFbb6
BKNzArPXhl570OBbjkUEnpda4Fi+ut4dsIu/EC6oSKSmzXv5i/5+9WQy53Xb2lZU
JaOH/dovvpzlfrX23dFHukiPNCsgiupq9J+kzQSlX0JjuVaPYI/9u4vvPD53+WEs
JPZUaAUF4kyTJT76vMRca47AMuOEDmaVofeIoOCl2PzmSah8ZSPQq+YGJl/Q8imU
BilBwnlVb+9kxp2TSNgh90PUG2mUkfWQWESBYQ3u+u9+1nbRVVvJtzFX5ZBqWcMZ
GOuIfgKGv0s1JS/XN5Oyw9trGzgZ7vMODisDuB33mzciL0e70y97S8gz8q4sXi07
9zBHpJZkjaLWAwOg5SqyQ05EjWQ6c2nURGsicuBgKPqcdimWoyptwbHH/C8oqzu5
IzDLuALB/955QRoSI3hY1B+NwJ2gdUX0GmYn/ZiYb9J9LeF/le712kUIjMAnEFVp
9gDg7brijyvi9ULcK2MFQC9z9zwlDFNCwCyjEl2D73KCFBwCJwE=
=q8by
-----END PGP SIGNATURE-----

--OdofmF9j5haQfHF0--
