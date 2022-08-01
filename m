Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764645865CC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 09:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiHAHlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 03:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiHAHk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 03:40:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93DEE59;
        Mon,  1 Aug 2022 00:40:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b21so11367299ljk.8;
        Mon, 01 Aug 2022 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3CySBFeUWN85aXoonRz+AZDirKDNsX9iBAr2bBqFmHU=;
        b=eTu6j9zzaLbBPXTYLnqfHsSDrQNeiG8n4svWVAROvuNolOkayxxX1ArmqdYOJngEM7
         tIGROr+VLARtg1ZJXR/u1A0AgkXu+iespBhq2+tZ3yDLJc4D6QCAo8TlEGeBkhwrZzPP
         u0h913n4nfmLmAjmTbd4j6qvRppKi0/FfQsVB4tSRdp2H3LuJiI1Ss4fQRZ7XixxC9hg
         j0zJjX+wTo6lFctiIOdL5jC+pZsjxrsF48GWU40kvkGGQZF3aUmnSyVjTQZFy+nqrQun
         w3zzVXIhw6XYfsP+1/h4jlbocUhf8aTI7J7Axrk64rZE+yUPJzoqvNyqkGPQ1cae8x4d
         5D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3CySBFeUWN85aXoonRz+AZDirKDNsX9iBAr2bBqFmHU=;
        b=cKAhqCypgNHvugMsCARBwtVlP0dwuVnkYA3/xg41tzAedZu0cFtxM9Ld5SrhjV1E2B
         JA7N5SLAEYR6/LrBHWypohgGor7HBUChB96jd1uvUsS9TZW+iqZZjmZZfqssBrMTdzbO
         CgmREcx2+JqB9b5doRPXFUt1FH2dvmANpDdtGPIdypx1h/gOxj4XF2O1bLldIDkqAegK
         wTe93dxEq8cMM/mNh71926qcYn1KX7ON6wrs1YuEbqm3FqVoZlA87eXZ6+vUSC1SFMcj
         Mcqzw651SBJOOEJVLhKuAtrB7HlVtNjhJYuuvmDA+2eCBbmGbNpDfhrxhRlfFA47R7TM
         EmwA==
X-Gm-Message-State: ACgBeo2haNHbmC89WEm1HKypK0d0LfByw/z4z6GqNcZxxoLVZL2Oc8zK
        LACZkKwlk2tCT0phrvdPLwY=
X-Google-Smtp-Source: AA6agR60lgw2vb7OWO93hjNB85sYnk9WjvegobksCPHLQnpGTAEzdAsDbc8DqH5esnhPzmHMNcUpLg==
X-Received: by 2002:a2e:a168:0:b0:25e:4dbc:2ac0 with SMTP id u8-20020a2ea168000000b0025e4dbc2ac0mr1359949ljl.187.1659339657265;
        Mon, 01 Aug 2022 00:40:57 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v8-20020a2ea448000000b0025e2c5a12b6sm1511078ljn.129.2022.08.01.00.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 00:40:56 -0700 (PDT)
Date:   Mon, 1 Aug 2022 09:45:07 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] Improve MCP3911 driver
Message-ID: <YueEg0tmKpc4kdLO@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
 <20220731174112.072345e3@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W/hEucp5LQz60B6z"
Content-Disposition: inline
In-Reply-To: <20220731174112.072345e3@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/hEucp5LQz60B6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 31, 2022 at 05:41:12PM +0100, Jonathan Cameron wrote:
> On Fri, 22 Jul 2022 15:07:17 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20
> > Hi,
> >=20
> > This patch series intend to fix bugs and improve functionality of the
> > MCP3911 driver.
> > The main features added are
> > - Support for buffers
> > - Interrupt driven readings
> > - Support for oversampling ratio
> > - Support for set scale values (Gain)
> >=20
> > Among the bug fixes, there are changes in the formula for calculate raw
> > value and a fix for mismatch in the devicetree property.
> >=20
> > Another general improvement for the driver is to use managed resources
> > for all allocated resources.
> >=20
> Hi Marcus,
>=20
> The first 3 fixes look good to me.  Do you want me to pick those up to
> go in after rc1 via my togreg-fixes branch?  The side effect of doing
> that is it'll be a little while before they are upstream in the branch
> I'll want to pick the rest of the series on top of.
>=20
> So it's a trade off between getting fixes in as soon as possible and
> slowing down other improvements a little.

Both ways works for me.
I guess it is preferable to get the fixes in as soon as possible?

If so, do you want me to rebase the series on your togreg-fixes branch
or wait to send v5 until the patches are upstream?

Or simply keep sending the whole series?

Thanks,
Marcus Folkesson

>=20
> Jonathan
>=20

--W/hEucp5LQz60B6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmLnhH4ACgkQiIBOb1ld
UjKmEg//cqbYKmFpcnaOrWMfyZOZHbWE7RbHs+5DupY019C250WBr+p/esK/vNJU
IsY2r2eHswuxECGCAU4BytjWcNDqLLSOZbewyJC5Xc6KhFZ/jmpsBjPPvr0ifSgd
H+kFkuNuXWAuXwekJHycgyveghSpP3GhqFUR435pDrQhaW7Vqt9yiGccwqYcaE2n
DJc7xkjYXF2k+KoNRwZ4LaDqUX/4450+wlHgBI6FRFMDESCdui9wXPl/D5tULYo1
kGogWuZtwjYXW+Fjn5zsIwoNwJPZixNQl1pXQFd2TSoCtWM90ZcVHqMSkvuvZYTb
fAOuv60VOXGvbB6yNPKPnnGL0JEOFeKXxRulm/Cn2nOTD2483wdR80DYChMuaHUL
Y+OE9DVTz1sUXhW9Oae4af7A7CS6T5zxX5a3TjbmgjzPCs5FlfHOqpXf5AR9AzSp
vEvyXTmyagLrFsDcxaAmEog7zFafWi4hnl4dgKdHTa5SfbHC2ws14BiyHZuk4zyx
2Xqk1picambN3kaL3TbTGMruWFrgRVhav9GM4PBZZyGnx37pcB7UqEGu6Yea8nm6
/sib0CgxwSmyXmg3kr9HxtGOOo7bADe4JK2MvJ9tHhz4oR37ruxS2E2SUI75Mlaf
dA1kvXTzu1MwOEvEyRcRpcH2B2A+Dodmqjn7BqHtcFi7Z9lAQ/k=
=xvHz
-----END PGP SIGNATURE-----

--W/hEucp5LQz60B6z--
